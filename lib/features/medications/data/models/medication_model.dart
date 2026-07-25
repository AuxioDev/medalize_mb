import 'package:intl/intl.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';

final DateFormat _dateOnlyFmt = DateFormat('yyyy-MM-dd');

class MedicationScheduleModel {
  final String id;

  /// 24h "HH:MM" times, local wall-clock time of the patient.
  final List<String> times;

  /// 0=Mon .. 6=Sun. Empty means every day.
  final List<int> daysOfWeek;
  final DateTime startDate;
  final DateTime? endDate;

  /// IANA timezone name (e.g. "Asia/Baku"); empty means "use the device's
  /// current timezone at display time".
  final String timezone;
  final bool isActive;

  const MedicationScheduleModel({
    required this.id,
    required this.times,
    required this.daysOfWeek,
    required this.startDate,
    this.endDate,
    this.timezone = '',
    this.isActive = true,
  });

  factory MedicationScheduleModel.fromJson(Map<String, dynamic> j) =>
      MedicationScheduleModel(
        id: j['id'] as String? ?? '',
        times: ((j['times'] as List<dynamic>?) ?? const [])
            .map((e) => e as String)
            .toList(),
        daysOfWeek: ((j['days_of_week'] as List<dynamic>?) ?? const [])
            .map((e) => e as int)
            .toList(),
        startDate: j['start_date'] != null
            ? DateTime.parse(j['start_date'] as String)
            : DateTime.now(),
        endDate: j['end_date'] != null
            ? DateTime.parse(j['end_date'] as String)
            : null,
        timezone: j['timezone'] as String? ?? '',
        isActive: j['is_active'] as bool? ?? true,
      );

  /// Request body shape for create/update — `id` is server-assigned and
  /// read-only, so it's intentionally omitted here.
  Map<String, dynamic> toJson() => {
        'times': times,
        'days_of_week': daysOfWeek,
        'start_date': _dateOnlyFmt.format(startDate),
        if (endDate != null) 'end_date': _dateOnlyFmt.format(endDate!),
        'timezone': timezone,
        'is_active': isActive,
      };

  MedicationScheduleModel copyWith({
    String? id,
    List<String>? times,
    List<int>? daysOfWeek,
    DateTime? startDate,
    DateTime? endDate,
    bool clearEndDate = false,
    String? timezone,
    bool? isActive,
  }) =>
      MedicationScheduleModel(
        id: id ?? this.id,
        times: times ?? this.times,
        daysOfWeek: daysOfWeek ?? this.daysOfWeek,
        startDate: startDate ?? this.startDate,
        endDate: clearEndDate ? null : (endDate ?? this.endDate),
        timezone: timezone ?? this.timezone,
        isActive: isActive ?? this.isActive,
      );
}

class MedicationModel {
  static const sourceManual = 'manual';
  static const sourcePrescription = 'prescription';

  final String id;
  final String name;
  final String dosage;
  final String form;
  final String notes;
  final String source;
  final bool isActive;
  final List<MedicationScheduleModel> schedules;
  final DateTime createdAt;

  /// Set when this medication belongs to a managed family member rather
  /// than the account holder — see `activeProfileProvider`
  /// (`lib/features/family/providers/family_provider.dart`).
  final DependentModel? dependent;

  const MedicationModel({
    required this.id,
    required this.name,
    this.dosage = '',
    this.form = '',
    this.notes = '',
    this.source = sourceManual,
    this.isActive = true,
    this.schedules = const [],
    required this.createdAt,
    this.dependent,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> j) => MedicationModel(
        id: j['id'] as String,
        name: j['name'] as String? ?? '',
        dosage: j['dosage'] as String? ?? '',
        form: j['form'] as String? ?? '',
        notes: j['notes'] as String? ?? '',
        source: j['source'] as String? ?? sourceManual,
        isActive: j['is_active'] as bool? ?? true,
        schedules: ((j['schedules'] as List<dynamic>?) ?? const [])
            .map((e) =>
                MedicationScheduleModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        createdAt: j['created_at'] != null
            ? DateTime.parse(j['created_at'] as String)
            : DateTime.now(),
        dependent: j['dependent'] != null
            ? DependentModel.fromJson(j['dependent'] as Map<String, dynamic>)
            : null,
      );

  bool get isFromPrescription => source == sourcePrescription;
  bool get hasSchedule => schedules.any((s) => s.isActive && s.times.isNotEmpty);
}

class DoseLogModel {
  static const statusTaken = 'taken';
  static const statusSkipped = 'skipped';

  final String id;
  final String scheduleId;
  final DateTime scheduledAt;
  final String status;

  const DoseLogModel({
    required this.id,
    required this.scheduleId,
    required this.scheduledAt,
    required this.status,
  });

  factory DoseLogModel.fromJson(Map<String, dynamic> j) => DoseLogModel(
        id: j['id'] as String? ?? '',
        scheduleId: j['schedule'] as String,
        scheduledAt: DateTime.parse(j['scheduled_at'] as String),
        status: j['status'] as String,
      );
}
