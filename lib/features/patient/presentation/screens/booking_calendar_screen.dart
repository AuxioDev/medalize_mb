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
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

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

  // The patient's explicit slot choice, if any. Null means "no explicit
  // choice yet" — the earliest slot in the day's list is used as the
  // default (see `selectedSlot` below), rather than requiring a tap before
  // the booking can proceed.
  DateTime? _pickedStartsAt;

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

    // The default is the earliest slot in the list; `_pickedStartsAt`
    // overrides it once the patient taps a different chip. `firstWhere`'s
    // `orElse` also covers the case where the picked slot just got taken by
    // someone else and vanished from a refreshed list — it quietly falls
    // back to the new earliest slot instead of leaving a dangling selection.
    final slots = slotsAsync?.valueOrNull ?? const <SlotModel>[];
    final selectedSlot = slots.isEmpty
        ? null
        : slots.firstWhere(
            (s) => s.startsAt == _pickedStartsAt,
            orElse: () => slots.first,
          );

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          context.t.booking.bookWith(name: widget.doctor.fullName),
          icon: Icons.calendar_month_outlined,
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
                if (widget.doctor.workplaces.length > 1)
                  SliverToBoxAdapter(
                    child: _WorkplaceSelector(
                      workplaces: widget.doctor.workplaces,
                      selected: _selectedWorkplaceId,
                      onChanged: (v) => setState(() {
                        _selectedWorkplaceId = v;
                        _selectedDay = null;
                        _pickedStartsAt = null;
                      }),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: StyledSlotCalendar(
                    focusedDay: _focusedDay,
                    selectedDay: _selectedDay,
                    onDaySelected: (selected, focused) {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedDay = selected;
                        _focusedDay = focused;
                        _pickedStartsAt = null;
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
                          Expanded(
                            child: Text(
                              DateFormat('EEEE, d MMMM y')
                                  .format(_selectedDay!),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(color: context.colors.primaryText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (selectedSlot != null && _pickedStartsAt == null)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          0,
                          AppSpacing.md,
                          8,
                        ),
                        child: Text(
                          context.t.booking.earliestPreselected,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: context.colors.textSecondary),
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
                              child: SlotChip(
                                time: DateFormat('HH:mm').format(slot.startsAt),
                                selected: slot.startsAt == selectedSlot?.startsAt,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() => _pickedStartsAt = slot.startsAt);
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
      bottomNavigationBar: selectedSlot == null
          ? null
          : BottomActionBar(
              child: LoadingFilledButton(
                label: context.t.booking.continueAt(
                  time: DateFormat('HH:mm').format(selectedSlot.startsAt),
                ),
                onPressed: () {
                  context.push(
                    '/patient/booking-confirm',
                    extra: {
                      'doctor': widget.doctor,
                      'slot': selectedSlot,
                      'workplaceId': _selectedWorkplaceId,
                    },
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
        body: EmptyState(
          icon: Icons.cloud_off_outlined,
          title: context.t.common.somethingWrong,
          subtitle: context.t.common.tryAgain,
          actionLabel: context.t.common.retry,
          onAction: () => ref.invalidate(doctorDetailProvider(doctorId)),
        ),
      ),
      data: (d) => BookingCalendarScreen(doctor: d),
    );
  }
}
