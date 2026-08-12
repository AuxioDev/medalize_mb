import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/utils/validators.dart';
import 'package:medalize_mb/core/widgets/fade_slide_transition.dart';
import 'package:medalize_mb/core/widgets/phone_field.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/tinted_notice_banner.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  bool get _isFormValid =>
      Validators.phoneOk(_phoneController.text) &&
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
    _phoneController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
    ref.read(authProvider.notifier).clearError();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref
        .read(authProvider.notifier)
        .login(
          '+994${_phoneController.text.trim()}',
          _passwordController.text,
          rememberMe: _rememberMe,
        );
  }

  String _errorMessage(ApiException e) => switch (e) {
    InvalidCredentialsException(:final message) =>
      message ?? t.errors.invalidCredentials,
    RateLimitException(:final retryAfterSeconds) =>
      retryAfterSeconds != null
          ? t.errors.rateLimitWithSeconds(seconds: retryAfterSeconds)
          : t.errors.rateLimit,
    NetworkException() => t.errors.network,
    _ => e.userMessage,
  };

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (_, next) {
      if (next is AuthError && next.exception is PhoneNotVerifiedException) {
        final phone = (next.exception as PhoneNotVerifiedException).phone;
        ref.read(authProvider.notifier).clearError();
        context.push('/auth/verify-phone', extra: phone);
      }
      if (next is AuthError && next.exception is SocialPhoneRequiredException) {
        final token =
            (next.exception as SocialPhoneRequiredException).pendingSocialToken;
        ref.read(authProvider.notifier).clearError();
        context.push('/auth/social-complete', extra: token);
      }
    });

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
              FadeSlideTransition(
                animation: _headerAnim,
                child: AuthCardHeader(
                  imageAsset: 'assets/icon/app_icon_fg.png',
                  title: context.t.auth.welcomeBack,
                  subtitle: context.t.auth.signInToContinue,
                ),
              ),
              const SizedBox(height: 28),

              // ── Form fields ───────────────────────────────────────
              FadeSlideTransition(
                animation: _formAnim,
                child: Column(
                  children: [
                    PhoneField(
                      controller: _phoneController,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.telephoneNumber],
                    ),
                    const SizedBox(height: 12),
                    AuthCardField(
                      controller: _passwordController,
                      label: context.t.auth.password,
                      hint: context.t.auth.passwordHint,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      onFieldSubmitted: (_) => _submit(),
                      suffix: VisibilityToggle(
                        obscure: _obscurePassword,
                        onToggle: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                      validator: (v) => (v == null || v.isEmpty)
                          ? t.validation.passwordRequired
                          : null,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      // spaceBetween (not a Spacer child) so the "Remember
                      // me" cluster gets ALL leftover space instead of
                      // splitting it 50/50 with a flex gap — a Spacer here
                      // previously squeezed the label down to "Reme…" even
                      // on a full-size phone screen.
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () =>
                                setState(() => _rememberMe = !_rememberMe),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (v) =>
                                      setState(() => _rememberMe = v ?? false),
                                  activeColor: AppColors.primary,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    context.t.auth.rememberMe,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: context.colors.textPrimary,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.push('/auth/forgot-password'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                          ),
                          child: Text(context.t.auth.forgotPassword),
                        ),
                      ],
                    ), // Row
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ── Inline error ──────────────────────────────────────
              if (authState is AuthError &&
                  authState.exception is! PhoneNotVerifiedException &&
                  authState.exception is! SocialPhoneRequiredException) ...[
                TintedNoticeBanner(
                  color: AppColors.error,
                  icon: Icons.error_outline_rounded,
                  child: Text(
                    _errorMessage(authState.exception),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.error,
                        ),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              // ── CTA + footer ──────────────────────────────────────
              FadeSlideTransition(
                animation: _footerAnim,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoadingFilledButton(
                      label: context.t.auth.login,
                      loading: isLoading,
                      onPressed: isLoading || !_isFormValid ? null : _submit,
                    ),
                    const SizedBox(height: 16),
                    SocialLoginButtons(
                      enabled: !isLoading,
                      onGoogleTap: () =>
                          ref.read(authProvider.notifier).loginWithGoogle(),
                      onAppleTap: () =>
                          ref.read(authProvider.notifier).loginWithApple(),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            context.t.auth.noAccount,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.push('/auth/register'),
                          child: Text(context.t.auth.signUp),
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
