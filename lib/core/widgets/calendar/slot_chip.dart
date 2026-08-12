import 'package:flutter/material.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

/// A tappable time-slot pill with a press-scale/fill swap. Shared by
/// [BookingCalendarScreen] and [RescheduleCalendarScreen] — previously two
/// byte-identical private `_SlotChip` classes.
class SlotChip extends StatefulWidget {
  const SlotChip({
    super.key,
    required this.time,
    required this.onTap,
    this.selected = false,
  });

  final String time;
  final VoidCallback onTap;

  /// Whether this chip is the currently selected slot (e.g. the
  /// auto-preselected earliest slot, or one the patient explicitly tapped).
  /// Renders with the same filled treatment as the transient press state,
  /// but persists after release.
  final bool selected;

  @override
  State<SlotChip> createState() => _SlotChipState();
}

class _SlotChipState extends State<SlotChip> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final filled = _pressed || widget.selected;
    final scale = _pressed ? 0.95 : 1.0;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(scale, scale, 1),
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : c.primarySurface,
          borderRadius: BorderRadius.circular(AppRadius.sm + 2),
          border: Border.all(
            color: AppColors.primary,
            width: filled ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(
            widget.time,
            style: TextStyle(
              color: filled ? Colors.white : c.primaryText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
