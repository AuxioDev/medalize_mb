import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final reducedMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    Widget iconContainer = Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: c.primarySurface,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 38, color: c.primaryText),
    );

    if (!reducedMotion) {
      iconContainer = iconContainer
          .animate(onPlay: (ctrl) => ctrl.repeat(reverse: true))
          .moveY(begin: 0, end: -6, duration: 1800.ms, curve: Curves.easeInOut);
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconContainer,
            const Gap(16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(6),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const Gap(20),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
