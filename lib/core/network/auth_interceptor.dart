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
  final List<({RequestOptions options, ErrorInterceptorHandler handler})> _pendingQueue = [];

  static const _noAuthPaths = [
    '/login/', '/register/', '/token/refresh/',
    '/password/reset/', '/password/reset/confirm/',
  ];

  bool _skipAuth(String path) => _noAuthPaths.any((p) => path.endsWith(p));

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
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final data = err.response?.data;
    final code = data is Map ? data['code'] as String? : null;

    if (code == 'token_blacklisted' || code == 'token_invalid' || code == 'not_authenticated') {
      _forceLogoutAndDrain();
      return handler.next(err);
    }

    // Queue subsequent 401s while a refresh is already in flight
    if (_isRefreshing) {
      _pendingQueue.add((options: err.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;
    try {
      final refreshToken = await storage.getRefreshToken();
      if (refreshToken == null) {
        _forceLogoutAndDrain();
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

      final newAccessToken = responseData['access'] as String;
      final newRefreshToken = responseData['refresh'] as String;

      await storage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
        role: responseData['role'] as String? ?? await storage.getUserRole() ?? '',
        userId: responseData['user_id'] as String? ?? await storage.getUserId() ?? '',
        email: await storage.getUserEmail() ?? '',
      );

      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      final retryResponse = await dio.fetch(retryOptions);
      handler.resolve(retryResponse);

      _drainQueue(newAccessToken);
    } catch (_) {
      _forceLogoutAndDrain();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  void _forceLogoutAndDrain() {
    onForceLogout();
    final pending = List.of(_pendingQueue);
    _pendingQueue.clear();
    for (final entry in pending) {
      entry.handler.next(DioException(requestOptions: entry.options));
    }
  }

  void _drainQueue(String newAccessToken) {
    final pending = List.of(_pendingQueue);
    _pendingQueue.clear();
    for (final entry in pending) {
      entry.options.headers['Authorization'] = 'Bearer $newAccessToken';
      dio.fetch(entry.options).then(
        (response) => entry.handler.resolve(response),
        onError: (e) {
          if (e is DioException) {
            entry.handler.next(e);
          } else {
            entry.handler.next(DioException(requestOptions: entry.options));
          }
        },
      );
    }
  }
}
