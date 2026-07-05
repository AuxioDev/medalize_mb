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
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/greeting_banner.dart';
import 'package:medalize_mb/core/widgets/notification_bell.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/section_header.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/doctors/data/repository/doctor_repository.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/notifications/providers/notification_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class PatientHomeScreen extends ConsumerWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final name = auth is AuthAuthenticated ? auth.displayName : '';
    final unread = ref.watch(unreadCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.appName),
        actions: [
          IconButton(
            tooltip: context.t.favorites.title,
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () => context.push('/patient/favorites'),
          ),
          NotificationBell(
            count: unread,
            onTap: () => context.push('/shared/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/shared/settings'),
          ),
          const Gap(4),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(patientAppointmentsProvider),
        color: AppColors.primary,
        child: ResponsiveBody(
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              AnimatedEntrance(
                slideY: 0.08,
                child: GreetingBanner(
                  title: context.t.home.helloPatient(name: name),
                  subtitle: context.t.home.patientSubtitle,
                  avatarText: name,
                ),
              ),
              const Gap(AppSpacing.lg - 4),
              const AnimatedEntrance(index: 1, slideY: 0.08, child: _QuickActionsRow()),
              const Gap(AppSpacing.lg),
              AnimatedEntrance(
                index: 2,
                child: SectionHeader(
                  title: context.t.home.upcoming,
                  actionLabel: context.t.common.seeAll,
                  onAction: () => context.push('/patient/appointments'),
                ),
              ),
              const Gap(AppSpacing.sm),
              const _UpcomingAppointments(),
              const _WaitlistSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            icon: Icons.search_rounded,
            label: context.t.home.findDoctor,
            onTap: () => context.push('/patient/doctor-search'),
          ),
        ),
        const Gap(12),
        Expanded(
          child: _ActionCard(
            icon: Icons.calendar_month_outlined,
            label: context.t.home.myAppointments,
            onTap: () => context.push('/patient/appointments'),
          ),
        ),
        const Gap(12),
        Expanded(
          child: _ActionCard(
            icon: Icons.smart_toy_outlined,
            label: context.t.home.aiAssistant,
            onTap: () => context.push('/patient/assistant'),
          ),
        ),
      ],
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
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppRadius.md + 2),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const Gap(10),
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

class _UpcomingAppointments extends ConsumerWidget {
  const _UpcomingAppointments();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(patientAppointmentsProvider(null));
    return async.when(
      loading: () => const Column(
        children: [
          ShimmerSkeleton(height: 80),
          ShimmerSkeleton(height: 80),
        ],
      ),
      error: (_, _) => EmptyState(
        icon: Icons.cloud_off_outlined,
        title: context.t.common.somethingWrong,
        subtitle: context.t.home.couldNotLoadAppointments,
        actionLabel: context.t.common.retry,
        onAction: () => ref.invalidate(patientAppointmentsProvider),
      ),
      data: (all) {
        final upcoming = all.where((a) => a.isUpcoming).take(3).toList();
        if (upcoming.isEmpty) {
          return EmptyState(
            icon: Icons.calendar_today_outlined,
            title: context.t.home.noUpcoming,
            subtitle: context.t.home.bookFirst,
            actionLabel: context.t.home.findADoctor,
            onAction: () => context.push('/patient/doctor-search'),
          );
        }
        return Column(
          children: [
            for (int i = 0; i < upcoming.length; i++)
              AnimatedEntrance(
                index: i,
                child: _MiniAppointmentCard(upcoming[i]),
              ),
          ],
        );
      },
    );
  }
}

class _MiniAppointmentCard extends StatelessWidget {
  const _MiniAppointmentCard(this.appt);
  final AppointmentModel appt;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final date = appt.startsAt;
    final dayFmt = DateFormat('d');
    final monthFmt = DateFormat('MMM');
    final timeFmt = DateFormat('HH:mm');

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/patient/appointment-detail/${appt.id}', extra: appt);
      },
      child: Row(
        children: [
          Container(
            width: 48,
            height: 56,
            decoration: BoxDecoration(
              color: c.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.sm + 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayFmt.format(date),
                  style: TextStyle(
                    color: c.primaryText,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                Text(
                  monthFmt.format(date),
                  style: TextStyle(
                    color: c.primaryText,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appt.doctor.fullName,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(3),
                Text(
                  timeFmt.format(date),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          StatusChip(status: appt.status),
        ],
      ),
    );
  }
}

class _WaitlistSection extends ConsumerWidget {
  const _WaitlistSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waitlistAsync = ref.watch(myWaitlistProvider);
    final entries = waitlistAsync.asData?.value ?? [];
    if (entries.isEmpty) return const SizedBox.shrink();
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(AppSpacing.lg),
        AnimatedEntrance(
          index: 3,
          child: SectionHeader(title: context.t.home.myWaitlist, actionLabel: null, onAction: null),
        ),
        const Gap(AppSpacing.sm),
        for (final entry in entries)
          AnimatedEntrance(
            index: 4,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: c.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.md + 2),
                border: Border.all(color: c.border),
              ),
              child: Row(
                children: [
                  Icon(Icons.notifications_active_outlined,
                      size: 20, color: c.primaryText),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      entry.doctorName.isEmpty
                          ? context.t.common.doctor
                          : entry.doctorName,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await ref.read(doctorRepositoryProvider).leaveWaitlist(entry.id);
                      ref.invalidate(myWaitlistProvider);
                    },
                    style: TextButton.styleFrom(foregroundColor: AppColors.error),
                    child: Text(context.t.home.leaveWaitlist),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
