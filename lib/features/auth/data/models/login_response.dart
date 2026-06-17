class LoginResponse {
  const LoginResponse({
    required this.access,
    required this.refresh,
    required this.role,
    required this.userId,
    required this.email,
    required this.onboardingComplete,
    this.isVerified,
  });

  final String access;
  final String refresh;
  final String role;
  final String userId;
  final String email;
  final bool onboardingComplete;
  final bool? isVerified;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        access: json['access'] as String,
        refresh: json['refresh'] as String,
        role: json['role'] as String,
        userId: json['user_id'] as String,
        email: json['email'] as String,
        onboardingComplete: json['onboarding_complete'] as bool? ?? false,
        isVerified: json['is_verified'] as bool?,
      );
}
