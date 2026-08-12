import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/utils/validators.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/fade_slide_transition.dart';
import 'package:medalize_mb/core/widgets/otp_code_field.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/auth_scaffold.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, required this.phone});

  final String phone;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String _otpCode = '';
  bool _otpError = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  bool get _isFormValid =>
      _otpCode.length == 6 &&
      Validators.passwordOk(_passwordController.text) &&
      _confirmController.text == _passwordController.text;

  late final AnimationController _ctrl;
  late final Animation<double> _headerAnim;
  late final Animation<double> _formAnim;
  late final Animation<double> _footerAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _headerAnim = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.0, 0.55, curve: AppCurve.enter),
    );
    _formAnim = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.2, 0.75, curve: AppCurve.enter),
    );
    _footerAnim = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.45, 1.0, curve: AppCurve.enter),
    );
    _ctrl.forward();
    _passwordController.addListener(_onFieldChanged);
    _confirmController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() => setState(() {});

  @override
  void dispose() {
    _ctrl.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).confirmPasswordReset(
            phone: widget.phone,
            code: _otpCode,
            newPassword: _passwordController.text,
          );
      if (!mounted) return;
      AppSnackBar.show(
        context,
        t.resetPassword.success,
        type: SnackBarType.success,
      );
      context.go('/auth/login');
    } on ApiException catch (e) {
      if (!mounted) return;
      // Highlight the OTP field based on the structured error (the backend
      // reports a bad code under the `code` field), not by string-matching a
      // localized message — which breaks in non-English locales.
      final isCodeError =
          e is ValidationException && e.fieldErrors.containsKey('code');
      if (isCodeError) {
        setState(() => _otpError = true);
      }
      AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeSlideTransition(
              animation: _headerAnim,
              child: AuthCardHeader(
                icon: Icons.lock_reset_rounded,
                title: context.t.resetPassword.title,
                subtitle: context.t.resetPassword.subtitle,
              ),
            ),
            const SizedBox(height: 28),

            FadeSlideTransition(
              animation: _formAnim,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.auth.verificationCode,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  OtpCodeField(
                    hasError: _otpError,
                    onChanged: (v) => setState(() {
                      _otpCode = v;
                      if (_otpError) _otpError = false;
                    }),
                    onCompleted: (v) => setState(() => _otpCode = v),
                  ),
                  const SizedBox(height: 16),
                  AuthCardField(
                    controller: _passwordController,
                    label: context.t.auth.password,
                    hint: context.t.auth.passwordHint,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    suffix: VisibilityToggle(
                      obscure: _obscurePassword,
                      onToggle: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 12),
                  AuthCardField(
                    controller: _confirmController,
                    label: context.t.auth.confirmPassword,
                    hint: context.t.auth.passwordHint,
                    obscureText: _obscureConfirm,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    suffix: VisibilityToggle(
                      obscure: _obscureConfirm,
                      onToggle: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                    validator: (v) =>
                        Validators.confirmPassword(v, _passwordController.text),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            FadeSlideTransition(
              animation: _footerAnim,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoadingFilledButton(
                    label: context.t.resetPassword.button,
                    loading: _isLoading,
                    onPressed: _isLoading || !_isFormValid ? null : _submit,
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: TextButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_rounded, size: 16),
                      label: Text(context.t.common.back),
                    ),
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

