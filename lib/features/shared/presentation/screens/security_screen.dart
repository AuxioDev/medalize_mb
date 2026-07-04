import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/auth/providers/biometric_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class SecurityScreen extends ConsumerStatefulWidget {
  const SecurityScreen({super.key});

  @override
  ConsumerState<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends ConsumerState<SecurityScreen> {
  bool _toggling = false;

  Future<void> _onBiometricChanged(bool value) async {
    setState(() => _toggling = true);
    final applied = await ref.read(biometricEnabledProvider.notifier).setEnabled(value);
    if (mounted) {
      setState(() => _toggling = false);
      if (!applied) {
        AppSnackBar.show(
          context,
          value ? context.t.security.biometricEnableFailed : context.t.security.biometricUnavailable,
          type: SnackBarType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final enabled = ref.watch(biometricEnabledProvider);
    final supportedAsync = ref.watch(biometricSupportedProvider);
    final supported = supportedAsync.value ?? false;

    return Scaffold(
      appBar: AppBar(title: Text(t.security.title)),
      body: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colors.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: context.colors.border),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.fingerprint),
                    title: Text(t.security.biometricLogin),
                    subtitle: Text(
                      supportedAsync.isLoading
                          ? ''
                          : (supported
                              ? t.security.biometricLoginSubtitle
                              : t.security.biometricUnavailable),
                    ),
                    value: enabled,
                    onChanged: (supported && !_toggling) ? _onBiometricChanged : null,
                    activeThumbColor: AppColors.primary,
                  ),
                  Divider(height: 1, indent: 56, color: context.colors.border),
                  ListTile(
                    leading: const Icon(Icons.devices_outlined),
                    title: Text(t.security.activeSessions),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/shared/active-sessions'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
