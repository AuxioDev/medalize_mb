import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract final class _Keys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const userRole = 'user_role';
  static const userId = 'user_id';
  static const userEmail = 'user_email';
  static const themeMode = 'theme_mode';
}

class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String role,
    required String userId,
    required String email,
  }) async {
    await Future.wait([
      _storage.write(key: _Keys.accessToken, value: accessToken),
      _storage.write(key: _Keys.refreshToken, value: refreshToken),
      _storage.write(key: _Keys.userRole, value: role),
      _storage.write(key: _Keys.userId, value: userId),
      _storage.write(key: _Keys.userEmail, value: email),
    ]);
  }

  Future<String?> getAccessToken() =>
      _storage.read(key: _Keys.accessToken);

  Future<String?> getRefreshToken() =>
      _storage.read(key: _Keys.refreshToken);

  Future<String?> getUserRole() => _storage.read(key: _Keys.userRole);
  Future<String?> getUserId() => _storage.read(key: _Keys.userId);
  Future<String?> getUserEmail() => _storage.read(key: _Keys.userEmail);

  Future<String?> getThemeMode() => _storage.read(key: _Keys.themeMode);
  Future<void> saveThemeMode(String mode) =>
      _storage.write(key: _Keys.themeMode, value: mode);

  /// Clears session data but preserves the user's theme preference.
  Future<void> clearAll() async {
    final theme = await getThemeMode();
    await _storage.deleteAll();
    if (theme != null) await saveThemeMode(theme);
  }
}
