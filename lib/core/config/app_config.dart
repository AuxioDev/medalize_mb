import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

abstract final class AppConfig {
  // Compile-time override: flutter run --dart-define=API_BASE_URL=https://...
  static const _envUrl = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    final url = _envUrl.isNotEmpty ? _envUrl : _defaultUrl;
    assert(
      kDebugMode || url.startsWith('https://'),
      'API_BASE_URL must use HTTPS in release builds. Got: $url',
    );
    return url;
  }

  static String get _defaultUrl {
    if (kIsWeb) return 'http://localhost:8000/api';
    return 'http://${Platform.isAndroid ? '10.0.2.2' : '127.0.0.1'}:8000/api';
  }

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
