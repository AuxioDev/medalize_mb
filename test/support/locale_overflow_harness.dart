import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// A pre-existing debug-only paint lint (a ListTile inside a colored
/// Container) that fires in any language and is unrelated to text length.
/// The same fragment is already filtered out by
/// `integration_test/language_switcher_test.dart`.
const _ignoredErrorFragment = 'ListTile background color or ink splashes';

/// Loads the deferred translation libraries for all six locales.
///
/// Must be called from `setUpAll` (i.e. outside the FakeAsync zone of
/// `testWidgets`): the deferred `loadLibrary()` future only completes on the
/// real event loop, and once every locale is loaded
/// [expectNoOverflowAcrossLocales] can switch locales synchronously.
Future<void> loadAllLocalesForTest() => LocaleSettings.instance.loadAllLocales();

/// Pumps [buildScreen] under all six supported locales and fails the test —
/// naming the offending locale — if Flutter reports any error (most notably
/// a "RenderFlex overflowed" layout error) while rendering.
///
/// The original locale and [FlutterError.onError] handler are restored
/// afterward regardless of outcome, and the screen is unmounted so provider
/// timers/animations don't leak into the next test.
///
/// Set [settle] to `false` for screens that run infinitely repeating
/// animations (e.g. `EmptyState` without `disableAnimations`); the harness
/// then pumps a bounded `Duration` instead of `pumpAndSettle`, mirroring the
/// pattern used by the router-loader tests.
///
/// [afterPump] runs once per locale after the screen has settled — use it to
/// drive locale-independent interactions (e.g. switching to the second tab)
/// so deeper parts of the screen are laid out too.
Future<void> expectNoOverflowAcrossLocales(
  WidgetTester tester,
  Widget Function() buildScreen, {
  bool settle = true,
  Future<void> Function(WidgetTester tester)? afterPump,
}) async {
  final originalLocale = LocaleSettings.currentLocale;
  final originalOnError = FlutterError.onError;
  try {
    for (final locale in AppLocale.values) {
      final errors = <String>[];
      FlutterError.onError = (details) {
        final message = details.exceptionAsString();
        if (message.contains(_ignoredErrorFragment)) return;
        errors.add(message);
      };
      // setLocaleSync, not setLocale: the async variant awaits the deferred
      // translation library's loadLibrary(), a real-world event that never
      // completes inside the FakeAsync zone of testWidgets — the test would
      // hang forever. The sync variant builds translations directly, which
      // works on the VM where deferred libraries are loaded eagerly.
      LocaleSettings.setLocaleSync(locale);
      await tester.pumpWidget(buildScreen());
      if (settle) {
        // Bounded timeout: an accidentally still-running repeat animation
        // should fail fast with the locale named, not stall CI for the
        // default ten minutes.
        try {
          await tester.pumpAndSettle(
            const Duration(milliseconds: 100),
            EnginePhase.sendSemanticsUpdate,
            const Duration(seconds: 10),
          );
        } on FlutterError catch (e) {
          fail(
            'pumpAndSettle did not settle under locale '
            '"${locale.languageCode}" — the screen probably runs an '
            'infinitely repeating animation; pass settle: false. ($e)',
          );
        }
      } else {
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
      }
      if (afterPump != null) await afterPump(tester);
      // Restore before asserting so a failure here doesn't leave the
      // collector installed for the rest of the test run.
      FlutterError.onError = originalOnError;
      expect(
        errors,
        isEmpty,
        reason: 'Layout error(s) rendering under locale '
            '"${locale.languageCode}":\n${errors.join('\n')}',
      );
    }
  } finally {
    FlutterError.onError = originalOnError;
    LocaleSettings.setLocaleSync(originalLocale);
    // Unmount the screen so provider disposal (periodic timers, animation
    // controllers) happens inside this test's scope.
    await tester.pumpWidget(const SizedBox.shrink());
  }
}
