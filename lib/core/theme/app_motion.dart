import 'package:flutter/animation.dart';

/// Motion duration tokens. Kept short and refined for a healthcare app.
abstract final class AppDuration {
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration base = Duration(milliseconds: 280);
  static const Duration slow = Duration(milliseconds: 400);

  /// Per-item delay applied when staggering a list/grid entrance.
  static const Duration stagger = Duration(milliseconds: 55);

  /// Maximum number of items to stagger before the delay is capped, so long
  /// lists don't animate in for an uncomfortably long time.
  static const int maxStaggerItems = 8;
}

/// Easing tokens.
abstract final class AppCurve {
  /// Default curve for content entering the screen.
  static const Curve enter = Curves.easeOutCubic;

  /// Slightly more pronounced curve for emphasized transitions.
  static const Curve emphasized = Curves.easeOutQuart;

  /// Curve for press / tactile feedback.
  static const Curve press = Curves.easeInOut;
}
