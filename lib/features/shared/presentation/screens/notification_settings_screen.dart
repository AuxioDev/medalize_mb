import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_form_section.dart';
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

  Future<void> _update({
    bool? pushEnabled,
    bool? emailEnabled,
    bool? carePushEnabled,
    bool? messagesPushEnabled,
    bool? accountPushEnabled,
    bool? quietHoursEnabled,
    String? quietHoursStart,
    String? quietHoursEnd,
  }) async {
    setState(() => _updating = true);
    try {
      await ref
          .read(notificationRepositoryProvider)
          .updatePreferences(
            pushEnabled: pushEnabled,
            emailEnabled: emailEnabled,
            carePushEnabled: carePushEnabled,
            messagesPushEnabled: messagesPushEnabled,
            accountPushEnabled: accountPushEnabled,
            quietHoursEnabled: quietHoursEnabled,
            quietHoursStart: quietHoursStart,
            quietHoursEnd: quietHoursEnd,
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

  static TimeOfDay _parseTime(String hhmmss) {
    final parts = hhmmss.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static String _formatForApi(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:00';

  Future<void> _pickQuietHoursTime(String current, {required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _parseTime(current),
    );
    if (picked == null) return;
    final formatted = _formatForApi(picked);
    if (isStart) {
      await _update(quietHoursStart: formatted);
    } else {
      await _update(quietHoursEnd: formatted);
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
              AppFormSection(
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
                  const AppFormSectionDivider(),
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
              const SizedBox(height: 20),
              AppFormSection(
                title: t.notifications.categoriesTitle,
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.event_available_outlined),
                    title: Text(t.notifications.careCategory),
                    subtitle: Text(t.notifications.careCategorySubtitle),
                    value: prefs.carePushEnabled,
                    onChanged: _updating || !prefs.pushEnabled
                        ? null
                        : (v) => _update(carePushEnabled: v),
                    activeThumbColor: AppColors.primary,
                  ),
                  const AppFormSectionDivider(),
                  SwitchListTile(
                    secondary: const Icon(Icons.chat_bubble_outline_rounded),
                    title: Text(t.notifications.messagesCategory),
                    subtitle: Text(t.notifications.messagesCategorySubtitle),
                    value: prefs.messagesPushEnabled,
                    onChanged: _updating || !prefs.pushEnabled
                        ? null
                        : (v) => _update(messagesPushEnabled: v),
                    activeThumbColor: AppColors.primary,
                  ),
                  const AppFormSectionDivider(),
                  SwitchListTile(
                    secondary: const Icon(Icons.account_balance_wallet_outlined),
                    title: Text(t.notifications.accountCategory),
                    subtitle: Text(t.notifications.accountCategorySubtitle),
                    value: prefs.accountPushEnabled,
                    onChanged: _updating || !prefs.pushEnabled
                        ? null
                        : (v) => _update(accountPushEnabled: v),
                    activeThumbColor: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppFormSection(
                title: t.notifications.quietHoursTitle,
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.bedtime_outlined),
                    title: Text(t.notifications.quietHoursEnabled),
                    subtitle: Text(t.notifications.quietHoursSubtitle),
                    value: prefs.quietHoursEnabled,
                    onChanged: _updating || !prefs.pushEnabled
                        ? null
                        : (v) => _update(quietHoursEnabled: v),
                    activeThumbColor: AppColors.primary,
                  ),
                  const AppFormSectionDivider(),
                  ListTile(
                    leading: const Icon(Icons.schedule_outlined),
                    title: Text(t.notifications.quietHoursStart),
                    trailing: Text(
                      _parseTime(prefs.quietHoursStart).format(context),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    enabled: !_updating && prefs.quietHoursEnabled,
                    onTap: () => _pickQuietHoursTime(
                      prefs.quietHoursStart,
                      isStart: true,
                    ),
                  ),
                  const AppFormSectionDivider(),
                  ListTile(
                    leading: const Icon(Icons.schedule_outlined),
                    title: Text(t.notifications.quietHoursEnd),
                    trailing: Text(
                      _parseTime(prefs.quietHoursEnd).format(context),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    enabled: !_updating && prefs.quietHoursEnabled,
                    onTap: () => _pickQuietHoursTime(
                      prefs.quietHoursEnd,
                      isStart: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
