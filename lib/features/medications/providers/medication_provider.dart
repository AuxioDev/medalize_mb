import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/data/repository/medication_repository.dart';

final medicationsProvider = FutureProvider<List<MedicationModel>>((ref) {
  return ref.watch(medicationRepositoryProvider).getMedications();
});

/// Today's dose logs (server default when no `date` is passed is "today",
/// but we pass it explicitly so the provider key stays stable regardless of
/// when it's first read).
final todaysDoseLogsProvider = FutureProvider<List<DoseLogModel>>((ref) {
  return ref.watch(medicationRepositoryProvider).getDoseLogs(date: DateTime.now());
});

/// One concrete dose slot for today, derived client-side from a medication's
/// active schedules — the server only stores the recurring rule (times +
/// days of week), not per-day instances.
class TodayDose {
  const TodayDose({
    required this.medication,
    required this.schedule,
    required this.time,
    required this.scheduledAt,
    required this.status,
    this.doseLogId,
  });

  final MedicationModel medication;
  final MedicationScheduleModel schedule;

  /// "HH:MM" as configured on the schedule.
  final String time;

  /// Today's concrete local moment for [time].
  final DateTime scheduledAt;

  /// 'taken' | 'skipped' | 'pending'.
  final String status;
  final String? doseLogId;

  bool get isPending => status == 'pending';
}

/// Expands every active medication/schedule into today's concrete dose slots,
/// sorted chronologically, cross-referencing [todaysDoseLogsProvider] so each
/// slot already knows whether it was taken/skipped.
final todaysDosesProvider = Provider<AsyncValue<List<TodayDose>>>((ref) {
  final medsAsync = ref.watch(medicationsProvider);
  final logsAsync = ref.watch(todaysDoseLogsProvider);

  if (medsAsync.isLoading || logsAsync.isLoading) {
    return const AsyncValue.loading();
  }
  if (medsAsync.hasError) {
    return AsyncValue.error(medsAsync.error!, medsAsync.stackTrace!);
  }
  if (logsAsync.hasError) {
    return AsyncValue.error(logsAsync.error!, logsAsync.stackTrace!);
  }

  final meds = medsAsync.value ?? const <MedicationModel>[];
  final logs = logsAsync.value ?? const <DoseLogModel>[];
  return AsyncValue.data(computeTodaysDoses(meds, logs, DateTime.now()));
});

/// Pure function (kept top-level so it's directly unit-testable) that expands
/// [medications] into today's concrete dose slots relative to [now].
List<TodayDose> computeTodaysDoses(
  List<MedicationModel> medications,
  List<DoseLogModel> logs,
  DateTime now,
) {
  final today = DateTime(now.year, now.month, now.day);
  // MedicationSchedule.days_of_week is 0=Mon..6=Sun; DateTime.weekday is
  // 1=Mon..7=Sun.
  final todayWeekday = now.weekday - 1;

  final doses = <TodayDose>[];
  for (final med in medications) {
    if (!med.isActive) continue;
    for (final sched in med.schedules) {
      if (!sched.isActive) continue;
      final start = DateTime(
          sched.startDate.year, sched.startDate.month, sched.startDate.day);
      if (today.isBefore(start)) continue;
      final end = sched.endDate;
      if (end != null) {
        final endDay = DateTime(end.year, end.month, end.day);
        if (today.isAfter(endDay)) continue;
      }
      if (sched.daysOfWeek.isNotEmpty &&
          !sched.daysOfWeek.contains(todayWeekday)) {
        continue;
      }
      for (final time in sched.times) {
        final parts = time.split(':');
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
        final scheduledAt =
            DateTime(now.year, now.month, now.day, hour, minute);
        DoseLogModel? match;
        for (final log in logs) {
          if (log.scheduleId == sched.id &&
              log.scheduledAt.toUtc().isAtSameMomentAs(scheduledAt.toUtc())) {
            match = log;
            break;
          }
        }
        doses.add(TodayDose(
          medication: med,
          schedule: sched,
          time: time,
          scheduledAt: scheduledAt,
          status: match?.status ?? 'pending',
          doseLogId: match?.id,
        ));
      }
    }
  }
  doses.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
  return doses;
}
