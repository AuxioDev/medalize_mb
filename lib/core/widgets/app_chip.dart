import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

/// Shared selectable chip with an overflow-safe label (single line +
/// ellipsis) and no externally imposed height — the chip sizes itself to its
/// content, so long translations and larger text scales never clip.
///
/// Two visual variants mirror the two chip styles that used to live as
/// independent copies across screens:
/// - [AppChip.filter] — a Material [FilterChip] (doctor search filters).
/// - [AppChip.choice] — the animated pill used by the slot-duration /
///   cancellation-window selectors, with haptics and a disabled state.
class AppChip extends StatelessWidget {
  /// FilterChip-style chip: [onSelected] receives the new selected state.
  /// [leading] renders before the label (e.g. a star icon).
  const AppChip.filter({
    super.key,
    required this.label,
    required this.selected,
    required ValueChanged<bool> this.onSelected,
    this.leading,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 4),
  })  : onTap = null,
        _variant = _AppChipVariant.filter;

  /// Pill-style choice chip: tapping fires [onTap] (with a selection-click
  /// haptic). A null [onTap] disables the chip (read-only).
  const AppChip.choice({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  })  : onSelected = null,
        leading = null,
        labelPadding = null,
        _variant = _AppChipVariant.choice;

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final VoidCallback? onTap;
  final Widget? leading;
  final EdgeInsetsGeometry? labelPadding;
  final _AppChipVariant _variant;

  @override
  Widget build(BuildContext context) {
    return switch (_variant) {
      _AppChipVariant.filter => _buildFilter(context),
      _AppChipVariant.choice => _buildChoice(context),
    };
  }

  Widget _buildFilter(BuildContext context) {
    final c = context.colors;
    final text = Text(label, maxLines: 1, overflow: TextOverflow.ellipsis);
    return FilterChip(
      label: leading == null
          ? text
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                leading!,
                const SizedBox(width: 3),
                Flexible(child: text),
              ],
            ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: c.primarySurface,
      checkmarkColor: c.primaryText,
      labelStyle: TextStyle(
        color: selected ? c.primaryText : c.textSecondary,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        fontSize: 13,
      ),
      side: BorderSide(color: selected ? AppColors.primary : c.border),
      padding: labelPadding,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildChoice(BuildContext context) {
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

enum _AppChipVariant { filter, choice }
