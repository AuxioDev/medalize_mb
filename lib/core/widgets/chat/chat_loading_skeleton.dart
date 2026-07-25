import 'package:flutter/material.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';

/// Loading placeholder for a chat screen's initial message-history fetch.
/// Shared by [ThreadChatScreen] and [AssistantChatScreen] — previously two
/// byte-identical private `_LoadingSkeleton` classes.
class ChatLoadingSkeleton extends StatelessWidget {
  const ChatLoadingSkeleton({super.key});

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
