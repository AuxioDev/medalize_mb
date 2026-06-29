import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/services/navigator_key.dart';
import 'package:medalize_mb/features/notifications/data/repository/notification_repository.dart';

final fcmServiceProvider = Provider<FcmService>((ref) {
  return FcmService(ref.read(notificationRepositoryProvider));
});

final _localNotifications = FlutterLocalNotificationsPlugin();

const _androidChannel = AndroidNotificationChannel(
  'medalize_high',
  'Medalize Notifications',
  description: 'Appointment and booking alerts',
  importance: Importance.high,
);

class FcmService {
  FcmService(this._repo);
  final NotificationRepository _repo;

  Future<void> init() async {
    // Local notifications setup
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    await _localNotifications.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: (details) {
        // Tapping a local (foreground) banner navigates to notifications
        _navigateToNotifications();
      },
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);

    // FCM permission + token. Guarded so a missing/placeholder Firebase config
    // (before the real project is registered) degrades gracefully instead of
    // breaking login — local notifications above still work.
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(alert: true, badge: true, sound: true);
      final token = await messaging.getToken();
      if (token != null) await _registerToken(token);
      messaging.onTokenRefresh.listen(_registerToken);

      // Message handlers
      FirebaseMessaging.onMessage.listen(_handleForeground);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleTap);
      final initial = await messaging.getInitialMessage();
      if (initial != null) _handleTap(initial);
    } catch (e) {
      debugPrint('FCM setup skipped (push notifications disabled): $e');
    }
  }

  Future<void> _registerToken(String token) async {
    try {
      await _repo.registerFCMToken(token);
    } catch (_) {}
  }

  Future<void> _handleForeground(RemoteMessage message) async {
    final n = message.notification;
    if (n == null) return;
    await _localNotifications.show(
      message.hashCode,
      n.title,
      n.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  void _handleTap(RemoteMessage message) {
    _navigateToNotifications();
  }

  void _navigateToNotifications() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      GoRouter.of(context).go('/shared/notifications');
    }
  }
}
