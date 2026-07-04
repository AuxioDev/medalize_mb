import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/utils/validators.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/otp_code_field.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Two-step email change flow: (1) new email + current password requests a
/// verification code sent to the new address, (2) the 6-digit code confirms
/// it. The backend revokes every session on success, so the screen forces a
/// local logout and the router lands the user back on the login screen.
class ChangeEmailScreen extends ConsumerStatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  ConsumerState<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends ConsumerState<ChangeEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _codeSent = false;
  bool _loading = false;
  String _code = '';
  bool _codeError = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(authRepositoryProvider).requestEmailChange(
            newEmail: _emailCtrl.text.trim(),
            password: _passwordCtrl.text,
          );
      if (mounted) {
        setState(() {
          _codeSent = true;
          _code = '';
          _codeError = false;
        });
      }
    } on ApiException catch (e) {
      final msg = e is ValidationException
          ? (e.firstErrorFor('new_email') ??
              e.firstErrorFor('password') ??
              e.userMessage)
          : e.userMessage;
      if (mounted) setState(() => _error = msg);
    } catch (_) {
      if (mounted) setState(() => _error = context.t.common.somethingWrong);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _confirm() async {
    setState(() {
      _loading = true;
      _error = null;
      _codeError = false;
    });
    try {
      await ref.read(authRepositoryProvider).confirmEmailChange(code: _code);
      if (!mounted) return;
      // Shown via the root messenger so it survives the redirect to the login
      // screen that forceLogout() triggers.
      AppSnackBar.show(
        context,
        context.t.security.changeEmailSuccess,
        type: SnackBarType.success,
      );
      await ref.read(authProvider.notifier).forceLogout();
    } on ApiException catch (e) {
      final msg = e is ValidationException
          ? (e.firstErrorFor('code') ?? e.userMessage)
          : e.userMessage;
      if (mounted) {
        setState(() {
          _error = msg;
          _codeError = true;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _error = context.t.common.somethingWrong);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Back to step 1 keeping the typed email/password so the user can fix a
  /// typo and request a fresh code.
  void _editEmail() {
    setState(() {
      _codeSent = false;
      _code = '';
      _codeError = false;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t.security.changeEmail)),
      body: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            if (!_codeSent) _buildRequestStep(t) else _buildConfirmStep(t),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestStep(Translations t) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.security.changeEmailSubtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Gap(AppSpacing.md),
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            enabled: !_loading,
            decoration: InputDecoration(
              labelText: t.security.newEmailLabel,
              hintText: t.auth.emailHint,
            ),
            validator: Validators.email,
          ),
          const Gap(12),
          TextFormField(
            controller: _passwordCtrl,
            obscureText: true,
            enabled: !_loading,
            decoration: InputDecoration(labelText: t.profile.currentPassword),
            validator: (v) =>
                (v == null || v.isEmpty) ? t.validation.passwordRequired : null,
            onFieldSubmitted: (_) => _loading ? null : _sendCode(),
          ),
          if (_error != null) ...[
            const Gap(AppSpacing.sm),
            Text(_error!, style: const TextStyle(color: AppColors.error)),
          ],
          const Gap(AppSpacing.md),
          FilledButton(
            onPressed: _loading ? null : _sendCode,
            child: _loading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : Text(t.security.sendCode),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmStep(Translations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.security.codeSentTo(email: _emailCtrl.text.trim()),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Gap(AppSpacing.md),
        OtpCodeField(
          hasError: _codeError,
          onChanged: (v) => setState(() {
            _code = v;
            if (_codeError) _codeError = false;
          }),
          onCompleted: (v) => setState(() => _code = v),
        ),
        if (_error != null) ...[
          const Gap(AppSpacing.sm),
          Text(_error!, style: const TextStyle(color: AppColors.error)),
        ],
        const Gap(AppSpacing.md),
        FilledButton(
          onPressed: (_loading || _code.length != 6) ? null : _confirm,
          child: _loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : Text(t.security.confirmNewEmail),
        ),
        const Gap(4),
        TextButton(
          onPressed: _loading ? null : _editEmail,
          child: Text(t.common.back),
        ),
      ],
    );
  }
}
