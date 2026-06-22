import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/notifications/data/models/notification_model.dart';
import 'package:medalize_mb/features/notifications/data/repository/notification_repository.dart';
import 'package:medalize_mb/features/notifications/providers/notification_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ResponsiveBody(
        child: async.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
              ],
            ),
          ),
          error: (_, _) => EmptyState(
            icon: Icons.cloud_off_outlined,
            title: 'Something went wrong',
            subtitle: 'Could not load notifications',
            actionLabel: 'Retry',
            onAction: () => ref.invalidate(notificationsProvider),
          ),
          data: (notifications) {
            if (notifications.isEmpty) {
              return const EmptyState(
                icon: Icons.notifications_none_outlined,
                title: 'No notifications',
                subtitle: 'You are all caught up',
              );
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(notificationsProvider),
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: notifications.length,
                itemBuilder: (_, i) => AnimatedEntrance(
                  index: i,
                  slideY: 0.05,
                  child: _NotificationTile(
                    notification: notifications[i],
                    onRead: () async {
                      if (!notifications[i].isRead) {
                        await ref
                            .read(notificationRepositoryProvider)
                            .markRead(notifications[i].id);
                        ref.invalidate(notificationsProvider);
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.onRead});
  final NotificationModel notification;
  final VoidCallback onRead;

  IconData _iconFor(String type) => switch (type) {
        'booking_confirmed' => Icons.check_circle_outline,
        'booking_cancelled' => Icons.cancel_outlined,
        'rescheduling_required' => Icons.schedule,
        'appointment_reminder' => Icons.notifications_outlined,
        _ => Icons.info_outline,
      };

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fmt = DateFormat('d MMM, HH:mm');
    final unread = !notification.isRead;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: unread ? c.primarySurface : c.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: onRead,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: c.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: unread ? c.surface : c.background,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(
                    _iconFor(notification.type),
                    size: 20,
                    color: unread ? c.primaryText : c.textSecondary,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                color: c.textPrimary,
                                fontSize: 14,
                                fontWeight:
                                    unread ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            fmt.format(notification.sentAt),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      const Gap(3),
                      Text(
                        notification.message,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
