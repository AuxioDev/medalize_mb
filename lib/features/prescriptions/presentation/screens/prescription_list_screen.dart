import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_list_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/providers/prescription_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class PrescriptionListScreen extends ConsumerWidget {
  const PrescriptionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(patientPrescriptionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          context.t.prescriptions.title,
          icon: Icons.description_outlined,
        ),
      ),
      body: async.when(
        loading: () => const ResponsiveBody(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                ShimmerSkeleton(height: 90),
                ShimmerSkeleton(height: 90),
                ShimmerSkeleton(height: 90),
              ],
            ),
          ),
        ),
        error: (_, _) => RefreshableView(
          onRefresh: () async => ref.invalidate(patientPrescriptionsProvider),
          child: EmptyState(
            icon: Icons.cloud_off_outlined,
            title: context.t.common.somethingWrong,
            subtitle: context.t.common.tryAgain,
            actionLabel: context.t.common.retry,
            onAction: () => ref.invalidate(patientPrescriptionsProvider),
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return RefreshableView(
              onRefresh: () async => ref.invalidate(patientPrescriptionsProvider),
              child: EmptyState(
                icon: Icons.receipt_long_outlined,
                title: context.t.prescriptions.empty,
                subtitle: context.t.prescriptions.emptySubtitle,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(patientPrescriptionsProvider),
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
                  child: _PrescriptionCard(prescription: items[i]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard({required this.prescription});
  final PrescriptionModel prescription;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final dateFmt = DateFormat('d MMM y');
    return AppListCard(
      icon: Icons.receipt_long_outlined,
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/patient/prescriptions/${prescription.id}');
      },
      trailing: Icon(Icons.chevron_right, color: c.textSecondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.t.prescriptions.issuedBy(name: prescription.doctorName),
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(2),
          Text(
            context.t.prescriptions.itemsCount(count: prescription.items.length),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Gap(2),
          Text(dateFmt.format(prescription.issuedAt),
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
