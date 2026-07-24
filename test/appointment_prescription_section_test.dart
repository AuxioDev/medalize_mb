import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/patient/presentation/screens/appointment_detail_screen.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakePrescriptionRepository extends PrescriptionRepository {
  _FakePrescriptionRepository({this.existing}) : super(Dio());
  final PrescriptionModel? existing;

  @override
  Future<PrescriptionModel?> getPrescriptionForAppointment(String appointmentId) async =>
      existing;
}

AppointmentModel _completedAppointment() => AppointmentModel(
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
      startsAt: DateTime(2026, 1, 1, 10, 0),
      endsAt: DateTime(2026, 1, 1, 10, 30),
      status: 'completed',
      reason: '',
      notes: '',
      createdAt: DateTime(2025, 12, 1),
    );

Future<void> _pump(
  WidgetTester tester, {
  required bool asDoctor,
  required _FakePrescriptionRepository repo,
}) async {
  tester.view.physicalSize = const Size(480, 1200);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final appt = _completedAppointment();
  final router = GoRouter(
    initialLocation: '/detail',
    routes: [
      GoRoute(
        path: '/detail',
        builder: (_, _) => AppointmentDetailScreen(appointment: appt, asDoctor: asDoctor),
      ),
      GoRoute(
        path: '/doctor/write-prescription/:id',
        builder: (_, _) => const Scaffold(body: Text('write-prescription-screen')),
      ),
      GoRoute(
        path: '/patient/prescriptions/:id',
        builder: (_, state) =>
            Scaffold(body: Text('prescription-detail:${state.pathParameters['id']}')),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [prescriptionRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'doctor sees a "write prescription" CTA when a completed appointment has none',
      (tester) async {
    final repo = _FakePrescriptionRepository();
    await _pump(tester, asDoctor: true, repo: repo);

    expect(find.text('No prescription for this appointment yet'), findsOneWidget);
    expect(find.text('Write Prescription'), findsOneWidget);

    await tester.tap(find.text('Write Prescription'));
    await tester.pumpAndSettle();

    expect(find.text('write-prescription-screen'), findsOneWidget);
  });

  testWidgets('patient sees a summary card and can open the full prescription',
      (tester) async {
    final prescription = PrescriptionModel(
      id: 'p1',
      doctorName: 'Jane Doe',
      issuedAt: DateTime(2026, 6, 1),
      items: const [PrescriptionItemModel(drugName: 'Amoxicillin')],
    );
    final repo = _FakePrescriptionRepository(existing: prescription);
    await _pump(tester, asDoctor: false, repo: repo);

    expect(find.text('1 medications'), findsOneWidget);
    expect(find.text('View Details'), findsOneWidget);

    await tester.tap(find.text('View Details'));
    await tester.pumpAndSettle();

    expect(find.text('prescription-detail:p1'), findsOneWidget);
  });

  testWidgets('patient sees nothing when there is no prescription yet', (tester) async {
    final repo = _FakePrescriptionRepository();
    await _pump(tester, asDoctor: false, repo: repo);

    expect(find.text('No prescription for this appointment yet'), findsNothing);
    expect(find.textContaining('Prescription'), findsNothing);
  });
}
