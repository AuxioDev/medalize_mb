import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

/// Info strip pinned above a chat's message list (e.g. "this isn't a
/// substitute for medical advice", "messages aren't end-to-end encrypted").
/// Shared by [ThreadChatScreen] and [AssistantChatScreen] — previously two
/// byte-identical private `_DisclaimerBanner` classes.
class ChatDisclaimerBanner extends StatelessWidget {
  const ChatDisclaimerBanner({super.key, required this.text});

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
