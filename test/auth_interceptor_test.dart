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

void main() {
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
