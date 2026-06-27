import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryDark, AppColors.primary],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Logo()
                  .animate()
                  .scale(
                    begin: const Offset(0.65, 0.65),
                    end: const Offset(1.0, 1.0),
                    duration: 700.ms,
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(duration: 350.ms),
              const SizedBox(height: 22),
              const Text(
                'Medalize',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              )
                  .animate()
                  .fadeIn(delay: 280.ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0, delay: 280.ms, duration: 400.ms, curve: Curves.easeOut),
              const SizedBox(height: 6),
              Text(
                context.t.splash.tagline,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              )
                  .animate()
                  .fadeIn(delay: 380.ms, duration: 400.ms),
              const SizedBox(height: 56),
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white54),
              ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
      ),
      child: const Icon(
        Icons.medical_services_rounded,
        size: 44,
        color: Colors.white,
      ),
    );
  }
}
