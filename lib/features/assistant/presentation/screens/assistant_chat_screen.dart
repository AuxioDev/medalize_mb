import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/presentation/widgets/flag_message_dialog.dart';
import 'package:medalize_mb/features/assistant/presentation/widgets/suggested_doctor_card.dart';
import 'package:medalize_mb/features/assistant/providers/assistant_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Chat with the AI symptom assistant. Loads the conversation by [conversationId]
/// from the route path; [conversation] is an optional preview passed via
/// `extra` and may be null (e.g. after state restoration).
class AssistantChatScreen extends ConsumerStatefulWidget {
  const AssistantChatScreen({
    super.key,
    required this.conversationId,
    this.conversation,
  });

  final String conversationId;
  final ConversationModel? conversation;

  @override
  ConsumerState<AssistantChatScreen> createState() =>
      _AssistantChatScreenState();
}

class _AssistantChatScreenState extends ConsumerState<AssistantChatScreen> {
  final _inputController = TextEditingController();
  var _hasText = false;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      final hasText = _inputController.text.trim().isNotEmpty;
      if (hasText != _hasText) setState(() => _hasText = hasText);
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  /// The disclaimer arrives from the backend, already localized: either as a
  /// dedicated field on assistant messages or as the final paragraph appended
  /// to every substantive assistant reply. Never hardcoded on the client.
  String? _disclaimerText(List<MessageModel> messages) {
    for (final m in messages.reversed) {
      if (!m.isAssistant) continue;
      final d = m.disclaimer;
      if (d != null && d.isNotEmpty) return d;
      final parts = m.content
          .split(RegExp(r'\n\s*\n'))
          .where((p) => p.trim().isNotEmpty)
          .toList();
      if (parts.length > 1) return parts.last.trim();
    }
    return null;
  }

  Future<void> _send() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    final notifier = ref.read(assistantChatProvider(widget.conversationId).notifier);
    _inputController.clear();
    final ok = await notifier.send(text);
    if (!ok && mounted) {
      // Roll the text back into the field so the patient can retry.
      _inputController.text = text;
      final error =
          ref.read(assistantChatProvider(widget.conversationId)).sendError;
      AppSnackBar.show(
        context,
        error ?? context.t.assistant.sendFailed,
        type: SnackBarType.error,
      );
    }
  }

  Future<void> _flag(MessageModel message) async {
    final reason = await showFlagMessageDialog(context);
    if (reason == null || !mounted) return;
    final ok = await ref
        .read(assistantChatProvider(widget.conversationId).notifier)
        .flag(message.id, reason);
    if (!mounted) return;
    AppSnackBar.show(
      context,
      ok ? context.t.assistant.reportSuccess : context.t.assistant.reportFailed,
      type: ok ? SnackBarType.success : SnackBarType.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(assistantChatProvider(widget.conversationId));

    return Scaffold(
      appBar: AppBar(title: Text(context.t.assistant.title)),
      body: ResponsiveBody(
        child: switch ((state.loading, state.loadFailed)) {
          (true, _) => const _LoadingSkeleton(),
          (false, true) => EmptyState(
              icon: Icons.cloud_off_outlined,
              title: context.t.common.somethingWrong,
              subtitle: context.t.assistant.couldNotLoadChat,
              actionLabel: context.t.common.retry,
              onAction: () => ref
                  .read(assistantChatProvider(widget.conversationId).notifier)
                  .retryLoad(),
            ),
          _ => _buildChat(context, state),
        },
      ),
    );
  }

  Widget _buildChat(BuildContext context, AssistantChatState state) {
    final disclaimer = _disclaimerText(state.messages);
    final reversed = state.messages.reversed.toList();
    final itemCount = reversed.length + (state.sending ? 1 : 0);

    return Column(
      children: [
        if (disclaimer != null) _DisclaimerBanner(text: disclaimer),
        Expanded(
          child: state.messages.isEmpty && !state.sending
              ? EmptyState(
                  icon: Icons.health_and_safety_outlined,
                  title: context.t.assistant.startTitle,
                  subtitle: context.t.assistant.startSubtitle,
                )
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  physics: const BouncingScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (context, i) {
                    if (state.sending && i == 0) {
                      return const _TypingIndicator();
                    }
                    final message = reversed[state.sending ? i - 1 : i];
                    return _MessageBubble(
                      message: message,
                      onFlag: () => _flag(message),
                    );
                  },
                ),
        ),
        _InputBar(
          controller: _inputController,
          enabled: !state.sending,
          canSend: _hasText && !state.sending,
          onSend: _send,
        ),
      ],
    );
  }
}

class _DisclaimerBanner extends StatelessWidget {
  const _DisclaimerBanner({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm + 2),
      decoration: BoxDecoration(
        color: c.primarySurface,
        border: Border(bottom: BorderSide(color: c.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 16, color: c.primaryText),
          const Gap(8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: c.primaryText, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.onFlag});

  final MessageModel message;
  final VoidCallback onFlag;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final isUser = message.isUser;

    final bubble = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isUser ? AppColors.primary : c.surfaceAlt,
        border: isUser ? null : Border.all(color: c.border),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(AppRadius.lg),
          topRight: const Radius.circular(AppRadius.lg),
          bottomLeft: Radius.circular(isUser ? AppRadius.lg : AppRadius.sm - 2),
          bottomRight: Radius.circular(isUser ? AppRadius.sm - 2 : AppRadius.lg),
        ),
      ),
      child: Text(
        message.content,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isUser ? Colors.white : c.textPrimary,
              height: 1.4,
            ),
      ),
    );

    if (isUser) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 48),
        child: Align(alignment: Alignment.centerRight, child: bubble),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: bubble),
              const Gap(2),
              message.flagged
                  ? Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Icon(Icons.flag_rounded,
                          size: 16, color: c.textSecondary),
                    )
                  : IconButton(
                      tooltip: context.t.assistant.reportTooltip,
                      onPressed: onFlag,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Icons.flag_outlined,
                          size: 16, color: c.textSecondary),
                    ),
            ],
          ),
          for (final doctor in message.suggestedDoctors)
            SuggestedDoctorCard(doctor: doctor),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 64),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: c.surfaceAlt,
            border: Border.all(color: c.border),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: c.primaryText,
                ),
              ),
              const Gap(8),
              Text(
                context.t.assistant.typing,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.enabled,
    required this.canSend,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool enabled;
  final bool canSend;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.md, AppSpacing.sm, AppSpacing.sm, AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 4000,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: context.t.assistant.inputHint,
                    counterText: '',
                    isDense: true,
                  ),
                  onSubmitted: (_) {
                    if (canSend) onSend();
                  },
                ),
              ),
              const Gap(8),
              IconButton.filled(
                tooltip: context.t.assistant.send,
                onPressed: canSend
                    ? () {
                        HapticFeedback.lightImpact();
                        onSend();
                      }
                    : null,
                icon: const Icon(Icons.arrow_upward_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: const [
        ShimmerSkeleton(height: 56),
        ShimmerSkeleton(height: 88),
        ShimmerSkeleton(height: 56),
        ShimmerSkeleton(height: 88),
      ],
    );
  }
}
