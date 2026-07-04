import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

abstract final class AppConfig {
  // Compile-time override: flutter run --dart-define=API_BASE_URL=https://...
  static const _envUrl = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    final url = _envUrl.isNotEmpty ? _envUrl : _defaultUrl;
    // Enforce HTTPS in release/profile builds. An assert() is stripped from
    // non-debug builds and would provide no protection, so this is a real
    // runtime check.
    if (!kDebugMode && !url.startsWith('https://')) {
      throw StateError('API_BASE_URL must use HTTPS in release builds. Got: $url');
    }
    return url;
  }

  static String get _defaultUrl {
    if (kIsWeb) return 'http://localhost:8000/api';
    return 'http://${Platform.isAndroid ? '10.0.2.2' : '127.0.0.1'}:8000/api';
  }

  static const Duration connectTimeout = Duration(seconds: 10);
  // 60 s covers slow connections and large uploads (diploma PDFs).
  static const Duration receiveTimeout = Duration(seconds: 60);

  // ── Social sign-in ────────────────────────────────────────────────────────
  // PLACEHOLDERS: real values come from Google Cloud Console after the app
  // (az.medalize.app) is registered there. Override at build time:
  //   flutter run --dart-define=GOOGLE_SERVER_CLIENT_ID=xxx.apps.googleusercontent.com
  //
  // The *server* (web-type) client ID is what the backend verifies as the
  // id_token audience — it must match the backend's expected value.
  static const googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue:
        'REPLACE_WITH_GOOGLE_WEB_CLIENT_ID.apps.googleusercontent.com',
  );

  // iOS-type client ID. Normally read from GoogleService-Info.plist, but the
  // bundled plist is a placeholder, so it can also be injected here.
  static const googleIosClientId = String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
    defaultValue: '',
  );

  /// True when [value] holds a real (non-placeholder) configuration value.
  static bool isConfigured(String value) =>
      value.isNotEmpty && !value.startsWith('REPLACE_WITH');
}
