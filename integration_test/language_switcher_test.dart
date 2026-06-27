import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/shared/presentation/screens/settings_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Drives the real SettingsScreen language switcher on a device:
/// localeProvider → LocaleSettings → TranslationProvider rebuild → SecureStorage.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget harness() => TranslationProvider(
        child: ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light,
            home: const SettingsScreen(),
          ),
        ),
      );

  /// The language row is opened by its icon, so this works no matter what
  /// language the screen is currently showing.
  Future<void> openPicker(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.language_outlined));
    await tester.pumpAndSettle();
  }

  /// Picks an option from inside the open bottom sheet. Scoping to the sheet
  /// avoids matching the language tile's "current selection" label, which can
  /// carry the same text as an option.
  Future<void> pickFromSheet(WidgetTester tester, String nativeName) async {
    final option = find.descendant(
      of: find.byType(BottomSheet),
      matching: find.text(nativeName),
    );
    expect(option, findsOneWidget);
    await tester.tap(option);
    await tester.pumpAndSettle();
  }

  /// Screenshots need a driver to write to disk; best-effort so the assertions
  /// (the actual verification) always run under plain `flutter test`.
  Future<void> shot(String name) async {
    try {
      await binding.takeScreenshot(name);
    } catch (_) {}
  }

  testWidgets('language switcher changes the whole UI language',
      (tester) async {
    // SettingsScreen has a pre-existing debug-only paint lint (a ListTile inside
    // a colored Container). It is unrelated to localization and fires in any
    // language, so swallow just that one and let every other error through.
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details
          .exceptionAsString()
          .contains('ListTile background color or ink splashes')) {
        return;
      }
      originalOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = originalOnError);

    await tester.pumpWidget(harness());
    await tester.pumpAndSettle();

    // Normalize to English through the picker itself (deterministic regardless
    // of the simulator's device locale or any previously persisted choice).
    await openPicker(tester);
    await pickFromSheet(tester, 'English');
    expect(find.text('Settings'), findsOneWidget); // appbar title (unique)
    expect(LocaleSettings.currentLocale, AppLocale.en);
    await shot('01-settings-english');

    // The picker lists "System default" + the six native names.
    await openPicker(tester);
    expect(find.text('System default'), findsOneWidget);
    for (final name in ['English', 'Azərbaycan', 'Русский', 'Türkçe', '中文', 'Français']) {
      expect(find.descendant(of: find.byType(BottomSheet), matching: find.text(name)),
          findsOneWidget);
    }
    await shot('02-language-picker-open');

    // → Azerbaijani: the whole screen re-renders in az. Assert on the appbar
    // title and the language-row label, both rendered verbatim (group titles
    // are upper-cased by the UI, so they aren't reliable finders).
    await pickFromSheet(tester, 'Azərbaycan');
    expect(find.text('Parametrlər'), findsOneWidget); // Settings (appbar)
    expect(find.text('Dil'), findsOneWidget); // Language (row label)
    expect(find.text('Settings'), findsNothing);
    expect(LocaleSettings.currentLocale, AppLocale.az);
    await shot('03-settings-azerbaijani');

    // → Russian: prove it switches again, not just once.
    await openPicker(tester);
    await pickFromSheet(tester, 'Русский');
    expect(find.text('Настройки'), findsOneWidget); // Settings
    expect(find.text('Язык'), findsOneWidget); // Language
    expect(find.text('Parametrlər'), findsNothing);
    expect(LocaleSettings.currentLocale, AppLocale.ru);
    await shot('04-settings-russian');

    // → Chinese, to confirm a non-Latin script renders too.
    await openPicker(tester);
    await pickFromSheet(tester, '中文');
    expect(find.text('设置'), findsOneWidget); // Settings
    expect(find.text('语言'), findsOneWidget); // Language
    expect(LocaleSettings.currentLocale, AppLocale.zh);
    await shot('05-settings-chinese');

    // Restore English so the run leaves no persisted side effect behind.
    await openPicker(tester);
    await pickFromSheet(tester, 'English');
    expect(find.text('Settings'), findsOneWidget);
  });
}
