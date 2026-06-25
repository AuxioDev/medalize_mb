import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_strings.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/utils/validators.dart';
import 'package:medalize_mb/core/widgets/phone_field.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/animated_button.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/password_strength_indicator.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String? _selectedRole;
  String _dialCode = '+994';
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  Map<String, List<String>> _fieldErrors = {};
  final _phoneController = TextEditingController();

  static final _nameFormatters = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZÀ-ÖØ-öø-ÿ' -]")),
    LengthLimitingTextInputFormatter(50),
  ];

  bool get _isFormValid {
    final password = _passwordController.text;
    return Validators.nameOk(_firstNameController.text) &&
        Validators.nameOk(_lastNameController.text) &&
        Validators.emailOk(_emailController.text) &&
        _selectedRole != null &&
        Validators.passwordOk(password) &&
        _confirmController.text == password &&
        Validators.phoneOk(_phoneController.text);
  }

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
      curve: Interval(0.0, 0.5, curve: AppCurve.enter),
    );
    _formAnim = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.2, 0.75, curve: AppCurve.enter),
    );
    _footerAnim = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.5, 1.0, curve: AppCurve.enter),
    );
    _ctrl.forward();
    _firstNameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
    _confirmController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
    ref.read(authProvider.notifier).clearError();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _fieldErrors = {});
    if (_selectedRole == null) {
      AppSnackBar.show(context, AppStrings.roleRequired, type: SnackBarType.error);
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final rawPhone = _phoneController.text.trim();
    final phone = rawPhone.isEmpty ? '' : '$_dialCode$rawPhone';

    await ref.read(authProvider.notifier).register(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          passwordConfirm: _confirmController.text,
          role: _selectedRole!,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phone: phone,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (_, next) {
      if (next is AuthError && next.exception is ValidationException) {
        final e = next.exception as ValidationException;
        setState(() => _fieldErrors = e.fieldErrors);
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
              _Section(
                anim: _headerAnim,
                child: const AuthCardHeader(
                  icon: Icons.medical_services_rounded,
                  title: AppStrings.createYourAccount,
                  subtitle: AppStrings.joinMedalize,
                ),
              ),
              const SizedBox(height: 24),

              // ── Form ─────────────────────────────────────────────
              _Section(
                anim: _formAnim,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Name row
                    Row(
                      children: [
                        Expanded(
                          child: AuthCardField(
                            controller: _firstNameController,
                            label: AppStrings.firstName,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.givenName],
                            textInputAction: TextInputAction.next,
                            errorText: _fieldErrors['first_name']?.firstOrNull,
                            inputFormatters: _nameFormatters,
                            validator: (v) => Validators.name(v, label: 'First name'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AuthCardField(
                            controller: _lastNameController,
                            label: AppStrings.lastName,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.familyName],
                            textInputAction: TextInputAction.next,
                            errorText: _fieldErrors['last_name']?.firstOrNull,
                            inputFormatters: _nameFormatters,
                            validator: (v) => Validators.name(v, label: 'Last name'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Email
                    AuthCardField(
                      controller: _emailController,
                      label: AppStrings.email,
                      hint: AppStrings.emailHint,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.newUsername],
                      textInputAction: TextInputAction.next,
                      errorText: _fieldErrors['email']?.firstOrNull,
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 10),

                    // Phone
                    PhoneField(
                      controller: _phoneController,
                      textInputAction: TextInputAction.next,
                      label: 'Phone Number (Optional)',
                      hint: '501234567',
                      optional: true,
                      onCountryChanged: (c) => setState(() => _dialCode = c.dialCode),
                    ),
                    const SizedBox(height: 14),

                    // Role selector
                    Text(
                      AppStrings.iAmA,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: context.colors.textSecondary),
                    ),
                    const SizedBox(height: 6),
                    SegmentedButton<String>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(
                          value: 'patient',
                          label: Text('Patient'),
                          icon: Icon(Icons.person_outline_rounded, size: 16),
                        ),
                        ButtonSegment(
                          value: 'doctor',
                          label: Text('Doctor'),
                          icon: Icon(Icons.medical_services_outlined, size: 16),
                        ),
                      ],
                      selected: _selectedRole != null
                          ? {_selectedRole!}
                          : const <String>{},
                      emptySelectionAllowed: true,
                      onSelectionChanged: (v) {
                        if (v.isNotEmpty) setState(() => _selectedRole = v.first);
                      },
                      style: SegmentedButton.styleFrom(
                        foregroundColor: context.colors.textSecondary,
                        selectedForegroundColor: AppColors.primary,
                        selectedBackgroundColor:
                            AppColors.primary.withValues(alpha: 0.08),
                        side: BorderSide(color: context.colors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Password
                    AuthCardField(
                      controller: _passwordController,
                      label: AppStrings.password,
                      autofillHints: const [AutofillHints.newPassword],
                      textInputAction: TextInputAction.next,
                      obscureText: _obscurePassword,
                      errorText: _fieldErrors['password']?.firstOrNull,
                      inputFormatters: [LengthLimitingTextInputFormatter(128)],
                      suffix: VisibilityToggle(
                        obscure: _obscurePassword,
                        onToggle: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      validator: Validators.password,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _passwordController,
                      builder: (_, value, _) =>
                          _InlineStrength(password: value.text),
                    ),
                    const SizedBox(height: 8),

                    // Confirm password
                    AuthCardField(
                      controller: _confirmController,
                      label: AppStrings.confirmPassword,
                      autofillHints: const [AutofillHints.newPassword],
                      textInputAction: TextInputAction.done,
                      obscureText: _obscureConfirm,
                      errorText: _fieldErrors['password_confirm']?.firstOrNull,
                      inputFormatters: [LengthLimitingTextInputFormatter(128)],
                      suffix: VisibilityToggle(
                        obscure: _obscureConfirm,
                        onToggle: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                      ),
                      onFieldSubmitted: (_) => _submit(),
                      validator: (v) =>
                          Validators.confirmPassword(v, _passwordController.text),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Inline error ──────────────────────────────────────
              if (authState is AuthError &&
                  authState.exception is! ValidationException)
                _ErrorBanner(message: authState.exception.userMessage),

              // ── CTA + footer ──────────────────────────────────────
              _Section(
                anim: _footerAnim,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnimatedButton(
                      label: AppStrings.register,
                      isLoading: isLoading,
                      onPressed: isLoading || !_isFormValid ? null : _submit,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.haveAccount,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text(AppStrings.signIn),
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

// ── Shared stagger section ────────────────────────────────────────────────────

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

// ── Inline strength bar ───────────────────────────────────────────────────────

class _InlineStrength extends StatelessWidget {
  const _InlineStrength({required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final strength = evaluatePasswordStrength(password);
    if (strength == PasswordStrength.empty) return const SizedBox(height: 4);

    final (color, label, value) = switch (strength) {
      PasswordStrength.weak   => (AppColors.strengthWeak, 'Weak', 0.25),
      PasswordStrength.fair   => (const Color(0xFFF97316), 'Fair', 0.5),
      PasswordStrength.good   => (const Color(0xFF84CC16), 'Good', 0.75),
      PasswordStrength.strong => (AppColors.strengthStrong, 'Strong', 1.0),
      PasswordStrength.empty  => (AppColors.border, '', 0.0),
    };

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: value),
                duration: const Duration(milliseconds: 300),
                builder: (_, v, _) => LinearProgressIndicator(
                  value: v,
                  minHeight: 3,
                  backgroundColor: context.colors.border,
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
