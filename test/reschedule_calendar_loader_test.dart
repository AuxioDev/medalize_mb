import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/patient/presentation/screens/reschedule_calendar_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

AppointmentModel _sample() => AppointmentModel(
      id: 'a1',
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
      status: 'confirmed',
      reason: 'Annual checkup',
      notes: '',
      createdAt: DateTime(2029, 12, 1),
    );

Widget _wrap(Widget child, {List<Override> overrides = const []}) {
  return TranslationProvider(
    child: ProviderScope(
      overrides: overrides,
      child: MaterialApp(theme: AppTheme.light, home: child),
    ),
  );
}

void main() {
  setUp(() {
    // The calendar screen lays out for a phone-sized (tall) viewport; the
    // default 800x600 test surface overflows it by a couple of pixels.
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first
      ..physicalSize = const Size(1170, 2532)
      ..devicePixelRatio = 3.0;
  });

  tearDown(() {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first
      ..resetPhysicalSize()
      ..resetDevicePixelRatio();
  });

  testWidgets(
      'renders RescheduleCalendarScreen immediately when appointment provided',
      (tester) async {
    var fetched = false;
    await tester.pumpWidget(_wrap(
      RescheduleCalendarLoader(appointmentId: 'a1', appointment: _sample()),
      overrides: [
        appointmentByIdProvider.overrideWith((ref, id) async {
          fetched = true;
          return _sample();
        }),
      ],
    ));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.byType(RescheduleCalendarScreen), findsOneWidget);
    expect(find.byType(ShimmerSkeleton), findsNothing);
    expect(fetched, isFalse,
        reason: 'must not fetch when appointment is provided');

    // Let flutter_animate stagger-delay timers fire; the screen's EmptyState
    // repeats forever, so pumpAndSettle would never settle.
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('loads appointment by id when extra is null (deep link/restore)',
      (tester) async {
    String? requestedId;
    await tester.pumpWidget(_wrap(
      const RescheduleCalendarLoader(appointmentId: 'a1'),
      overrides: [
        appointmentByIdProvider.overrideWith((ref, id) async {
          requestedId = id;
          return _sample();
        }),
      ],
    ));

    // First frame: still loading — skeleton visible.
    expect(find.byType(ShimmerSkeleton), findsWidgets);
    expect(find.byType(RescheduleCalendarScreen), findsNothing);

    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(requestedId, 'a1');
    expect(find.byType(RescheduleCalendarScreen), findsOneWidget);

    // Let flutter_animate stagger-delay timers fire; the screen's EmptyState
    // repeats forever, so pumpAndSettle would never settle.
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('shows error state when the fetch fails', (tester) async {
    await tester.pumpWidget(_wrap(
      const RescheduleCalendarLoader(appointmentId: 'a1'),
      overrides: [
        appointmentByIdProvider.overrideWith(
          (ref, id) => Future<AppointmentModel>.error(Exception('network')),
        ),
      ],
    ));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.byType(RescheduleCalendarScreen), findsNothing);
  });
}
