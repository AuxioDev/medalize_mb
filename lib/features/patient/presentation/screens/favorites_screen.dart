import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/patient/providers/favorites_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(favoriteDoctorsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.t.favorites.title)),
      body: ResponsiveBody(
        child: async.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                ShimmerSkeleton(height: 88),
                ShimmerSkeleton(height: 88),
                ShimmerSkeleton(height: 88),
              ],
            ),
          ),
          error: (_, _) => RefreshableView(
            onRefresh: () async => ref.invalidate(favoriteDoctorsProvider),
            child: EmptyState(
              icon: Icons.cloud_off_outlined,
              title: context.t.common.somethingWrong,
              subtitle: context.t.common.tryAgain,
              actionLabel: context.t.common.retry,
              onAction: () => ref.invalidate(favoriteDoctorsProvider),
            ),
          ),
          data: (doctors) {
            if (doctors.isEmpty) {
              return RefreshableView(
                onRefresh: () async => ref.invalidate(favoriteDoctorsProvider),
                child: EmptyState(
                  icon: Icons.favorite_border_rounded,
                  title: context.t.favorites.empty,
                  subtitle: context.t.favorites.emptySubtitle,
                  actionLabel: context.t.home.findADoctor,
                  onAction: () => context.push('/patient/doctor-search'),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(favoriteDoctorsProvider),
              color: AppColors.primary,
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: doctors.length,
                itemBuilder: (_, i) => AnimatedEntrance(
                  index: i,
                  child: _FavoriteCard(doctor: doctors[i]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FavoriteCard extends ConsumerWidget {
  const _FavoriteCard({required this.doctor});
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final initials =
        doctor.firstName.isNotEmpty ? doctor.firstName[0].toUpperCase() : 'D';

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/patient/doctor-detail/${doctor.id}', extra: doctor);
      },
      child: Row(
        children: [
          doctor.avatarUrl != null
              ? CachedNetworkImage(
                  imageUrl: doctor.avatarUrl!,
                  imageBuilder: (ctx, imageProvider) => CircleAvatar(
                    radius: 26,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (ctx, _) =>
                      GradientAvatar(initials: initials, size: 52),
                  errorWidget: (ctx, url, _) =>
                      GradientAvatar(initials: initials, size: 52),
                )
              : GradientAvatar(initials: initials, size: 52),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.fullName,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(3),
                Text(
                  doctor.specializationDisplay,
                  style: TextStyle(
                      fontSize: 13,
                      color: c.primaryText,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (doctor.primaryWorkplaceCity != null) ...[
                  const Gap(2),
                  Text(
                    doctor.primaryWorkplaceCity!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            tooltip: context.t.favorites.remove,
            onPressed: () {
              HapticFeedback.selectionClick();
              ref.read(favoritesProvider.notifier).toggle(doctor.id);
            },
            icon: const Icon(Icons.favorite, color: AppColors.error),
          ),
        ],
      ),
    );
  }
}
