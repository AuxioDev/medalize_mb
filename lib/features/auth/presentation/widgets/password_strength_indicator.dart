import 'package:flutter/material.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

enum PasswordStrength { empty, weak, medium, strong }

PasswordStrength evaluatePasswordStrength(String password) {
  if (password.isEmpty) return PasswordStrength.empty;
  final hasLetter = password.contains(RegExp(r'[A-Za-z]'));
  final hasDigit = password.contains(RegExp(r'\d'));
  final isLongEnough = password.length >= 8;

  if (!isLongEnough) return PasswordStrength.weak;
  if (hasLetter && hasDigit && password.length >= 12) {
    return PasswordStrength.strong;
  }
  if (hasLetter && hasDigit) return PasswordStrength.medium;
  return PasswordStrength.weak;
}

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final strength = evaluatePasswordStrength(password);
    if (strength == PasswordStrength.empty) return const SizedBox.shrink();

    final (color, label, value) = switch (strength) {
      PasswordStrength.weak => (AppColors.strengthWeak, 'Weak', 0.33),
      PasswordStrength.medium => (AppColors.strengthMedium, 'Medium', 0.66),
      PasswordStrength.strong => (AppColors.strengthStrong, 'Strong', 1.0),
      PasswordStrength.empty => (AppColors.border, '', 0.0),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value),
            duration: const Duration(milliseconds: 300),
            builder: (_, v, _) => LinearProgressIndicator(
              value: v,
              minHeight: 4,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Strength: $label',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}
