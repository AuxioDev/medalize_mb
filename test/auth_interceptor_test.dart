import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/network/auth_interceptor.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';

/// Returns a canned HTTP response for every request, so the interceptor can be
/// exercised without a real server.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.statusCode, this.body);
  final int statusCode;
  final Map<String, dynamic> body;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

/// Returns a scripted response per request path so different concurrent
/// requests can be driven through different outcomes in one test.
class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(this._handlers);
  final Map<String, Future<ResponseBody> Function()> _handlers;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    final handler = _handlers[options.path];
    if (handler == null) {
      throw StateError('No scripted handler for ${options.path}');
    }
    return handler();
  }
}

ResponseBody _jsonResponse(int statusCode, Map<String, dynamic> body) =>
    ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

/// Avoids touching the real flutter_secure_storage platform channel, which
/// isn't available under plain `test()` (no Flutter binding).
class _FakeStorage extends SecureStorage {
  String? savedAccessToken;

  @override
  Future<String?> getAccessToken() async => 'stored-access-token';
  @override
  Future<String?> getRefreshToken() async => 'stored-refresh-token';
  @override
  Future<String?> getDeviceId() async => null;
  @override
  Future<String?> getDeviceName() async => null;
  @override
  Future<String?> getDevicePlatform() async => null;
  @override
  Future<String?> getUserRole() async => 'patient';
  @override
  Future<String?> getUserId() async => 'u1';
  @override
  Future<String?> getUserEmail() async => 'a@b.co';
  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String role,
    required String userId,
    required String email,
  }) async {
    savedAccessToken = accessToken;
  }
}

void main() {
  test(
      'a concurrent force-logout is not undone by an in-flight refresh that '
      'succeeds afterwards', () async {
    var forceLogoutCalls = 0;
    final storage = _FakeStorage();
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
    final adapter = _ScriptedAdapter({
      // Request A: a plain 401 that triggers the refresh flow.
      '/patient/a': () async => _jsonResponse(401, {'code': 'general_401'}),
      // Request B: a blacklisted-token 401 that must force-logout immediately,
      // without waiting for A's in-flight refresh.
      '/patient/b': () async =>
          _jsonResponse(401, {'code': 'token_blacklisted'}),
      // A's refresh: deliberately delayed so B's force-logout can land while
      // it's still in flight.
      '/auth/token/refresh/': () async {
        await Future.delayed(const Duration(milliseconds: 30));
        return _jsonResponse(200, {
          'access': 'new-access',
          'refresh': 'new-refresh',
          'role': 'patient',
          'user_id': 'u1',
        });
      },
    });
    dio.httpClientAdapter = adapter;
    // The interceptor posts the refresh on its own internal Dio — inject one
    // wired to the same scripted adapter so that call is controllable too,
    // instead of hitting the real network via AppConfig.baseUrl.
    final refreshDio = Dio(BaseOptions(baseUrl: 'http://localhost/api'))
      ..httpClientAdapter = adapter;
    dio.interceptors.add(AuthInterceptor(
      storage: storage,
      dio: dio,
      refreshDio: refreshDio,
      onForceLogout: () async {
        forceLogoutCalls++;
      },
    ));

    final futureA =
        dio.get<void>('/patient/a').then<Object>((r) => r).catchError((e) => e);
    // Let A's onError run past its first await (into the refresh call)
    // before firing B, so they genuinely interleave.
    await Future.delayed(const Duration(milliseconds: 5));
    final futureB =
        dio.get<void>('/patient/b').then<Object>((r) => r).catchError((e) => e);

    final resultA = await futureA;
    final resultB = await futureB;

    expect(forceLogoutCalls, 1,
        reason: 'onForceLogout must fire exactly once, not per failing request');
    expect(resultA, isA<DioException>(),
        reason:
            "A's own request must not resolve as a success once a concurrent "
            'force-logout has fired — that would resurrect a killed session');
    expect(resultB, isA<DioException>());
    expect(storage.savedAccessToken, isNull,
        reason: 'the stale refresh must never be persisted after a concurrent '
            'force-logout');
  });

  test('resetForceLogoutState re-enables queue draining for a new session',
      () async {
    var forceLogoutCalls = 0;
    final storage = _FakeStorage();
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
    var refreshCall = 0;
    var patientBCall = 0;
    final adapter = _ScriptedAdapter({
      '/patient/a': () async => _jsonResponse(401, {'code': 'token_blacklisted'}),
      '/patient/b': () async {
        patientBCall++;
        // First call: 401 to trigger a refresh. Retry (after refresh): success.
        if (patientBCall == 1) return _jsonResponse(401, {'code': 'general_401'});
        return _jsonResponse(200, {'ok': true});
      },
      '/auth/token/refresh/': () async {
        refreshCall++;
        return _jsonResponse(200, {
          'access': 'access-$refreshCall',
          'refresh': 'refresh-$refreshCall',
          'role': 'patient',
          'user_id': 'u1',
        });
      },
    });
    dio.httpClientAdapter = adapter;
    final refreshDio = Dio(BaseOptions(baseUrl: 'http://localhost/api'))
      ..httpClientAdapter = adapter;
    final interceptor = AuthInterceptor(
      storage: storage,
      dio: dio,
      refreshDio: refreshDio,
      onForceLogout: () async {
        forceLogoutCalls++;
      },
    );
    dio.interceptors.add(interceptor);

    // First episode: force-logout fires and latches _isForceLoggingOut.
    try {
      await dio.get<void>('/patient/a');
    } on DioException {
      // expected
    }
    expect(forceLogoutCalls, 1);

    // A brand-new session begins (equivalent to AuthNotifier._applyAuthResponse).
    interceptor.resetForceLogoutState();

    // A later 401 unrelated to the first episode must be able to refresh and
    // resolve normally again — proving the latch no longer blocks draining.
    final result =
        await dio.get<void>('/patient/b').then<Object>((r) => r).catchError((e) => e);
    expect(result, isA<Response>(),
        reason: 'after resetForceLogoutState(), a normal 401 must refresh and '
            'retry successfully again, not be silently dropped');
  });

  test('login 401 is passed through without forcing logout', () async {
    // Regression guard: a wrong-credentials 401 from /auth/login/ used to hit
    // the token-refresh path, whose forceLogout() async storage wipe overwrote
    // the AuthError state — so the "Invalid email or password" message never
    // showed. The interceptor must now pass auth-endpoint errors straight
    // through, untouched.
    var forcedOut = false;
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
    dio.httpClientAdapter = _FakeAdapter(
      401,
      {'code': 'invalid_credentials', 'message': 'Invalid email or password.'},
    );
    dio.interceptors.add(AuthInterceptor(
      storage: SecureStorage(),
      dio: dio,
      onForceLogout: () async {
        forcedOut = true;
      },
    ));

    DioException? caught;
    try {
      await dio.post('/auth/login/', data: {'email': 'a@b.co', 'password': 'x'});
    } on DioException catch (e) {
      caught = e;
    }

    expect(caught, isNotNull);
    expect(caught!.response?.statusCode, 401);
    expect((caught.response?.data as Map)['code'], 'invalid_credentials');
    expect(forcedOut, isFalse);
  });
}
