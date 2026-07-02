import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract final class _Keys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const userRole = 'user_role';
  static const userId = 'user_id';
  static const userEmail = 'user_email';
  static const onboardingComplete = 'onboarding_complete';
  static const isVerified = 'is_verified';
  static const firstName = 'first_name';
  static const lastName = 'last_name';
  static const themeMode = 'theme_mode';
  static const language = 'app_language';
  static const favoriteDoctors = 'favorite_doctors';
}

class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    // unlocked_this_device_only: tokens are only readable when the device is
    // actively unlocked, and are never synced to iCloud — appropriate for PHI.
    iOptions: IOSOptions(accessibility: KeychainAccessibility.unlocked_this_device),
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

  /// Persists profile flags so an offline cold-start can restore an accurate
  /// authenticated state (correct doctor onboarding/verification routing)
  /// without a network round-trip. [isVerified] may be null (patients).
  Future<void> saveProfile({
    required bool onboardingComplete,
    required bool? isVerified,
    required String firstName,
    required String lastName,
  }) async {
    await Future.wait([
      _storage.write(
          key: _Keys.onboardingComplete, value: onboardingComplete.toString()),
      _storage.write(
          key: _Keys.isVerified, value: isVerified == null ? '' : isVerified.toString()),
      _storage.write(key: _Keys.firstName, value: firstName),
      _storage.write(key: _Keys.lastName, value: lastName),
    ]);
  }

  Future<bool?> getOnboardingComplete() async {
    final raw = await _storage.read(key: _Keys.onboardingComplete);
    if (raw == null) return null;
    return raw == 'true';
  }

  Future<bool?> getIsVerified() async {
    final raw = await _storage.read(key: _Keys.isVerified);
    if (raw == null || raw.isEmpty) return null;
    return raw == 'true';
  }

  Future<String> getFirstName() async =>
      await _storage.read(key: _Keys.firstName) ?? '';
  Future<String> getLastName() async =>
      await _storage.read(key: _Keys.lastName) ?? '';

  Future<String?> getThemeMode() => _storage.read(key: _Keys.themeMode);
  Future<void> saveThemeMode(String mode) =>
      _storage.write(key: _Keys.themeMode, value: mode);

  Future<String?> getLanguage() => _storage.read(key: _Keys.language);
  Future<void> saveLanguage(String value) =>
      _storage.write(key: _Keys.language, value: value);

  /// Locally saved favorite doctor IDs. Stored as a JSON list; wiped on logout
  /// (see [clearAll]) so favorites never leak between accounts on a shared
  /// device.
  Future<List<String>> getFavoriteDoctors() async {
    final raw = await _storage.read(key: _Keys.favoriteDoctors);
    if (raw == null || raw.isEmpty) return [];
    try {
      return (jsonDecode(raw) as List<dynamic>).cast<String>();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveFavoriteDoctors(List<String> ids) =>
      _storage.write(key: _Keys.favoriteDoctors, value: jsonEncode(ids));

  /// Clears session data but preserves the user's theme and language preferences.
  Future<void> clearAll() async {
    final theme = await getThemeMode();
    final language = await getLanguage();
    await _storage.deleteAll();
    if (theme != null) await saveThemeMode(theme);
    if (language != null) await saveLanguage(language);
  }
}
