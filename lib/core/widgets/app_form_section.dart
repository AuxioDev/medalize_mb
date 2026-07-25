import 'package:flutter/material.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

/// Bordered, rounded group of rows (settings tiles, form fields) with an
/// optional uppercase small-caps caption above it. Shared by the
/// settings/security/notification-settings screens — previously one named
/// `_SettingsGroup` plus two unnamed verbatim copies of its container.
///
/// Wraps the group in a transparent [Material] so descendant `ListTile`/
/// `SwitchListTile` ink splashes paint inside this container's bounds and get
/// clipped to its rounded corners, instead of bleeding out to whatever
/// `Material` ancestor sits above it (e.g. the `Scaffold`'s own).
class AppFormSection extends StatelessWidget {
  const AppFormSection({
    super.key,
    this.title,
    required this.children,
    this.tintColor,
  });

  final String? title;
  final List<Widget> children;

  /// Tints the container and its caption/border with this color instead of
  /// the default neutral `surfaceAlt`/border — for a "danger zone" group
  /// (e.g. `AppColors.error` around account deactivation).
  final Color? tintColor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fill = tintColor?.withValues(alpha: 0.04) ?? c.surfaceAlt;
    final border = tintColor?.withValues(alpha: 0.35) ?? c.border;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title!.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: tintColor ?? c.textSecondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
            ),
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}

/// Hairline divider between rows inside an [AppFormSection], indented to
/// align with a leading icon's typical width.
class AppFormSectionDivider extends StatelessWidget {
  const AppFormSectionDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      Divider(height: 1, indent: 56, color: context.colors.border);
}
