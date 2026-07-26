import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/chat/chat_disclaimer_banner.dart';
import 'package:medalize_mb/core/widgets/chat/chat_input_bar.dart';
import 'package:medalize_mb/core/widgets/chat/chat_loading_skeleton.dart';
import 'package:medalize_mb/core/widgets/chat/chat_message_bubble.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
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
  ///
  /// Only looks at the LAST assistant message, not the whole history — some
  /// replies (emergency warning, off-topic refusal, "didn't understand") are
  /// a single paragraph with no disclaimer. Falling back to an older message
  /// there would pin a stale disclaimer from a previous, unrelated turn.
  String? _disclaimerText(List<MessageModel> messages) {
    final lastAssistant = messages.reversed.where((m) => m.isAssistant).firstOrNull;
    if (lastAssistant == null) return null;
    final d = lastAssistant.disclaimer;
    if (d != null && d.isNotEmpty) return d;
    final parts = lastAssistant.content
        .split(RegExp(r'\n\s*\n'))
        .where((p) => p.trim().isNotEmpty)
        .toList();
    return parts.length > 1 ? parts.last.trim() : null;
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
      appBar: AppBar(
        title: Text(context.t.assistant.title),
      ),
      body: ResponsiveBody(
        child: switch ((state.loading, state.loadFailed)) {
          (true, _) => const ChatLoadingSkeleton(),
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
        if (disclaimer != null) ChatDisclaimerBanner(text: disclaimer),
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
                    final c = context.colors;
                    return ChatMessageBubble(
                      text: message.content,
                      isMine: message.isUser,
                      trailing: message.isUser
                          ? null
                          : (message.flagged
                              ? Padding(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  child: Icon(Icons.flag_rounded,
                                      size: 16, color: c.textSecondary),
                                )
                              : IconButton(
                                  tooltip: context.t.assistant.reportTooltip,
                                  onPressed: () => _flag(message),
                                  visualDensity: VisualDensity.compact,
                                  icon: Icon(Icons.flag_outlined,
                                      size: 16, color: c.textSecondary),
                                )),
                      below: message.isUser
                          ? null
                          : [
                              for (final doctor in message.suggestedDoctors)
                                SuggestedDoctorCard(doctor: doctor),
                            ],
                    );
                  },
                ),
        ),
        ChatInputBar(
          controller: _inputController,
          enabled: !state.sending,
          canSend: _hasText && !state.sending,
          onSend: _send,
          hintText: context.t.assistant.inputHint,
          sendTooltip: context.t.assistant.send,
        ),
      ],
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

