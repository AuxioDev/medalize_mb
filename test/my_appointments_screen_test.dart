import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_badge.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/patient/presentation/screens/my_appointments_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeAppointmentRepository extends AppointmentRepository {
  _FakeAppointmentRepository(this.appointments) : super(Dio());
  final List<AppointmentModel> appointments;

  @override
  Future<List<AppointmentModel>> getPatientAppointments({String? status}) async =>
      appointments;
}

AppointmentModel _appt({
  required String id,
  DependentModel? dependent,
}) =>
    AppointmentModel(
      id: id,
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
      // Comfortably in the future so it lands on the "Upcoming" tab, which
      // is the tab shown by default (index 0).
      startsAt: DateTime(2999, 1, 1, 10, 0),
      endsAt: DateTime(2999, 1, 1, 10, 30),
      status: 'confirmed',
      reason: '',
      notes: '',
      createdAt: DateTime(2026, 1, 1),
      dependent: dependent,
    );

Widget _app(_FakeAppointmentRepository repo) => TranslationProvider(
      child: ProviderScope(
        overrides: [appointmentRepositoryProvider.overrideWithValue(repo)],
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(theme: AppTheme.light, home: const MyAppointmentsScreen()),
        ),
      ),
    );

void main() {
  testWidgets(
      'shows a "for" badge only on the appointment that has a dependent — '
      'the combined list stays otherwise undifferentiated (Phase 4)',
      (tester) async {
    const daughter = DependentModel(
      id: 'dep-1',
      firstName: 'Anna',
      relationship: DependentModel.relationshipChild,
    );
    final repo = _FakeAppointmentRepository([
      _appt(id: 'a1'),
      _appt(id: 'a2', dependent: daughter),
    ]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.byType(AppBadge), findsOneWidget);
    expect(find.text('for Anna'), findsOneWidget);
  });

  testWidgets('shows no "for" badge when no appointment has a dependent',
      (tester) async {
    final repo = _FakeAppointmentRepository([_appt(id: 'a1')]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.byType(AppBadge), findsNothing);
  });
}
