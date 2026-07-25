import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:table_calendar/table_calendar.dart';

/// [TableCalendar] themed to match the app (primary-filled selection, muted
/// weekend/outside-month text). Shared by [BookingCalendarScreen] and
/// [RescheduleCalendarScreen] — previously two byte-identical private
/// `_StyledCalendar` classes.
///
/// Weekends are bookable in this app, so [CalendarStyle.weekendTextStyle] is
/// kept visually neutral (red would read as "unavailable").
class StyledSlotCalendar extends StatelessWidget {
  const StyledSlotCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
  });

  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 60)),
      focusedDay: focusedDay,
      selectedDayPredicate: (d) => isSameDay(selectedDay, d),
      onDaySelected: onDaySelected,
      calendarStyle: CalendarStyle(
        selectedDecoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.25),
          shape: BoxShape.circle,
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        todayTextStyle: TextStyle(
          color: c.primaryText,
          fontWeight: FontWeight.w600,
        ),
        weekendTextStyle: TextStyle(color: c.textPrimary),
        outsideTextStyle: TextStyle(
          color: c.textSecondary.withValues(alpha: 0.4),
        ),
        defaultTextStyle: TextStyle(color: c.textPrimary),
        rowDecoration: BoxDecoration(color: c.surface),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: Theme.of(context).textTheme.titleSmall!,
        leftChevronIcon: Icon(Icons.chevron_left, color: c.primaryText),
        rightChevronIcon: Icon(Icons.chevron_right, color: c.primaryText),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: c.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        weekendStyle: TextStyle(
          color: c.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
