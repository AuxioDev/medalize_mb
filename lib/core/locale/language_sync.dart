import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Sentinel persisted by the language picker when the app follows the device
/// language (see `locale_provider.dart`). The backend only accepts concrete
/// language codes, so this must be resolved before being sent.
const systemLanguageSentinel = 'system';

/// Maps a stored language preference to the concrete code the backend accepts
/// (`en`/`ru`/`az`/`tr`/`fr`/`zh`): `null` / `'system'` resolve to the actual
/// device locale (falling back to the base locale, English, when the device
/// language isn't one of the six).
String resolveBackendLanguageCode(String? saved) =>
    (saved == null || saved == systemLanguageSentinel)
        ? AppLocaleUtils.findDeviceLocale().languageCode
        : saved;

/// Pushes [code] to `PATCH /auth/me/` in the background so server-sent emails
/// and notifications switch to the user's language. Best-effort by design:
/// the language has already changed locally, so a network failure is only
/// logged — never surfaced to the user or allowed to roll the UI back.
Future<void> pushLanguageToBackend(Ref ref, String code) async {
  try {
    await ref.read(authRepositoryProvider).updateLanguage(code);
  } catch (e) {
    developer.log(
      'Failed to sync language "$code" to backend: $e',
      name: 'language_sync',
    );
  }
}

/// Reads the locally saved language preference and pushes its resolved code
/// to the backend. Used right after a successful sign-in so a language chosen
/// before logging in still reaches the server. Never throws.
Future<void> syncStoredLanguageToBackend(Ref ref) async {
  try {
    final saved = await ref.read(secureStorageProvider).getLanguage();
    await pushLanguageToBackend(ref, resolveBackendLanguageCode(saved));
  } catch (e) {
    developer.log(
      'Failed to read the stored language preference: $e',
      name: 'language_sync',
    );
  }
}
