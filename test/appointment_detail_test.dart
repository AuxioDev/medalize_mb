import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/patient/presentation/screens/appointment_detail_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

AppointmentModel _sample({String status = 'confirmed'}) => AppointmentModel(
      id: '1',
      doctor: const AppointmentDoctor(
        id: 'd1',
        firstName: 'Jane',
        lastName: 'Doe',
        specialization: 'cardiologist',
        specializationDisplay: 'Cardiology',
      ),
      patient: const AppointmentPatient(
        id: 'p1',
        firstName: 'John',
        lastName: 'Smith',
      ),
      workplace: const AppointmentWorkplace(
        id: 'w1',
        name: 'City Clinic',
        address: '12 Main St',
        city: 'Baku',
      ),
      startsAt: DateTime(2030, 1, 1, 10, 0),
      endsAt: DateTime(2030, 1, 1, 10, 30),
      status: status,
      reason: 'Annual checkup',
      notes: 'Bring previous results',
      createdAt: DateTime(2029, 12, 1),
    );

void main() {
  testWidgets('AppointmentDetailScreen renders without layout errors',
      (tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light,
            home: AppointmentDetailScreen(appointment: _sample()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('City Clinic'), findsOneWidget);
  });

  testWidgets('doctor view shows the patient and confirm/decline for pending',
      (tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light,
            home: AppointmentDetailScreen(
              appointment: _sample(status: 'pending'),
              asDoctor: true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // Surfaces the patient, not the doctor.
    expect(find.text('John Smith'), findsOneWidget);
    expect(find.text('Jane Doe'), findsNothing);
    // Pending requests get confirm/decline actions.
    expect(find.text('Confirm'), findsOneWidget);
    expect(find.text('Decline'), findsOneWidget);
    expect(find.text('Cancel Appointment'), findsNothing);
  });
}
