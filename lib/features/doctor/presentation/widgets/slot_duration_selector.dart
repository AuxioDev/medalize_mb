import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Selectable appointment-slot lengths (minutes) offered to doctors. Shared by
/// onboarding and the doctor profile so the options stay in one place.
const kSlotDurations = [15, 20, 30, 45, 60];

/// A wrap of selectable slot-duration chips.
///
/// When [enabled] is false the chips are shown read-only (used by the profile
/// screen outside edit mode).
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
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final d in kSlotDurations)
          SlotDurationChip(
            minutes: d,
            selected: selected == d,
            onTap: enabled ? () => onSelect(d) : null,
          ),
      ],
    );
  }
}

class SlotDurationChip extends StatelessWidget {
  const SlotDurationChip({
    super.key,
    required this.minutes,
    required this.selected,
    required this.onTap,
  });

  final int minutes;
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
            context.t.onboarding.minutes(min: minutes),
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
