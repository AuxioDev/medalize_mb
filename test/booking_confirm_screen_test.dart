import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/models/booking_request.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/features/patient/presentation/screens/booking_confirm_screen.dart';
import 'package:medalize_mb/features/payments/data/models/payment_model.dart';
import 'package:medalize_mb/features/payments/data/repository/payment_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeAppointmentRepository extends AppointmentRepository {
  _FakeAppointmentRepository() : super(Dio());

  /// Captures the request handed to the most recent `bookAppointment` call
  /// so tests can assert what was actually sent (e.g. `dependentId`).
  BookingRequest? lastRequest;

  @override
  Future<AppointmentModel> bookAppointment(BookingRequest req) async {
    lastRequest = req;
    return AppointmentModel(
        id: 'appt-1',
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
        startsAt: req.startsAt,
        endsAt: req.startsAt.add(const Duration(minutes: 30)),
        status: 'pending',
        reason: req.reason,
        notes: '',
        createdAt: DateTime(2026, 7, 1),
      );
  }
}

/// Payriff isn't configured in this (dev) environment — the default, current
/// state per the phase spec. `createPayment` must answer exactly like the
/// real repository does on a 503: [PaymentUnavailableException].
class _PaymentsDisabledRepository extends PaymentRepository {
  _PaymentsDisabledRepository() : super(Dio());

  @override
  Future<PaymentModel> createPayment(String appointmentId) async {
    throw const PaymentUnavailableException();
  }
}

class _PaymentsEnabledRepository extends PaymentRepository {
  _PaymentsEnabledRepository() : super(Dio());
  String? requestedAppointmentId;

  @override
  Future<PaymentModel> createPayment(String appointmentId) async {
    requestedAppointmentId = appointmentId;
    return PaymentModel(
      id: 'pay-1',
      appointmentId: appointmentId,
      amount: '50.00',
      currency: 'AZN',
      status: PaymentModel.statusPending,
      paymentUrl: 'https://checkout.payriff.com/session/abc',
    );
  }
}

const _doctor = DoctorDetailModel(
  id: 'd1',
  firstName: 'Jane',
  lastName: 'Doe',
  specialization: 'cardiologist',
  specializationDisplay: 'Cardiology',
  slotDurationMin: 30,
  bio: 'Experienced cardiologist',
  workplaces: [
    DoctorWorkplace(
      id: 'w1',
      name: 'City Clinic',
      city: 'Baku',
      address: '12 Main St',
      type: 'clinic',
      isPrimary: true,
    ),
  ],
);

final _slot = SlotModel(
  startsAt: DateTime(2030, 1, 1, 10, 0),
  endsAt: DateTime(2030, 1, 1, 10, 30),
);

Future<void> _pump(
  WidgetTester tester, {
  required PaymentRepository paymentRepo,
  _FakeAppointmentRepository? appointmentRepo,
  DependentModel? activeProfile,
}) async {
  tester.view.physicalSize = const Size(480, 1000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: '/confirm',
    routes: [
      GoRoute(
        path: '/confirm',
        builder: (_, _) => BookingConfirmScreen(
          doctor: _doctor,
          slot: _slot,
          workplaceId: 'w1',
        ),
      ),
      GoRoute(
        path: '/patient/home',
        builder: (_, _) => const Scaffold(body: Text('patient-home')),
      ),
      GoRoute(
        path: '/patient/appointments/:id/payment',
        builder: (_, state) =>
            Scaffold(body: Text('payment-screen:${state.pathParameters['id']}')),
      ),
    ],
  );

  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          appointmentRepositoryProvider
              .overrideWithValue(appointmentRepo ?? _FakeAppointmentRepository()),
          paymentRepositoryProvider.overrideWithValue(paymentRepo),
          if (activeProfile != null)
            activeProfileProvider.overrideWith((ref) => activeProfile),
        ],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'when Payriff is unconfigured (503) the success dialog renders exactly '
      'as before — no payment UI appears at all', (tester) async {
    await _pump(tester, paymentRepo: _PaymentsDisabledRepository());

    await tester.tap(find.byType(LoadingFilledButton));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Booked!'), findsOneWidget);
    expect(find.text('Your appointment request has been sent.'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    // The one and only behavioral difference this phase introduces — and it
    // must not appear when payments are unavailable.
    expect(find.text('Pay Now'), findsNothing);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('patient-home'), findsOneWidget);
  });

  testWidgets(
      'when payment creation succeeds, the success dialog gains an optional '
      'Pay Now button alongside the unchanged success UI', (tester) async {
    final paymentRepo = _PaymentsEnabledRepository();
    await _pump(tester, paymentRepo: paymentRepo);

    await tester.tap(find.byType(LoadingFilledButton));
    await tester.pumpAndSettle();

    expect(find.text('Booked!'), findsOneWidget);
    expect(find.text('Your appointment request has been sent.'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Pay Now'), findsOneWidget);
    expect(paymentRepo.requestedAppointmentId, 'appt-1');
  });

  testWidgets('tapping Pay Now closes the dialog and navigates to the payment screen',
      (tester) async {
    await _pump(tester, paymentRepo: _PaymentsEnabledRepository());

    await tester.tap(find.byType(LoadingFilledButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pay Now'));
    await tester.pumpAndSettle();

    expect(find.text('payment-screen:appt-1'), findsOneWidget);
  });

  testWidgets(
      'tapping OK with payment available still goes straight home, without '
      'forcing the patient into the payment screen', (tester) async {
    await _pump(tester, paymentRepo: _PaymentsEnabledRepository());

    await tester.tap(find.byType(LoadingFilledButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('patient-home'), findsOneWidget);
    expect(find.text('payment-screen:appt-1'), findsNothing);
  });

  group('family profile switching (Phase 4)', () {
    const daughter = DependentModel(
      id: 'dep-1',
      firstName: 'Anna',
      lastName: 'Doe',
      relationship: DependentModel.relationshipChild,
    );

    testWidgets(
        'shows no "Booking for" banner and sends no dependentId when the '
        'active profile is "myself" (the default)', (tester) async {
      final appointmentRepo = _FakeAppointmentRepository();
      await _pump(
        tester,
        paymentRepo: _PaymentsDisabledRepository(),
        appointmentRepo: appointmentRepo,
      );

      expect(find.textContaining('Booking for:'), findsNothing);

      await tester.tap(find.byType(LoadingFilledButton));
      await tester.pumpAndSettle();

      expect(appointmentRepo.lastRequest?.dependentId, isNull);
    });

    testWidgets(
        'shows "Booking for: Anna" and sends her id as dependentId when she is '
        'the active profile', (tester) async {
      final appointmentRepo = _FakeAppointmentRepository();
      await _pump(
        tester,
        paymentRepo: _PaymentsDisabledRepository(),
        appointmentRepo: appointmentRepo,
        activeProfile: daughter,
      );

      expect(find.text('Booking for: Anna Doe'), findsOneWidget);

      await tester.tap(find.byType(LoadingFilledButton));
      await tester.pumpAndSettle();

      expect(appointmentRepo.lastRequest?.dependentId, 'dep-1');
    });
  });
}
