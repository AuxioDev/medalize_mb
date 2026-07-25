import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/chat/chat_disclaimer_banner.dart';
import 'package:medalize_mb/core/widgets/chat/chat_input_bar.dart';
import 'package:medalize_mb/core/widgets/chat/chat_loading_skeleton.dart';
import 'package:medalize_mb/core/widgets/chat/chat_message_bubble.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
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
          (true, _) => const ChatLoadingSkeleton(),
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
        ChatDisclaimerBanner(text: context.t.messaging.disclaimer),
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
                  itemBuilder: (context, i) => ChatMessageBubble(
                    text: reversed[i].body,
                    isMine: reversed[i].isMine,
                  ),
                ),
        ),
        ChatInputBar(
          controller: _inputController,
          enabled: !state.sending,
          canSend: _hasText && !state.sending,
          onSend: _send,
          hintText: context.t.messaging.typeMessage,
          sendTooltip: context.t.messaging.send,
        ),
      ],
    );
  }
}
