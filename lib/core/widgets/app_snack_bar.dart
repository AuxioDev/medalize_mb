import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

enum SnackBarType { success, error, info }

abstract final class AppSnackBar {
  static void show(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.info,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    showOn(
      ScaffoldMessenger.of(context),
      message,
      type: type,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// Same as [show], but takes the [ScaffoldMessengerState] directly —
  /// for call sites that navigate away (and so lose their [BuildContext])
  /// in the same breath as showing the snack bar, e.g. a success message
  /// right before returning to a previous screen.
  static void showOn(
    ScaffoldMessengerState messenger,
    String message, {
    SnackBarType type = SnackBarType.info,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final (icon, color) = switch (type) {
      SnackBarType.success => (Icons.check_circle_outline_rounded, AppColors.success),
      SnackBarType.error => (Icons.error_outline_rounded, AppColors.error),
      SnackBarType.info => (Icons.info_outline_rounded, AppColors.primary),
    };

    messenger
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
          action: actionLabel != null && onAction != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: Colors.white,
                  onPressed: onAction,
                )
              : null,
        ),
      );
  }
}
