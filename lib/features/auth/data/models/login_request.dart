class LoginRequest {
  const LoginRequest({
    required this.email,
    required this.password,
    this.rememberMe = false,
    this.deviceId,
    this.deviceName,
    this.platform,
  });

  final String email;
  final String password;
  final bool rememberMe;

  // Device identity (see DeviceIdentity) — lets the backend track this
  // session in the active-devices list. Optional so the model stays usable
  // when identity resolution fails.
  final String? deviceId;
  final String? deviceName;
  final String? platform;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'remember_me': rememberMe,
        'device_id': ?deviceId,
        'device_name': ?deviceName,
        'platform': ?platform,
      };
}
