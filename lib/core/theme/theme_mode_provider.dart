import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';

/// Holds the app's [ThemeMode], loading the saved preference on startup and
/// persisting changes. Defaults to [ThemeMode.system].
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _load();
  }

  final _storage = SecureStorage();

  Future<void> _load() async {
    final saved = await _storage.getThemeMode();
    if (saved != null) state = _parse(saved);
  }

  Future<void> setMode(ThemeMode mode) async {
    if (mode == state) return;
    state = mode;
    await _storage.saveThemeMode(mode.name);
  }

  static ThemeMode _parse(String value) => ThemeMode.values.firstWhere(
        (m) => m.name == value,
        orElse: () => ThemeMode.system,
      );
}
