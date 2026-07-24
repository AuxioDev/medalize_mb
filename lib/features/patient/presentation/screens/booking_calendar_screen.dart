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
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendarScreen extends ConsumerStatefulWidget {
  const BookingCalendarScreen({super.key, required this.doctor});
  final DoctorDetailModel doctor;

  @override
  ConsumerState<BookingCalendarScreen> createState() =>
      _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends ConsumerState<BookingCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedWorkplaceId;

  @override
  void initState() {
    super.initState();
    if (widget.doctor.workplaces.isNotEmpty) {
      final primary = widget.doctor.workplaces.firstWhere(
        (w) => w.isPrimary,
        orElse: () => widget.doctor.workplaces.first,
      );
      _selectedWorkplaceId = primary.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final slotsAsync = _selectedDay != null && _selectedWorkplaceId != null
        ? ref.watch(
            slotsProvider(
              SlotsParams(
                doctorId: widget.doctor.id,
                workplaceId: _selectedWorkplaceId!,
                date: _selectedDay!,
              ),
            ),
          )
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.booking.bookWith(name: widget.doctor.fullName)),
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
                if (widget.doctor.workplaces.length > 1)
                  SliverToBoxAdapter(
                    child: _WorkplaceSelector(
                      workplaces: widget.doctor.workplaces,
                      selected: _selectedWorkplaceId,
                      onChanged: (v) => setState(() {
                        _selectedWorkplaceId = v;
                        _selectedDay = null;
                      }),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: _StyledCalendar(
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
                if (_selectedDay != null && _selectedWorkplaceId != null) ...[
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
                            subtitle: context.t.booking.noOpenSlots,
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
                              child: _SlotChip(
                                time: DateFormat('HH:mm').format(slot.startsAt),
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  context.push(
                                    '/patient/booking-confirm',
                                    extra: {
                                      'doctor': widget.doctor,
                                      'slot': slot,
                                      'workplaceId': _selectedWorkplaceId,
                                    },
                                  );
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

class _WorkplaceSelector extends StatelessWidget {
  const _WorkplaceSelector({
    required this.workplaces,
    required this.selected,
    required this.onChanged,
  });

  final List<DoctorWorkplace> workplaces;
  final String? selected;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 12, AppSpacing.md, 0),
      child: DropdownButtonFormField<String>(
        initialValue: selected,
        decoration: InputDecoration(
          labelText: context.t.booking.selectWorkplace,
          prefixIcon: const Icon(Icons.business_outlined, size: 20),
          isDense: true,
        ),
        items: workplaces
            .map((wp) => DropdownMenuItem(value: wp.id, child: Text(wp.name)))
            .toList(),
        onChanged: onChanged,
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
        selectedTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        todayTextStyle: TextStyle(
          color: c.primaryText,
          fontWeight: FontWeight.w600,
        ),
        // Weekends are bookable, so keep them visually neutral (red would read
        // as "unavailable").
        weekendTextStyle: TextStyle(color: c.textPrimary),
        outsideTextStyle: TextStyle(
          color: c.textSecondary.withValues(alpha: 0.4),
        ),
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
          color: c.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        weekendStyle: TextStyle(
          color: c.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
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

/// Wraps [BookingCalendarScreen] to handle cases where the GoRouter [extra]
/// state is unavailable (deep link, app restoration after kill). Falls back to
/// loading the doctor from the API by [doctorId].
class BookingCalendarLoader extends ConsumerWidget {
  const BookingCalendarLoader({super.key, required this.doctorId, this.doctor});

  final String doctorId;
  final DoctorDetailModel? doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (doctor != null) {
      return BookingCalendarScreen(doctor: doctor!);
    }
    final async = ref.watch(doctorDetailProvider(doctorId));
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
        body: Center(child: Text(context.t.common.somethingWrong)),
      ),
      data: (d) => BookingCalendarScreen(doctor: d),
    );
  }
}
