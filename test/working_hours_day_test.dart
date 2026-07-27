import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/doctor/presentation/widgets/working_hours_fields.dart';

void main() {
  group('WorkingHoursDay.defaultWeek', () {
    test('all inactive 09:00-17:00 by default', () {
      final days = WorkingHoursDay.defaultWeek();
      expect(days, hasLength(7));
      for (final d in days) {
        expect(d.isActive, isFalse);
        expect(d.startTime, const TimeOfDay(hour: 9, minute: 0));
        expect(d.endTime, const TimeOfDay(hour: 17, minute: 0));
      }
    });

    test('weekdaysActive enables Mon-Fri only', () {
      final days = WorkingHoursDay.defaultWeek(weekdaysActive: true);
      for (var i = 0; i < 5; i++) {
        expect(days[i].isActive, isTrue);
      }
      expect(days[5].isActive, isFalse);
      expect(days[6].isActive, isFalse);
    });
  });

  group('WorkingHoursDay.fromApiList / toPayload round trip', () {
    test('parses HH:MM:SS strings and fills missing weekdays with defaults',
        () {
      final days = WorkingHoursDay.fromApiList([
        {
          'weekday': 2,
          'start_time': '08:30:00',
          'end_time': '13:45:00',
          'is_active': true,
        },
      ]);
      expect(days[2].isActive, isTrue);
      expect(days[2].startTime, const TimeOfDay(hour: 8, minute: 30));
      expect(days[2].endTime, const TimeOfDay(hour: 13, minute: 45));
      // Untouched day falls back to the inactive default.
      expect(days[0].isActive, isFalse);
      expect(days[0].startTime, const TimeOfDay(hour: 9, minute: 0));
    });

    test('null list yields the default week', () {
      final days = WorkingHoursDay.fromApiList(null);
      expect(days, hasLength(7));
      expect(days.every((d) => !d.isActive), isTrue);
    });

    test('toPayload emits all 7 weekdays with zero-padded HH:MM:SS', () {
      final days = WorkingHoursDay.defaultWeek(weekdaysActive: true);
      days[0].startTime = const TimeOfDay(hour: 8, minute: 5);
      final payload = WorkingHoursDay.toPayload(days);
      expect(payload, hasLength(7));
      expect(payload[0]['weekday'], 0);
      expect(payload[0]['start_time'], '08:05:00');
      expect(payload[0]['end_time'], '17:00:00');
      expect(payload[0]['is_active'], true);
    });
  });

  group('WorkingHoursDay.hasInvalidRange', () {
    test('false when no active day has a bad range', () {
      final days = WorkingHoursDay.defaultWeek(weekdaysActive: true);
      expect(WorkingHoursDay.hasInvalidRange(days), isFalse);
    });

    test('true when an active day has end <= start', () {
      final days = WorkingHoursDay.defaultWeek();
      days[0].isActive = true;
      days[0].startTime = const TimeOfDay(hour: 17, minute: 0);
      days[0].endTime = const TimeOfDay(hour: 9, minute: 0);
      expect(WorkingHoursDay.hasInvalidRange(days), isTrue);
    });

    test('inactive days with a bad range are ignored', () {
      final days = WorkingHoursDay.defaultWeek();
      days[0].isActive = false;
      days[0].startTime = const TimeOfDay(hour: 17, minute: 0);
      days[0].endTime = const TimeOfDay(hour: 9, minute: 0);
      expect(WorkingHoursDay.hasInvalidRange(days), isFalse);
    });
  });
}
