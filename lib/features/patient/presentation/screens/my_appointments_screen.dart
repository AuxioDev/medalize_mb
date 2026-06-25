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
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';

class MyAppointmentsScreen extends ConsumerStatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  ConsumerState<MyAppointmentsScreen> createState() =>
      _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends ConsumerState<MyAppointmentsScreen>
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
        title: const Text('My Appointments'),
        bottom: TabBar(
          controller: _tab,
          onTap: _onTabTap,
          tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Past')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _AppointmentList(
            filterFn: (a) => a.isUpcoming,
            emptyTitle: 'No upcoming appointments',
            emptySubtitle: 'Book your first appointment with a doctor',
            scrollController: _scrollControllers[0],
            onRefresh: () => ref.refresh(patientAppointmentsProvider(null)),
          ),
          _AppointmentList(
            filterFn: (a) => !a.isUpcoming,
            emptyTitle: 'No past appointments',
            emptySubtitle: 'Completed and cancelled appointments appear here',
            scrollController: _scrollControllers[1],
            onRefresh: () => ref.refresh(patientAppointmentsProvider(null)),
          ),
        ],
      ),
    );
  }
}

class _AppointmentList extends ConsumerWidget {
  const _AppointmentList({
    required this.filterFn,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.onRefresh,
    required this.scrollController,
  });

  final bool Function(AppointmentModel) filterFn;
  final String emptyTitle;
  final String emptySubtitle;
  final VoidCallback onRefresh;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(patientAppointmentsProvider(null));
    return async.when(
      loading: () => const ResponsiveBody(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              ShimmerSkeleton(height: 90),
              ShimmerSkeleton(height: 90),
              ShimmerSkeleton(height: 90),
              ShimmerSkeleton(height: 90),
            ],
          ),
        ),
      ),
      error: (_, _) => EmptyState(
        icon: Icons.cloud_off_outlined,
        title: 'Something went wrong',
        subtitle: 'Could not load appointments',
        actionLabel: 'Retry',
        onAction: onRefresh,
      ),
      data: (all) {
        final items = all.where(filterFn).toList();
        if (items.isEmpty) {
          return EmptyState(
            icon: Icons.calendar_today_outlined,
            title: emptyTitle,
            subtitle: emptySubtitle,
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
                slideY: 0.05,
                child: _AppointmentCard(appointment: items[i]),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard({required this.appointment});
  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final date = appointment.startsAt;
    final dayFmt = DateFormat('d');
    final monthFmt = DateFormat('MMM');
    final timeFmt = DateFormat('HH:mm');

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push(
          '/patient/appointment-detail/${appointment.id}',
          extra: appointment,
        );
      },
      child: Row(
        children: [
          Container(
            width: 50,
            height: 58,
            decoration: BoxDecoration(
              color: c.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayFmt.format(date),
                  style: TextStyle(
                    color: c.primaryText,
                    fontSize: 20,
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
                  appointment.doctor.fullName,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(
                  appointment.workplace.name,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Row(
                  children: [
                    Icon(Icons.schedule_outlined,
                        size: 12, color: c.textSecondary),
                    const Gap(3),
                    Text(
                      timeFmt.format(date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(8),
          StatusChip(status: appointment.status),
        ],
      ),
    );
  }
}
