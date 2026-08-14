import 'package:flutter/material.dart';
import 'package:medalize_mb/core/widgets/badged_icon_button.dart';

/// App-bar notification icon with an animated unread-count badge.
class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BadgedIconButton(
      icon: Icons.notifications_outlined,
      count: count,
      onTap: onTap,
    );
  }
}
