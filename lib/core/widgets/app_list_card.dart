import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';

/// Shared shell for "leading icon/avatar + free-form content + trailing
/// action" list rows — the shape repeated (with small, unintentional drift
/// in square size and radius) across medications, prescriptions, records,
/// notifications, devices, conversations, dependents, and message threads.
///
/// Wraps [AppCard] for the press-scale/border/surface chrome. The leading
/// slot is either a tinted icon square (pass [icon]) or a fully custom
/// widget (pass [leading]) for e.g. `GradientAvatar`. [child] carries the
/// row's title/subtitle/badges — those vary too much per screen to
/// parameterize — and [trailing] is optional (an `IconButton`, a chevron, a
/// timestamp column, ...).
class AppListCard extends StatelessWidget {
  const AppListCard({
    super.key,
    this.icon,
    this.leading,
    required this.child,
    this.trailing,
    this.onTap,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : assert(
          (icon == null) != (leading == null),
          'pass exactly one of icon or leading',
        );

  /// Icon for the default tinted 44×44 square. Mutually exclusive with
  /// [leading].
  final IconData? icon;

  /// A fully custom leading widget (e.g. `GradientAvatar(size: 44)`),
  /// replacing the default icon square. Mutually exclusive with [icon].
  final Widget? leading;

  final Widget child;
  final Widget? trailing;
  final VoidCallback? onTap;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          leading ??
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: c.primarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(icon, color: c.primaryText, size: 22),
              ),
          const Gap(12),
          Expanded(child: child),
          ?trailing,
        ],
      ),
    );
  }
}
