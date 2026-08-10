import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_form_section.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/biometric_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
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

  Future<void> _showDeleteAccountDialog() async {
    final deleted = await showDialog<bool>(
      context: context,
      builder: (_) => const _DeleteAccountDialog(),
    );
    if (deleted != true || !mounted) return;
    // The dialog itself already called authProvider.deleteAccount() (see
    // that method's docstring) — by the time it pops with `true`, local
    // session state is already torn down and the redirect to the login
    // screen is already underway, same as _showDeactivateDialog's flow.
    // Shown via the root messenger so it survives that redirect.
    AppSnackBar.show(
      context,
      context.t.security.deleteAccountSuccess,
      type: SnackBarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final enabled = ref.watch(biometricEnabledProvider);
    final supportedAsync = ref.watch(biometricSupportedProvider);
    final supported = supportedAsync.value ?? false;

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(t.security.title, icon: Icons.security_outlined),
      ),
      body: ResponsiveBody(
        child: ListView(
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
                const AppFormSectionDivider(),
                ListTile(
                  leading: const Icon(Icons.devices_outlined),
                  title: Text(t.security.activeSessions),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/shared/active-sessions'),
                ),
                const AppFormSectionDivider(),
                ListTile(
                  leading: const Icon(Icons.alternate_email),
                  title: Text(t.security.changeEmail),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/shared/change-email'),
                ),
              ],
            ),
            const Gap(AppSpacing.lg),
            AppFormSection(
              title: t.security.dangerZone,
              tintColor: AppColors.error,
              children: [
                ListTile(
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
                const AppFormSectionDivider(),
                ListTile(
                  leading: const Icon(
                    Icons.delete_forever_outlined,
                    color: AppColors.error,
                  ),
                  title: Text(
                    t.security.deleteAccount,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(t.security.deleteAccountSubtitle),
                  onTap: _showDeleteAccountDialog,
                ),
              ],
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
          style: AppButtonStyles.destructiveFilled,
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

/// Confirmation dialog for the irreversible delete-account action — same
/// re-authenticate-with-password shape as [_DeactivateAccountDialog], but
/// with an explicit, honest breakdown of what gets erased vs. retained
/// (see `security.deleteConfirmMessage`) ahead of the password field, since
/// unlike deactivation this cannot be walked back by contacting support.
///
/// Pops with `true` only after the backend has confirmed deletion AND the
/// local session has already been torn down (see
/// `AuthNotifier.deleteAccount`, called directly from here rather than the
/// repository) — the caller only needs to show a confirmation and rely on
/// the auth-state change to redirect to the login screen.
class _DeleteAccountDialog extends ConsumerStatefulWidget {
  const _DeleteAccountDialog();

  @override
  ConsumerState<_DeleteAccountDialog> createState() =>
      _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends ConsumerState<_DeleteAccountDialog> {
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
          .read(authProvider.notifier)
          .deleteAccount(password: _passwordCtrl.text);
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
      title: Text(t.security.deleteConfirmTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.security.deleteConfirmWarning,
              style: const TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(t.security.deleteConfirmMessage),
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
          style: AppButtonStyles.destructiveFilled,
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
              : Text(t.security.deleteAccount),
        ),
      ],
    );
  }
}
