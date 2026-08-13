import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/notifications/data/models/notification_model.dart';
import 'package:medalize_mb/features/notifications/providers/notification_provider.dart';
import 'package:medalize_mb/features/patient/presentation/screens/patient_home_screen.dart';
import 'package:medalize_mb/features/patient/providers/favorites_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

AppointmentModel _completedAppointment({
  required String id,
  required String doctorId,
  required String doctorFirstName,
  required String workplaceId,
  required DateTime startsAt,
}) =>
    AppointmentModel(
      id: id,
      doctor: AppointmentDoctor(
        id: doctorId,
        firstName: doctorFirstName,
        lastName: 'Doe',
        specialization: 'cardiologist',
        specializationDisplay: 'Cardiology',
      ),
      patient: const AppointmentPatient(id: 'p1', firstName: 'John', lastName: 'Smith'),
      workplace: AppointmentWorkplace(
        id: workplaceId,
        name: 'Clinic',
        address: '1 Main St',
        city: 'Baku',
      ),
      startsAt: startsAt,
      endsAt: startsAt.add(const Duration(minutes: 30)),
      status: 'completed',
      reason: '',
      notes: '',
      createdAt: startsAt,
    );

DoctorModel _favorite({required String id, required String firstName}) => DoctorModel(
      id: id,
      firstName: firstName,
      lastName: 'Doe',
      specialization: 'cardiologist',
      specializationDisplay: 'Cardiology',
      slotDurationMin: 30,
      primaryWorkplaceId: 'w-fav-$id',
    );

Future<void> _pump(
  WidgetTester tester, {
  List<DoctorModel> favorites = const [],
  List<AppointmentModel> appointments = const [],
}) async {
  tester.view.physicalSize = const Size(390, 1400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          notificationsProvider.overrideWith((ref) async => const <NotificationModel>[]),
          patientAppointmentsProvider.overrideWith((ref, status) async => appointments),
          myWaitlistProvider.overrideWith((ref) async => []),
          favoriteDoctorsProvider.overrideWith((ref) async => favorites),
          nextAvailableDateProvider.overrideWith((ref, id) async => null),
        ],
        child: MaterialApp(theme: AppTheme.light, home: const PatientHomeScreen()),
      ),
    ),
  );
  // Not pumpAndSettle: with no upcoming appointments, _UpcomingAppointments
  // falls back to EmptyState, whose float animation repeats forever (same
  // reasoning as the locale-overflow harness's `settle: false` escape
  // hatch) — a bounded pump is enough for the providers above to resolve.
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  testWidgets(
      'exactly one favorite doctor wins over any completed-appointment history',
      (tester) async {
    await _pump(
      tester,
      favorites: [_favorite(id: 'fav-1', firstName: 'Aysel')],
      appointments: [
        _completedAppointment(
          id: 'a1',
          doctorId: 'seen-before',
          doctorFirstName: 'Rauf',
          workplaceId: 'w1',
          startsAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ],
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Book with Dr. Aysel Doe'), findsOneWidget);
    expect(find.text('Book with Rauf Doe'), findsNothing);
  });

  testWidgets(
      'falls back to the most recent completed appointment\'s doctor when '
      'there is no single favorite (zero or 2+)', (tester) async {
    await _pump(
      tester,
      favorites: const [],
      appointments: [
        _completedAppointment(
          id: 'a1',
          doctorId: 'older',
          doctorFirstName: 'Rauf',
          workplaceId: 'w1',
          startsAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
        _completedAppointment(
          id: 'a2',
          doctorId: 'newer',
          doctorFirstName: 'Leyla',
          workplaceId: 'w2',
          startsAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
    );

    expect(tester.takeException(), isNull);
    // The most recent completed visit's doctor, not the older one.
    expect(find.text('Book with Leyla Doe'), findsOneWidget);
    expect(find.text('Book with Rauf Doe'), findsNothing);
  });

  testWidgets(
      'shows nothing when there is no single favorite and no completed '
      'appointment history', (tester) async {
    await _pump(tester);

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Book with'), findsNothing);
  });
}
