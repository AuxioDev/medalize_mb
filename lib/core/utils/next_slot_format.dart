import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// "Available today" / "tomorrow" / "on 5 Aug" label for a doctor's next
/// free slot date. Shared by the doctor-search card and the home screen's
/// quick-book card — both show the same next-slot hint next to a doctor.
String formatNextSlotDate(BuildContext context, DateTime date) {
  final today = DateTime.now();
  final tomorrow = today.add(const Duration(days: 1));
  if (date.year == today.year && date.month == today.month && date.day == today.day) {
    return context.t.doctorSearch.availableToday;
  }
  if (date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day) {
    return context.t.doctorSearch.availableTomorrow;
  }
  return context.t.doctorSearch.availableOn(date: DateFormat('d MMM').format(date));
}
