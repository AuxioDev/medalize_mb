class RegisterRequest {
  const RegisterRequest({
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.role,
    required this.firstName,
    required this.lastName,
  });

  final String email;
  final String password;
  final String passwordConfirm;
  final String role;
  final String firstName;
  final String lastName;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'password_confirm': passwordConfirm,
        'role': role,
        'first_name': firstName,
        'last_name': lastName,
      };
}
