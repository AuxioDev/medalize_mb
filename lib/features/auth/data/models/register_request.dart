class RegisterRequest {
  const RegisterRequest({
    required this.phone,
    required this.password,
    required this.passwordConfirm,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.privacyConsent,
    this.hospitalId,
    this.hospitalName = '',
    this.hospitalCity = '',
    this.hospitalAddress = '',
  });

  // E.164 (e.g. '+994501234567') — the login identifier. See
  // apps.users.phone.normalize_az_phone on the backend.
  final String phone;
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

  /// role == 'hospital' only — see apps.hospitals.services.
  /// claim_or_create_hospital: either [hospitalId] (claiming a registry
  /// entry the picker found) or [hospitalName]+[hospitalCity] (no match —
  /// create a new one) must be set, never both.
  final String? hospitalId;
  final String hospitalName;
  final String hospitalCity;
  final String hospitalAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'phone': phone,
      'password': password,
      'password_confirm': passwordConfirm,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
      'privacy_consent': privacyConsent,
    };
    if (hospitalId != null) map['hospital_id'] = hospitalId;
    if (hospitalName.isNotEmpty) map['hospital_name'] = hospitalName;
    if (hospitalCity.isNotEmpty) map['hospital_city'] = hospitalCity;
    if (hospitalAddress.isNotEmpty) map['hospital_address'] = hospitalAddress;
    return map;
  }
}
