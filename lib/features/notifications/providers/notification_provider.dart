import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/notifications/data/models/notification_model.dart';
import 'package:medalize_mb/features/notifications/data/repository/notification_repository.dart';

final notificationsProvider = FutureProvider<List<NotificationModel>>((ref) {
  return ref.read(notificationRepositoryProvider).getNotifications();
});

final unreadCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsProvider).when(
        data: (list) => list.where((n) => !n.isRead).length,
        loading: () => 0,
        error: (_, __) => 0,
      );
});
