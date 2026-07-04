import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/auth/data/models/user_device_model.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/shared/presentation/screens/active_sessions_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Stands in for AuthRepository's network calls so the screen can be tested
/// without a live backend.
class _FakeAuthRepository extends AuthRepository {
  _FakeAuthRepository(this.devices) : super(Dio());

  final List<UserDeviceModel> devices;

  @override
  Future<List<UserDeviceModel>> getDevices() async => devices;
}

UserDeviceModel _device({
  required String id,
  required String name,
  required String platform,
  bool isCurrent = false,
  DateTime? lastSeenAt,
}) =>
    UserDeviceModel(
      id: id,
      deviceId: 'device-$id',
      deviceName: name,
      platform: platform,
      isCurrent: isCurrent,
      lastSeenAt: lastSeenAt,
    );

void main() {
  testWidgets('renders the device list with a badge on the current device',
      (tester) async {
    final repo = _FakeAuthRepository([
      _device(
        id: '1',
        name: 'iPhone 15 Pro',
        platform: 'ios',
        isCurrent: true,
        lastSeenAt: DateTime(2026, 1, 1, 10, 30),
      ),
      _device(id: '2', name: 'Pixel 8', platform: 'android'),
    ]);

    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [authRepositoryProvider.overrideWithValue(repo)],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const ActiveSessionsScreen(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('iPhone 15 Pro'), findsOneWidget);
    expect(find.text('Pixel 8'), findsOneWidget);
    expect(find.text('This device'), findsOneWidget);
    expect(find.text('Sign out of all devices'), findsOneWidget);
  });

  testWidgets('shows an empty state when there are no active sessions',
      (tester) async {
    final repo = _FakeAuthRepository(const []);

    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [authRepositoryProvider.overrideWithValue(repo)],
          // EmptyState runs an infinitely-repeating float animation unless
          // disableAnimations is set, which would hang pumpAndSettle().
          child: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: MaterialApp(
              theme: AppTheme.light,
              home: const ActiveSessionsScreen(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('No active sessions found'), findsOneWidget);
  });

  testWidgets('tapping revoke on a device asks for confirmation first',
      (tester) async {
    final repo = _FakeAuthRepository([
      _device(id: '1', name: 'Pixel 8', platform: 'android'),
    ]);

    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [authRepositoryProvider.overrideWithValue(repo)],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const ActiveSessionsScreen(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.logout).first);
    await tester.pumpAndSettle();

    // Confirmation dialog shown, network call not fired yet.
    expect(find.text('Revoke device?'), findsOneWidget);
  });
}
