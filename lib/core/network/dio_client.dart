import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/config/app_config.dart';
import 'package:medalize_mb/core/network/auth_interceptor.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';

final secureStorageProvider = Provider<SecureStorage>((_) => SecureStorage());

/// Logs requests/responses without exposing sensitive payloads.
/// Auth paths (login, register, password reset) have their bodies redacted.
class _SanitisedLogger extends Interceptor {
  static const _sensitivePathPrefixes = [
    '/auth/login',
    '/auth/register',
    '/auth/password',
    '/auth/token',
  ];

  bool _isSensitive(String path) =>
      _sensitivePathPrefixes.any((p) => path.startsWith(p));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final tag = _isSensitive(options.path) ? ' [body redacted]' : '';
    debugPrint('[DIO] → ${options.method} ${options.path}$tag');
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint('[DIO] ← ${response.statusCode} ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('[DIO] ✗ ${err.response?.statusCode} ${err.requestOptions.path}: ${err.message}');
    handler.next(err);
  }
}

final dioClientProvider = Provider<Dio>((ref) {
  final storage = ref.read(secureStorageProvider);

  final dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: AppConfig.connectTimeout,
    receiveTimeout: AppConfig.receiveTimeout,
    headers: {'Content-Type': 'application/json'},
  ));

  dio.interceptors.add(AuthInterceptor(
    storage: storage,
    dio: dio,
    onForceLogout: () => ref.read(authProvider.notifier).forceLogout(),
  ));

  if (kDebugMode) {
    dio.interceptors.add(_SanitisedLogger());
  }

  return dio;
});
