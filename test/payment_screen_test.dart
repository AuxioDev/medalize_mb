import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/payments/data/models/payment_model.dart';
import 'package:medalize_mb/features/payments/data/repository/payment_repository.dart';
import 'package:medalize_mb/features/payments/presentation/screens/payment_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Answers `getPayment` with one canned value per call (last value repeats
/// once exhausted), so a test can simulate the status changing between the
/// initial load and a later resume-triggered refresh.
class _FakePaymentRepository extends PaymentRepository {
  _FakePaymentRepository(this._responses) : super(Dio());
  final List<PaymentModel?> _responses;
  int callCount = 0;

  @override
  Future<PaymentModel?> getPayment(String appointmentId) async {
    final index = callCount < _responses.length ? callCount : _responses.length - 1;
    callCount++;
    return _responses[index];
  }
}

PaymentModel _payment({
  String status = PaymentModel.statusPending,
  String amount = '50.00',
  String currency = 'AZN',
  String paymentUrl = 'https://checkout.payriff.com/session/abc',
}) =>
    PaymentModel(
      id: 'pay-1',
      appointmentId: 'appt-1',
      amount: amount,
      currency: currency,
      status: status,
      paymentUrl: paymentUrl,
    );

Future<void> _pump(WidgetTester tester, _FakePaymentRepository repo) async {
  // Payment screen is always reached by pushing on top of something (the
  // booking success flow or the appointment detail screen) — start on that
  // "something" so context.pop() from the Pay Later button has somewhere to
  // return to, matching real navigation instead of an empty stack.
  final router = GoRouter(
    initialLocation: '/behind',
    routes: [
      GoRoute(
        path: '/behind',
        builder: (_, _) => Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => context.push('/patient/appointments/appt-1/payment'),
                child: const Text('open-payment'),
              ),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/patient/appointments/:id/payment',
        builder: (_, state) =>
            PaymentScreen(appointmentId: state.pathParameters['id']!),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [paymentRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('open-payment'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('renders amount, currency, pending status, and a Pay Now button',
      (tester) async {
    final repo = _FakePaymentRepository([_payment()]);
    await _pump(tester, repo);

    expect(tester.takeException(), isNull);
    expect(find.text('50.00 AZN'), findsOneWidget);
    expect(find.text('Payment Pending'), findsOneWidget);
    expect(find.text('Pay Now'), findsOneWidget);
    expect(find.text('Pay Later'), findsOneWidget);
  });

  testWidgets('paid status hides Pay Now and shows the confirmation banner',
      (tester) async {
    final repo = _FakePaymentRepository([_payment(status: PaymentModel.statusPaid)]);
    await _pump(tester, repo);

    expect(find.text('Paid'), findsOneWidget);
    expect(find.text('Payment confirmed. Thank you!'), findsOneWidget);
    expect(find.text('Pay Now'), findsNothing);
    // Pay Later remains available regardless of status.
    expect(find.text('Pay Later'), findsOneWidget);
  });

  testWidgets('failed/cancelled payments also hide the Pay Now button',
      (tester) async {
    final repo = _FakePaymentRepository([_payment(status: PaymentModel.statusFailed)]);
    await _pump(tester, repo);

    expect(find.text('Payment Failed'), findsOneWidget);
    expect(find.text('Pay Now'), findsNothing);
  });

  testWidgets('Pay Later pops back to the previous screen without creating a payment',
      (tester) async {
    final repo = _FakePaymentRepository([_payment()]);
    await _pump(tester, repo);

    await tester.tap(find.text('Pay Later'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // Back on the screen underneath — this screen never creates a payment
    // itself (booking_confirm_screen.dart does that), Pay Later just closes.
    expect(find.text('open-payment'), findsOneWidget);
  });

  testWidgets(
      'app resume re-fetches status: a pending payment becoming paid updates '
      'the screen and shows a confirmation snackbar', (tester) async {
    final repo = _FakePaymentRepository([
      _payment(), // initial load: pending
      _payment(status: PaymentModel.statusPaid), // after resume: paid
    ]);
    await _pump(tester, repo);

    expect(find.text('Payment Pending'), findsOneWidget);
    expect(find.text('Pay Now'), findsOneWidget);
    expect(repo.callCount, 1);

    // Simulate the patient returning from the external Payriff checkout
    // browser — the payment screen re-fetches status on resume.
    WidgetsBinding.instance.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(repo.callCount, 2);
    expect(find.text('Paid'), findsOneWidget);
    expect(find.text('Pay Now'), findsNothing);
    expect(find.text('Payment confirmed. Thank you!'), findsWidgets);
  });

  testWidgets(
      'app resume while already paid does not show a duplicate confirmation snackbar',
      (tester) async {
    final repo = _FakePaymentRepository([
      _payment(status: PaymentModel.statusPaid),
      _payment(status: PaymentModel.statusPaid),
    ]);
    await _pump(tester, repo);

    // Dismiss the (none yet, since it loaded already-paid) snackbar state
    // and resume again — still paid, so no fresh confirmation should fire
    // via the snackbar mechanism a second time.
    WidgetsBinding.instance.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    // The only "Payment confirmed" text should be the persistent in-screen
    // banner, not a stacked snackbar — i.e. exactly one on-screen instance,
    // not growing with each resume.
    expect(find.text('Payment confirmed. Thank you!'), findsOneWidget);
  });
}
