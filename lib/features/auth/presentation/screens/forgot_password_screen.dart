import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_strings.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
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
  bool _sent = false;

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
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );
    _formAnim = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.2, 0.75, curve: Curves.easeOut),
    );
    _footerAnim = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.45, 1.0, curve: Curves.easeOut),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .requestPasswordReset(_emailController.text.trim());
      if (mounted) setState(() => _sent = true);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.userMessage),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
        ),
        child: _sent
            ? _SuccessView(key: const ValueKey('success'))
            : _FormContent(
                key: const ValueKey('form'),
                headerAnim: _headerAnim,
                formAnim: _formAnim,
                footerAnim: _footerAnim,
                formKey: _formKey,
                emailController: _emailController,
                isLoading: _isLoading,
                onSubmit: _submit,
              ),
      ),
    );
  }
}

// ── Form view ─────────────────────────────────────────────────────────────────

class _FormContent extends StatelessWidget {
  const _FormContent({
    super.key,
    required this.headerAnim,
    required this.formAnim,
    required this.footerAnim,
    required this.formKey,
    required this.emailController,
    required this.isLoading,
    required this.onSubmit,
  });

  final Animation<double> headerAnim;
  final Animation<double> formAnim;
  final Animation<double> footerAnim;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          _Section(
            anim: headerAnim,
            child: const AuthCardHeader(
              icon: Icons.lock_reset_rounded,
              title: AppStrings.forgotPasswordTitle,
              subtitle: AppStrings.forgotPasswordSubtitle,
            ),
          ),
          const SizedBox(height: 28),

          // Email field
          _Section(
            anim: formAnim,
            child: AutofillGroup(
              child: AuthCardField(
                controller: emailController,
                label: AppStrings.email,
                hint: AppStrings.emailHint,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.email],
                onFieldSubmitted: (_) => onSubmit(),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return AppStrings.emailRequired;
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                    return AppStrings.emailInvalid;
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Button + back link
          _Section(
            anim: footerAnim,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedButton(
                  label: AppStrings.sendResetLink,
                  isLoading: isLoading,
                  onPressed: isLoading ? null : onSubmit,
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
    );
  }
}

// ── Success view ──────────────────────────────────────────────────────────────

class _SuccessView extends StatelessWidget {
  const _SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthCardHeader(
          icon: Icons.mark_email_read_outlined,
          title: 'Email Sent!',
          subtitle: AppStrings.resetEmailSent,
          iconColor: AppColors.success,
        ),
        const SizedBox(height: 28),
        AnimatedButton(
          label: 'Back to Sign In',
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}

// ── Stagger section ───────────────────────────────────────────────────────────

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
