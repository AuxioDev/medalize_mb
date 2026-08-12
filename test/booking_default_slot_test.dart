import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/calendar/slot_chip.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/patient/presentation/screens/booking_calendar_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:table_calendar/table_calendar.dart';

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

final _today = DateTime.now();
final _slots = [
  SlotModel(
    startsAt: DateTime(_today.year, _today.month, _today.day, 9),
    endsAt: DateTime(_today.year, _today.month, _today.day, 9, 30),
  ),
  SlotModel(
    startsAt: DateTime(_today.year, _today.month, _today.day, 10),
    endsAt: DateTime(_today.year, _today.month, _today.day, 10, 30),
  ),
  SlotModel(
    startsAt: DateTime(_today.year, _today.month, _today.day, 11),
    endsAt: DateTime(_today.year, _today.month, _today.day, 11, 30),
  ),
];

Widget _wrap(Widget child, {List<Override> overrides = const []}) {
  return TranslationProvider(
    child: ProviderScope(
      overrides: overrides,
      child: MaterialApp(theme: AppTheme.light, home: child),
    ),
  );
}

/// The calendar day grid is rendered by the third-party [TableCalendar]; the
/// day cells aren't reliably tappable by text (the same day-of-month number
/// can appear twice, for the leading/trailing padding days of adjacent
/// months). Driving its `onDaySelected` callback directly exercises exactly
/// what `BookingCalendarScreen` reacts to, without depending on that
/// package's internal rendering.
Future<void> _selectToday(WidgetTester tester) async {
  final calendar = tester.widget(find.byWidgetPredicate((w) => w is TableCalendar))
      as TableCalendar;
  calendar.onDaySelected!(_today, _today);
  // First pump rebuilds with `_selectedDay` set, which starts watching
  // `slotsProvider` for the first time (shows the loading skeleton); the
  // future resolves on a microtask, so a second pump is needed to rebuild
  // with the resolved slot list.
  await tester.pump();
  await tester.pump();
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
      'preselects the earliest slot and shows it on the Continue button',
      (tester) async {
    await tester.pumpWidget(_wrap(
      const BookingCalendarScreen(doctor: _doctor),
      overrides: [
        slotsProvider.overrideWith((ref, params) async => _slots),
      ],
    ));
    await tester.pump();
    await _selectToday(tester);

    final chips = tester.widgetList<SlotChip>(find.byType(SlotChip)).toList();
    expect(chips, hasLength(3));
    expect(chips[0].selected, isTrue);
    expect(chips[1].selected, isFalse);
    expect(chips[2].selected, isFalse);

    expect(find.text('Continue — 09:00'), findsOneWidget);
    expect(find.text('Earliest free slot is preselected'), findsOneWidget);

    // Let flutter_animate stagger-delay timers fire before the test tears
    // down the widget tree.
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('tapping a later chip overrides the default selection',
      (tester) async {
    await tester.pumpWidget(_wrap(
      const BookingCalendarScreen(doctor: _doctor),
      overrides: [
        slotsProvider.overrideWith((ref, params) async => _slots),
      ],
    ));
    await tester.pump();
    await _selectToday(tester);

    await tester.tap(find.byType(SlotChip).at(2));
    await tester.pump();

    final chips = tester.widgetList<SlotChip>(find.byType(SlotChip)).toList();
    expect(chips[0].selected, isFalse);
    expect(chips[2].selected, isTrue);

    expect(find.text('Continue — 11:00'), findsOneWidget);
    // The preselected hint only applies to the untouched default.
    expect(find.text('Earliest free slot is preselected'), findsNothing);

    // Let flutter_animate stagger-delay timers fire before the test tears
    // down the widget tree.
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('no Continue button when the day has no free slots',
      (tester) async {
    await tester.pumpWidget(_wrap(
      const BookingCalendarScreen(doctor: _doctor),
      overrides: [
        slotsProvider.overrideWith((ref, params) async => const []),
      ],
    ));
    await tester.pump();
    await _selectToday(tester);

    expect(find.byType(BottomActionBar), findsNothing);
    expect(find.text('No available slots'), findsOneWidget);

    // Let flutter_animate stagger-delay timers fire; the EmptyState
    // repeats forever, so pumpAndSettle would never settle.
    await tester.pump(const Duration(seconds: 1));
  });
}
