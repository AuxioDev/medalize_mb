import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_strings.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/password_strength_indicator.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String? _selectedRole;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  Map<String, List<String>> _fieldErrors = {};

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _fieldErrors = {});
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.roleRequired)),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authProvider.notifier).register(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          passwordConfirm: _confirmController.text,
          role: _selectedRole!,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (_, next) {
      if (next is AuthError) {
        final e = next.exception;
        if (e is ValidationException) {
          setState(() => _fieldErrors = e.fieldErrors);
          if (e.fieldErrors.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.firstError), backgroundColor: AppColors.error),
            );
          }
        } else {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(e.userMessage),
              backgroundColor: AppColors.error,
            ));
        }
      }
    });

    final isLoading = ref.watch(authProvider) is AuthLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: AutofillGroup(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Header ──────────────────────────────────────────
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.medical_services_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.createYourAccount,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 22),
                          ),
                          Text(
                            AppStrings.joinMedalize,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Name row ─────────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: _Field(
                          controller: _firstNameController,
                          label: AppStrings.firstName,
                          autofillHints: const [AutofillHints.givenName],
                          textInputAction: TextInputAction.next,
                          errorText: _fieldErrors['first_name']?.firstOrNull,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? AppStrings.firstNameRequired
                              : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _Field(
                          controller: _lastNameController,
                          label: AppStrings.lastName,
                          autofillHints: const [AutofillHints.familyName],
                          textInputAction: TextInputAction.next,
                          errorText: _fieldErrors['last_name']?.firstOrNull,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? AppStrings.lastNameRequired
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // ── Email ────────────────────────────────────────────
                  _Field(
                    controller: _emailController,
                    label: AppStrings.email,
                    hint: AppStrings.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.newUsername],
                    textInputAction: TextInputAction.next,
                    errorText: _fieldErrors['email']?.firstOrNull,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return AppStrings.emailRequired;
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                        return AppStrings.emailInvalid;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  // ── Role ─────────────────────────────────────────────
                  Text(
                    AppStrings.iAmA,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
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
                      foregroundColor: AppColors.textSecondary,
                      selectedForegroundColor: AppColors.primary,
                      selectedBackgroundColor:
                          AppColors.primary.withValues(alpha: 0.08),
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Password ─────────────────────────────────────────
                  _Field(
                    controller: _passwordController,
                    label: AppStrings.password,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.next,
                    obscureText: _obscurePassword,
                    errorText: _fieldErrors['password']?.firstOrNull,
                    suffix: _VisibilityToggle(
                      obscure: _obscurePassword,
                      onToggle: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return AppStrings.passwordRequired;
                      if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$').hasMatch(v)) {
                        return AppStrings.passwordTooShort;
                      }
                      return null;
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _passwordController,
                    builder: (_, value, _) =>
                        _CompactStrength(password: value.text),
                  ),
                  const SizedBox(height: 8),

                  // ── Confirm ──────────────────────────────────────────
                  _Field(
                    controller: _confirmController,
                    label: AppStrings.confirmPassword,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.done,
                    obscureText: _obscureConfirm,
                    errorText: _fieldErrors['password_confirm']?.firstOrNull,
                    suffix: _VisibilityToggle(
                      obscure: _obscureConfirm,
                      onToggle: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                    onFieldSubmitted: (_) => _submit(),
                    validator: (v) {
                      if (v == null || v.isEmpty) return AppStrings.passwordRequired;
                      if (v != _passwordController.text) return AppStrings.passwordMismatch;
                      return null;
                    },
                  ),

                  const Spacer(),

                  // ── CTA ──────────────────────────────────────────────
                  FilledButton(
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Text(AppStrings.register),
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
          ),
        ),
      ),
    );
  }
}

// ── Compact floating-label field ──────────────────────────────────────────────

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.obscureText = false,
    this.suffix,
    this.errorText,
    this.validator,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final Widget? suffix;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: suffix,
        errorText: errorText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}

// ── Password visibility toggle ────────────────────────────────────────────────

class _VisibilityToggle extends StatelessWidget {
  const _VisibilityToggle({required this.obscure, required this.onToggle});

  final bool obscure;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: AppColors.textSecondary,
        size: 20,
      ),
      onPressed: onToggle,
    );
  }
}

// ── Inline strength bar ───────────────────────────────────────────────────────

class _CompactStrength extends StatelessWidget {
  const _CompactStrength({required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final strength = evaluatePasswordStrength(password);
    if (strength == PasswordStrength.empty) return const SizedBox(height: 4);

    final (color, label, value) = switch (strength) {
      PasswordStrength.weak => (AppColors.strengthWeak, 'Weak', 0.33),
      PasswordStrength.medium => (AppColors.strengthMedium, 'Medium', 0.66),
      PasswordStrength.strong => (AppColors.strengthStrong, 'Strong', 1.0),
      PasswordStrength.empty => (AppColors.border, '', 0.0),
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
                  backgroundColor: AppColors.border,
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
