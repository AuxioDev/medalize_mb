import 'package:dio/dio.dart';

sealed class ApiException implements Exception {
  const ApiException();

  String get userMessage;
}

class InvalidCredentialsException extends ApiException {
  const InvalidCredentialsException([this.message = 'Invalid email or password']);
  final String message;
  @override
  String get userMessage => message;
}

class TokenExpiredException extends ApiException {
  const TokenExpiredException();
  @override
  String get userMessage => 'Session expired. Please sign in again.';
}

class TokenInvalidException extends ApiException {
  const TokenInvalidException();
  @override
  String get userMessage => 'Authentication error. Please sign in again.';
}

class TokenBlacklistedException extends ApiException {
  const TokenBlacklistedException();
  @override
  String get userMessage => 'Session was revoked. Please sign in again.';
}

class RateLimitException extends ApiException {
  const RateLimitException({this.retryAfterSeconds});
  final int? retryAfterSeconds;
  @override
  String get userMessage => retryAfterSeconds != null
      ? 'Too many attempts. Try again in ${retryAfterSeconds}s.'
      : 'Too many attempts. Please wait and try again.';
}

class PermissionDeniedException extends ApiException {
  const PermissionDeniedException({this.role});
  final String? role;
  @override
  String get userMessage => 'You do not have permission to do this.';
}

class ValidationException extends ApiException {
  const ValidationException({required this.fieldErrors, this.message});
  final Map<String, List<String>> fieldErrors;
  final String? message;

  String? firstErrorFor(String field) => fieldErrors[field]?.firstOrNull;

  String get firstError =>
      fieldErrors.values.expand((e) => e).firstOrNull ??
      message ??
      'Validation error';

  @override
  String get userMessage => firstError;
}

class NetworkException extends ApiException {
  const NetworkException([this.message = 'Network error. Check your connection.']);
  final String message;
  @override
  String get userMessage => message;
}

class ServerException extends ApiException {
  const ServerException(this.statusCode);
  final int statusCode;
  @override
  String get userMessage => 'Server error ($statusCode). Please try again.';
}

ApiException mapDioError(Object err) {
  if (err is! DioException) return const NetworkException();

  if (err.type == DioExceptionType.connectionTimeout ||
      err.type == DioExceptionType.receiveTimeout ||
      err.type == DioExceptionType.connectionError) {
    return NetworkException(err.message ?? 'Network error');
  }

  final response = err.response;
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
