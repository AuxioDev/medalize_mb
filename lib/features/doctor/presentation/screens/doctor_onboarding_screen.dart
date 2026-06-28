import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/doctor/data/repository/doctor_profile_repository.dart';
import 'package:medalize_mb/features/doctor/presentation/widgets/slot_duration_selector.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

const _kTotalSteps = 3;

class DoctorOnboardingScreen extends ConsumerStatefulWidget {
  const DoctorOnboardingScreen({super.key});

  @override
  ConsumerState<DoctorOnboardingScreen> createState() =>
      _DoctorOnboardingScreenState();
}

class _DoctorOnboardingScreenState
    extends ConsumerState<DoctorOnboardingScreen> {
  final _pageController = PageController();
  final _licenseController = TextEditingController();
  final _bioController = TextEditingController();

  int _step = 0;
  String? _specialization;
  int _slotDuration = 30;
  String? _diplomaPath;
  String? _diplomaName;

  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _pageController.dispose();
    _licenseController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  String? _validateStep(int step) {
    switch (step) {
      case 0:
        if (_specialization == null) {
          return context.t.onboarding.selectSpecError;
        }
        if (_licenseController.text.trim().isEmpty) {
          return context.t.onboarding.licenseError;
        }
        return null;
      case 2:
        if (_diplomaPath == null) return context.t.onboarding.diplomaError;
        return null;
      default:
        return null;
    }
  }

  void _next() {
    final err = _validateStep(_step);
    if (err != null) {
      setState(() => _error = err);
      return;
    }
    setState(() => _error = null);
    if (_step < _kTotalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    } else {
      _submit();
    }
  }

  void _back() {
    if (_step == 0) return;
    setState(() => _error = null);
    _pageController.previousPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _pickDiploma() async {
    final result = await FilePicker.platform.pickFiles(withData: false);
    if (result == null || result.files.single.path == null) return;
    setState(() {
      _diplomaPath = result.files.single.path;
      _diplomaName = result.files.single.name;
      _error = null;
    });
  }

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final repo = ref.read(doctorProfileRepositoryProvider);
      await repo.updateProfile(
        specialization: _specialization,
        licenseNumber: _licenseController.text.trim(),
        bio: _bioController.text.trim(),
        slotDurationMin: _slotDuration,
      );
      await repo.uploadDiploma(_diplomaPath!, fileName: _diplomaName);
      await repo.completeOnboarding();
      await ref.read(authProvider.notifier).refreshProfile();
      if (mounted) context.go('/doctor/pending-verification');
    } on ValidationException catch (e) {
      setState(() => _error = e.fieldErrors.values
          .expand((v) => v)
          .join('\n')
          .ifEmptyThen(context.t.onboarding.checkDetails));
    } on ApiException catch (e) {
      setState(() => _error = e.userMessage);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.onboarding.title),
        actions: [
          TextButton(
            onPressed: () => ref.read(authProvider.notifier).logout(),
            child: Text(context.t.common.signOut),
          ),
        ],
      ),
      body: ResponsiveBody(
        child: Column(
          children: [
            _ProgressHeader(step: _step, total: _kTotalSteps),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _step = i),
                children: [
                  _stepProfessionalInfo(),
                  _stepSlotDuration(),
                  _stepDiploma(),
                ],
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
                child: Text(
                  _error!,
                  style: const TextStyle(color: AppColors.error, fontSize: 13),
                ),
              ),
            BottomActionBar(
              child: Row(
                children: [
                  if (_step > 0) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _submitting ? null : _back,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                        ),
                        child: Text(context.t.common.back),
                      ),
                    ),
                    const Gap(12),
                  ],
                  Expanded(
                    child: LoadingFilledButton(
                      label: _step == _kTotalSteps - 1
                          ? context.t.onboarding.finish
                          : context.t.onboarding.continueButton,
                      loading: _submitting,
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        _next();
                      },
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

  // ── Step 1: professional info ─────────────────────────────────────────────
  Widget _stepProfessionalInfo() {
    final specsAsync = ref.watch(specializationsProvider);
    return _StepScroll(
      title: context.t.onboarding.professionalInfo,
      subtitle: context.t.onboarding.tellPatients,
      children: [
        _FieldLabel(context.t.onboarding.specialization),
        const Gap(6),
        specsAsync.when(
          loading: () => const _LoadingField(),
          error: (_, _) => Text(
            context.t.onboarding.couldNotLoadSpecs,
            style: TextStyle(color: context.colors.textSecondary, fontSize: 13),
          ),
          data: (options) => DropdownButtonFormField<String>(
            initialValue: _specialization,
            isExpanded: true,
            decoration: InputDecoration(
              hintText: context.t.onboarding.selectSpecialization,
              prefixIcon: const Icon(Icons.medical_services_outlined, size: 20),
            ),
            items: [
              for (final o in options)
                DropdownMenuItem(value: o.value, child: Text(o.label)),
            ],
            onChanged: (v) => setState(() => _specialization = v),
          ),
        ),
        const Gap(AppSpacing.md),
        _FieldLabel(context.t.onboarding.licenseNumber),
        const Gap(6),
        TextField(
          controller: _licenseController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: context.t.onboarding.licenseHint,
            prefixIcon: const Icon(Icons.badge_outlined, size: 20),
          ),
        ),
        const Gap(AppSpacing.md),
        _FieldLabel(context.t.onboarding.bio),
        const Gap(6),
        TextField(
          controller: _bioController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: context.t.onboarding.bioHint,
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }

  // ── Step 2: slot duration ─────────────────────────────────────────────────
  Widget _stepSlotDuration() {
    return _StepScroll(
      title: context.t.onboarding.appointmentLength,
      subtitle: context.t.onboarding.slotQuestion,
      children: [
        AppCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlotDurationSelector(
                selected: _slotDuration,
                onSelect: (d) => setState(() => _slotDuration = d),
              ),
              const Gap(AppSpacing.md),
              Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: context.colors.textSecondary),
                  const Gap(6),
                  Expanded(
                    child: Text(
                      context.t.onboarding.changeLater,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Step 3: diploma ───────────────────────────────────────────────────────
  Widget _stepDiploma() {
    final c = context.colors;
    final picked = _diplomaPath != null;
    return _StepScroll(
      title: context.t.onboarding.verificationDoc,
      subtitle: context.t.onboarding.uploadDiploma,
      children: [
        GestureDetector(
          onTap: _submitting ? null : _pickDiploma,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: picked ? c.primarySurface : c.surfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: picked ? AppColors.primary : c.border,
                width: picked ? 1.5 : 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  picked
                      ? Icons.check_circle_outline
                      : Icons.cloud_upload_outlined,
                  size: 40,
                  color: picked ? AppColors.primary : c.textSecondary,
                ),
                const Gap(10),
                Text(
                  picked ? _diplomaName! : context.t.onboarding.tapToChoose,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                Text(
                  picked
                      ? context.t.onboarding.tapToReplace
                      : context.t.onboarding.anyFileType,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.step, required this.total});
  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
      child: Row(
        children: [
          for (int i = 0; i < total; i++) ...[
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 5,
                decoration: BoxDecoration(
                  color: i <= step ? AppColors.primary : c.border,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
            if (i != total - 1) const Gap(6),
          ],
        ],
      ),
    );
  }
}

class _StepScroll extends StatelessWidget {
  const _StepScroll({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const Gap(4),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          const Gap(AppSpacing.lg),
          ...children,
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: Theme.of(context).textTheme.titleSmall);
}

class _LoadingField extends StatelessWidget {
  const _LoadingField();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: c.border),
      ),
      child: const Center(
        child: SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

extension _StringFallback on String {
  String ifEmptyThen(String fallback) => trim().isEmpty ? fallback : this;
}
