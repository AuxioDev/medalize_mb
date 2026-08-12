import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/phone_field.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/shared/presentation/screens/change_phone_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Stands in for AuthRepository's network calls so both steps of the
/// change-phone flow can be tested without a live backend.
class _FakeAuthRepository extends AuthRepository {
  _FakeAuthRepository({this.requestError, this.confirmError}) : super(Dio());

  final ApiException? requestError;
  final ApiException? confirmError;
  String? lastNewPhone;
  String? lastPassword;
  String? lastCode;
  var requestCallCount = 0;
  var confirmCallCount = 0;

  @override
  Future<void> requestPhoneChange({
    required String newPhone,
    required String password,
  }) async {
    requestCallCount++;
    lastNewPhone = newPhone;
    lastPassword = password;
    if (requestError != null) throw requestError!;
  }

  @override
  Future<void> confirmPhoneChange({required String code}) async {
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
          home: const ChangePhoneScreen(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _phoneInput() => find.descendant(
      of: find.byType(PhoneField),
      matching: find.byType(TextField),
    );

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

  testWidgets('step 1 renders the new-phone and password fields',
      (tester) async {
    await _pump(tester, _FakeAuthRepository());

    expect(tester.takeException(), isNull);
    expect(find.byType(PhoneField), findsOneWidget);
    expect(find.text('Send Code'), findsOneWidget);
  });

  testWidgets(
      'valid phone + password requests a code and advances to step 2',
      (tester) async {
    final repo = _FakeAuthRepository();
    await _pump(tester, repo);

    await tester.enterText(_phoneInput(), '501234567');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Current Password'), 'mypassword1');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Code'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(repo.requestCallCount, 1);
    expect(repo.lastNewPhone, '+994501234567');
    expect(repo.lastPassword, 'mypassword1');
    // Step 2: OTP entry is shown.
    expect(find.text('Confirm New Phone Number'), findsOneWidget);
    expect(find.textContaining('+994501234567'), findsOneWidget);
  });

  testWidgets('a taken phone number shows an inline error and stays on step 1',
      (tester) async {
    final repo = _FakeAuthRepository(
      requestError: const ValidationException(
        fieldErrors: {
          'new_phone': ['A user with this phone number already exists.'],
        },
      ),
    );
    await _pump(tester, repo);

    await tester.enterText(_phoneInput(), '501234567');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Current Password'), 'mypassword1');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Code'));
    await tester.pumpAndSettle();

    expect(repo.requestCallCount, 1);
    expect(find.text('A user with this phone number already exists.'), findsOneWidget);
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

    await tester.enterText(_phoneInput(), '501234567');
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

    await tester.enterText(_phoneInput(), '501234567');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Current Password'), 'mypassword1');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Code'));
    await tester.pumpAndSettle();

    await _enterCode(tester, '123456');
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm New Phone Number'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(repo.confirmCallCount, 1);
    expect(repo.lastCode, '123456');
    expect(
      find.text(
          'Your phone number has been changed. Please sign in again with your new number.'),
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

    await tester.enterText(_phoneInput(), '501234567');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Current Password'), 'mypassword1');
    await tester.tap(find.widgetWithText(FilledButton, 'Send Code'));
    await tester.pumpAndSettle();

    await _enterCode(tester, '000000');
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm New Phone Number'));
    await tester.pumpAndSettle();

    expect(repo.confirmCallCount, 1);
    expect(find.text('Invalid or expired code'), findsOneWidget);
    // Still on step 2.
    expect(find.text('Confirm New Phone Number'), findsOneWidget);
  });
}
