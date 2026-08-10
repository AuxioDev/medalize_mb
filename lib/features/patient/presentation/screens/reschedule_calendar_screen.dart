import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/calendar/slot_chip.dart';
import 'package:medalize_mb/core/widgets/calendar/styled_slot_calendar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class RescheduleCalendarScreen extends ConsumerStatefulWidget {
  const RescheduleCalendarScreen({super.key, required this.appointment});
  final AppointmentModel appointment;

  @override
  ConsumerState<RescheduleCalendarScreen> createState() =>
      _RescheduleCalendarScreenState();
}

class _RescheduleCalendarScreenState
    extends ConsumerState<RescheduleCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late String _selectedWorkplaceId;

  @override
  void initState() {
    super.initState();
    _selectedWorkplaceId = widget.appointment.workplace.id;
  }

  @override
  Widget build(BuildContext context) {
    final slotsAsync = _selectedDay != null
        ? ref.watch(
            slotsProvider(
              SlotsParams(
                doctorId: widget.appointment.doctor.id,
                workplaceId: _selectedWorkplaceId,
                date: _selectedDay!,
              ),
            ),
          )
        : null;

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          context.t.appointments.rescheduleTitle,
          icon: Icons.event_repeat_outlined,
        ),
      ),
      body: ResponsiveBody(
        // A CustomScrollView (rather than a fixed Column with an Expanded
        // slot grid) lets the whole screen scroll on short devices, since
        // the calendar's own intrinsic height varies and can otherwise push
        // the slot grid/CTA past the bottom of the viewport.
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = ResponsiveBody.columnsFor(
              constraints.maxWidth,
              minTileWidth: 100,
            );
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: StyledSlotCalendar(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    onDaySelected: (selected, focused) {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedDay = selected;
                        _focusedDay = focused;
                      });
                    },
                  ),
                ),
                if (_selectedDay != null) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        12,
                        AppSpacing.md,
                        8,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: context.colors.primaryText,
                          ),
                          const Gap(6),
                          Text(
                            DateFormat('EEEE, d MMMM y').format(_selectedDay!),
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: context.colors.primaryText),
                          ),
                        ],
                      ),
                    ),
                  ),
                  slotsAsync!.when(
                    loading: () => SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 2.4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (_, _) => const ShimmerSkeleton(
                            height: double.infinity,
                            margin: EdgeInsets.zero,
                            radius: 10,
                          ),
                          childCount: 9,
                        ),
                      ),
                    ),
                    error: (_, _) => SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyState(
                        icon: Icons.cloud_off_outlined,
                        title: context.t.booking.couldNotLoadSlots,
                        subtitle: context.t.common.tryAgain,
                        actionLabel: context.t.common.retry,
                        onAction: () => ref.invalidate(slotsProvider),
                      ),
                    ),
                    data: (slots) {
                      if (slots.isEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyState(
                            icon: Icons.event_busy_outlined,
                            title: context.t.booking.noAvailableSlots,
                            subtitle: context.t.booking.tryDifferentDate,
                          ),
                        );
                      }
                      return SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          0,
                          AppSpacing.md,
                          AppSpacing.md,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: 2.4,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          delegate: SliverChildBuilderDelegate((_, i) {
                            final slot = slots[i];
                            return AnimatedEntrance(
                              index: i,
                              slideY: 0,
                              child: SlotChip(
                                time: DateFormat('HH:mm').format(slot.startsAt),
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  context.pop(slot.startsAt);
                                },
                              ),
                            );
                          }, childCount: slots.length),
                        ),
                      );
                    },
                  ),
                ] else
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyState(
                      icon: Icons.calendar_month_outlined,
                      title: context.t.booking.pickDate,
                      subtitle: context.t.booking.slotsAppear,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Wraps [RescheduleCalendarScreen] to handle cases where the GoRouter [extra]
/// state is unavailable (deep link, app restoration after kill). Falls back to
/// loading the appointment from the API by [appointmentId].
class RescheduleCalendarLoader extends ConsumerWidget {
  const RescheduleCalendarLoader({
    super.key,
    required this.appointmentId,
    this.appointment,
  });

  final String appointmentId;
  final AppointmentModel? appointment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (appointment != null) {
      return RescheduleCalendarScreen(appointment: appointment!);
    }
    final async = ref.watch(appointmentByIdProvider(appointmentId));
    return async.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              ShimmerSkeleton(height: 64),
              ShimmerSkeleton(height: 120),
              ShimmerSkeleton(height: 120),
              ShimmerSkeleton(height: 80),
            ],
          ),
        ),
      ),
      error: (_, _) => Scaffold(
        appBar: AppBar(),
        body: EmptyState(
          icon: Icons.cloud_off_outlined,
          title: context.t.common.somethingWrong,
          subtitle: context.t.appointments.couldNotLoad,
          actionLabel: context.t.common.retry,
          onAction: () => ref.invalidate(appointmentByIdProvider(appointmentId)),
        ),
      ),
      data: (appt) => RescheduleCalendarScreen(appointment: appt),
    );
  }
}
