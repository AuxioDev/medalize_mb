import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/providers/medication_provider.dart';

MedicationScheduleModel _schedule({
  String id = 's1',
  List<String> times = const ['08:00'],
  List<int> daysOfWeek = const [],
  DateTime? startDate,
  DateTime? endDate,
  bool isActive = true,
}) =>
    MedicationScheduleModel(
      id: id,
      times: times,
      daysOfWeek: daysOfWeek,
      startDate: startDate ?? DateTime(2020, 1, 1),
      endDate: endDate,
      isActive: isActive,
    );

MedicationModel _medication({
  String id = 'm1',
  String name = 'Metformin',
  bool isActive = true,
  List<MedicationScheduleModel> schedules = const [],
  String source = MedicationModel.sourceManual,
}) =>
    MedicationModel(
      id: id,
      name: name,
      isActive: isActive,
      schedules: schedules,
      source: source,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  group('MedicationScheduleModel', () {
    test('fromJson parses server fields', () {
      final s = MedicationScheduleModel.fromJson({
        'id': 'sched-1',
        'times': ['08:00', '20:00'],
        'days_of_week': [0, 2, 4],
        'start_date': '2026-01-01',
        'end_date': '2026-02-01',
        'timezone': 'Asia/Baku',
        'is_active': true,
      });
      expect(s.times, ['08:00', '20:00']);
      expect(s.daysOfWeek, [0, 2, 4]);
      expect(s.startDate, DateTime(2026, 1, 1));
      expect(s.endDate, DateTime(2026, 2, 1));
      expect(s.timezone, 'Asia/Baku');
    });

    test('toJson omits the read-only id and formats dates as yyyy-MM-dd', () {
      final s = _schedule(
        times: ['09:30'],
        daysOfWeek: [1, 3],
        startDate: DateTime(2026, 3, 5),
      );
      final json = s.toJson();
      expect(json.containsKey('id'), isFalse);
      expect(json['times'], ['09:30']);
      expect(json['days_of_week'], [1, 3]);
      expect(json['start_date'], '2026-03-05');
      expect(json.containsKey('end_date'), isFalse);
    });
  });

  group('MedicationModel', () {
    test('fromJson parses nested schedules and defaults', () {
      final med = MedicationModel.fromJson({
        'id': 'm1',
        'name': 'Ibuprofen',
        'dosage': '200mg',
        'source': 'prescription',
        'is_active': true,
        'created_at': '2026-01-01T00:00:00Z',
        'schedules': [
          {
            'id': 's1',
            'times': ['08:00'],
            'days_of_week': [],
            'start_date': '2026-01-01',
          },
        ],
      });
      expect(med.name, 'Ibuprofen');
      expect(med.isFromPrescription, isTrue);
      expect(med.schedules, hasLength(1));
      expect(med.hasSchedule, isTrue);
    });

    test('hasSchedule is false with no active schedules', () {
      final med = _medication(schedules: const []);
      expect(med.hasSchedule, isFalse);
    });
  });

  group('DoseLogModel.fromJson', () {
    test('parses the schedule FK and status', () {
      final log = DoseLogModel.fromJson({
        'id': 'l1',
        'schedule': 's1',
        'scheduled_at': '2026-01-01T08:00:00Z',
        'status': 'taken',
      });
      expect(log.scheduleId, 's1');
      expect(log.status, 'taken');
    });
  });

  group('computeTodaysDoses', () {
    test('expands a daily schedule into a slot for today', () {
      final now = DateTime(2026, 7, 24, 10, 0); // a Friday
      final med = _medication(schedules: [
        _schedule(times: ['08:00', '20:00'], startDate: DateTime(2026, 1, 1)),
      ]);
      final doses = computeTodaysDoses([med], const [], now);
      expect(doses, hasLength(2));
      expect(doses[0].time, '08:00');
      expect(doses[0].status, 'pending');
      expect(doses[1].time, '20:00');
    });

    test('respects days_of_week filtering', () {
      final now = DateTime(2026, 7, 24, 10, 0); // Friday -> Mon=0..Fri=4
      final medOnFriday = _medication(schedules: [
        _schedule(times: ['09:00'], daysOfWeek: const [4]),
      ]);
      final medOnMonday = _medication(id: 'm2', schedules: [
        _schedule(id: 's2', times: ['09:00'], daysOfWeek: const [0]),
      ]);
      final doses = computeTodaysDoses([medOnFriday, medOnMonday], const [], now);
      expect(doses, hasLength(1));
      expect(doses.first.medication.id, medOnFriday.id);
    });

    test('skips schedules before startDate or after endDate', () {
      final now = DateTime(2026, 7, 24);
      final future = _medication(schedules: [
        _schedule(startDate: DateTime(2026, 8, 1)),
      ]);
      final expired = _medication(id: 'm2', schedules: [
        _schedule(
          id: 's2',
          startDate: DateTime(2026, 1, 1),
          endDate: DateTime(2026, 6, 1),
        ),
      ]);
      final doses = computeTodaysDoses([future, expired], const [], now);
      expect(doses, isEmpty);
    });

    test('ignores inactive medications and schedules', () {
      final now = DateTime(2026, 7, 24);
      final inactiveMed = _medication(isActive: false, schedules: [_schedule()]);
      final inactiveSchedule =
          _medication(id: 'm2', schedules: [_schedule(id: 's2', isActive: false)]);
      final doses = computeTodaysDoses([inactiveMed, inactiveSchedule], const [], now);
      expect(doses, isEmpty);
    });

    test('cross-references a matching dose log to report taken status', () {
      final now = DateTime(2026, 7, 24, 10, 0);
      final med = _medication(schedules: [_schedule(times: ['08:00'])]);
      final log = DoseLogModel(
        id: 'l1',
        scheduleId: 's1',
        scheduledAt: DateTime(2026, 7, 24, 8, 0),
        status: 'taken',
      );
      final doses = computeTodaysDoses([med], [log], now);
      expect(doses.single.status, 'taken');
      expect(doses.single.isPending, isFalse);
    });
  });
}
