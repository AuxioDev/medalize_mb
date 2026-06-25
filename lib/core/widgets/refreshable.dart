import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

/// Wraps non-scrolling content (e.g. an [EmptyState] or error view) so it still
/// supports pull-to-refresh. Makes the child fill the viewport and scrollable,
/// so the gesture is available even when there's nothing to scroll.
class RefreshableView extends StatelessWidget {
  const RefreshableView({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        ),
      ),
    );
  }
}
