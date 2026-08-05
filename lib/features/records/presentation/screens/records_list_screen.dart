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
import 'package:medalize_mb/core/widgets/app_badge.dart';
import 'package:medalize_mb/core/widgets/app_list_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/section_header.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/records/data/models/medical_record_model.dart';
import 'package:medalize_mb/features/records/data/repository/medical_record_repository.dart';
import 'package:medalize_mb/features/records/providers/medical_record_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

const _kTypeOrder = [
  MedicalRecordModel.typeLabResult,
  MedicalRecordModel.typeImaging,
  MedicalRecordModel.typeDocument,
  MedicalRecordModel.typeOther,
];

IconData recordTypeIcon(String type) => switch (type) {
      MedicalRecordModel.typeLabResult => Icons.science_outlined,
      MedicalRecordModel.typeImaging => Icons.image_outlined,
      MedicalRecordModel.typeDocument => Icons.description_outlined,
      _ => Icons.folder_outlined,
    };

String recordTypeLabel(String type) => switch (type) {
      MedicalRecordModel.typeLabResult => t.records.typeLabResult,
      MedicalRecordModel.typeImaging => t.records.typeImaging,
      MedicalRecordModel.typeDocument => t.records.typeDocument,
      _ => t.records.typeOther,
    };

class RecordsListScreen extends ConsumerWidget {
  const RecordsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(medicalRecordsByTypeProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.t.records.title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          context.push('/patient/records/upload');
        },
        tooltip: context.t.records.upload,
        child: const Icon(Icons.add),
      ),
      body: async.when(
        loading: () => const ResponsiveBody(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(children: [
              ShimmerSkeleton(height: 72),
              ShimmerSkeleton(height: 72),
              ShimmerSkeleton(height: 72),
            ]),
          ),
        ),
        error: (_, _) => RefreshableView(
          onRefresh: () async => ref.invalidate(medicalRecordsProvider),
          child: EmptyState(
            icon: Icons.cloud_off_outlined,
            title: context.t.common.somethingWrong,
            subtitle: context.t.common.tryAgain,
            actionLabel: context.t.common.retry,
            onAction: () => ref.invalidate(medicalRecordsProvider),
          ),
        ),
        data: (byType) {
          if (byType.isEmpty) {
            return RefreshableView(
              onRefresh: () async => ref.invalidate(medicalRecordsProvider),
              child: EmptyState(
                icon: Icons.folder_shared_outlined,
                title: context.t.records.empty,
                subtitle: context.t.records.emptySubtitle,
              ),
            );
          }
          final orderedTypes = [
            ..._kTypeOrder.where(byType.containsKey),
            ...byType.keys.where((k) => !_kTypeOrder.contains(k)),
          ];
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(medicalRecordsProvider),
            color: AppColors.primary,
            child: ResponsiveBody(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  for (final type in orderedTypes) ...[
                    SectionHeader(title: recordTypeLabel(type)),
                    const Gap(AppSpacing.sm),
                    for (final record in byType[type]!)
                      AnimatedEntrance(child: _RecordCard(record: record)),
                    const Gap(AppSpacing.md),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RecordCard extends ConsumerWidget {
  const _RecordCard({required this.record});
  final MedicalRecordModel record;

  Future<void> _open(BuildContext context) async {
    if (record.fileUrl.isEmpty) return;
    final uri = Uri.tryParse(record.fileUrl);
    final opened = uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      AppSnackBar.show(context, context.t.records.couldNotOpen, type: SnackBarType.error);
    }
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.t.records.deleteConfirmTitle),
        content: Text(context.t.records.deleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: AppButtonStyles.destructiveFilled,
            child: Text(context.t.common.delete),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await ref.read(medicalRecordRepositoryProvider).deleteRecord(record.id);
      ref.invalidate(medicalRecordsProvider);
      if (context.mounted) {
        AppSnackBar.show(context, context.t.records.deletedSuccess,
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
    final dateFmt = DateFormat('d MMM y');
    return AppListCard(
      icon: recordTypeIcon(record.recordType),
      onTap: () {
        HapticFeedback.lightImpact();
        _open(context);
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, size: 20),
        color: context.colors.textSecondary,
        onPressed: () => _confirmDelete(context, ref),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(record.title,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          if (record.recordDate != null) ...[
            const Gap(2),
            Text(dateFmt.format(record.recordDate!),
                style: Theme.of(context).textTheme.bodySmall),
          ],
          // Records lists stay combined across the account holder and
          // family members — this badge is the only differentiator,
          // and it's absent entirely for the account holder's own.
          if (record.dependent != null) ...[
            const Gap(4),
            AppBadge(
              label: context.t.family.forLabel(name: record.dependent!.fullName),
              color: AppColors.primary,
            ),
          ],
        ],
      ),
    );
  }
}
