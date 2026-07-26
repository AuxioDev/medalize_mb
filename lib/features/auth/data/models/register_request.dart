class RegisterRequest {
  const RegisterRequest({
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.privacyConsent,
    this.phone = '',
  });

  final String email;
  final String password;
  final String passwordConfirm;
  final String role;
  final String firstName;
  final String lastName;
  // Backend re-validates this and rejects registration if false — see
  // apps.users.serializers.RegisterSerializer.validate_privacy_consent.
  // Required (not defaulted to true) so no call site can forget to wire it
  // up to an actual user action.
  final bool privacyConsent;
  final String phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'email': email,
      'password': password,
      'password_confirm': passwordConfirm,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
      'privacy_consent': privacyConsent,
    };
    if (phone.isNotEmpty) map['phone'] = phone;
    return map;
  }
}
