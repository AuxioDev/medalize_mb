import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/hospital/providers/hospital_provider.dart';
import 'package:medalize_mb/features/subscription/providers/subscription_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class HospitalProfileScreen extends ConsumerWidget {
  const HospitalProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(hospitalProfileProvider);
    final subscriptionAsync = ref.watch(subscriptionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.t.hospitalProfile.title)),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(hospitalProfileProvider);
          ref.invalidate(subscriptionProvider);
        },
        color: AppColors.primary,
        child: ResponsiveBody(
          child: profileAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(children: [
                ShimmerSkeleton(height: 140),
                Gap(12),
                ShimmerSkeleton(height: 90),
              ]),
            ),
            error: (_, _) => Center(
              child: EmptyState(
                icon: Icons.cloud_off_outlined,
                title: context.t.common.somethingWrong,
                subtitle: context.t.common.tryAgain,
                actionLabel: context.t.common.retry,
                onAction: () => ref.invalidate(hospitalProfileProvider),
              ),
            ),
            data: (profile) {
              final c = context.colors;
              return ListView(
                physics:
                    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700)),
                        const Gap(4),
                        if (profile.address.isNotEmpty)
                          Text(profile.address, style: TextStyle(color: c.textSecondary)),
                        if (profile.cityDisplay.isNotEmpty)
                          Text(profile.cityDisplay, style: TextStyle(color: c.textSecondary)),
                        if (profile.phone.isNotEmpty) ...[
                          const Gap(8),
                          Row(children: [
                            Icon(Icons.phone_outlined, size: 16, color: c.textSecondary),
                            const Gap(6),
                            Text(profile.phone, style: TextStyle(color: c.textSecondary)),
                          ]),
                        ],
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.t.subscription.title,
                            style: Theme.of(context).textTheme.titleSmall),
                        const Gap(8),
                        subscriptionAsync.when(
                          loading: () => const ShimmerSkeleton(height: 20),
                          error: (_, _) => const SizedBox.shrink(),
                          data: (sub) {
                            final limit = sub.limits.doctors;
                            final count = sub.usage?.doctors ?? 0;
                            return Text(
                              limit == null
                                  ? context.t.hospitalProfile
                                      .usageDoctorsUnlimited(count: count)
                                  : context.t.hospitalProfile
                                      .usageDoctors(count: count, limit: limit),
                              style: TextStyle(color: c.textSecondary),
                            );
                          },
                        ),
                        const Gap(12),
                        LoadingFilledButton(
                          label: context.t.hospitalProfile.manageSubscription,
                          loading: false,
                          onPressed: () =>
                              context.push('/hospital/subscription', extra: true),
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  TextButton(
                    onPressed: () => ref.read(authProvider.notifier).logout(),
                    child: Text(context.t.common.signOut),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
