import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/auth/data/models/login_request.dart';
import 'package:medalize_mb/features/auth/data/models/login_response.dart';
import 'package:medalize_mb/features/auth/data/models/register_request.dart';
import 'package:medalize_mb/features/auth/data/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read(dioClientProvider)),
);

class AuthRepository {
  const AuthRepository(this._dio);

  final Dio _dio;

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final res = await _dio.post('/login/', data: request.toJson());
      return LoginResponse.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> register(RegisterRequest request) async {
    try {
      await _dio.post('/register/', data: request.toJson());
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<LoginResponse> refreshToken(String refreshToken) async {
    try {
      final res =
          await _dio.post('/token/refresh/', data: {'refresh': refreshToken});
      return LoginResponse.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> logout({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await _dio.post(
        '/logout/',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<UserModel> getMe() async {
    try {
      final res = await _dio.get('/me/');
      return UserModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      await _dio.post('/password/reset/', data: {'email': email});
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  ApiException _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return NetworkException(e.message ?? 'Network error');
    }

    final response = e.response;
    if (response == null) return const NetworkException();

    final data = response.data;
    final code = data is Map ? data['code'] as String? : null;

    switch (code) {
      case 'invalid_credentials':
        return InvalidCredentialsException(
            data['message'] as String? ?? 'Invalid email or password');
      case 'token_expired':
        return const TokenExpiredException();
      case 'token_invalid':
        return const TokenInvalidException();
      case 'token_blacklisted':
        return const TokenBlacklistedException();
      case 'not_authenticated':
        return const TokenInvalidException();
      case 'rate_limit_exceeded':
        return RateLimitException(
            retryAfterSeconds: data['retry_after_seconds'] as int?);
      case 'permission_denied':
        return PermissionDeniedException(role: data['role'] as String?);
      case 'validation_error':
        final raw = data['errors'];
        final errors = <String, List<String>>{};
        if (raw is Map) {
          raw.forEach((key, value) {
            if (value is List) {
              errors[key as String] = value.map((e) => e.toString()).toList();
            } else if (value is String) {
              errors[key as String] = [value];
            }
          });
        }
        return ValidationException(fieldErrors: errors);
      default:
        return ServerException(response.statusCode ?? 500);
    }
  }
}
