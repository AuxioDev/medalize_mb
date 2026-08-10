import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/notifications/data/models/notification_preferences_model.dart';
import 'package:medalize_mb/features/notifications/data/repository/notification_repository.dart';
import 'package:medalize_mb/features/shared/presentation/screens/notification_settings_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Stands in for NotificationRepository's network calls so the screen can be
/// tested without a live backend.
class _FakeNotificationRepository extends NotificationRepository {
  _FakeNotificationRepository({
    this.pushEnabled = true,
    this.emailEnabled = true,
    this.carePushEnabled = true,
    this.messagesPushEnabled = true,
    this.accountPushEnabled = true,
    this.quietHoursEnabled = false,
    this.quietHoursStart = '22:00:00',
    this.quietHoursEnd = '08:00:00',
  }) : super(Dio());

  bool pushEnabled;
  bool emailEnabled;
  bool carePushEnabled;
  bool messagesPushEnabled;
  bool accountPushEnabled;
  bool quietHoursEnabled;
  String quietHoursStart;
  String quietHoursEnd;
  Map<String, Object?>? lastUpdate;

  NotificationPreferences _current() => NotificationPreferences(
        pushEnabled: pushEnabled,
        emailEnabled: emailEnabled,
        carePushEnabled: carePushEnabled,
        messagesPushEnabled: messagesPushEnabled,
        accountPushEnabled: accountPushEnabled,
        quietHoursEnabled: quietHoursEnabled,
        quietHoursStart: quietHoursStart,
        quietHoursEnd: quietHoursEnd,
      );

  @override
  Future<NotificationPreferences> getPreferences() async => _current();

  @override
  Future<NotificationPreferences> updatePreferences({
    bool? pushEnabled,
    bool? emailEnabled,
    bool? carePushEnabled,
    bool? messagesPushEnabled,
    bool? accountPushEnabled,
    bool? quietHoursEnabled,
    String? quietHoursStart,
    String? quietHoursEnd,
  }) async {
    if (pushEnabled != null) this.pushEnabled = pushEnabled;
    if (emailEnabled != null) this.emailEnabled = emailEnabled;
    if (carePushEnabled != null) this.carePushEnabled = carePushEnabled;
    if (messagesPushEnabled != null) this.messagesPushEnabled = messagesPushEnabled;
    if (accountPushEnabled != null) this.accountPushEnabled = accountPushEnabled;
    if (quietHoursEnabled != null) this.quietHoursEnabled = quietHoursEnabled;
    if (quietHoursStart != null) this.quietHoursStart = quietHoursStart;
    if (quietHoursEnd != null) this.quietHoursEnd = quietHoursEnd;
    lastUpdate = {
      'push_enabled': ?pushEnabled,
      'email_enabled': ?emailEnabled,
      'care_push_enabled': ?carePushEnabled,
      'messages_push_enabled': ?messagesPushEnabled,
      'account_push_enabled': ?accountPushEnabled,
      'quiet_hours_enabled': ?quietHoursEnabled,
      'quiet_hours_start': ?quietHoursStart,
      'quiet_hours_end': ?quietHoursEnd,
    };
    return _current();
  }
}

Future<void> _pump(WidgetTester tester, _FakeNotificationRepository repo) async {
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [notificationRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const NotificationSettingsScreen(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('renders every toggle from the backend state', (tester) async {
    final repo = _FakeNotificationRepository(
      pushEnabled: true,
      emailEnabled: false,
      carePushEnabled: true,
      messagesPushEnabled: false,
      accountPushEnabled: true,
      quietHoursEnabled: true,
    );

    await _pump(tester, repo);

    expect(tester.takeException(), isNull);
    final switches =
        tester.widgetList<SwitchListTile>(find.byType(SwitchListTile)).toList();
    // push, email, care, messages, account, quiet-hours-enabled
    expect(switches.length, 6);
    expect(switches[0].value, isTrue); // push
    expect(switches[1].value, isFalse); // email
    expect(switches[2].value, isTrue); // care
    expect(switches[3].value, isFalse); // messages
    expect(switches[4].value, isTrue); // account
    expect(switches[5].value, isTrue); // quiet hours enabled

    // Start/end time rows render the formatted times.
    expect(find.text('10:00 PM'), findsOneWidget);
    expect(find.text('8:00 AM'), findsOneWidget);
  });

  testWidgets('toggling push calls the repository with the new value',
      (tester) async {
    final repo = _FakeNotificationRepository();
    await _pump(tester, repo);

    await tester.tap(find.byType(SwitchListTile).first);
    await tester.pumpAndSettle();

    expect(repo.pushEnabled, isFalse);
    expect(repo.lastUpdate, {'push_enabled': false});
  });

  testWidgets('toggling a category switch calls the repository', (tester) async {
    final repo = _FakeNotificationRepository();
    await _pump(tester, repo);

    final switches = find.byType(SwitchListTile);
    await tester.tap(switches.at(2)); // care category
    await tester.pumpAndSettle();

    expect(repo.carePushEnabled, isFalse);
    expect(repo.lastUpdate, {'care_push_enabled': false});
  });

  testWidgets('category and quiet-hours toggles are disabled when push is off',
      (tester) async {
    final repo = _FakeNotificationRepository(pushEnabled: false);
    await _pump(tester, repo);

    final switches =
        tester.widgetList<SwitchListTile>(find.byType(SwitchListTile)).toList();
    // push and email stay interactive regardless; the 4 push-only-dependent
    // toggles (care/messages/account categories + quiet hours) don't.
    expect(switches[0].onChanged, isNotNull); // push
    expect(switches[1].onChanged, isNotNull); // email — independent of push
    for (final s in switches.skip(2)) {
      expect(s.onChanged, isNull);
    }
  });
}
