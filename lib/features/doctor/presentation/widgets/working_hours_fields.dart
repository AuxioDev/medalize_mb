import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// One weekday's working-hours state: whether the doctor works that day and,
/// if so, the time range.
class WorkingHoursDay {
  WorkingHoursDay({
    required this.isActive,
    required this.startTime,
    required this.endTime,
  });

  bool isActive;
  TimeOfDay startTime;
  TimeOfDay endTime;

  WorkingHoursDay copy() => WorkingHoursDay(
        isActive: isActive,
        startTime: startTime,
        endTime: endTime,
      );

  /// Mon(0)–Sun(6), each defaulting to 09:00–17:00. When [weekdaysActive] is
  /// true, Monday–Friday start enabled (a sane default for a brand-new
  /// workplace) while Saturday/Sunday stay off.
  static List<WorkingHoursDay> defaultWeek({bool weekdaysActive = false}) {
    return List.generate(
      7,
      (i) => WorkingHoursDay(
        isActive: weekdaysActive && i < 5,
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
      ),
    );
  }

  /// Parses the API's per-day shape (`weekday`, `start_time`/`end_time` as
  /// `"HH:MM:SS"` strings, `is_active`) into a full Mon–Sun list, filling any
  /// weekday missing from [data] with an inactive 09:00–17:00 default.
  static List<WorkingHoursDay> fromApiList(List<dynamic>? data) {
    final days = defaultWeek();
    if (data == null) return days;
    for (final entry in data) {
      final d = entry as Map<String, dynamic>;
      final weekday = d['weekday'] as int?;
      if (weekday == null || weekday < 0 || weekday > 6) continue;
      final startParts = (d['start_time'] as String).split(':');
      final endParts = (d['end_time'] as String).split(':');
      days[weekday] = WorkingHoursDay(
        isActive: d['is_active'] as bool? ?? false,
        startTime: TimeOfDay(
          hour: int.parse(startParts[0]),
          minute: int.parse(startParts[1]),
        ),
        endTime: TimeOfDay(
          hour: int.parse(endParts[0]),
          minute: int.parse(endParts[1]),
        ),
      );
    }
    return days;
  }

  /// Builds the full 7-entry PUT/POST payload the backend expects.
  static List<Map<String, dynamic>> toPayload(List<WorkingHoursDay> days) {
    return List.generate(7, (i) {
      final d = days[i];
      return {
        'weekday': i,
        'is_active': d.isActive,
        'start_time': _format(d.startTime),
        'end_time': _format(d.endTime),
      };
    });
  }

  static String _format(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:00';

  /// True if any active day has an end time at or before its start time.
  static bool hasInvalidRange(List<WorkingHoursDay> days) {
    return days.any((d) {
      if (!d.isActive) return false;
      final start = d.startTime.hour * 60 + d.startTime.minute;
      final end = d.endTime.hour * 60 + d.endTime.minute;
      return end <= start;
    });
  }
}

/// Localized weekday name for index 0 (Monday) … 6 (Sunday).
String workingHoursDayName(BuildContext context, int i) {
  final d = context.t.workingHours.days;
  return [
    d.monday,
    d.tuesday,
    d.wednesday,
    d.thursday,
    d.friday,
    d.saturday,
    d.sunday,
  ][i];
}

/// Seven day rows — day name, an active switch and (when active) start/end
/// time pickers. Shared by the working-hours section embedded in
/// [AddEditWorkplaceScreen] and the standalone [WorkingHoursEditorScreen].
class WorkingHoursFields extends StatelessWidget {
  const WorkingHoursFields({
    super.key,
    required this.days,
    required this.onChanged,
    this.animateEntrance = true,
  });

  final List<WorkingHoursDay> days;
  final ValueChanged<List<WorkingHoursDay>> onChanged;
  final bool animateEntrance;

  Future<void> _pickTime(BuildContext context, int index, bool isStart) async {
    final day = days[index];
    final current = isStart ? day.startTime : day.endTime;
    final picked = await showTimePicker(context: context, initialTime: current);
    if (picked == null) return;
    final updated = List<WorkingHoursDay>.of(days);
    final newDay = day.copy();
    if (isStart) {
      newDay.startTime = picked;
    } else {
      newDay.endTime = picked;
    }
    updated[index] = newDay;
    onChanged(updated);
  }

  void _toggle(int index, bool value) {
    final updated = List<WorkingHoursDay>.of(days);
    updated[index] = days[index].copy()..isActive = value;
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(7, (i) {
        final day = days[i];
        final row = AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  workingHoursDayName(context, i),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Switch(
                value: day.isActive,
                onChanged: (v) => _toggle(i, v),
              ),
              if (day.isActive) ...[
                const SizedBox(width: 8),
                // Flexible + FittedBox so a long 12-hour time ("11:30 PM") at
                // a large text scale on a narrow phone shrinks the two time
                // buttons instead of overflowing the row.
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _TimeButton(
                          label: day.startTime.format(context),
                          onTap: () => _pickTime(context, i, true),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            '—',
                            style: TextStyle(color: context.colors.textSecondary),
                          ),
                        ),
                        _TimeButton(
                          label: day.endTime.format(context),
                          onTap: () => _pickTime(context, i, false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
        return animateEntrance ? AnimatedEntrance(index: i, child: row) : row;
      }),
    );
  }
}

class _TimeButton extends StatelessWidget {
  const _TimeButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      child: Text(label),
    );
  }
}
