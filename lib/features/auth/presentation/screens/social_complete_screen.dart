import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/utils/validators.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/fade_slide_transition.dart';
import 'package:medalize_mb/core/widgets/phone_field.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Second step of a first-time Google/Apple sign-up (see SocialLoginView's
/// `phone_required` response and AuthRepository.completeSocialSignup):
/// the provider already proved the user's identity, but phone is the
/// unique login identifier, so a brand-new social account needs one more
/// step to collect and verify it before it can be created. On success,
/// routes to the same verify-phone screen a password sign-up uses.
class SocialCompleteScreen extends ConsumerStatefulWidget {
  const SocialCompleteScreen({super.key, required this.pendingSocialToken});

  final String pendingSocialToken;

  @override
  ConsumerState<SocialCompleteScreen> createState() =>
      _SocialCompleteScreenState();
}

class _SocialCompleteScreenState extends ConsumerState<SocialCompleteScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  Map<String, List<String>> _fieldErrors = {};

  bool get _isFormValid => Validators.phoneOk(_phoneController.text);

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
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _fieldErrors = {};
    });
    final phone = '+994${_phoneController.text.trim()}';
    try {
      await ref.read(authRepositoryProvider).completeSocialSignup(
            pendingSocialToken: widget.pendingSocialToken,
            phone: phone,
          );
      if (!mounted) return;
      context.pushReplacement('/auth/verify-phone', extra: phone);
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e is ValidationException) {
        setState(() => _fieldErrors = e.fieldErrors);
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
                icon: Icons.phone_android_rounded,
                title: context.t.socialComplete.title,
                subtitle: context.t.socialComplete.subtitle,
              ),
            ),
            const SizedBox(height: 28),

            FadeSlideTransition(
              animation: _formAnim,
              child: AutofillGroup(
                child: PhoneField(
                  controller: _phoneController,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  onFieldSubmitted: (_) => _submit(),
                  errorText: _fieldErrors['phone']?.firstOrNull,
                ),
              ),
            ),
            const SizedBox(height: 24),

            FadeSlideTransition(
              animation: _footerAnim,
              child: LoadingFilledButton(
                label: context.t.socialComplete.button,
                loading: _isLoading,
                onPressed: _isLoading || !_isFormValid ? null : _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
