import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_strings.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/utils/validators.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/animated_button.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  bool get _isFormValid =>
      Validators.emailOk(_emailController.text) &&
      _passwordController.text.isNotEmpty;

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
    _passwordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
    ref.read(authProvider.notifier).clearError();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
          rememberMe: _rememberMe,
        );
  }

  String _errorMessage(ApiException e) => switch (e) {
        InvalidCredentialsException(:final message) => message,
        RateLimitException(:final retryAfterSeconds) => retryAfterSeconds != null
            ? 'Too many attempts. Try again in ${retryAfterSeconds}s.'
            : AppStrings.rateLimitError,
        NetworkException() => AppStrings.networkError,
        _ => e.userMessage,
      };

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;

    return AuthScaffold(
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ───────────────────────────────────────────
              _Section(
                anim: _headerAnim,
                child: const AuthCardHeader(
                  icon: Icons.medical_services_rounded,
                  title: AppStrings.welcomeBack,
                  subtitle: AppStrings.signInToContinue,
                ),
              ),
              const SizedBox(height: 28),

              // ── Form fields ───────────────────────────────────────
              _Section(
                anim: _formAnim,
                child: Column(
                  children: [
                    AuthCardField(
                      controller: _emailController,
                      label: AppStrings.email,
                      hint: AppStrings.emailHint,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 12),
                    AuthCardField(
                      controller: _passwordController,
                      label: AppStrings.password,
                      hint: AppStrings.passwordHint,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      onFieldSubmitted: (_) => _submit(),
                      suffix: VisibilityToggle(
                        obscure: _obscurePassword,
                        onToggle: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? AppStrings.passwordRequired : null,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => setState(() => _rememberMe = !_rememberMe),
                          child: Row(
                            children: [
                              Switch(
                                value: _rememberMe,
                                onChanged: (v) => setState(() => _rememberMe = v),
                                activeThumbColor: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                AppStrings.rememberMe,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: context.colors.textPrimary),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => context.push('/auth/forgot-password'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                          ),
                          child: const Text(AppStrings.forgotPassword),
                        ),
                      ],
                    ), // Row
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ── Inline error ──────────────────────────────────────
              if (authState is AuthError)
                _ErrorBanner(message: _errorMessage(authState.exception)),

              // ── CTA + footer ──────────────────────────────────────
              _Section(
                anim: _footerAnim,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnimatedButton(
                      label: AppStrings.login,
                      isLoading: isLoading,
                      onPressed: isLoading || !_isFormValid ? null : _submit,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.noAccount,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => context.push('/auth/register'),
                          child: const Text(AppStrings.signUp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline_rounded, color: AppColors.error, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animates opacity + upward slide for a section of the auth card.
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
