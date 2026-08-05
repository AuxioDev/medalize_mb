import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/notifications/data/models/notification_model.dart';
import 'package:medalize_mb/features/notifications/data/models/notification_preferences_model.dart';
import 'package:medalize_mb/features/notifications/data/repository/notification_repository.dart';

/// `autoDispose`: holds the signed-in user's own notification preferences —
/// must not survive a logout/login as someone else on a shared device.
/// Disposed once nothing is watching it, which the auth redirect guarantees
/// happens on both logout and the next login (see `medicationsProvider` for
/// the full rationale).
final notificationPreferencesProvider =
    FutureProvider.autoDispose<NotificationPreferences>((ref) {
  return ref.read(notificationRepositoryProvider).getPreferences();
});

/// `autoDispose` — same per-user-data rationale as
/// [notificationPreferencesProvider]; disposing also stops the periodic
/// refresh timer via `ref.onDispose` below.
final notificationsProvider = FutureProvider.autoDispose<List<NotificationModel>>((ref) async {
  // Auto-refresh every 60 seconds while the provider is alive.
  final timer = Timer.periodic(const Duration(seconds: 60), (_) {
    ref.invalidateSelf();
  });
  ref.onDispose(timer.cancel);
  return ref.read(notificationRepositoryProvider).getNotifications();
});

/// `autoDispose`: required because it watches [notificationsProvider], which
/// is itself `autoDispose`.
final unreadCountProvider = Provider.autoDispose<int>((ref) {
  return ref.watch(notificationsProvider).when(
        data: (list) => list.where((n) => !n.isRead).length,
        loading: () => 0,
        error: (_, _) => 0,
      );
});
