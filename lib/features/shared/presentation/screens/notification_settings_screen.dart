import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/notifications/data/repository/notification_repository.dart';
import 'package:medalize_mb/features/notifications/providers/notification_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends ConsumerState<NotificationSettingsScreen> {
  bool _updating = false;

  Future<void> _update({bool? pushEnabled, bool? emailEnabled}) async {
    setState(() => _updating = true);
    try {
      await ref
          .read(notificationRepositoryProvider)
          .updatePreferences(
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
          );
      ref.invalidate(notificationPreferencesProvider);
    } on ApiException catch (_) {
      if (mounted) {
        AppSnackBar.show(
          context,
          context.t.common.somethingWrong,
          type: SnackBarType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _updating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final async = ref.watch(notificationPreferencesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.notifications.settingsTitle)),
      body: ResponsiveBody(
        child: async.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
              ],
            ),
          ),
          error: (_, _) => RefreshableView(
            onRefresh: () async =>
                ref.invalidate(notificationPreferencesProvider),
            child: EmptyState(
              icon: Icons.cloud_off_outlined,
              title: t.common.somethingWrong,
              subtitle: t.notifications.couldNotLoad,
              actionLabel: t.common.retry,
              onAction: () => ref.invalidate(notificationPreferencesProvider),
            ),
          ),
          data: (prefs) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              96,
            ),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.colors.surfaceAlt,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: context.colors.border),
                ),
                clipBehavior: Clip.antiAlias,
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SwitchListTile(
                        secondary: const Icon(
                          Icons.notifications_active_outlined,
                        ),
                        title: Text(t.notifications.pushEnabled),
                        subtitle: Text(t.notifications.pushEnabledSubtitle),
                        value: prefs.pushEnabled,
                        onChanged: _updating
                            ? null
                            : (v) => _update(pushEnabled: v),
                        activeThumbColor: AppColors.primary,
                      ),
                      Divider(
                        height: 1,
                        indent: 56,
                        color: context.colors.border,
                      ),
                      SwitchListTile(
                        secondary: const Icon(Icons.email_outlined),
                        title: Text(t.notifications.emailEnabled),
                        subtitle: Text(t.notifications.emailEnabledSubtitle),
                        value: prefs.emailEnabled,
                        onChanged: _updating
                            ? null
                            : (v) => _update(emailEnabled: v),
                        activeThumbColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
