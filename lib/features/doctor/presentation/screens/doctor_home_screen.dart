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
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/greeting_banner.dart';
import 'package:medalize_mb/core/widgets/notification_bell.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/section_header.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/notifications/providers/notification_provider.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';

class DoctorHomeScreen extends ConsumerWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final name = auth is AuthAuthenticated ? auth.email.split('@')[0] : '';
    final unread = ref.watch(unreadCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medalize'),
        actions: [
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
        onRefresh: () async => ref.invalidate(doctorAppointmentsProvider),
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
                  title: 'Hello, Dr. $name!',
                  subtitle: 'Manage your schedule\nand appointments.',
                  avatarText: name,
                ),
              ),
              const Gap(AppSpacing.lg - 4),
              const AnimatedEntrance(
                  index: 1, slideY: 0.08, child: _DoctorQuickActions()),
              const Gap(AppSpacing.lg),
              AnimatedEntrance(
                index: 2,
                child: SectionHeader(
                  title: 'Pending Requests',
                  actionLabel: 'See all',
                  onAction: () => context.push('/doctor/appointments'),
                ),
              ),
              const Gap(AppSpacing.sm),
              const _PendingAppointmentsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorQuickActions extends StatelessWidget {
  const _DoctorQuickActions();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.35,
      children: [
        _ActionCard(
          icon: Icons.calendar_month_outlined,
          label: 'Appointments',
          onTap: () => context.push('/doctor/appointments'),
        ),
        _ActionCard(
          icon: Icons.business_outlined,
          label: 'Workplaces',
          onTap: () => context.push('/doctor/workplaces'),
        ),
        _ActionCard(
          icon: Icons.block_outlined,
          label: 'Block Time',
          onTap: () => context.push('/doctor/block-time'),
        ),
        _ActionCard(
          icon: Icons.person_outline_rounded,
          label: 'Profile',
          onTap: () => context.push('/shared/profile'),
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

class _PendingAppointmentsList extends ConsumerWidget {
  const _PendingAppointmentsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(doctorAppointmentsProvider(null));
    return async.when(
      loading: () => const Column(
        children: [
          ShimmerSkeleton(height: 110),
          ShimmerSkeleton(height: 110),
          ShimmerSkeleton(height: 110),
        ],
      ),
      error: (_, _) => EmptyState(
        icon: Icons.cloud_off_outlined,
        title: 'Something went wrong',
        subtitle: 'Could not load appointments',
        actionLabel: 'Retry',
        onAction: () => ref.invalidate(doctorAppointmentsProvider),
      ),
      data: (all) {
        final pending = all.where((a) => a.status == 'pending').take(5).toList();
        if (pending.isEmpty) {
          return const EmptyState(
            icon: Icons.check_circle_outline,
            title: 'All caught up',
            subtitle: 'No pending appointment requests',
          );
        }
        return Column(
          children: [
            for (int i = 0; i < pending.length; i++)
              AnimatedEntrance(
                index: i,
                child: _PendingCard(
                  appointment: pending[i],
                  onUpdated: () => ref.invalidate(doctorAppointmentsProvider),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _PendingCard extends ConsumerWidget {
  const _PendingCard({required this.appointment, required this.onUpdated});
  final AppointmentModel appointment;
  final VoidCallback onUpdated;

  Future<void> _updateStatus(
      WidgetRef ref, BuildContext context, String status) async {
    try {
      await ref
          .read(appointmentRepositoryProvider)
          .updateAppointmentStatus(appointment.id, status);
      ref.invalidate(doctorAppointmentsProvider);
      onUpdated();
    } on ApiException catch (e) {
      if (context.mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final fmt = DateFormat('d MMM y • HH:mm');
    final patient = appointment.patient;
    final initials = patient.fullName.isNotEmpty ? patient.fullName[0] : 'P';

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/doctor/appointment-detail/${appointment.id}',
            extra: appointment);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GradientAvatar(initials: initials, size: 40),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.fullName,
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(2),
                    Row(
                      children: [
                        Icon(Icons.schedule_outlined,
                            size: 13, color: c.textSecondary),
                        const Gap(4),
                        Text(
                          fmt.format(appointment.startsAt),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StatusChip(status: appointment.status),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _updateStatus(ref, context, 'declined'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: BorderSide(color: AppColors.error.withValues(alpha: 0.5)),
                    minimumSize: const Size(0, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm + 2)),
                  ),
                  child: const Text('Decline'),
                ),
              ),
              const Gap(8),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    _updateStatus(ref, context, 'confirmed');
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm + 2)),
                  ),
                  child: const Text('Confirm'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
