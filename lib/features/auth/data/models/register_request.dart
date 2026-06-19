class RegisterRequest {
  const RegisterRequest({
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.phone = '',
  });

  final String email;
  final String password;
  final String passwordConfirm;
  final String role;
  final String firstName;
  final String lastName;
  final String phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'email': email,
      'password': password,
      'password_confirm': passwordConfirm,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
    };
    if (phone.isNotEmpty) map['phone'] = phone;
    return map;
  }
}
