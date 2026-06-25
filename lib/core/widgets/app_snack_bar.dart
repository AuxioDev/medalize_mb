import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

enum SnackBarType { success, error, info }

abstract final class AppSnackBar {
  static void show(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.info,
  }) {
    final (icon, color) = switch (type) {
      SnackBarType.success => (Icons.check_circle_outline_rounded, AppColors.success),
      SnackBarType.error => (Icons.error_outline_rounded, AppColors.error),
      SnackBarType.info => (Icons.info_outline_rounded, AppColors.primary),
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(message, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          backgroundColor: color,
        ),
      );
  }
}
