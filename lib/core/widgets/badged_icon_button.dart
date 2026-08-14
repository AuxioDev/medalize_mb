import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

/// App-bar icon button with an animated unread-count badge — shared
/// rendering behind [NotificationBell] and [MessageBell]
/// (`lib/core/widgets/{notification,message}_bell.dart`), which differ only
/// in which icon they show. Unread notifications and unread messages stay
/// separate providers/counts at each call site — only the visual chrome
/// (badge, animation) was actually duplicated, not the data.
///
/// `Positioned` deliberately wraps the whole `AnimatedSwitcher`, not the
/// other way around — see `test/bell_badge_test.dart` for the
/// ParentDataWidget crash that the opposite nesting caused mid-animation.
class BadgedIconButton extends StatelessWidget {
  const BadgedIconButton({
    super.key,
    required this.icon,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(icon: Icon(icon), onPressed: onTap),
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
