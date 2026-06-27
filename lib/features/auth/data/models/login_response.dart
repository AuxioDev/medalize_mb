class LoginResponse {
  const LoginResponse({
    required this.access,
    required this.refresh,
    required this.role,
    required this.userId,
    required this.email,
    required this.onboardingComplete,
    this.isVerified,
    this.firstName = '',
    this.lastName = '',
  });

  final String access;
  final String refresh;
  final String role;
  final String userId;
  final String email;
  final bool onboardingComplete;
  final bool? isVerified;
  final String firstName;
  final String lastName;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final access = json['access'] as String?;
    final refresh = json['refresh'] as String?;
    final role = json['role'] as String?;
    final userId = json['user_id'] as String?;
    final email = json['email'] as String?;

    if (access == null || refresh == null || role == null || userId == null || email == null) {
      throw FormatException('Incomplete login response: $json');
    }

    return LoginResponse(
      access: access,
      refresh: refresh,
      role: role,
      userId: userId,
      email: email,
      onboardingComplete: json['onboarding_complete'] as bool? ?? false,
      isVerified: json['is_verified'] as bool?,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
    );
  }
}
