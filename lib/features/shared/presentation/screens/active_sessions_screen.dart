import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_badge.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/auth/data/models/user_device_model.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

final _devicesProvider =
    FutureProvider.autoDispose<List<UserDeviceModel>>((ref) {
  return ref.read(authRepositoryProvider).getDevices();
});

class ActiveSessionsScreen extends ConsumerWidget {
  const ActiveSessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(_devicesProvider);
    final t = context.t;

    return Scaffold(
      appBar: AppBar(title: Text(t.security.activeSessions)),
      body: ResponsiveBody(
        child: async.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
              ],
            ),
          ),
          error: (_, _) => RefreshableView(
            onRefresh: () async => ref.invalidate(_devicesProvider),
            child: EmptyState(
              icon: Icons.cloud_off_outlined,
              title: t.common.somethingWrong,
              subtitle: t.security.loadFailed,
              actionLabel: t.common.retry,
              onAction: () => ref.invalidate(_devicesProvider),
            ),
          ),
          data: (devices) {
            if (devices.isEmpty) {
              return RefreshableView(
                onRefresh: () async => ref.invalidate(_devicesProvider),
                child: EmptyState(
                  icon: Icons.devices_other_outlined,
                  title: t.security.noDevices,
                  subtitle: t.security.activeSessionsSubtitle,
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(_devicesProvider),
              color: AppColors.primary,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.md, AppSpacing.md, 96),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: devices.length + 1,
                itemBuilder: (context, i) {
                  if (i == devices.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: OutlinedButton.icon(
                        onPressed: () => _confirmSignOutAll(context, ref),
                        icon: const Icon(Icons.logout, color: AppColors.error),
                        label: Text(
                          t.security.signOutAllDevices,
                          style: const TextStyle(color: AppColors.error),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.error),
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                    );
                  }
                  return _DeviceCard(
                    device: devices[i],
                    onRevoked: () => ref.invalidate(_devicesProvider),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmSignOutAll(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.security.signOutAllConfirmTitle),
        content: Text(t.security.signOutAllConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(t.security.signOutAllDevices),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      await ref.read(authRepositoryProvider).revokeAllDevices();
      // The confirmation copy promises this signs the user out everywhere,
      // including this device — so force the local session closed too,
      // regardless of whether the backend chose to exempt the current jti.
      await ref.read(authProvider.notifier).forceLogout();
    } on ApiException catch (e) {
      if (context.mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    } catch (_) {
      if (context.mounted) {
        AppSnackBar.show(context, t.security.signOutAllFailed,
            type: SnackBarType.error);
      }
    }
  }
}

class _DeviceCard extends ConsumerWidget {
  const _DeviceCard({required this.device, required this.onRevoked});

  final UserDeviceModel device;
  final VoidCallback onRevoked;

  IconData get _icon =>
      device.platform == 'ios' ? Icons.phone_iphone_outlined : Icons.phone_android_outlined;

  Future<void> _confirmRevoke(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.security.revokeConfirmTitle),
        content: Text(
          device.isCurrent
              ? t.security.revokeCurrentConfirmMessage
              : t.security.revokeConfirmMessage(name: device.deviceName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(t.security.revoke),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      await ref.read(authRepositoryProvider).revokeDevice(device.id);
      if (device.isCurrent) {
        // Revoking our own device blacklists this refresh token — reflect
        // that locally right away instead of waiting for the next 401.
        await ref.read(authProvider.notifier).forceLogout();
        return;
      }
      onRevoked();
    } on ApiException catch (e) {
      if (context.mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    } catch (_) {
      if (context.mounted) {
        AppSnackBar.show(context, t.security.revokeFailed,
            type: SnackBarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final t = context.t;
    final lastSeen = device.lastSeenAt;

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: c.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(_icon, color: c.primaryText, size: 22),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        device.deviceName.isNotEmpty
                            ? device.deviceName
                            : device.platform,
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (device.isCurrent) ...[
                      const Gap(8),
                      AppBadge(label: t.security.thisDevice),
                    ],
                  ],
                ),
                if (lastSeen != null) ...[
                  const Gap(2),
                  Text(
                    t.security.lastActive(
                        date: DateFormat('d MMM, HH:mm').format(lastSeen)),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.error),
            tooltip: t.security.revoke,
            onPressed: () => _confirmRevoke(context, ref),
          ),
        ],
      ),
    );
  }
}
