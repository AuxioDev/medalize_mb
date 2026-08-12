import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/utils/share_urls.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_model.dart';
import 'package:medalize_mb/features/hospital/providers/hospital_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/share_profile_sheet.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Patient-facing, read-only view of a hospital/clinic's public registry
/// entry — reached by tapping a workplace card on a doctor's profile, or by
/// opening a shared link/QR code (QR_SHARE_PROFILE_PLAN.md Phase 2). Not to
/// be confused with HospitalProfileScreen, the hospital's own self-service
/// account screen.
class HospitalDetailScreen extends ConsumerWidget {
  const HospitalDetailScreen({super.key, required this.hospitalId});

  final String hospitalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hospitalAsync = ref.watch(publicHospitalProvider(hospitalId));

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          hospitalAsync.asData?.value.name ?? context.t.hospitalDetail.title,
          icon: Icons.apartment_outlined,
        ),
        actions: [
          if (hospitalAsync.hasValue)
            IconButton(
              tooltip: context.t.share.title,
              onPressed: () => showShareProfileSheet(
                context,
                url: ShareUrls.hospital(hospitalId),
                subject: hospitalAsync.value!.name,
              ),
              icon: const Icon(Icons.ios_share_rounded),
            ),
        ],
      ),
      body: ResponsiveBody(
        child: hospitalAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                ShimmerSkeleton(height: 90),
                Gap(12),
                ShimmerSkeleton(height: 60),
              ],
            ),
          ),
          error: (_, _) => EmptyState(
            icon: Icons.cloud_off_outlined,
            title: context.t.hospitalDetail.couldNotLoad,
            subtitle: context.t.common.tryAgain,
            actionLabel: context.t.common.retry,
            onAction: () => ref.invalidate(publicHospitalProvider(hospitalId)),
          ),
          data: (hospital) => _HospitalBody(hospital: hospital),
        ),
      ),
    );
  }
}

class _HospitalBody extends StatelessWidget {
  const _HospitalBody({required this.hospital});

  final HospitalModel hospital;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final locationLine = [
      hospital.address,
      hospital.cityDisplay,
    ].where((s) => s.isNotEmpty).join(', ');

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Logo(hospital: hospital),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospital.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (hospital.cityDisplay.isNotEmpty) ...[
                        const Gap(4),
                        Text(
                          hospital.cityDisplay,
                          style: TextStyle(color: c.textSecondary),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (locationLine.isNotEmpty) ...[
              const Gap(20),
              Text(
                context.t.hospitalDetail.location,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: c.primarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: c.primaryText,
                      size: 20,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        locationLine,
                        style: TextStyle(color: c.primaryText, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            _DoctorsSection(hospitalId: hospital.id),
          ],
        ),
      ),
    );
  }
}

class _DoctorsSection extends ConsumerWidget {
  const _DoctorsSection({required this.hospitalId});
  final String hospitalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorsAsync = ref.watch(publicHospitalDoctorsProvider(hospitalId));
    final doctors = doctorsAsync.asData?.value ?? const <DoctorModel>[];
    // Loading/error/empty all render nothing — this is a secondary section,
    // not worth a skeleton or error state of its own.
    if (doctors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Text(
          context.t.hospitalDetail.doctorsHeading,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Gap(10),
        for (final doctor in doctors) _DoctorRow(doctor),
      ],
    );
  }
}

class _DoctorRow extends StatelessWidget {
  const _DoctorRow(this.doctor);
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final initials = doctor.firstName.isNotEmpty
        ? doctor.firstName[0].toUpperCase()
        : 'D';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: c.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
        border: Border.all(color: c.border, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () =>
            context.push('/patient/doctor-detail/${doctor.id}', extra: doctor),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              doctor.avatarUrl != null
                  ? CachedNetworkImage(
                      imageUrl: doctor.avatarUrl!,
                      imageBuilder: (ctx, imageProvider) => CircleAvatar(
                        radius: 20,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (ctx, _) => CircleAvatar(
                        radius: 20,
                        backgroundColor: c.primarySurface,
                        child: Text(
                          initials,
                          style: TextStyle(color: c.primaryText),
                        ),
                      ),
                      errorWidget: (ctx, url, _) => CircleAvatar(
                        radius: 20,
                        backgroundColor: c.primarySurface,
                        child: Text(
                          initials,
                          style: TextStyle(color: c.primaryText),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 20,
                      backgroundColor: c.primarySurface,
                      child: Text(
                        initials,
                        style: TextStyle(color: c.primaryText),
                      ),
                    ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.fullName,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      doctor.specializationDisplay,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (doctor.averageRating != null) ...[
                Icon(
                  Icons.star_rounded,
                  size: 16,
                  color: Colors.amber.shade600,
                ),
                const Gap(2),
                Text(
                  doctor.averageRating!.toStringAsFixed(1),
                  style: TextStyle(fontSize: 12, color: c.textSecondary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.hospital});
  final HospitalModel hospital;

  @override
  Widget build(BuildContext context) {
    final initial = hospital.name.isNotEmpty
        ? hospital.name[0].toUpperCase()
        : 'H';
    final fallback = Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final logoUrl = hospital.logoUrl;
    if (logoUrl == null) return fallback;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: CachedNetworkImage(
        imageUrl: logoUrl,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
        placeholder: (_, _) => fallback,
        errorWidget: (_, _, _) => fallback,
      ),
    );
  }
}
