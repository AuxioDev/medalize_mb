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
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:table_calendar/table_calendar.dart';

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
        ? ref.watch(slotsProvider(SlotsParams(
            doctorId: widget.appointment.doctor.id,
            workplaceId: _selectedWorkplaceId,
            date: _selectedDay!,
          )))
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(context.t.appointments.rescheduleTitle)),
      body: ResponsiveBody(
        child: Column(
          children: [
            _StyledCalendar(
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
            if (_selectedDay != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, 12, AppSpacing.md, 8),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 14, color: context.colors.primaryText),
                    const Gap(6),
                    Text(
                      DateFormat('EEEE, d MMMM y').format(_selectedDay!),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: context.colors.primaryText),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: slotsAsync!.when(
                  loading: () => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 2.4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        9,
                        (_) => const ShimmerSkeleton(
                          height: double.infinity,
                          margin: EdgeInsets.zero,
                          radius: 10,
                        ),
                      ),
                    ),
                  ),
                  error: (_, _) => EmptyState(
                    icon: Icons.cloud_off_outlined,
                    title: context.t.booking.couldNotLoadSlots,
                    subtitle: context.t.common.tryAgain,
                    actionLabel: context.t.common.retry,
                    onAction: () => ref.invalidate(slotsProvider),
                  ),
                  data: (slots) {
                    if (slots.isEmpty) {
                      return EmptyState(
                        icon: Icons.event_busy_outlined,
                        title: context.t.booking.noAvailableSlots,
                        subtitle: context.t.booking.tryDifferentDate,
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: slots.length,
                      itemBuilder: (_, i) {
                        final slot = slots[i];
                        return AnimatedEntrance(
                          index: i,
                          slideY: 0,
                          child: _SlotChip(
                            time: DateFormat('HH:mm').format(slot.startsAt),
                            onTap: () {
                              HapticFeedback.lightImpact();
                              context.pop(slot.startsAt);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ] else
              Expanded(
                child: EmptyState(
                  icon: Icons.calendar_month_outlined,
                  title: context.t.booking.pickDate,
                  subtitle: context.t.booking.slotsAppear,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StyledCalendar extends StatelessWidget {
  const _StyledCalendar({
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
  });

  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 60)),
      focusedDay: focusedDay,
      selectedDayPredicate: (d) => isSameDay(selectedDay, d),
      onDaySelected: onDaySelected,
      calendarStyle: CalendarStyle(
        selectedDecoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.25),
          shape: BoxShape.circle,
        ),
        selectedTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        todayTextStyle:
            TextStyle(color: c.primaryText, fontWeight: FontWeight.w600),
        weekendTextStyle: TextStyle(color: c.textPrimary),
        outsideTextStyle:
            TextStyle(color: c.textSecondary.withValues(alpha: 0.4)),
        defaultTextStyle: TextStyle(color: c.textPrimary),
        rowDecoration: BoxDecoration(color: c.surface),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: Theme.of(context).textTheme.titleSmall!,
        leftChevronIcon: Icon(Icons.chevron_left, color: c.primaryText),
        rightChevronIcon: Icon(Icons.chevron_right, color: c.primaryText),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
            color: c.textSecondary, fontSize: 12, fontWeight: FontWeight.w500),
        weekendStyle: TextStyle(
            color: c.textSecondary, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _SlotChip extends StatefulWidget {
  const _SlotChip({required this.time, required this.onTap});
  final String time;
  final VoidCallback onTap;

  @override
  State<_SlotChip> createState() => _SlotChipState();
}

class _SlotChipState extends State<_SlotChip> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final scale = _pressed ? 0.95 : 1.0;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(scale, scale, 1),
        decoration: BoxDecoration(
          color: _pressed ? AppColors.primary : c.primarySurface,
          borderRadius: BorderRadius.circular(AppRadius.sm + 2),
          border: Border.all(
            color: AppColors.primary,
            width: _pressed ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(
            widget.time,
            style: TextStyle(
              color: _pressed ? Colors.white : c.primaryText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
