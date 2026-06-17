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

ApiException parseApiException(Object err) {
  // Imported and used by repository — keeps error parsing in one place
  return const NetworkException();
}
