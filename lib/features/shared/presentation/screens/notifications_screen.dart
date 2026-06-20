import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
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
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications'));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(notificationsProvider),
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (_, i) => _NotificationTile(
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
          );
        },
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
    final fmt = DateFormat('d MMM, HH:mm');
    return InkWell(
      onTap: onRead,
      child: Container(
        color: notification.isRead
            ? null
            : AppColors.primary.withValues(alpha: 0.05),
        child: ListTile(
          leading: Icon(
            _iconFor(notification.type),
            color: notification.isRead ? Colors.grey : AppColors.primary,
          ),
          title: Text(
            notification.title,
            style: TextStyle(
              fontWeight:
                  notification.isRead ? FontWeight.normal : FontWeight.w600,
            ),
          ),
          subtitle: Text(notification.message),
          trailing: Text(
            fmt.format(notification.sentAt),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
