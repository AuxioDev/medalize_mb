import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/locale/language_sync.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Sentinel persisted when the user wants the app to follow the device language.
const _systemLanguage = systemLanguageSentinel;

/// Resolves the persisted language preference at startup, before [runApp], so
/// the first frame already renders in the correct language (no flash).
///
/// - No saved value / "system" → follow the phone's locale (falls back to the
///   base locale, English, when the device language isn't one of the six).
/// - A saved language code → force that [AppLocale].
Future<void> initLocale() async {
  final saved = await SecureStorage().getLanguage();
  // Use the async API (awaited before runApp): locales are generated as
  // deferred libraries, so the *Sync variants would throw "Deferred library
  // not loaded". Awaiting loads the locale before the first frame — no flash.
  if (saved == null || saved == _systemLanguage) {
    await LocaleSettings.useDeviceLocale();
  } else {
    await LocaleSettings.setLocale(AppLocaleUtils.parse(saved));
  }
}

/// Holds the active [AppLocale], or `null` when the app follows the device
/// language. Mirrors the persistence pattern of `themeModeProvider`.
final localeProvider =
    StateNotifierProvider<LocaleNotifier, AppLocale?>((ref) => LocaleNotifier(ref));

class LocaleNotifier extends StateNotifier<AppLocale?> {
  LocaleNotifier(this._ref) : super(null) {
    _load();
  }

  final Ref _ref;
  final _storage = SecureStorage();

  Future<void> _load() async {
    final saved = await _storage.getLanguage();
    if (saved == null || saved == _systemLanguage) {
      state = null;
    } else {
      state = AppLocaleUtils.parse(saved);
    }
  }

  /// Switches the app language. Pass `null` to follow the device language.
  ///
  /// The local switch is synchronous and immediate; when the user is signed
  /// in, the choice is additionally pushed to the backend in the background.
  Future<void> setLocale(AppLocale? locale) async {
    if (locale == null) {
      LocaleSettings.useDeviceLocale();
      await _storage.saveLanguage(_systemLanguage);
    } else {
      LocaleSettings.setLocale(locale);
      await _storage.saveLanguage(locale.languageCode);
    }
    state = locale;
    // Only an explicit user choice is synced — the startup [_load] restores
    // from storage without touching the network. "System" is resolved to the
    // actual device language code first; the backend rejects `'system'`.
    // Fire-and-forget: a failure never blocks or rolls back the local switch.
    if (_ref.read(authProvider) is AuthAuthenticated) {
      unawaited(pushLanguageToBackend(
        _ref,
        (locale ?? AppLocaleUtils.findDeviceLocale()).languageCode,
      ));
    }
  }
}

/// Native display names for the language picker (shown in their own language).
const localeDisplayNames = <AppLocale, String>{
  AppLocale.en: 'English',
  AppLocale.az: 'Azərbaycan',
  AppLocale.ru: 'Русский',
  AppLocale.tr: 'Türkçe',
  AppLocale.zh: '中文',
  AppLocale.fr: 'Français',
};
