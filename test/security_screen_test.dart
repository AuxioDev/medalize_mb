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
/// and delete-account flows can be tested without a live backend.
class _FakeAuthRepository extends AuthRepository {
  _FakeAuthRepository({this.deactivateError, this.deleteError}) : super(Dio());

  final ApiException? deactivateError;
  final ApiException? deleteError;
  String? lastPassword;
  var deactivateCallCount = 0;
  String? lastDeletePassword;
  var deleteCallCount = 0;

  @override
  Future<void> deactivateAccount({required String password}) async {
    deactivateCallCount++;
    lastPassword = password;
    if (deactivateError != null) throw deactivateError!;
  }

  @override
  Future<void> deleteAccount({required String password}) async {
    deleteCallCount++;
    lastDeletePassword = password;
    if (deleteError != null) throw deleteError!;
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
    // AppFormSection uppercases its caption (matching every other section
    // header in the app, e.g. "ACCOUNT", "APPEARANCE" on the settings
    // screen) — this one used to render in title case before the shared
    // widget consolidated the two styles.
    expect(find.text('DANGER ZONE'), findsOneWidget);
    expect(find.text('Deactivate Account'), findsOneWidget);
    expect(find.text('Change Phone Number'), findsOneWidget);
    // The separate, heavier, irreversible delete action sits alongside
    // deactivate in the same danger zone (Apple 5.1.1(v) account-deletion
    // requirement).
    expect(find.text('Delete Account Permanently'), findsOneWidget);
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

  testWidgets(
      'tapping delete opens a confirmation dialog with a warning and a '
      'password field', (tester) async {
    await _pump(tester, _FakeAuthRepository());

    await tester.tap(find.widgetWithText(ListTile, 'Delete Account Permanently'));
    await tester.pumpAndSettle();

    expect(find.text('Delete your account permanently?'), findsOneWidget);
    expect(find.text('This action is permanent and cannot be undone.'),
        findsOneWidget);
    expect(
      find.textContaining('Your profile, medical records, prescriptions, '
          'and messages will be permanently erased.'),
      findsOneWidget,
    );
    expect(find.byType(TextField), findsOneWidget);
    // The submit button is disabled until a password is entered.
    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Delete Account Permanently'),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets(
      'correct password permanently deletes the account and shows the '
      'success confirmation', (tester) async {
    final repo = _FakeAuthRepository();
    await _pump(tester, repo);

    await tester.tap(find.widgetWithText(ListTile, 'Delete Account Permanently'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'correct-password');
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(FilledButton, 'Delete Account Permanently'),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(repo.deleteCallCount, 1);
    expect(repo.lastDeletePassword, 'correct-password');
    // The confirmation dialog is dismissed and a success message shown.
    expect(find.text('Delete your account permanently?'), findsNothing);
    expect(find.text('Your account has been permanently deleted.'),
        findsOneWidget);
  });

  testWidgets(
      'wrong password shows an inline error and keeps the delete dialog open',
      (tester) async {
    final repo = _FakeAuthRepository(
      deleteError: const ValidationException(
        fieldErrors: {
          'password': ['Incorrect password'],
        },
      ),
    );
    await _pump(tester, repo);

    await tester.tap(find.widgetWithText(ListTile, 'Delete Account Permanently'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'wrong-password');
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(FilledButton, 'Delete Account Permanently'),
    );
    await tester.pumpAndSettle();

    expect(repo.deleteCallCount, 1);
    // Dialog stays open with the error surfaced inline — the account is
    // never touched without a correct re-authentication.
    expect(find.text('Delete your account permanently?'), findsOneWidget);
    expect(find.text('Incorrect password'), findsOneWidget);
  });
}
