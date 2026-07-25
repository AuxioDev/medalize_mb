import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';

/// Icon + message inside a color-tinted, color-bordered container — the
/// app's "notice banner" idiom (inline form errors, informational notes,
/// urgency flags). [color] drives the icon and the tint; [child] carries the
/// message so callers can pass a single [Text] or a title+subtitle [Column].
///
/// The three geometry knobs default to the shape used by routine, single-line
/// notices (auth-form errors, the legal-screen draft notice, the appointment
/// status banner, the "booking for someone else" note). Widen them only for
/// a banner that must outrank a normal notice — e.g. a medical urgency flag
/// wants a bigger icon, a larger radius, and (for its worst case) a thicker
/// border.
class TintedNoticeBanner extends StatelessWidget {
  const TintedNoticeBanner({
    super.key,
    required this.color,
    required this.icon,
    required this.child,
    this.iconSize = 18,
    this.radius = AppRadius.md,
    this.borderWidth = 1,
  });

  final Color color;
  final IconData icon;
  final Widget child;
  final double iconSize;
  final double radius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: color.withValues(alpha: 0.35), width: borderWidth),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: iconSize),
          const Gap(10),
          Expanded(child: child),
        ],
      ),
    );
  }
}
