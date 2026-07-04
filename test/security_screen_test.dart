import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/shared/presentation/screens/security_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Stands in for AuthRepository's network calls so the deactivate-account
/// flow can be tested without a live backend.
class _FakeAuthRepository extends AuthRepository {
  _FakeAuthRepository({this.deactivateError}) : super(Dio());

  final ApiException? deactivateError;
  String? lastPassword;
  var deactivateCallCount = 0;

  @override
  Future<void> deactivateAccount({required String password}) async {
    deactivateCallCount++;
    lastPassword = password;
    if (deactivateError != null) throw deactivateError!;
  }
}

Future<void> _pump(WidgetTester tester, AuthRepository repo) async {
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const SecurityScreen(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  testWidgets('renders the danger zone with a deactivate-account tile',
      (tester) async {
    await _pump(tester, _FakeAuthRepository());

    expect(tester.takeException(), isNull);
    expect(find.text('Danger Zone'), findsOneWidget);
    expect(find.text('Deactivate Account'), findsOneWidget);
    expect(find.text('Change Email'), findsOneWidget);
  });

  testWidgets('tapping deactivate opens a confirmation dialog with a password field',
      (tester) async {
    await _pump(tester, _FakeAuthRepository());

    await tester.tap(find.text('Deactivate Account'));
    await tester.pumpAndSettle();

    expect(find.text('Deactivate account?'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    // The submit button is disabled until a password is entered.
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('correct password deactivates the account and calls the API',
      (tester) async {
    final repo = _FakeAuthRepository();
    await _pump(tester, repo);

    await tester.tap(find.text('Deactivate Account'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'correct-password');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Deactivate'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(repo.deactivateCallCount, 1);
    expect(repo.lastPassword, 'correct-password');
    // The confirmation dialog is dismissed and a success message shown.
    expect(find.text('Deactivate account?'), findsNothing);
    expect(find.text('Your account has been deactivated.'), findsOneWidget);
  });

  testWidgets('wrong password shows an inline error and keeps the dialog open',
      (tester) async {
    final repo = _FakeAuthRepository(
      deactivateError: const ValidationException(
        fieldErrors: {
          'password': ['Incorrect password'],
        },
      ),
    );
    await _pump(tester, repo);

    await tester.tap(find.text('Deactivate Account'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'wrong-password');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Deactivate'));
    await tester.pumpAndSettle();

    expect(repo.deactivateCallCount, 1);
    // Dialog stays open with the error surfaced inline.
    expect(find.text('Deactivate account?'), findsOneWidget);
    expect(find.text('Incorrect password'), findsOneWidget);
  });
}
