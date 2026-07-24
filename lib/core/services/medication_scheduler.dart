import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:medalize_mb/core/services/fcm_service.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

final medicationSchedulerProvider =
    Provider<MedicationScheduler>((ref) => MedicationScheduler());

/// Reserved local-notification id range for medication dose reminders, kept
/// apart from other notification ids (FCM foreground alerts use
/// `message.hashCode`) so [MedicationScheduler] only ever cancels its own
/// notifications when it recomputes the schedule.
const _idRangeStart = 900000000;
const _idRangeEnd = 999999999;
const _idRangeSize = _idRangeEnd - _idRangeStart;

/// Schedules/cancels local "time to take your medication" reminders from the
/// server-synced schedule. Reminder delivery is intentionally local-only —
/// there is no server-side beat task for this (see PHASE1_CARE_LOOP_PROMPT.md
/// §1) — so this class is the single source of truth for what's on-device.
class MedicationScheduler {
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _tzReady = false;

  /// Idempotent: safe to call before every reschedule and again at app start.
  Future<void> ensureTimezoneReady() async {
    if (_tzReady) return;
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (e) {
      debugPrint('MedicationScheduler: falling back to UTC timezone: $e');
      tz.setLocalLocation(tz.UTC);
    }
    _tzReady = true;
  }

  /// Recomputes every reminder from scratch: cancels everything in the
  /// reserved id range, then re-schedules one recurring notification per
  /// (schedule time [x] day-of-week) combination for every active medication.
  Future<void> rescheduleAll(List<MedicationModel> medications) async {
    await ensureTimezoneReady();
    await _cancelReservedRange();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (final med in medications) {
      if (!med.isActive) continue;
      for (final schedule in med.schedules) {
        if (!schedule.isActive || schedule.times.isEmpty) continue;

        final start = DateTime(schedule.startDate.year,
            schedule.startDate.month, schedule.startDate.day);
        final end = schedule.endDate;
        if (end != null) {
          final endDay = DateTime(end.year, end.month, end.day);
          // The whole window is already over — nothing left to schedule.
          if (endDay.isBefore(today)) continue;
        }

        for (final time in schedule.times) {
          final parsed = _parseTime(time);
          if (parsed == null) continue;
          final (hour, minute) = parsed;

          if (schedule.daysOfWeek.isEmpty) {
            await _scheduleDaily(med, schedule, time, hour, minute, start);
          } else {
            for (final day in schedule.daysOfWeek) {
              await _scheduleWeekly(
                  med, schedule, time, hour, minute, day, start);
            }
          }
        }
      }
    }
  }

  /// Cancels every reminder this class has scheduled. Used on logout so
  /// nothing keeps firing for a signed-out user on a shared device.
  Future<void> cancelAll() => _cancelReservedRange();

  Future<void> _scheduleDaily(
    MedicationModel med,
    MedicationScheduleModel schedule,
    String time,
    int hour,
    int minute,
    DateTime start,
  ) async {
    final scheduledDate = _firstOccurrence(hour, minute, start: start);
    await _plugin.zonedSchedule(
      _notificationId('${schedule.id}|$time'),
      t.medications.reminderTitle(name: med.name),
      med.dosage.isNotEmpty
          ? t.medications.reminderBody(dosage: med.dosage)
          : med.name,
      scheduledDate,
      _details(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _scheduleWeekly(
    MedicationModel med,
    MedicationScheduleModel schedule,
    String time,
    int hour,
    int minute,
    int mondayBasedDay,
    DateTime start,
  ) async {
    final weekday = mondayBasedDay + 1; // DateTime: Monday == 1 .. Sunday == 7
    final scheduledDate =
        _firstOccurrence(hour, minute, start: start, weekday: weekday);
    await _plugin.zonedSchedule(
      _notificationId('${schedule.id}|$time|$mondayBasedDay'),
      t.medications.reminderTitle(name: med.name),
      med.dosage.isNotEmpty
          ? t.medications.reminderBody(dosage: med.dosage)
          : med.name,
      scheduledDate,
      _details(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  /// The next moment (today or later) matching [hour]:[minute] — and, if
  /// given, [weekday] (Dart convention: Monday == 1) — that is not before
  /// [start]. `matchDateTimeComponents` makes the OS repeat it forever from
  /// there (daily, or weekly on that weekday).
  tz.TZDateTime _firstOccurrence(
    int hour,
    int minute, {
    required DateTime start,
    int? weekday,
  }) {
    final now = tz.TZDateTime.now(tz.local);
    var candidate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    final step = weekday != null ? const Duration(days: 7) : const Duration(days: 1);
    if (weekday != null) {
      while (candidate.weekday != weekday) {
        candidate = candidate.add(const Duration(days: 1));
      }
    }
    if (candidate.isBefore(now)) {
      candidate = candidate.add(step);
    }

    final startTz = tz.TZDateTime(tz.local, start.year, start.month, start.day);
    while (candidate.isBefore(startTz)) {
      candidate = candidate.add(step);
    }
    return candidate;
  }

  (int, int)? _parseTime(String time) {
    final parts = time.split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return (hour, minute);
  }

  NotificationDetails _details() => NotificationDetails(
        android: AndroidNotificationDetails(
          medalizeHighChannel.id,
          medalizeHighChannel.name,
          channelDescription: medalizeHighChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      );

  Future<void> _cancelReservedRange() async {
    List<PendingNotificationRequest> pending;
    try {
      pending = await _plugin.pendingNotificationRequests();
    } catch (_) {
      return;
    }
    for (final p in pending) {
      if (p.id >= _idRangeStart && p.id < _idRangeEnd) {
        await _plugin.cancel(p.id);
      }
    }
  }

  /// Deterministic (FNV-1a) hash so the same schedule/time always maps to the
  /// same notification id across app runs — Dart's built-in `String.hashCode`
  /// is not guaranteed stable across isolates/versions, which would leak
  /// duplicate reminders every time the app restarts.
  int _notificationId(String key) {
    var hash = 0x811C9DC5;
    for (final unit in key.codeUnits) {
      hash ^= unit;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return _idRangeStart + (hash % _idRangeSize);
  }
}
