import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/services/medication_scheduler.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/data/repository/medication_repository.dart';
import 'package:medalize_mb/features/medications/providers/medication_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

IconData medicationFormIcon(String form) => switch (form) {
      'pill' => Icons.medication_outlined,
      'capsule' => Icons.medication_liquid_outlined,
      'liquid' => Icons.water_drop_outlined,
      'injection' => Icons.vaccines_outlined,
      _ => Icons.medical_services_outlined,
    };

String medicationFormLabel(String form) => switch (form) {
      'pill' => t.medications.formPill,
      'capsule' => t.medications.formCapsule,
      'liquid' => t.medications.formLiquid,
      'injection' => t.medications.formInjection,
      _ => t.medications.formOther,
    };

class MedicationListScreen extends ConsumerStatefulWidget {
  const MedicationListScreen({super.key});

  @override
  ConsumerState<MedicationListScreen> createState() => _MedicationListScreenState();
}

class _MedicationListScreenState extends ConsumerState<MedicationListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.medications.title),
        bottom: TabBar(
          controller: _tab,
          tabs: [
            Tab(text: context.t.medications.tabActive),
            Tab(text: context.t.medications.tabArchive),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          context.push('/patient/medications/add');
        },
        tooltip: context.t.medications.addMedication,
        child: const Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [
          _MedicationTab(active: true),
          _MedicationTab(active: false),
        ],
      ),
    );
  }
}

class _MedicationTab extends ConsumerWidget {
  const _MedicationTab({required this.active});
  final bool active;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(medicationsProvider);
    return async.when(
      loading: () => const ResponsiveBody(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              ShimmerSkeleton(height: 84),
              ShimmerSkeleton(height: 84),
              ShimmerSkeleton(height: 84),
            ],
          ),
        ),
      ),
      error: (_, _) => RefreshableView(
        onRefresh: () async => ref.invalidate(medicationsProvider),
        child: EmptyState(
          icon: Icons.cloud_off_outlined,
          title: context.t.common.somethingWrong,
          subtitle: context.t.common.tryAgain,
          actionLabel: context.t.common.retry,
          onAction: () => ref.invalidate(medicationsProvider),
        ),
      ),
      data: (all) {
        final items = all.where((m) => m.isActive == active).toList();
        if (items.isEmpty) {
          return RefreshableView(
            onRefresh: () async => ref.invalidate(medicationsProvider),
            child: EmptyState(
              icon: Icons.medication_outlined,
              title: context.t.medications.emptyTitle,
              subtitle: context.t.medications.emptySubtitle,
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(medicationsProvider),
          color: AppColors.primary,
          child: ResponsiveBody(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: items.length,
              itemBuilder: (_, i) => AnimatedEntrance(
                index: i,
                slideY: 0.05,
                child: _MedicationCard(medication: items[i]),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MedicationCard extends ConsumerWidget {
  const _MedicationCard({required this.medication});
  final MedicationModel medication;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.t.medications.deleteConfirmTitle),
        content: Text(context.t.medications.deleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(context.t.common.delete),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await ref.read(medicationRepositoryProvider).deleteMedication(medication.id);
      ref.invalidate(medicationsProvider);
      final remaining = await ref.read(medicationRepositoryProvider).getMedications();
      await ref.read(medicationSchedulerProvider).rescheduleAll(remaining);
      if (context.mounted) {
        AppSnackBar.show(context, context.t.medications.deletedSuccess,
            type: SnackBarType.success);
      }
    } on ApiException catch (e) {
      if (context.mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final times = medication.schedules
        .where((s) => s.isActive)
        .expand((s) => s.times)
        .toList();

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/patient/medications/${medication.id}/edit', extra: medication);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: c.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(medicationFormIcon(medication.form), color: c.primaryText, size: 22),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medication.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                if (medication.dosage.isNotEmpty) ...[
                  const Gap(2),
                  Text(medication.dosage, style: Theme.of(context).textTheme.bodySmall),
                ],
                const Gap(6),
                Text(
                  times.isEmpty
                      ? context.t.medications.noSchedule
                      : times.join(' · '),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: times.isEmpty ? AppColors.warning : c.textSecondary,
                      ),
                ),
                if (medication.isFromPrescription) ...[
                  const Gap(6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: c.primarySurface,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      context.t.medications.fromPrescription,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w600, color: c.primaryText),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (medication.isActive)
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              color: c.textSecondary,
              onPressed: () => _confirmDelete(context, ref),
            ),
        ],
      ),
    );
  }
}
