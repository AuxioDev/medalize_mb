import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_strings.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/utils/validators.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/animated_button.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/auth_scaffold.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  bool get _isFormValid => Validators.emailOk(_emailController.text);

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
    _emailController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() => setState(() {});

  @override
  void dispose() {
    _ctrl.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final email = _emailController.text.trim();
    try {
      await ref.read(authRepositoryProvider).requestPasswordReset(email);
      if (!mounted) return;
      // Navigate to OTP entry screen regardless of whether the email exists
      // (backend always returns 200 to prevent email enumeration)
      context.push('/auth/reset-password', extra: email);
    } on ApiException catch (e) {
      if (!mounted) return;
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
            _Section(
              anim: _headerAnim,
              child: const AuthCardHeader(
                icon: Icons.lock_reset_rounded,
                title: AppStrings.forgotPasswordTitle,
                subtitle: AppStrings.forgotPasswordSubtitle,
              ),
            ),
            const SizedBox(height: 28),

            _Section(
              anim: _formAnim,
              child: AutofillGroup(
                child: AuthCardField(
                  controller: _emailController,
                  label: AppStrings.email,
                  hint: AppStrings.emailHint,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.email],
                  onFieldSubmitted: (_) => _submit(),
                  validator: Validators.email,
                ),
              ),
            ),
            const SizedBox(height: 24),

            _Section(
              anim: _footerAnim,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedButton(
                    label: AppStrings.sendResetLink,
                    isLoading: _isLoading,
                    onPressed: _isLoading || !_isFormValid ? null : _submit,
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Builder(
                      builder: (context) => TextButton.icon(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_rounded, size: 16),
                        label: const Text('Back to Sign In'),
                      ),
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

class _Section extends StatelessWidget {
  const _Section({required this.anim, required this.child});

  final Animation<double> anim;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.14),
          end: Offset.zero,
        ).animate(anim),
        child: child,
      ),
    );
  }
}
