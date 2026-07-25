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
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/messaging/data/models/messaging_models.dart';
import 'package:medalize_mb/features/messaging/providers/messaging_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Chat with a doctor or patient inside a shared thread. Visually mirrors
/// `assistant_chat_screen.dart` (bubbles + bottom input bar), but there is no
/// typing indicator or AI-specific chrome (flags, suggested doctors) — this
/// is plain asynchronous human messaging, polled rather than real-time. The
/// [thread] preview arrives via the route's `extra` when navigated to from a
/// list; it's null after a deep link (e.g. a push notification tap), in which
/// case the app bar falls back to a generic title.
class ThreadChatScreen extends ConsumerStatefulWidget {
  const ThreadChatScreen({super.key, required this.threadId, this.thread});

  final String threadId;
  final ThreadModel? thread;

  @override
  ConsumerState<ThreadChatScreen> createState() => _ThreadChatScreenState();
}

class _ThreadChatScreenState extends ConsumerState<ThreadChatScreen> {
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

  Future<void> _send() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    final notifier = ref.read(threadChatProvider(widget.threadId).notifier);
    _inputController.clear();
    final ok = await notifier.send(text);
    if (!ok && mounted) {
      // Roll the text back into the field so it can be retried.
      _inputController.text = text;
      final error = ref.read(threadChatProvider(widget.threadId)).sendError;
      AppSnackBar.show(
        context,
        error ?? context.t.errors.network,
        type: SnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(threadChatProvider(widget.threadId));
    final auth = ref.watch(authProvider);
    final asDoctor = auth is AuthAuthenticated && auth.role == 'doctor';
    final title = widget.thread != null
        ? widget.thread!.counterpart(asDoctor: asDoctor).fullName
        : context.t.messaging.title;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ResponsiveBody(
        child: switch ((state.loading, state.loadFailed)) {
          (true, _) => const _LoadingSkeleton(),
          (false, true) => EmptyState(
              icon: Icons.cloud_off_outlined,
              title: context.t.common.somethingWrong,
              subtitle: context.t.common.tryAgain,
              actionLabel: context.t.common.retry,
              onAction: () => ref
                  .read(threadChatProvider(widget.threadId).notifier)
                  .retryLoad(),
            ),
          _ => _buildChat(context, state),
        },
      ),
    );
  }

  Widget _buildChat(BuildContext context, ThreadChatState state) {
    final reversed = state.messages.reversed.toList();

    return Column(
      children: [
        _DisclaimerBanner(text: context.t.messaging.disclaimer),
        Expanded(
          child: state.messages.isEmpty
              ? EmptyState(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: context.t.messaging.empty,
                  subtitle: context.t.messaging.emptySubtitle,
                )
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  physics: const BouncingScrollPhysics(),
                  itemCount: reversed.length,
                  itemBuilder: (context, i) => _MessageBubble(message: reversed[i]),
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
  const _MessageBubble({required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final isMine = message.isMine;

    final bubble = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isMine ? AppColors.primary : c.surfaceAlt,
        border: isMine ? null : Border.all(color: c.border),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(AppRadius.lg),
          topRight: const Radius.circular(AppRadius.lg),
          bottomLeft: Radius.circular(isMine ? AppRadius.lg : AppRadius.sm - 2),
          bottomRight: Radius.circular(isMine ? AppRadius.sm - 2 : AppRadius.lg),
        ),
      ),
      child: Text(
        message.body,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isMine ? Colors.white : c.textPrimary,
              height: 1.4,
            ),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: 10,
        left: isMine ? 48 : 0,
        right: isMine ? 0 : 48,
      ),
      child: Align(
        alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
        child: bubble,
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
                    hintText: context.t.messaging.typeMessage,
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
                tooltip: context.t.messaging.send,
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
