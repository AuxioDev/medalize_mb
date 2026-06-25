import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

/// App-bar notification icon with an animated unread-count badge.
class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: onTap,
        ),
        AnimatedSwitcher(
          duration: AppDuration.fast,
          transitionBuilder: (child, anim) => ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: AppCurve.emphasized),
            ),
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: count > 0
              ? Positioned(
                  key: ValueKey(count),
                  right: 8,
                  top: 8,
                  child: IgnorePointer(
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
                  ),
                )
              : const SizedBox.shrink(key: ValueKey(0)),
        ),
      ],
    );
  }
}
