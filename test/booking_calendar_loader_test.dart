import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/patient/presentation/screens/booking_calendar_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

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

  testWidgets('renders BookingCalendarScreen immediately when doctor provided',
      (tester) async {
    var fetched = false;
    await tester.pumpWidget(_wrap(
      const BookingCalendarLoader(doctorId: 'd1', doctor: _doctor),
      overrides: [
        doctorDetailProvider.overrideWith((ref, id) async {
          fetched = true;
          return _doctor;
        }),
      ],
    ));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.byType(BookingCalendarScreen), findsOneWidget);
    expect(find.byType(ShimmerSkeleton), findsNothing);
    expect(fetched, isFalse, reason: 'must not fetch when doctor is provided');

    // Let flutter_animate stagger-delay timers fire; the screen's EmptyState
    // repeats forever, so pumpAndSettle would never settle.
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('loads doctor by id when extra is null (deep link/restore)',
      (tester) async {
    String? requestedId;
    await tester.pumpWidget(_wrap(
      const BookingCalendarLoader(doctorId: 'd1'),
      overrides: [
        doctorDetailProvider.overrideWith((ref, id) async {
          requestedId = id;
          return _doctor;
        }),
      ],
    ));

    // First frame: still loading — skeleton visible.
    expect(find.byType(ShimmerSkeleton), findsWidgets);
    expect(find.byType(BookingCalendarScreen), findsNothing);

    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(requestedId, 'd1');
    expect(find.byType(BookingCalendarScreen), findsOneWidget);

    // Let flutter_animate stagger-delay timers fire; the screen's EmptyState
    // repeats forever, so pumpAndSettle would never settle.
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('shows error state when the fetch fails', (tester) async {
    await tester.pumpWidget(_wrap(
      const BookingCalendarLoader(doctorId: 'd1'),
      overrides: [
        doctorDetailProvider.overrideWith(
          (ref, id) => Future<DoctorDetailModel>.error(Exception('network')),
        ),
      ],
    ));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.byType(BookingCalendarScreen), findsNothing);
  });
}
