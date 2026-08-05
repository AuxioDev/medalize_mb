import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/patient/presentation/screens/appointment_detail_screen.dart';
import 'package:medalize_mb/features/payments/data/models/payment_model.dart';
import 'package:medalize_mb/features/payments/data/repository/payment_repository.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Records the id `cancelAppointment` was called with and returns a canned
/// `AppointmentCancelResult` — the backend now answers `200 OK` with a body
/// instead of a bare `204` (see `AppointmentRepository.cancelAppointment`'s
/// docstring), so this stands in for whatever refund_eligible/payment
/// combination each test wants to exercise.
class _FakeAppointmentRepository extends AppointmentRepository {
  _FakeAppointmentRepository(this.result) : super(Dio());
  final AppointmentCancelResult result;
  String? cancelledId;

  @override
  Future<AppointmentCancelResult> cancelAppointment(String id) async {
    cancelledId = id;
    return result;
  }
}

/// No payment exists yet for these appointments — stubbed out so the
/// payment section (rendered for a patient's pending/confirmed appointment)
/// doesn't hit the network (matches `test/appointment_payment_section_test.dart`).
class _NoPaymentRepository extends PaymentRepository {
  _NoPaymentRepository() : super(Dio());

  @override
  Future<PaymentModel?> getPayment(String appointmentId) async => null;
}

/// Not a completed appointment in any of these tests, so the prescription
/// section never queries — stubbed defensively anyway (matches
/// `test/appointment_review_test.dart`).
class _NoPrescriptionRepository extends PrescriptionRepository {
  _NoPrescriptionRepository() : super(Dio());

  @override
  Future<PrescriptionModel?> getPrescriptionForAppointment(String appointmentId) async => null;
}

AppointmentModel _cancellableAppointment() => AppointmentModel(
      id: 'a1',
      doctor: const AppointmentDoctor(
        id: 'd1',
        firstName: 'Jane',
        lastName: 'Doe',
        specialization: 'cardiologist',
        specializationDisplay: 'Cardiology',
      ),
      patient: const AppointmentPatient(id: 'p1', firstName: 'John', lastName: 'Smith'),
      workplace: const AppointmentWorkplace(
        id: 'w1',
        name: 'City Clinic',
        address: '12 Main St',
        city: 'Baku',
      ),
      // Far enough in the future that the local _withinCancelWindow fallback
      // (no canCancelOverride sent by this fake) resolves canCancel true.
      startsAt: DateTime(2030, 1, 1, 10, 0),
      endsAt: DateTime(2030, 1, 1, 10, 30),
      status: 'confirmed',
      reason: 'Annual checkup',
      notes: '',
      createdAt: DateTime(2029, 12, 1),
    );

Future<void> _pump(
  WidgetTester tester,
  _FakeAppointmentRepository repo,
) async {
  tester.view.physicalSize = const Size(480, 1200);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final appt = _cancellableAppointment();
  final router = GoRouter(
    initialLocation: '/list',
    routes: [
      GoRoute(path: '/list', builder: (_, _) => const Scaffold(body: Text('list-screen'))),
      GoRoute(
        path: '/detail',
        builder: (_, _) => AppointmentDetailScreen(appointment: appt),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          appointmentRepositoryProvider.overrideWithValue(repo),
          paymentRepositoryProvider.overrideWithValue(_NoPaymentRepository()),
          prescriptionRepositoryProvider.overrideWithValue(_NoPrescriptionRepository()),
        ],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  router.push('/detail');
  await tester.pumpAndSettle();
}

/// Taps the bottom action bar's "Cancel Appointment" button, then the
/// destructive "Cancel Appointment" button inside the confirmation dialog
/// that opens — the two are different widget types (OutlinedButton vs.
/// FilledButton) so they can be told apart even though they share a label.
Future<void> _cancelThroughUi(WidgetTester tester) async {
  await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel Appointment'));
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton, 'Cancel Appointment'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'cancelling a refund-eligible paid appointment shows the refunded '
      'confirmation and returns to the previous screen', (tester) async {
    final repo = _FakeAppointmentRepository(
      AppointmentCancelResult(
        refundEligible: true,
        payment: PaymentModel(id: 'pay1', status: PaymentModel.statusRefunded),
      ),
    );
    await _pump(tester, repo);

    await _cancelThroughUi(tester);

    expect(repo.cancelledId, 'a1');
    expect(find.text('Appointment cancelled. Your payment has been refunded.'),
        findsOneWidget);
    // Popped back to the previous screen.
    expect(find.text('list-screen'), findsOneWidget);
    expect(find.byType(AppointmentDetailScreen), findsNothing);
  });

  testWidgets(
      'cancelling inside the refund window shows the no-refund confirmation',
      (tester) async {
    final repo = _FakeAppointmentRepository(
      AppointmentCancelResult(
        refundEligible: false,
        payment: PaymentModel(id: 'pay1', status: PaymentModel.statusPaid),
      ),
    );
    await _pump(tester, repo);

    await _cancelThroughUi(tester);

    expect(repo.cancelledId, 'a1');
    expect(
      find.text(
        'Appointment cancelled. No refund was issued — this was too close to the appointment time.',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
      'cancelling an appointment that was never paid for shows a plain '
      'cancellation confirmation', (tester) async {
    final repo = _FakeAppointmentRepository(
      const AppointmentCancelResult(refundEligible: true, payment: null),
    );
    await _pump(tester, repo);

    await _cancelThroughUi(tester);

    expect(repo.cancelledId, 'a1');
    expect(find.text('Appointment cancelled.'), findsOneWidget);
  });
}
