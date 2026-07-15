import 'package:dio/dio.dart';
import 'package:medalize_mb/core/config/app_config.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.storage,
    required this.dio,
    required this.onForceLogout,
    Dio? refreshDio,
  }) : _injectedRefreshDio = refreshDio;

  final SecureStorage storage;
  final Dio dio;
  final Future<void> Function() onForceLogout;
  // Overrides the Dio used for the token-refresh POST — tests inject one
  // wired to a fake adapter so the refresh response is controllable; unset in
  // production, where a fresh plain Dio is created per refresh (see below).
  final Dio? _injectedRefreshDio;

  bool _isRefreshing = false;
  bool _isForceLoggingOut = false;
  final List<({RequestOptions options, ErrorInterceptorHandler handler})> _pendingQueue = [];

  static const _noAuthPaths = {
    '/auth/login/', '/auth/register/', '/auth/token/refresh/',
    '/auth/password/reset/', '/auth/password/reset/confirm/',
    '/auth/social/google/', '/auth/social/apple/',
  };

  bool _skipAuth(String path) {
    // Normalise: add trailing slash if missing so both /auth/login and
    // /auth/login/ match set entries that always end with '/'.
    final normalised = path.endsWith('/') ? path : '$path/';
    return _noAuthPaths.contains(normalised);
  }

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
      // Identifies this device on authenticated calls so the backend can mark
      // the current entry in the active-sessions list (GET /auth/devices/).
      // Unauthenticated auth endpoints already carry device fields in their
      // bodies.
      final deviceId = await storage.getDeviceId();
      if (deviceId != null) {
        options.headers['X-Device-Id'] = deviceId;
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Auth endpoints (login / register / refresh / password reset) legitimately
    // return 401/400 — e.g. wrong credentials. They must NEVER trigger the
    // token-refresh / force-logout machinery: doing so calls forceLogout(),
    // whose async storage wipe overwrites the AuthError state the screen needs
    // to show the message. Pass their errors straight through to the caller.
    if (_skipAuth(err.requestOptions.path)) {
      return handler.next(err);
    }

    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final data = err.response?.data;
    final code = data is Map ? data['code'] as String? : null;

    if (code == 'token_blacklisted' || code == 'token_invalid' || code == 'not_authenticated') {
      _forceLogoutAndDrain(err);
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
        _forceLogoutAndDrain(err);
        return handler.next(err);
      }

      final refreshDio = _injectedRefreshDio ??
          Dio(BaseOptions(
            baseUrl: AppConfig.baseUrl,
            connectTimeout: AppConfig.connectTimeout,
            receiveTimeout: AppConfig.receiveTimeout,
          ));

      // Device identity accompanies the refresh so the backend can update
      // this device's entry (jti + last_seen_at) in the sessions list.
      final deviceId = await storage.getDeviceId();
      final deviceName = await storage.getDeviceName();
      final devicePlatform = await storage.getDevicePlatform();
      final res = await refreshDio.post(
        '/auth/token/refresh/',
        data: {
          'refresh': refreshToken,
          'device_id': ?deviceId,
          'device_name': ?deviceName,
          'platform': ?devicePlatform,
        },
      );
      final responseData = res.data as Map<String, dynamic>;

      if (_isForceLoggingOut) {
        // A concurrent request (e.g. a token_blacklisted 401) already forced a
        // logout while this refresh was in flight. Don't resurrect the
        // session with a stale "successful" refresh — discard it and flush
        // anything that queued up in the meantime.
        _forceLogoutAndDrain(err);
        handler.next(err);
        return;
      }

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
      _forceLogoutAndDrain(err);
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  void _forceLogoutAndDrain(DioException triggeringError) {
    // onForceLogout() must fire at most once per force-logout episode: two
    // requests can independently discover a blacklisted/invalid token around
    // the same time (e.g. right after a session revoke), and without this
    // guard each would call it, double-navigating/double-clearing state.
    // The queue is still drained every call, since later 401s can add fresh
    // entries after the first trigger already emptied it once.
    if (!_isForceLoggingOut) {
      _isForceLoggingOut = true;
      onForceLogout();
    }
    final pending = List.of(_pendingQueue);
    _pendingQueue.clear();
    for (final entry in pending) {
      entry.handler.next(DioException(
        requestOptions: entry.options,
        response: triggeringError.response,
        type: triggeringError.type,
        error: triggeringError.error,
      ));
    }
  }

  /// Clears the force-logout latch after a fresh, successful sign-in. Without
  /// this, a logout forced earlier in the same app process would silently
  /// disable 401-queue draining (see [_drainQueue]) for the rest of the
  /// process's lifetime — this interceptor is a long-lived singleton reused
  /// across login/logout cycles, not recreated per session. Called from
  /// [AuthNotifier._applyAuthResponse].
  void resetForceLogoutState() {
    _isForceLoggingOut = false;
  }

  void _drainQueue(String newAccessToken) {
    // Do nothing if force logout already fired — queued requests are already
    // resolved with an error by _forceLogoutAndDrain.
    if (_isForceLoggingOut) return;
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
