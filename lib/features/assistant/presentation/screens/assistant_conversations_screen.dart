import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/data/repository/assistant_repository.dart';
import 'package:medalize_mb/features/assistant/providers/assistant_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class AssistantConversationsScreen extends ConsumerStatefulWidget {
  const AssistantConversationsScreen({super.key});

  @override
  ConsumerState<AssistantConversationsScreen> createState() =>
      _AssistantConversationsScreenState();
}

class _AssistantConversationsScreenState
    extends ConsumerState<AssistantConversationsScreen> {
  var _creating = false;

  Future<void> _newChat() async {
    if (_creating) return;
    setState(() => _creating = true);
    try {
      final convo =
          await ref.read(assistantRepositoryProvider).createConversation();
      if (!mounted) return;
      await context.push('/patient/assistant/${convo.id}', extra: convo);
      ref.invalidate(assistantConversationsProvider);
    } on ApiException catch (e) {
      if (mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _creating = false);
    }
  }

  Future<void> _openChat(ConversationModel convo) async {
    await context.push('/patient/assistant/${convo.id}', extra: convo);
    if (mounted) ref.invalidate(assistantConversationsProvider);
  }

  Future<void> _delete(ConversationModel convo) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.t.assistant.deleteTitle),
        content: Text(context.t.assistant.deleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.t.common.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref.read(assistantRepositoryProvider).deleteConversation(convo.id);
      ref.invalidate(assistantConversationsProvider);
    } on ApiException catch (e) {
      if (mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(assistantConversationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.t.assistant.title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _creating ? null : _newChat,
        icon: _creating
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : const Icon(Icons.add_comment_outlined),
        label: Text(context.t.assistant.newChat),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(assistantConversationsProvider),
        color: AppColors.primary,
        child: ResponsiveBody(
          child: async.when(
            loading: () => ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: const [
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
              ],
            ),
            error: (_, _) => EmptyState(
              icon: Icons.cloud_off_outlined,
              title: context.t.common.somethingWrong,
              subtitle: context.t.assistant.couldNotLoad,
              actionLabel: context.t.common.retry,
              onAction: () => ref.invalidate(assistantConversationsProvider),
            ),
            data: (conversations) {
              if (conversations.isEmpty) {
                return EmptyState(
                  icon: Icons.health_and_safety_outlined,
                  title: context.t.assistant.empty,
                  subtitle: context.t.assistant.emptySubtitle,
                  actionLabel: context.t.assistant.newChat,
                  onAction: _newChat,
                );
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.md, AppSpacing.md, 88),
                itemCount: conversations.length,
                itemBuilder: (context, i) => AnimatedEntrance(
                  index: i,
                  child: _ConversationCard(
                    conversation: conversations[i],
                    onTap: () => _openChat(conversations[i]),
                    onDelete: () => _delete(conversations[i]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ConversationCard extends StatelessWidget {
  const _ConversationCard({
    required this.conversation,
    required this.onTap,
    required this.onDelete,
  });

  final ConversationModel conversation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final preview = conversation.lastMessagePreview.trim();

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: c.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(Icons.smart_toy_outlined,
                size: 22, color: c.primaryText),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  preview.isEmpty
                      ? context.t.assistant.newConversation
                      : preview,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(3),
                Text(
                  DateFormat('d MMM, HH:mm').format(conversation.updatedAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: context.t.common.delete,
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline_rounded,
                size: 20, color: c.textSecondary),
          ),
        ],
      ),
    );
  }
}
