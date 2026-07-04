import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/shared/presentation/screens/change_email_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Stands in for AuthRepository's network calls so both steps of the
/// change-email flow can be tested without a live backend.
class _FakeAuthRepository extends AuthRepository {
  _FakeAuthRepository({this.requestError, this.confirmError}) : super(Dio());

  final ApiException? requestError;
  final ApiException? confirmError;
  String? lastNewEmail;
  String? lastPassword;
  String? lastCode;
  var requestCallCount = 0;
  var confirmCallCount = 0;

  @override
  Future<void> requestEmailChange({
    required String newEmail,
    required String password,
  }) async {
    requestCallCount++;
    lastNewEmail = newEmail;
    lastPassword = password;
    if (requestError != null) throw requestError!;
  }

  @override
  Future<void> confirmEmailChange({required String code}) async {
    confirmCallCount++;
    lastCode = code;
    if (confirmError != null) throw confirmError!;
  }
}

Future<void> _pump(WidgetTester tester, AuthRepository repo) async {
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const ChangeEmailScreen(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _enterCode(WidgetTester tester, String code) async {
  final boxes = find.byType(TextField);
  for (var i = 0; i < code.length; i++) {
    await tester.enterText(boxes.at(i), code[i]);
  }
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  testWidgets('step 1 renders the new-email and password fields',
      (tester) async {
    await _pump(tester, _FakeAuthRepository());

    expect(tester.takeException(), isNull);
    expect(find.text('New email'), findsOneWidget);
    expect(find.text('Send Code'), findsOneWidget);
  });

  testWidgets(
      'valid email + password requests a code and advances to step 2',
      (tester) async {
    final repo = _FakeAuthRepository();
    await _pump(tester, repo);

    await tester.enterText(
        find.widgetWithText(TextFormField, 'New email'), 'new@example.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Current Password'), 'mypassword1');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Code'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(repo.requestCallCount, 1);
    expect(repo.lastNewEmail, 'new@example.com');
    expect(repo.lastPassword, 'mypassword1');
    // Step 2: OTP entry is shown.
    expect(find.text('Confirm New Email'), findsOneWidget);
    expect(find.textContaining('new@example.com'), findsOneWidget);
  });

  testWidgets('a taken email shows an inline error and stays on step 1',
      (tester) async {
    final repo = _FakeAuthRepository(
      requestError: const ValidationException(
        fieldErrors: {
          'new_email': ['This email is already in use'],
        },
      ),
    );
    await _pump(tester, repo);

    await tester.enterText(
        find.widgetWithText(TextFormField, 'New email'), 'taken@example.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Current Password'), 'mypassword1');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Code'));
    await tester.pumpAndSettle();

    expect(repo.requestCallCount, 1);
    expect(find.text('This email is already in use'), findsOneWidget);
    // Still on step 1.
    expect(find.text('Send Code'), findsOneWidget);
  });

  testWidgets('a wrong current password shows an inline error on step 1',
      (tester) async {
    final repo = _FakeAuthRepository(
      requestError: const ValidationException(
        fieldErrors: {
          'password': ['Incorrect password'],
        },
      ),
    );
    await _pump(tester, repo);

    await tester.enterText(
        find.widgetWithText(TextFormField, 'New email'), 'new@example.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Current Password'), 'wrongpass1');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Code'));
    await tester.pumpAndSettle();

    expect(repo.requestCallCount, 1);
    expect(find.text('Incorrect password'), findsOneWidget);
    expect(find.text('Send Code'), findsOneWidget);
  });

  testWidgets(
      'entering the correct 6-digit code confirms the change and succeeds',
      (tester) async {
    final repo = _FakeAuthRepository();
    await _pump(tester, repo);

    await tester.enterText(
        find.widgetWithText(TextFormField, 'New email'), 'new@example.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Current Password'), 'mypassword1');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Code'));
    await tester.pumpAndSettle();

    await _enterCode(tester, '123456');
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm New Email'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(repo.confirmCallCount, 1);
    expect(repo.lastCode, '123456');
    expect(
      find.text(
          'Your email has been changed. Please sign in again with your new email.'),
      findsOneWidget,
    );
  });

  testWidgets('an invalid code shows an inline error and stays on step 2',
      (tester) async {
    final repo = _FakeAuthRepository(
      confirmError: const ValidationException(
        fieldErrors: {
          'code': ['Invalid or expired code'],
        },
      ),
    );
    await _pump(tester, repo);

    await tester.enterText(
        find.widgetWithText(TextFormField, 'New email'), 'new@example.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Current Password'), 'mypassword1');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Code'));
    await tester.pumpAndSettle();

    await _enterCode(tester, '000000');
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm New Email'));
    await tester.pumpAndSettle();

    expect(repo.confirmCallCount, 1);
    expect(find.text('Invalid or expired code'), findsOneWidget);
    // Still on step 2.
    expect(find.text('Confirm New Email'), findsOneWidget);
  });
}
