import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/notifications/data/repository/notification_repository.dart';

final fcmServiceProvider = Provider<FcmService>((ref) {
  return FcmService(ref.read(notificationRepositoryProvider));
});

class FcmService {
  FcmService(this._repo);
  final NotificationRepository _repo;

  Future<void> init() async {
    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final token = await messaging.getToken();
    if (token != null) {
      await _registerToken(token);
    }

    messaging.onTokenRefresh.listen(_registerToken);

    FirebaseMessaging.onMessage.listen(_handleForeground);
  }

  Future<void> _registerToken(String token) async {
    try {
      await _repo.registerFCMToken(token);
    } catch (_) {}
  }

  void _handleForeground(RemoteMessage message) {
    // In-app notifications are already shown via the notification bell.
    // Future: show a local notification banner here.
  }
}
