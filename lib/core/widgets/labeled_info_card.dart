import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

/// Bordered card with a primary accent bar and an optional small-caps caption,
/// used for structured detail sections (e.g. a single field or a labeled
/// group of fields) on record-like screens — appointment details, booking
/// summaries, prescriptions.
///
/// Pass [label]/[icon] together for the caption row; omit both when the
/// surrounding screen already establishes context (e.g. an AppBar title) and
/// a repeated caption would be redundant — the accent bar alone still marks
/// the block as a structured section.
class LabeledInfoCard extends StatelessWidget {
  const LabeledInfoCard({
    super.key,
    required this.child,
    this.label,
    this.icon,
  }) : assert(
          (label == null) == (icon == null),
          'label and icon must be provided together, or both omitted',
        );

  final String? label;
  final IconData? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: c.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
        border: Border.all(color: c.border, width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Full-height accent bar. IntrinsicHeight gives the Row a bounded
            // height so `stretch` can size this without an infinite constraint.
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.md + 2),
                  bottomLeft: Radius.circular(AppRadius.md + 2),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (label != null) ...[
                      Row(
                        children: [
                          Icon(icon, size: 14, color: c.primaryText),
                          const Gap(5),
                          Text(
                            label!.toUpperCase(),
                            style: TextStyle(
                              color: c.primaryText,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                    ],
                    child,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
