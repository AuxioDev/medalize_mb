import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
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
    final applied = await ref
        .read(biometricEnabledProvider.notifier)
        .setEnabled(value);
    if (mounted) {
      setState(() => _toggling = false);
      if (!applied) {
        AppSnackBar.show(
          context,
          value
              ? context.t.security.biometricEnableFailed
              : context.t.security.biometricUnavailable,
          type: SnackBarType.error,
        );
      }
    }
  }

  Future<void> _showDeactivateDialog() async {
    final deactivated = await showDialog<bool>(
      context: context,
      builder: (_) => const _DeactivateAccountDialog(),
    );
    if (deactivated != true || !mounted) return;
    // Shown via the root messenger so it survives the redirect to the login
    // screen that forceLogout() triggers.
    AppSnackBar.show(
      context,
      context.t.security.deactivateSuccess,
      type: SnackBarType.success,
    );
    await ref.read(authProvider.notifier).forceLogout();
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
              // Material ancestor so the tiles' ink splashes paint above this
              // container's own background instead of being clipped under it.
              child: Material(
                color: Colors.transparent,
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
                      onChanged: (supported && !_toggling)
                          ? _onBiometricChanged
                          : null,
                      activeThumbColor: AppColors.primary,
                    ),
                    Divider(
                      height: 1,
                      indent: 56,
                      color: context.colors.border,
                    ),
                    ListTile(
                      leading: const Icon(Icons.devices_outlined),
                      title: Text(t.security.activeSessions),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/shared/active-sessions'),
                    ),
                    Divider(
                      height: 1,
                      indent: 56,
                      color: context.colors.border,
                    ),
                    ListTile(
                      leading: const Icon(Icons.alternate_email),
                      title: Text(t.security.changeEmail),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/shared/change-email'),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.sm,
                bottom: AppSpacing.sm,
              ),
              child: Text(
                t.security.dangerZone,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.35),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: const Icon(
                    Icons.person_off_outlined,
                    color: AppColors.error,
                  ),
                  title: Text(
                    t.security.deactivateAccount,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(t.security.deactivateAccountSubtitle),
                  onTap: _showDeactivateDialog,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Confirmation dialog that re-checks the password before deactivating.
/// Pops with `true` only after the backend accepted the request; errors (e.g.
/// a wrong password) are shown inline and keep the dialog open.
class _DeactivateAccountDialog extends ConsumerStatefulWidget {
  const _DeactivateAccountDialog();

  @override
  ConsumerState<_DeactivateAccountDialog> createState() =>
      _DeactivateAccountDialogState();
}

class _DeactivateAccountDialogState
    extends ConsumerState<_DeactivateAccountDialog> {
  final _passwordCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref
          .read(authRepositoryProvider)
          .deactivateAccount(password: _passwordCtrl.text);
      if (mounted) Navigator.pop(context, true);
    } on ApiException catch (e) {
      final msg = e is ValidationException
          ? (e.firstErrorFor('password') ?? e.userMessage)
          : e.userMessage;
      if (mounted) setState(() => _error = msg);
    } catch (_) {
      if (mounted) setState(() => _error = context.t.common.somethingWrong);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final canSubmit = !_loading && _passwordCtrl.text.isNotEmpty;
    return AlertDialog(
      title: Text(t.security.deactivateConfirmTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.security.deactivateConfirmMessage),
            const Gap(AppSpacing.md),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              autofocus: true,
              enabled: !_loading,
              decoration: InputDecoration(
                labelText: t.auth.password,
                errorText: _error,
                errorMaxLines: 3,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => canSubmit ? _submit() : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context, false),
          child: Text(t.common.cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.error),
          onPressed: canSubmit ? _submit : null,
          child: _loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(t.security.deactivate),
        ),
      ],
    );
  }
}
