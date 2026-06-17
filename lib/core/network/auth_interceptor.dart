import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:medalize_mb/core/config/app_config.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.storage,
    required this.dio,
    required this.onForceLogout,
  });

  final SecureStorage storage;
  final Dio dio;
  final VoidCallback onForceLogout;

  bool _isRefreshing = false;

  static const _noAuthPaths = ['/login/', '/register/', '/token/refresh/'];

  bool _skipAuth(String path) =>
      _noAuthPaths.any((p) => path.endsWith(p));

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_skipAuth(options.path)) {
      final token = await storage.getAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 || _isRefreshing) {
      return handler.next(err);
    }

    final data = err.response?.data;
    final code = data is Map ? data['code'] as String? : null;

    if (code == 'token_blacklisted' || code == 'token_invalid') {
      onForceLogout();
      return handler.next(err);
    }

    _isRefreshing = true;
    try {
      final refreshToken = await storage.getRefreshToken();
      if (refreshToken == null) {
        onForceLogout();
        return handler.next(err);
      }

      final refreshDio = Dio(BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
      ));

      final res = await refreshDio.post(
        '/token/refresh/',
        data: {'refresh': refreshToken},
      );
      final responseData = res.data as Map<String, dynamic>;

      await storage.saveTokens(
        accessToken: responseData['access'] as String,
        refreshToken: responseData['refresh'] as String,
        role: responseData['role'] as String? ?? '',
        userId: responseData['user_id'] as String? ?? '',
        email: await storage.getUserEmail() ?? '',
      );

      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] =
          'Bearer ${responseData['access']}';
      final retryResponse = await dio.fetch(retryOptions);
      handler.resolve(retryResponse);
    } catch (_) {
      onForceLogout();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }
}
