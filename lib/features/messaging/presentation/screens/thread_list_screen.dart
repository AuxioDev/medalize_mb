import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_badge.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/messaging/data/models/messaging_models.dart';
import 'package:medalize_mb/features/messaging/providers/messaging_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// List of conversations for the signed-in user (patient or doctor — the
/// backend already filters by `request.user`, so this one screen serves both
/// `/patient/messages` and `/doctor/messages`).
class ThreadListScreen extends ConsumerWidget {
  const ThreadListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final asDoctor = auth is AuthAuthenticated && auth.role == 'doctor';
    final async = ref.watch(threadsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.t.messaging.title)),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(threadsProvider),
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
              subtitle: context.t.common.tryAgain,
              actionLabel: context.t.common.retry,
              onAction: () => ref.invalidate(threadsProvider),
            ),
            data: (threads) {
              if (threads.isEmpty) {
                return EmptyState(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: context.t.messaging.empty,
                  subtitle: context.t.messaging.emptySubtitle,
                );
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: threads.length,
                itemBuilder: (context, i) => AnimatedEntrance(
                  index: i,
                  child: _ThreadCard(thread: threads[i], asDoctor: asDoctor),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ThreadCard extends StatelessWidget {
  const _ThreadCard({required this.thread, required this.asDoctor});

  final ThreadModel thread;
  final bool asDoctor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final counterpart = thread.counterpart(asDoctor: asDoctor);
    final preview = thread.lastMessage?.body.trim() ?? '';

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        final path = asDoctor
            ? '/doctor/messages/${thread.id}'
            : '/patient/messages/${thread.id}';
        context.push(path, extra: thread);
      },
      child: Row(
        children: [
          GradientAvatar(
            initials: counterpart.firstName.isNotEmpty
                ? counterpart.firstName
                : counterpart.lastName,
            size: 44,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  counterpart.fullName,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(3),
                Text(
                  preview.isEmpty ? context.t.messaging.typeMessage : preview,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: c.textSecondary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('d MMM, HH:mm').format(thread.updatedAt),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              if (thread.unreadCount > 0) ...[
                const Gap(4),
                AppBadge(
                  label: thread.unreadCount > 99 ? '99+' : '${thread.unreadCount}',
                  color: AppColors.primary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
