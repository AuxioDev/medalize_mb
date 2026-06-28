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
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// A day-by-day schedule of the doctor's appointments. Reuses the shared
/// doctor-appointments list (loaded once) and filters client-side per day,
/// matching how the home and request screens already work.
class DoctorAgendaScreen extends ConsumerStatefulWidget {
  const DoctorAgendaScreen({super.key});

  @override
  ConsumerState<DoctorAgendaScreen> createState() => _DoctorAgendaScreenState();
}

class _DoctorAgendaScreenState extends ConsumerState<DoctorAgendaScreen> {
  DateTime _selectedDay = _dateOnly(DateTime.now());

  // Statuses that don't belong on a working schedule.
  static const _hidden = {'declined', 'cancelled'};

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(doctorAppointmentsProvider(null));

    // Days (within the visible strip) that have at least one appointment, for
    // the dot indicator.
    final daysWithAppointments = <DateTime>{
      for (final a in async.valueOrNull ?? const <AppointmentModel>[])
        if (!_hidden.contains(a.status)) _dateOnly(a.startsAt),
    };

    return Scaffold(
      appBar: AppBar(title: Text(context.t.agenda.title)),
      body: ResponsiveBody(
        child: Column(
          children: [
            _DateStrip(
              selected: _selectedDay,
              daysWithAppointments: daysWithAppointments,
              onSelect: (d) {
                HapticFeedback.selectionClick();
                setState(() => _selectedDay = d);
              },
            ),
            _DayHeader(day: _selectedDay),
            Expanded(
              child: async.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      ShimmerSkeleton(height: 84),
                      ShimmerSkeleton(height: 84),
                      ShimmerSkeleton(height: 84),
                    ],
                  ),
                ),
                error: (_, _) => RefreshableView(
                  onRefresh: () async =>
                      ref.invalidate(doctorAppointmentsProvider),
                  child: EmptyState(
                    icon: Icons.cloud_off_outlined,
                    title: context.t.common.somethingWrong,
                    subtitle: context.t.appointments.couldNotLoad,
                    actionLabel: context.t.common.retry,
                    onAction: () => ref.invalidate(doctorAppointmentsProvider),
                  ),
                ),
                data: (all) {
                  final items = all
                      .where((a) =>
                          !_hidden.contains(a.status) &&
                          _sameDay(a.startsAt, _selectedDay))
                      .toList()
                    ..sort((a, b) => a.startsAt.compareTo(b.startsAt));

                  if (items.isEmpty) {
                    return RefreshableView(
                      onRefresh: () async =>
                          ref.invalidate(doctorAppointmentsProvider),
                      child: EmptyState(
                        icon: Icons.event_available_outlined,
                        title: context.t.agenda.empty,
                        subtitle: context.t.agenda.emptySubtitle,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async =>
                        ref.invalidate(doctorAppointmentsProvider),
                    color: AppColors.primary,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md, 4, AppSpacing.md, AppSpacing.md),
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: items.length,
                      itemBuilder: (_, i) => AnimatedEntrance(
                        index: i,
                        child: _AgendaCard(appointment: items[i]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateStrip extends StatelessWidget {
  const _DateStrip({
    required this.selected,
    required this.daysWithAppointments,
    required this.onSelect,
  });

  final DateTime selected;
  final Set<DateTime> daysWithAppointments;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    final today = _dateOnly(DateTime.now());
    final days = List.generate(14, (i) => today.add(Duration(days: i)));
    return SizedBox(
      height: 78,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(AppSpacing.md, 10, AppSpacing.md, 8),
        itemCount: days.length,
        separatorBuilder: (_, _) => const Gap(8),
        itemBuilder: (_, i) {
          final day = days[i];
          return _DateChip(
            day: day,
            selected: _sameDay(day, selected),
            hasAppointments: daysWithAppointments.contains(day),
            onTap: () => onSelect(day),
          );
        },
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({
    required this.day,
    required this.selected,
    required this.hasAppointments,
    required this.onTap,
  });

  final DateTime day;
  final bool selected;
  final bool hasAppointments;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final weekday = DateFormat('E').format(day);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 52,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : c.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: selected ? AppColors.primary : c.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday,
              style: TextStyle(
                fontSize: 11,
                color: selected ? Colors.white70 : c.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(2),
            Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 16,
                color: selected ? Colors.white : c.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(4),
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasAppointments
                    ? (selected ? Colors.white : AppColors.primary)
                    : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.day});
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final isToday = _sameDay(day, DateTime.now());
    final label = isToday
        ? '${context.t.agenda.today} • ${DateFormat('d MMMM').format(day)}'
        : DateFormat('EEEE, d MMMM').format(day);
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 4, AppSpacing.md, 8),
      child: Row(
        children: [
          Icon(Icons.calendar_today_outlined,
              size: 14, color: context.colors.primaryText),
          const Gap(6),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: context.colors.primaryText),
          ),
        ],
      ),
    );
  }
}

class _AgendaCard extends StatelessWidget {
  const _AgendaCard({required this.appointment});
  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final timeFmt = DateFormat('HH:mm');
    final patient = appointment.patient;
    final initials = patient.fullName.isNotEmpty ? patient.fullName[0] : 'P';

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/doctor/appointment-detail/${appointment.id}',
            extra: appointment);
      },
      child: Row(
        children: [
          // Time column.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                timeFmt.format(appointment.startsAt),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                timeFmt.format(appointment.endsAt),
                style: TextStyle(fontSize: 11, color: c.textSecondary),
              ),
            ],
          ),
          const Gap(12),
          Container(width: 1, height: 38, color: c.border),
          const Gap(12),
          GradientAvatar(initials: initials, size: 36),
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
                    Icon(Icons.business_outlined,
                        size: 12, color: c.textSecondary),
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
