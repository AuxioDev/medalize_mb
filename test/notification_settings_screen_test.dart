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
  _FakeNotificationRepository({this.pushEnabled = true, this.emailEnabled = true})
      : super(Dio());

  bool pushEnabled;
  bool emailEnabled;
  Map<String, bool>? lastUpdate;

  @override
  Future<NotificationPreferences> getPreferences() async =>
      NotificationPreferences(pushEnabled: pushEnabled, emailEnabled: emailEnabled);

  @override
  Future<NotificationPreferences> updatePreferences({
    bool? pushEnabled,
    bool? emailEnabled,
  }) async {
    if (pushEnabled != null) this.pushEnabled = pushEnabled;
    if (emailEnabled != null) this.emailEnabled = emailEnabled;
    lastUpdate = {
      'push_enabled': ?pushEnabled,
      'email_enabled': ?emailEnabled,
    };
    return NotificationPreferences(
      pushEnabled: this.pushEnabled,
      emailEnabled: this.emailEnabled,
    );
  }
}

void main() {
  testWidgets('renders push and email toggles from the backend state',
      (tester) async {
    final repo =
        _FakeNotificationRepository(pushEnabled: true, emailEnabled: false);

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

    expect(tester.takeException(), isNull);
    final switches =
        tester.widgetList<SwitchListTile>(find.byType(SwitchListTile)).toList();
    expect(switches.length, 2);
    expect(switches[0].value, isTrue);
    expect(switches[1].value, isFalse);
  });

  testWidgets('toggling a switch calls the repository with the new value',
      (tester) async {
    final repo =
        _FakeNotificationRepository(pushEnabled: true, emailEnabled: true);

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

    await tester.tap(find.byType(SwitchListTile).first);
    await tester.pumpAndSettle();

    expect(repo.pushEnabled, isFalse);
    expect(repo.lastUpdate, {'push_enabled': false});
  });
}
