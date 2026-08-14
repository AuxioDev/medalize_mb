import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/patient/presentation/widgets/doctor_card.dart';
import 'package:medalize_mb/features/patient/providers/favorites_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(favoriteDoctorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          context.t.favorites.title,
          icon: Icons.favorite_border_rounded,
        ),
      ),
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
                  child: DoctorCard(doctor: doctors[i]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
