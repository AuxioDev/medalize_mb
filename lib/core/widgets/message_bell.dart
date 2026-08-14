import 'package:flutter/material.dart';
import 'package:medalize_mb/core/widgets/badged_icon_button.dart';

/// App-bar messaging icon with an animated unread-count badge. See
/// [BadgedIconButton] for the shared rendering — [NotificationBell]
/// (`lib/core/widgets/notification_bell.dart`) is the same chrome with a
/// different icon; unread messages and unread notifications stay separate
/// providers/counts at each call site.
class MessageBell extends StatelessWidget {
  const MessageBell({super.key, required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BadgedIconButton(
      icon: Icons.chat_bubble_outline_rounded,
      count: count,
      onTap: onTap,
    );
  }
}
