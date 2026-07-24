import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/section_header.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/data/repository/medication_repository.dart';
import 'package:medalize_mb/features/medications/presentation/screens/medication_list_screen.dart';
import 'package:medalize_mb/features/medications/providers/medication_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// "Today's Doses" card shown on the patient home screen: the nearest 1-3
/// dose slots for today, each with a quick taken/skip action. Renders nothing
/// when the patient has no doses scheduled today (nothing tracked yet, or a
/// day with no configured reminder times) — this keeps the home screen quiet
/// until medications are actually set up.
class TodaysDosesSection extends ConsumerWidget {
  const TodaysDosesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(todaysDosesProvider);
    final doses = async.asData?.value ?? const <TodayDose>[];
    if (doses.isEmpty) return const SizedBox.shrink();
    final shown = doses.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(AppSpacing.lg),
        AnimatedEntrance(
          child: SectionHeader(
            title: context.t.medications.todaysDoses,
            actionLabel: context.t.common.seeAll,
            onAction: () => context.push('/patient/medications'),
          ),
        ),
        const Gap(AppSpacing.sm),
        for (int i = 0; i < shown.length; i++)
          AnimatedEntrance(index: i, child: _DoseRow(dose: shown[i])),
      ],
    );
  }
}

class _DoseRow extends ConsumerStatefulWidget {
  const _DoseRow({required this.dose});
  final TodayDose dose;

  @override
  ConsumerState<_DoseRow> createState() => _DoseRowState();
}

class _DoseRowState extends ConsumerState<_DoseRow> {
  bool _submitting = false;

  Future<void> _log(String status) async {
    setState(() => _submitting = true);
    try {
      await ref.read(medicationRepositoryProvider).logDose(
            widget.dose.schedule.id,
            widget.dose.scheduledAt,
            status,
          );
      ref.invalidate(todaysDoseLogsProvider);
    } on ApiException catch (e) {
      if (mounted) AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final dose = widget.dose;
    final timeFmt = DateFormat('HH:mm');

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: c.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(medicationFormIcon(dose.medication.form),
                color: c.primaryText, size: 20),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dose.medication.name,
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const Gap(2),
                Text(timeFmt.format(dose.scheduledAt),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          if (_submitting)
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else if (!dose.isPending)
            Text(
              dose.status == DoseLogModel.statusTaken
                  ? context.t.medications.statusTaken
                  : context.t.medications.statusSkipped,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: dose.status == DoseLogModel.statusTaken
                    ? AppColors.success
                    : c.textSecondary,
              ),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: context.t.medications.markSkipped,
                  icon: const Icon(Icons.close_rounded),
                  color: c.textSecondary,
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    _log(DoseLogModel.statusSkipped);
                  },
                ),
                IconButton(
                  tooltip: context.t.medications.markTaken,
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  color: AppColors.success,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    _log(DoseLogModel.statusTaken);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
