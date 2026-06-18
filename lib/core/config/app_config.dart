import 'dart:io';

abstract final class AppConfig {
  // Compile-time override: flutter run --dart-define=API_BASE_URL=https://...
  static const _envUrl = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl =>
      _envUrl.isNotEmpty ? _envUrl : _defaultUrl;

  // Android emulator reaches host via 10.0.2.2; iOS simulator uses 127.0.0.1
  static String get _defaultUrl =>
      'http://${Platform.isAndroid ? '10.0.2.2' : '127.0.0.1'}:8000/api/auth';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
