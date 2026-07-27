import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

/// App-bar messaging icon with an animated unread-count badge. Mirrors
/// [NotificationBell] (`lib/core/widgets/notification_bell.dart`) but stays a
/// separate widget/provider pair, since unread messages and unread
/// notifications are unrelated counts.
class MessageBell extends StatelessWidget {
  const MessageBell({super.key, required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline_rounded),
          onPressed: onTap,
        ),
        Positioned(
          right: 8,
          top: 8,
          child: AnimatedSwitcher(
            duration: AppDuration.fast,
            transitionBuilder: (child, anim) => ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                CurvedAnimation(parent: anim, curve: AppCurve.emphasized),
              ),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: count > 0
                ? IgnorePointer(
                    key: ValueKey(count),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      constraints:
                          const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        count > 99 ? '99+' : '$count',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey(0)),
          ),
        ),
      ],
    );
  }
}
