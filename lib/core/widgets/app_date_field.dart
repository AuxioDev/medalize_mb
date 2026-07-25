import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';

/// A date picker trigger styled like a text field (label + value + calendar
/// icon), for forms that pick a date without typing one. Shared by the
/// medication, medical-record, and dependent forms — previously one named
/// `_DateField` plus two inline copies of the same `InkWell` +
/// `InputDecorator` construction.
class AppDateField extends StatelessWidget {
  const AppDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  /// Shows a clear (×) button instead of the calendar icon when non-null —
  /// for an optional date (e.g. a medication's end date).
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM y');
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: onClear != null
              ? IconButton(icon: const Icon(Icons.clear, size: 18), onPressed: onClear)
              : const Icon(Icons.calendar_today_outlined, size: 18),
        ),
        child: Text(value != null ? fmt.format(value!) : '—'),
      ),
    );
  }
}
