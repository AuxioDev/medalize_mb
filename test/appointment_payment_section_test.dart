import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/patient/presentation/screens/appointment_detail_screen.dart';
import 'package:medalize_mb/features/payments/data/models/payment_model.dart';
import 'package:medalize_mb/features/payments/data/repository/payment_repository.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakePaymentRepository extends PaymentRepository {
  _FakePaymentRepository({this.existing}) : super(Dio());
  final PaymentModel? existing;

  @override
  Future<PaymentModel?> getPayment(String appointmentId) async => existing;
}

/// The screen also renders a prescription section for completed
/// appointments — stub it out (matches
/// `test/appointment_prescription_section_test.dart`) so these
/// payment-focused tests don't also hit the network for that section.
class _NoPrescriptionRepository extends PrescriptionRepository {
  _NoPrescriptionRepository() : super(Dio());

  @override
  Future<PrescriptionModel?> getPrescriptionForAppointment(String appointmentId) async => null;
}

/// A `pending`-status (not yet doctor-confirmed) appointment: a payment can
/// already exist for it, since it's created right after booking, before the
/// doctor ever acts on the request.
AppointmentModel _pendingAppointment() => AppointmentModel(
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
      startsAt: DateTime(2030, 1, 1, 10, 0),
      endsAt: DateTime(2030, 1, 1, 10, 30),
      status: 'pending',
      reason: '',
      notes: '',
      createdAt: DateTime(2029, 12, 1),
    );

Future<void> _pump(
  WidgetTester tester, {
  required bool asDoctor,
  required _FakePaymentRepository repo,
}) async {
  tester.view.physicalSize = const Size(480, 1200);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final appt = _pendingAppointment();
  final router = GoRouter(
    initialLocation: '/detail',
    routes: [
      GoRoute(
        path: '/detail',
        builder: (_, _) => AppointmentDetailScreen(appointment: appt, asDoctor: asDoctor),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          paymentRepositoryProvider.overrideWithValue(repo),
          prescriptionRepositoryProvider.overrideWithValue(_NoPrescriptionRepository()),
        ],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('no badge appears when the appointment has no payment yet',
      (tester) async {
    await _pump(tester, asDoctor: false, repo: _FakePaymentRepository());

    expect(tester.takeException(), isNull);
    // _InfoCard renders its label uppercased.
    expect(find.text('PAYMENT'), findsNothing);
  });

  testWidgets('patient sees a pending-payment badge on a pending appointment',
      (tester) async {
    final payment = PaymentModel(
      id: 'pay-1',
      appointmentId: 'a1',
      amount: '50.00',
      currency: 'AZN',
      status: PaymentModel.statusPending,
      paymentUrl: 'https://checkout.payriff.com/session/abc',
    );
    await _pump(tester, asDoctor: false, repo: _FakePaymentRepository(existing: payment));

    expect(find.text('PAYMENT'), findsOneWidget);
    expect(find.text('50.00 AZN'), findsOneWidget);
    expect(find.text('Payment Pending'), findsOneWidget);
  });

  testWidgets('doctor also sees the payment badge, e.g. once it is paid',
      (tester) async {
    final payment = PaymentModel(
      id: 'pay-1',
      appointmentId: 'a1',
      amount: '50.00',
      currency: 'AZN',
      status: PaymentModel.statusPaid,
      paymentUrl: 'https://checkout.payriff.com/session/abc',
    );
    await _pump(tester, asDoctor: true, repo: _FakePaymentRepository(existing: payment));

    expect(find.text('PAYMENT'), findsOneWidget);
    expect(find.text('Paid'), findsOneWidget);
  });
}
