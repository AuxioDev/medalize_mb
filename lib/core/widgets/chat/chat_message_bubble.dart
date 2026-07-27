import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/chat/typewriter_text.dart';

/// One chat bubble, right-aligned and primary-filled for the current user's
/// own messages, left-aligned and outlined for the other side. Shared by
/// [ThreadChatScreen] and [AssistantChatScreen] — the two screens' message
/// models are unrelated types (each feature has its own `MessageModel`), so
/// this widget takes plain [text]/[isMine] rather than either model.
///
/// [trailing] and [below] exist only for the assistant screen's extra chrome
/// (a flag/report button beside the bubble, suggested-doctor cards beneath
/// it) — pass neither for a plain human-to-human message.
class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.text,
    required this.isMine,
    this.trailing,
    this.below,
    this.animateTyping = false,
    this.onTypingComplete,
  });

  final String text;
  final bool isMine;

  /// Placed beside the bubble on the same row. Only rendered for a non-mine
  /// bubble (a "mine" bubble never needs a report/flag action).
  final Widget? trailing;

  /// Stacked beneath the bubble. Only rendered for a non-mine bubble.
  final List<Widget>? below;

  /// Reveals [text] with [TypewriterText] instead of rendering it instantly —
  /// for a reply that just arrived (never for message history being
  /// scrolled back into view, and never for [isMine]). The caller is
  /// responsible for only setting this true once per message, and for
  /// flipping it back to false once [onTypingComplete] fires — this
  /// widget's own state is not a reliable place to remember "already
  /// played," since list recycling can discard and remount it mid-session.
  final bool animateTyping;

  /// Forwarded to [TypewriterText.onComplete] when [animateTyping] is true.
  final VoidCallback? onTypingComplete;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isMine ? Colors.white : c.textPrimary,
          height: 1.4,
        );

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
      child: animateTyping && !isMine
          ? TypewriterText(text: text, style: textStyle, onComplete: onTypingComplete)
          : Text(text, style: textStyle),
    );

    if (isMine) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 48),
        child: Align(alignment: Alignment.centerRight, child: bubble),
      );
    }

    final hasExtras = trailing != null || (below?.isNotEmpty ?? false);
    if (!hasExtras) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 48),
        child: Align(alignment: Alignment.centerLeft, child: bubble),
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
              if (trailing != null) ...[
                const Gap(2),
                trailing!,
              ],
            ],
          ),
          ...?below,
        ],
      ),
    );
  }
}
