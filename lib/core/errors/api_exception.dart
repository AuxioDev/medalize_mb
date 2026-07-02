import 'package:dio/dio.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

sealed class ApiException implements Exception {
  const ApiException();

  String get userMessage;
}

class InvalidCredentialsException extends ApiException {
  /// [message] is the (already-localized) text from the backend when present;
  /// otherwise we fall back to the bundled translation.
  const InvalidCredentialsException([this.message]);
  final String? message;
  @override
  String get userMessage => message ?? t.errors.invalidCredentials;
}

class TokenExpiredException extends ApiException {
  const TokenExpiredException();
  @override
  String get userMessage => t.errors.sessionExpired;
}

class TokenInvalidException extends ApiException {
  const TokenInvalidException();
  @override
  String get userMessage => t.errors.authError;
}

class TokenBlacklistedException extends ApiException {
  const TokenBlacklistedException();
  @override
  String get userMessage => t.errors.sessionRevoked;
}

class RateLimitException extends ApiException {
  const RateLimitException({this.retryAfterSeconds});
  final int? retryAfterSeconds;
  @override
  String get userMessage => retryAfterSeconds != null
      ? t.errors.rateLimitWithSeconds(seconds: retryAfterSeconds!)
      : t.errors.rateLimit;
}

class PermissionDeniedException extends ApiException {
  const PermissionDeniedException({this.role});
  final String? role;
  @override
  String get userMessage => t.errors.permissionDenied;
}

class ValidationException extends ApiException {
  const ValidationException({required this.fieldErrors, this.message});
  final Map<String, List<String>> fieldErrors;
  final String? message;

  String? firstErrorFor(String field) => fieldErrors[field]?.firstOrNull;

  String get firstError =>
      fieldErrors.values.expand((e) => e).firstOrNull ??
      message ??
      t.errors.validationError;

  @override
  String get userMessage => firstError;
}

class NetworkException extends ApiException {
  const NetworkException([this.message]);
  final String? message;
  @override
  String get userMessage => message ?? t.errors.network;
}

class ServerException extends ApiException {
  const ServerException(this.statusCode);
  final int statusCode;
  @override
  String get userMessage => t.errors.serverError(code: statusCode);
}

ApiException mapDioError(Object err) {
  if (err is! DioException) return const NetworkException();

  // Connectivity/timeout failures: never surface Dio's raw technical message
  // (e.g. "The connection errored...") — callers show userMessage directly, so
  // fall back to the friendly localized string.
  if (err.type == DioExceptionType.connectionTimeout ||
      err.type == DioExceptionType.sendTimeout ||
      err.type == DioExceptionType.receiveTimeout ||
      err.type == DioExceptionType.connectionError) {
    return const NetworkException();
  }

  final response = err.response;
  if (response == null) return const NetworkException();

  final data = response.data;
  final code = data is Map ? data['code'] as String? : null;

  switch (code) {
    case 'invalid_credentials':
      return InvalidCredentialsException(data['message'] as String?);
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
      return _mapValidationError(data as Map);
    default:
      return ServerException(response.statusCode ?? 500);
  }
}

/// Builds a [ValidationException] from a `validation_error` payload, tolerating
/// the several shapes DRF can produce: a per-field map, a bare list/string, or
/// a top-level `detail`/`message`. Field errors are kept for form binding;
/// anything non-field is captured in [ValidationException.message] so it is
/// still shown on screens that display `userMessage` directly.
ValidationException _mapValidationError(Map data) {
  final raw = data['errors'];
  final errors = <String, List<String>>{};
  String? nonFieldMessage;

  List<String> asStringList(dynamic value) => value is List
      ? value.map((e) => e.toString()).toList()
      : [value.toString()];

  if (raw is Map) {
    raw.forEach((key, value) {
      final list = asStringList(value);
      // 'non_field_errors' / 'detail' aren't tied to a form field — surface
      // them as a general message rather than an (invisible) field error.
      if (key == 'non_field_errors' || key == 'detail') {
        nonFieldMessage ??= list.isNotEmpty ? list.first : null;
      } else {
        errors[key.toString()] = list;
      }
    });
  } else if (raw is List && raw.isNotEmpty) {
    nonFieldMessage = raw.first.toString();
  } else if (raw is String) {
    nonFieldMessage = raw;
  }

  nonFieldMessage ??= data['message'] as String? ?? data['detail'] as String?;

  return ValidationException(fieldErrors: errors, message: nonFieldMessage);
}
