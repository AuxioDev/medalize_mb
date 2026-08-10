import 'package:flutter/material.dart';

import 'package:medalize_mb/core/constants/app_spacing.dart';

/// AppBar title with a leading section icon, used in place of a bare [Text]
/// so each screen's AppBar reads its context at a glance.
class AppBarTitle extends StatelessWidget {
  const AppBarTitle(this.text, {required this.icon, super.key});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: AppSpacing.sm),
        Flexible(child: Text(text, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
