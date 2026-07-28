import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/greeting_banner.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/section_header.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/presentation/widgets/link_request_card.dart';
import 'package:medalize_mb/features/hospital/providers/hospital_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class HospitalHomeScreen extends ConsumerWidget {
  const HospitalHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(hospitalProfileProvider);
    final name = profileAsync.valueOrNull?.name ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline_rounded),
            onPressed: () => context.push('/hospital/profile'),
          ),
          const Gap(4),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(hospitalProfileProvider);
          refreshHospitalLinks(ref);
        },
        color: AppColors.primary,
        child: ResponsiveBody(
          child: ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              AnimatedEntrance(
                slideY: 0.08,
                child: GreetingBanner(
                  title: context.t.hospitalHome.greeting(name: name),
                  subtitle: context.t.hospitalHome.subtitle,
                  avatarText: name,
                ),
              ),
              const Gap(AppSpacing.lg - 4),
              AnimatedEntrance(
                index: 1,
                slideY: 0.08,
                child: LayoutBuilder(
                  builder: (context, constraints) => GridView.count(
                    crossAxisCount: ResponsiveBody.columnsFor(constraints.maxWidth),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.35,
                    children: [
                      _ActionCard(
                        icon: Icons.groups_outlined,
                        label: context.t.hospitalHome.doctors,
                        onTap: () => context.push('/hospital/doctors'),
                      ),
                      _ActionCard(
                        icon: Icons.person_add_alt_outlined,
                        label: context.t.hospitalHome.inviteDoctor,
                        onTap: () => context.push('/hospital/invite-doctor'),
                      ),
                      _ActionCard(
                        icon: Icons.calendar_month_outlined,
                        label: context.t.hospitalHome.appointments,
                        onTap: () => context.push('/hospital/appointments'),
                      ),
                      _ActionCard(
                        icon: Icons.apartment_outlined,
                        label: context.t.hospitalHome.profile,
                        onTap: () => context.push('/hospital/profile'),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(AppSpacing.lg),
              AnimatedEntrance(
                index: 2,
                child: SectionHeader(
                  title: context.t.hospitalDoctors.tabRequests,
                  actionLabel: context.t.common.seeAll,
                  onAction: () => context.push('/hospital/doctors'),
                ),
              ),
              const Gap(AppSpacing.sm),
              const _PendingRequestsPreview(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PendingRequestsPreview extends ConsumerWidget {
  const _PendingRequestsPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingAsync = ref.watch(hospitalLinksProvider(HospitalDoctorLinkModel.statusPending));
    return pendingAsync.when(
      loading: () => const Column(children: [
        ShimmerSkeleton(height: 76),
        Gap(10),
        ShimmerSkeleton(height: 76),
      ]),
      error: (_, _) => const SizedBox.shrink(),
      data: (links) {
        if (links.isEmpty) {
          return Text(
            context.t.hospitalDoctors.noRequests,
            style: Theme.of(context).textTheme.bodyMedium,
          );
        }
        final preview = links.take(3);
        return Column(
          children: [
            for (final link in preview) ...[
              LinkRequestCard(
                link: link,
                onApproved: () => refreshHospitalLinks(ref),
                onRejected: () => refreshHospitalLinks(ref),
              ),
              const Gap(8),
            ],
          ],
        );
      },
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const Gap(8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
