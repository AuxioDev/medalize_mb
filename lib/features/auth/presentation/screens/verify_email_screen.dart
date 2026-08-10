import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/fade_slide_transition.dart';
import 'package:medalize_mb/core/widgets/otp_code_field.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';

/// Shown right after registration (RegisterScreen's auto-login fails with
/// [EmailNotVerifiedException]) and whenever a not-yet-verified account
/// tries to log in later — see CustomTokenObtainPairSerializer on the
/// backend. Confirming here signs the user straight in, same as
/// ResetPasswordScreen does for the password-reset OTP.
class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key, required this.email});

  final String email;

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen>
    with SingleTickerProviderStateMixin {
  String _otpCode = '';
  bool _otpError = false;
  bool _resending = false;

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
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_otpCode.length != 6) return;
    await ref.read(authProvider.notifier).verifyEmail(widget.email, _otpCode);
  }

  Future<void> _resend() async {
    setState(() => _resending = true);
    try {
      await ref.read(authRepositoryProvider).resendEmailVerification(widget.email);
      if (!mounted) return;
      AppSnackBar.show(context, t.verifyEmail.resendSent, type: SnackBarType.success);
    } on ApiException catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _resending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (_, next) {
      if (next is AuthError) {
        final isCodeError =
            next.exception is ValidationException &&
            (next.exception as ValidationException).fieldErrors.containsKey('code');
        if (isCodeError) setState(() => _otpError = true);
        AppSnackBar.show(context, next.exception.userMessage, type: SnackBarType.error);
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;

    return AuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeSlideTransition(
            animation: _headerAnim,
            child: AuthCardHeader(
              icon: Icons.mark_email_read_outlined,
              title: context.t.verifyEmail.title,
              subtitle: context.t.verifyEmail.subtitle(email: widget.email),
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
                  label: context.t.verifyEmail.button,
                  loading: isLoading,
                  onPressed: isLoading || _otpCode.length != 6 ? null : _submit,
                ),
                const SizedBox(height: 4),
                Center(
                  child: TextButton(
                    onPressed: _resending || isLoading ? null : _resend,
                    child: Text(context.t.verifyEmail.resend),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
