import 'package:medalize_mb/core/errors/api_exception.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
    required this.userId,
    required this.email,
    required this.onboardingComplete,
    this.isVerified,
  });

  final String accessToken;
  final String refreshToken;
  final String role;
  final String userId;
  final String email;
  final bool onboardingComplete;
  final bool? isVerified;
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  const AuthError(this.exception);
  final ApiException exception;
}
