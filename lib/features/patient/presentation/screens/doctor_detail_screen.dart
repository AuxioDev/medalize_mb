import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';

class DoctorDetailScreen extends ConsumerWidget {
  const DoctorDetailScreen({super.key, required this.doctorId, this.doctor});

  final String doctorId;
  final DoctorModel? doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(doctorDetailProvider(doctorId));

    return Scaffold(
      body: detailAsync.when(
        loading: () => _LoadingSkeleton(doctorId: doctorId),
        error: (_, _) => Scaffold(
          appBar: AppBar(title: Text(doctor?.fullName ?? 'Doctor Profile')),
          body: EmptyState(
            icon: Icons.cloud_off_outlined,
            title: 'Could not load profile',
            subtitle: 'Please try again',
            actionLabel: 'Retry',
            onAction: () => ref.invalidate(doctorDetailProvider(doctorId)),
          ),
        ),
        data: (detail) => _DetailBody(doctorId: doctorId, detail: detail),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.doctorId, required this.detail});

  final String doctorId;
  final DoctorDetailModel detail;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final initials =
        detail.firstName.isNotEmpty ? detail.firstName[0].toUpperCase() : 'D';

    return Scaffold(
      appBar: AppBar(title: Text(detail.fullName)),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileHeader(doctorId: doctorId, initials: initials, detail: detail),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (detail.bio.isNotEmpty) ...[
                      AnimatedEntrance(
                        index: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About',
                                style: Theme.of(context).textTheme.titleSmall),
                            const Gap(10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: c.primarySurface,
                                borderRadius: BorderRadius.circular(AppRadius.md),
                              ),
                              child: Text(
                                detail.bio,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: c.textPrimary,
                                      height: 1.5,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                    ],
                    if (detail.workplaces.isNotEmpty) ...[
                      AnimatedEntrance(
                        index: 1,
                        child: Text('Workplaces',
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                      const Gap(10),
                      for (int i = 0; i < detail.workplaces.length; i++)
                        AnimatedEntrance(
                          index: 2 + i,
                          child: _WorkplaceCard(detail.workplaces[i]),
                        ),
                    ],
                    const Gap(80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: LoadingFilledButton(
          label: 'Book Appointment',
          onPressed: () {
            HapticFeedback.lightImpact();
            context.push('/patient/booking-calendar/${detail.id}', extra: detail);
          },
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.doctorId,
    required this.initials,
    required this.detail,
  });

  final String doctorId;
  final String initials;
  final DoctorDetailModel detail;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg - 4),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(bottom: BorderSide(color: c.border, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'doctor-avatar-$doctorId',
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(detail.fullName, style: Theme.of(context).textTheme.titleLarge),
                const Gap(4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: c.primarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  child: Text(
                    detail.specializationDisplay,
                    style: TextStyle(
                      color: c.primaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Gap(6),
                Row(
                  children: [
                    Icon(Icons.schedule_outlined,
                        size: 13, color: c.textSecondary),
                    const Gap(4),
                    Text(
                      '${detail.slotDurationMin} min per slot',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkplaceCard extends StatelessWidget {
  const _WorkplaceCard(this.wp);
  final DoctorWorkplace wp;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
        border: Border.all(color: c.border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: c.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.sm + 2),
            ),
            child: Icon(Icons.location_on_outlined,
                color: c.primaryText, size: 20),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        wp.name,
                        style: Theme.of(context).textTheme.labelMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (wp.isPrimary) ...[
                      const Gap(8),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppRadius.xl),
                        ),
                        child: const Text(
                          'Primary',
                          style: TextStyle(
                            color: AppColors.success,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const Gap(2),
                Text(
                  '${wp.address}, ${wp.city}',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton({required this.doctorId});
  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Profile')),
      body: ResponsiveBody(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  ShimmerSkeleton(
                      height: 70, width: 70, radius: 35, margin: EdgeInsets.zero),
                  Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerSkeleton(
                            height: 20,
                            width: 160,
                            margin: EdgeInsets.only(bottom: 8)),
                        ShimmerSkeleton(
                            height: 14, width: 120, margin: EdgeInsets.zero),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(24),
              const ShimmerSkeleton(height: 80),
              const ShimmerSkeleton(height: 80),
              const ShimmerSkeleton(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
