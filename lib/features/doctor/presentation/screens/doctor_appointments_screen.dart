import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';

class DoctorAppointmentsScreen extends ConsumerStatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  ConsumerState<DoctorAppointmentsScreen> createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState
    extends ConsumerState<DoctorAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  final _scrollControllers = [ScrollController(), ScrollController()];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    for (final c in _scrollControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onTabTap(int index) {
    if (index == _tab.index && !_tab.indexIsChanging) {
      final ctrl = _scrollControllers[index];
      if (ctrl.hasClients) {
        ctrl.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        bottom: TabBar(
          controller: _tab,
          onTap: _onTabTap,
          tabs: const [Tab(text: 'Pending'), Tab(text: 'All')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _DoctorAppList(
            filterFn: (a) => a.status == 'pending',
            showActions: true,
            emptyTitle: 'No pending requests',
            emptySubtitle: 'New appointment requests will appear here',
            scrollController: _scrollControllers[0],
            onRefresh: () => ref.invalidate(doctorAppointmentsProvider),
          ),
          _DoctorAppList(
            filterFn: (_) => true,
            showActions: false,
            emptyTitle: 'No appointments',
            emptySubtitle: 'Your appointments will appear here',
            scrollController: _scrollControllers[1],
            onRefresh: () => ref.invalidate(doctorAppointmentsProvider),
          ),
        ],
      ),
    );
  }
}

class _DoctorAppList extends ConsumerWidget {
  const _DoctorAppList({
    required this.filterFn,
    required this.showActions,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.onRefresh,
    required this.scrollController,
  });

  final bool Function(AppointmentModel) filterFn;
  final bool showActions;
  final String emptyTitle;
  final String emptySubtitle;
  final VoidCallback onRefresh;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(doctorAppointmentsProvider(null));
    return async.when(
      loading: () => const ResponsiveBody(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              ShimmerSkeleton(height: 120),
              ShimmerSkeleton(height: 120),
              ShimmerSkeleton(height: 120),
            ],
          ),
        ),
      ),
      error: (_, _) => RefreshableView(
        onRefresh: () async => onRefresh(),
        child: EmptyState(
          icon: Icons.cloud_off_outlined,
          title: 'Something went wrong',
          subtitle: 'Could not load appointments',
          actionLabel: 'Retry',
          onAction: onRefresh,
        ),
      ),
      data: (all) {
        final items = all.where(filterFn).toList();
        if (items.isEmpty) {
          return RefreshableView(
            onRefresh: () async => onRefresh(),
            child: EmptyState(
              icon: Icons.event_available_outlined,
              title: emptyTitle,
              subtitle: emptySubtitle,
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => onRefresh(),
          color: AppColors.primary,
          child: ResponsiveBody(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(AppSpacing.md),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: items.length,
              itemBuilder: (_, i) => AnimatedEntrance(
                index: i,
                child: _DoctorAppCard(
                  appointment: items[i],
                  showActions: showActions,
                  onUpdated: onRefresh,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DoctorAppCard extends ConsumerWidget {
  const _DoctorAppCard({
    required this.appointment,
    required this.showActions,
    required this.onUpdated,
  });

  final AppointmentModel appointment;
  final bool showActions;
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
          const Gap(8),
          Row(
            children: [
              Icon(Icons.business_outlined, size: 13, color: c.textSecondary),
              const Gap(4),
              Expanded(
                child: Text(
                  appointment.workplace.name,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (appointment.reason.isNotEmpty) ...[
            const Gap(6),
            Text(
              appointment.reason,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (showActions) ...[
            const Gap(12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _updateStatus(ref, context, 'declined'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: BorderSide(
                          color: AppColors.error.withValues(alpha: 0.5)),
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
        ],
      ),
    );
  }
}
