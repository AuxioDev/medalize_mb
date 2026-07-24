import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/medications/providers/medication_provider.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';
import 'package:medalize_mb/features/prescriptions/providers/prescription_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class PrescriptionDetailScreen extends ConsumerStatefulWidget {
  const PrescriptionDetailScreen({super.key, required this.prescriptionId});
  final String prescriptionId;

  @override
  ConsumerState<PrescriptionDetailScreen> createState() =>
      _PrescriptionDetailScreenState();
}

class _PrescriptionDetailScreenState extends ConsumerState<PrescriptionDetailScreen> {
  bool _applying = false;
  bool _applied = false;

  Future<void> _apply() async {
    setState(() => _applying = true);
    try {
      await ref.read(prescriptionRepositoryProvider).applyPrescription(widget.prescriptionId);
      ref.invalidate(medicationsProvider);
      if (mounted) {
        setState(() => _applied = true);
        AppSnackBar.show(context, context.t.prescriptions.applySuccess,
            type: SnackBarType.success);
        context.push('/patient/medications');
      }
    } on ApiException catch (e) {
      if (mounted) AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _applying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(prescriptionByIdProvider(widget.prescriptionId));
    return Scaffold(
      appBar: AppBar(title: Text(context.t.prescriptions.summaryTitle)),
      body: async.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(children: [
            ShimmerSkeleton(height: 64),
            ShimmerSkeleton(height: 120),
          ]),
        ),
        error: (_, _) => Center(child: Text(context.t.common.somethingWrong)),
        data: (prescription) => _Body(
          prescription: prescription,
          applying: _applying,
          applied: _applied,
          onApply: _apply,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.prescription,
    required this.applying,
    required this.applied,
    required this.onApply,
  });

  final PrescriptionModel prescription;
  final bool applying;
  final bool applied;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final c = context.colors;
    final dateFmt = DateFormat('d MMM y');

    return ResponsiveBody(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedEntrance(
              child: Text(t.prescriptions.issuedBy(name: prescription.doctorName),
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const Gap(4),
            Text(
              t.prescriptions.issuedOn(date: dateFmt.format(prescription.issuedAt)),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (prescription.notes.isNotEmpty) ...[
              const Gap(AppSpacing.md),
              Text(t.prescriptions.notes, style: Theme.of(context).textTheme.labelLarge),
              const Gap(4),
              Text(prescription.notes),
            ],
            const Gap(AppSpacing.lg),
            for (int i = 0; i < prescription.items.length; i++)
              AnimatedEntrance(
                index: i,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: c.surfaceAlt,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: c.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(prescription.items[i].drugName,
                          style: Theme.of(context).textTheme.titleSmall),
                      if (prescription.items[i].dosage.isNotEmpty ||
                          prescription.items[i].frequency.isNotEmpty) ...[
                        const Gap(4),
                        Text(
                          [prescription.items[i].dosage, prescription.items[i].frequency]
                              .where((s) => s.isNotEmpty)
                              .join(' · '),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      if (prescription.items[i].duration.isNotEmpty) ...[
                        const Gap(2),
                        Text(prescription.items[i].duration,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                      if (prescription.items[i].instructions.isNotEmpty) ...[
                        const Gap(6),
                        Text(prescription.items[i].instructions,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ],
                  ),
                ),
              ),
            const Gap(AppSpacing.lg),
            LoadingFilledButton(
              label: applied
                  ? t.prescriptions.alreadyApplied
                  : t.prescriptions.applyToMedications,
              loading: applying,
              onPressed: applied ? null : onApply,
            ),
          ],
        ),
      ),
    );
  }
}
