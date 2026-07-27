import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:medalize_mb/core/onboarding/app_intro_provider.dart';
import 'package:medalize_mb/core/services/fcm_service.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:medalize_mb/main.dart';

/// The real FcmService.init() calls FirebaseMessaging.requestPermission(),
/// which pops a native "Would Like to Send You Notifications" system alert.
/// That alert isn't part of the Flutter widget tree, so it swallows every
/// subsequent tap — a no-op stand-in avoids it entirely (same idea as
/// stubbing LocationService in doctor_search_geolocation_test.dart).
class _NoopFcmService implements FcmService {
  @override
  Future<void> init() async {}

  @override
  Future<void> deregisterToken() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

/// Manual on-device verification for the "pick workplace location on a map"
/// feature: real backend (must be running at 127.0.0.1:8000), real network
/// calls (login, /locations/, CartoDB tiles, /geocode/reverse/), real
/// flutter_map widget. Not a permanent regression test — a one-off drive of
/// the actual app to see the new UI work end-to-end on a simulator.
///
/// Polls for conditions with bounded pump() loops instead of pumpAndSettle():
/// the splash screen (and other spots) show a plain CircularProgressIndicator,
/// an infinitely-repeating animation that always schedules another frame —
/// pumpAndSettle() would wait for "no more frames" forever and time out.
/// Fixed-duration pumps are also unreliable on a real device/simulator where
/// auth-state resolution, navigation, and network calls all vary in timing.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<bool> waitUntil(
    WidgetTester tester,
    bool Function() condition, {
    Duration timeout = const Duration(seconds: 30),
    Duration step = const Duration(milliseconds: 300),
  }) async {
    var elapsed = Duration.zero;
    while (elapsed < timeout) {
      await tester.pump(step);
      if (condition()) return true;
      elapsed += step;
    }
    return condition();
  }

  List<String> visibleText(WidgetTester tester) => tester
      .widgetList<Text>(find.byType(Text))
      .map((t) => t.data ?? t.textSpan?.toPlainText())
      .where((t) => t != null && t.isNotEmpty)
      .cast<String>()
      .toList();

  testWidgets('doctor adds a workplace with a pinned map location',
      (tester) async {
    await tester.pumpWidget(TranslationProvider(
      child: ProviderScope(
        overrides: [
          appIntroSeenProvider.overrideWith((ref) => true),
          fcmServiceProvider.overrideWithValue(_NoopFcmService()),
        ],
        child: const MedalizeApp(),
      ),
    ));
    await tester.pump();
    debugPrint('CHECKPOINT: launched');

    // ── Wait for the splash screen to resolve to either login or home ──
    final reachedLogin = await waitUntil(
      tester,
      () =>
          find.byType(AuthCardField).evaluate().length == 2 ||
          find.text('Workplaces').evaluate().isNotEmpty,
      timeout: const Duration(seconds: 25),
    );
    if (!reachedLogin) {
      debugPrint('CHECKPOINT: stuck after launch, visible text: '
          '${visibleText(tester)}');
    }

    if (find.byType(AuthCardField).evaluate().length == 2) {
      debugPrint('CHECKPOINT: login-form-visible');
      await tester.enterText(
          find.byType(TextFormField).at(0), 'ali.hasanov@medalize.az');
      await tester.enterText(find.byType(TextFormField).at(1), 'Doctor@1234');
      await tester.pump(const Duration(milliseconds: 500));
      await tester.tap(find.text('Sign In'));
      final reachedHome = await waitUntil(
        tester,
        () => find.text('Workplaces').evaluate().isNotEmpty,
        timeout: const Duration(seconds: 25),
      );
      if (!reachedHome) {
        debugPrint('CHECKPOINT: stuck after login, visible text: '
            '${visibleText(tester)}');
      }
    }
    debugPrint('CHECKPOINT: post-login, visible text: ${visibleText(tester)}');
    expect(find.text('Workplaces'), findsOneWidget,
        reason: 'must have reached the doctor home screen');
    debugPrint('CHECKPOINT: logged-in');

    // ── Navigate to the workplace list, then the add-workplace form ──
    await tester.tap(find.text('Workplaces'));
    await waitUntil(tester, () => find.byType(FloatingActionButton).evaluate().isNotEmpty);
    await tester.tap(find.byType(FloatingActionButton));
    await waitUntil(tester, () => find.text('Pick on Map').evaluate().isNotEmpty);
    expect(find.text('Pick on Map'), findsOneWidget);
    debugPrint('CHECKPOINT: add-workplace-form');

    // ── Fill name + address, pick a city ──
    final name =
        'Integration Test Clinic ${DateTime.now().millisecondsSinceEpoch}';
    await tester.enterText(find.byType(TextFormField).at(0), name);
    await tester.enterText(
        find.byType(TextFormField).at(1), 'Original typed address');
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.text('City'));
    await waitUntil(tester, () => find.byType(TextField).evaluate().isNotEmpty);
    await tester.enterText(find.byType(TextField).last, 'Baku');
    await waitUntil(
      tester,
      () => find.widgetWithText(ListTile, 'Baku').evaluate().isNotEmpty,
    );
    await tester.tap(find.widgetWithText(ListTile, 'Baku'));
    await tester.pump(const Duration(milliseconds: 500));
    debugPrint('CHECKPOINT: city-picked');

    // ── Open the map picker ──
    await tester.tap(find.text('Pick on Map'));
    await waitUntil(tester, () => find.text('Confirm Location').evaluate().isNotEmpty);
    expect(find.text('Confirm Location'), findsOneWidget);
    expect(find.byIcon(Icons.location_pin), findsOneWidget);
    debugPrint('CHECKPOINT: map-picker-open');
    // Dwell here so a screenshot can be taken of the live map screen.
    for (var i = 0; i < 80; i++) {
      await tester.pump(const Duration(milliseconds: 250));
    }
    debugPrint('CHECKPOINT: map-picker-dwell-done');

    // ── Confirm the default-centered pin (real reverse-geocode call) ──
    await tester.tap(find.text('Confirm Location'));
    final confirmed = await waitUntil(
      tester,
      () => find.text('Location set from map ✓').evaluate().isNotEmpty,
      timeout: const Duration(seconds: 15),
    );
    if (!confirmed) {
      debugPrint('CHECKPOINT: map-confirm-stuck, visible text: '
          '${visibleText(tester)}');
    }
    expect(find.text('Pick on Map'), findsOneWidget,
        reason: 'must be back on the workplace form');
    expect(find.text('Location set from map ✓'), findsOneWidget);
    debugPrint('CHECKPOINT: map-confirmed');

    // ── Save ──
    await tester.tap(find.text('Add Workplace').last);
    await waitUntil(
      tester,
      () => find.text(name).evaluate().isNotEmpty,
      timeout: const Duration(seconds: 15),
    );
    expect(find.textContaining('Failed to save workplace'), findsNothing);
    expect(find.text(name), findsOneWidget,
        reason: 'new workplace must appear back on the list');
    debugPrint('CHECKPOINT: saved');
  });
}
