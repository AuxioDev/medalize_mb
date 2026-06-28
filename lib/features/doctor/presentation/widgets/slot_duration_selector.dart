import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Appointment-slot lengths (minutes) offered to doctors. Shared by onboarding
/// and the doctor profile so the options stay in one place.
const kSlotDurations = [15, 20, 30, 45, 60];

/// Cancellation-window options (hours) offered in the doctor profile.
const kCancellationWindows = [1, 2, 6, 12, 24];

/// A wrap of selectable slot-duration chips.
class SlotDurationSelector extends StatelessWidget {
  const SlotDurationSelector({
    super.key,
    required this.selected,
    required this.onSelect,
    this.enabled = true,
  });

  final int selected;
  final ValueChanged<int> onSelect;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return _ChipWrap(
      values: kSlotDurations,
      selected: selected,
      enabled: enabled,
      onSelect: onSelect,
      labelFor: (d) => context.t.onboarding.minutes(min: d),
    );
  }
}

/// A wrap of selectable cancellation-window chips (in hours).
class CancellationWindowSelector extends StatelessWidget {
  const CancellationWindowSelector({
    super.key,
    required this.selected,
    required this.onSelect,
    this.enabled = true,
  });

  final int selected;
  final ValueChanged<int> onSelect;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return _ChipWrap(
      values: kCancellationWindows,
      selected: selected,
      enabled: enabled,
      onSelect: onSelect,
      labelFor: (h) => context.t.profile.hoursValue(h: h),
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({
    required this.values,
    required this.selected,
    required this.enabled,
    required this.onSelect,
    required this.labelFor,
  });

  final List<int> values;
  final int selected;
  final bool enabled;
  final ValueChanged<int> onSelect;
  final String Function(int) labelFor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final v in values)
          _ChoiceChip(
            label: labelFor(v),
            selected: selected == v,
            onTap: enabled ? () => onSelect(v) : null,
          ),
      ],
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;

  /// Null disables the chip (read-only).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final disabled = onTap == null;
    return GestureDetector(
      onTap: disabled
          ? null
          : () {
              HapticFeedback.selectionClick();
              onTap!();
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : c.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: selected ? AppColors.primary : c.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Opacity(
          opacity: disabled && !selected ? 0.55 : 1,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : c.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
