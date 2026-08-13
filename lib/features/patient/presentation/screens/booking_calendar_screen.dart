import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/services/navigator_key.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_chip.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/calendar/slot_chip.dart';
import 'package:medalize_mb/core/widgets/calendar/styled_slot_calendar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/profile_switcher.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/appointments/data/models/booking_request.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/features/payments/data/repository/payment_repository.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class BookingCalendarScreen extends ConsumerStatefulWidget {
  const BookingCalendarScreen({
    super.key,
    required this.doctor,
    this.initialWorkplaceId,
  });
  final DoctorDetailModel doctor;

  /// Preselects a workplace other than the primary — used when arriving via
  /// "book again" or the home screen's quick-book card, both of which know
  /// which workplace the patient was seen at before.
  final String? initialWorkplaceId;

  @override
  ConsumerState<BookingCalendarScreen> createState() =>
      _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends ConsumerState<BookingCalendarScreen> {
  // Null until the patient explicitly taps a day; the build method then
  // falls back to the doctor's nearest available date so the calendar opens
  // ready to book instead of on "today" with no slots shown.
  DateTime? _focusedDay;
  DateTime? _selectedDay;
  String? _selectedWorkplaceId;

  // The patient's explicit slot choice, if any. Null means "no explicit
  // choice yet" — the earliest slot in the day's list is used as the
  // default (see `selectedSlot` below), rather than requiring a tap before
  // the booking can proceed.
  DateTime? _pickedStartsAt;

  // Booking-confirmation state — this screen used to hand off to a separate
  // BookingConfirmScreen once a slot was picked; that hop (and its own
  // "Continue" tap) is gone, folded into the bottom of this one instead.
  final _reasonController = TextEditingController();
  bool _loading = false;
  String? _error;

  // (workplaceId, yyyy-MM-dd) of the day last prefetched for — guards
  // against re-issuing the same prefetch on every rebuild (e.g. while the
  // patient types in the reason field). Riverpod itself would dedupe the
  // network call anyway, but this skips the redundant `ref.read` entirely.
  (String, String)? _prefetchedFor;

  @override
  void initState() {
    super.initState();
    if (widget.doctor.workplaces.isNotEmpty) {
      // An explicit initialWorkplaceId (rebook / quick-book) wins as long as
      // it's actually one of this doctor's workplaces; otherwise fall back
      // to the usual primary/first default.
      final requested = widget.initialWorkplaceId;
      final hasRequested =
          requested != null && widget.doctor.workplaces.any((w) => w.id == requested);
      _selectedWorkplaceId = hasRequested
          ? requested
          : widget.doctor.workplaces
              .firstWhere((w) => w.isPrimary, orElse: () => widget.doctor.workplaces.first)
              .id;
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _confirm(SlotModel slot) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final repo = ref.read(appointmentRepositoryProvider);
      final appointment = await repo.bookAppointment(BookingRequest(
        doctorId: widget.doctor.id,
        workplaceId: _selectedWorkplaceId!,
        startsAt: slot.startsAt,
        reason: _reasonController.text.trim(),
        dependentId: ref.read(activeProfileProvider)?.id,
      ));
      // Refresh the patient's appointment lists so the new booking shows up,
      // and the slot availability so the just-booked slot disappears.
      ref.invalidate(patientAppointmentsProvider);
      ref.invalidate(slotsProvider);

      // Payment is optional and never blocks booking success: attempt to
      // create one, but a 503 (Payriff not configured in this environment —
      // the current default) or any other failure just means no "Pay now"
      // action appears. The success snackbar below renders identically
      // either way.
      var paymentAvailable = false;
      try {
        await ref.read(paymentRepositoryProvider).createPayment(appointment.id);
        paymentAvailable = true;
      } catch (_) {
        paymentAvailable = false;
      }

      if (mounted) {
        // Booking success doesn't block on an explicit "OK" tap — it's a
        // foregone conclusion once we're here, so a snackbar over the home
        // screen (with an optional "Pay now" action) stands in for a modal.
        // The messenger and translated strings are grabbed before
        // navigating away, since `context` stops being valid to read from
        // right after `context.go` swaps out this screen.
        final messenger = ScaffoldMessenger.of(context);
        final bookedMessage = context.t.appointments.bookedSnack;
        final payNowLabel = context.t.payments.payNow;
        context.go('/patient/home');
        AppSnackBar.showOn(
          messenger,
          bookedMessage,
          type: SnackBarType.success,
          actionLabel: paymentAvailable ? payNowLabel : null,
          onAction: paymentAvailable
              ? () {
                  final navContext = navigatorKey.currentContext;
                  if (navContext == null) return;
                  GoRouter.of(navContext)
                      .push('/patient/appointments/${appointment.id}/payment');
                }
              : null,
        );
      }
    } on ApiException catch (e) {
      setState(() => _error = e.userMessage);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Warms `slotsProvider`'s cache for the days either side of [day], so
  /// tapping to the next/previous day usually finds slots already there
  /// instead of a fresh loading shimmer. Fire-and-forget: failures here just
  /// mean no warm cache, not a user-visible error — the day itself would
  /// re-fetch normally if tapped.
  void _prefetchAdjacentDays(DateTime day, String workplaceId) {
    final key = (workplaceId, DateFormat('yyyy-MM-dd').format(day));
    if (_prefetchedFor == key) return;
    _prefetchedFor = key;

    final todayMidnight = DateTime.now();
    final today = DateTime(todayMidnight.year, todayMidnight.month, todayMidnight.day);
    for (final offset in [-1, 1]) {
      final adjacent = DateTime(day.year, day.month, day.day + offset);
      if (adjacent.isBefore(today)) continue;
      ref
          .read(slotsProvider(SlotsParams(
            doctorId: widget.doctor.id,
            workplaceId: workplaceId,
            date: adjacent,
          )).future)
          .ignore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final nextDateAsync =
        ref.watch(nextAvailableDateProvider(widget.doctor.id));
    // Once the doctor's nearest available date resolves, warm the cache for
    // the days around it too — same reasoning as the explicit tap in
    // onDaySelected below, just for the auto-preselected path.
    ref.listen<AsyncValue<DateTime?>>(
      nextAvailableDateProvider(widget.doctor.id),
      (previous, next) {
        final date = next.valueOrNull;
        if (date != null && _selectedWorkplaceId != null) {
          _prefetchAdjacentDays(date, _selectedWorkplaceId!);
        }
      },
    );
    final selectedDay = _selectedDay ?? nextDateAsync.valueOrNull;
    final focusedDay = _focusedDay ?? selectedDay ?? DateTime.now();

    final slotsAsync = selectedDay != null && _selectedWorkplaceId != null
        ? ref.watch(
            slotsProvider(
              SlotsParams(
                doctorId: widget.doctor.id,
                workplaceId: _selectedWorkplaceId!,
                date: selectedDay,
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

    // Who this booking is for. Defaults to "myself" (null) and is picked via
    // the switcher below, once a slot is chosen — a patient shouldn't have
    // to leave the booking flow to book for the right person.
    final activeProfile = ref.watch(activeProfileProvider);
    final workplace = _selectedWorkplaceId == null
        ? null
        : widget.doctor.workplaces
            .firstWhere((w) => w.id == _selectedWorkplaceId, orElse: () => widget.doctor.workplaces.first);

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
                    focusedDay: focusedDay,
                    selectedDay: selectedDay,
                    onDaySelected: (selected, focused) {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedDay = selected;
                        _focusedDay = focused;
                        _pickedStartsAt = null;
                      });
                      if (_selectedWorkplaceId != null) {
                        _prefetchAdjacentDays(selected, _selectedWorkplaceId!);
                      }
                    },
                  ),
                ),
                if (selectedDay != null && _selectedWorkplaceId != null) ...[
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
                                  .format(selectedDay),
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
                    loading: () => _slotsShimmerSliver(crossAxisCount),
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
                  // Everything below only appears once a slot is actually
                  // selected — same progressive feel the separate confirm
                  // screen used to give, minus the screen transition.
                  if (selectedSlot != null) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          4,
                          AppSpacing.md,
                          0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: context.colors.textSecondary,
                            ),
                            const Gap(6),
                            Expanded(
                              child: Text(
                                '${workplace!.name}, ${workplace.address}, ${workplace.city}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          AppSpacing.md,
                          AppSpacing.md,
                          8,
                        ),
                        child: Text(
                          context.t.family.bookingForQuestion,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        child: ProfileSwitcher(),
                      ),
                    ),
                    if (activeProfile != null)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md,
                            AppSpacing.md,
                            AppSpacing.md,
                            0,
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.info_outline,
                                    size: 16, color: AppColors.primary),
                                const Gap(8),
                                Expanded(
                                  child: Text(
                                    context.t.family.bookingForLabel(
                                        name: activeProfile.fullName),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _reasonController,
                        // Rebuilds just this chip row (not the whole screen)
                        // as the patient types, so a chip deselects the
                        // moment its preset text no longer matches exactly.
                        builder: (context, value, _) {
                          final presets = [
                            context.t.booking.reasonPresetCheckup,
                            context.t.booking.reasonPresetFollowUp,
                            context.t.booking.reasonPresetNewComplaint,
                          ];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.md,
                              AppSpacing.md,
                              AppSpacing.md,
                              0,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var i = 0; i < presets.length; i++) ...[
                                    if (i > 0) const Gap(8),
                                    AppChip.choice(
                                      label: presets[i],
                                      selected: value.text == presets[i],
                                      onTap: () {
                                        HapticFeedback.selectionClick();
                                        _reasonController.value = TextEditingValue(
                                          text: presets[i],
                                          selection: TextSelection.collapsed(
                                              offset: presets[i].length),
                                        );
                                      },
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          8,
                          AppSpacing.md,
                          0,
                        ),
                        child: TextField(
                          controller: _reasonController,
                          decoration: InputDecoration(
                            labelText: context.t.booking.reasonForVisit,
                            alignLabelWithHint: true,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    if (_error != null)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md,
                            12,
                            AppSpacing.md,
                            0,
                          ),
                          child: Text(_error!,
                              style: const TextStyle(color: AppColors.error)),
                        ),
                      ),
                    const SliverToBoxAdapter(child: Gap(AppSpacing.md)),
                  ],
                ] else if (_selectedWorkplaceId != null &&
                    nextDateAsync.isLoading)
                  // The doctor's nearest available date is still loading —
                  // show the same shimmer the slot grid itself would use,
                  // rather than a "Pick a date" prompt the patient would
                  // otherwise have to act on for no reason.
                  _slotsShimmerSliver(crossAxisCount)
                else
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
                label: context.t.booking.confirmAt(
                  time: DateFormat('HH:mm').format(selectedSlot.startsAt),
                ),
                loading: _loading,
                onPressed: () => _confirm(selectedSlot),
              ),
            ),
    );
  }

  Widget _slotsShimmerSliver(int crossAxisCount) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
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
  const BookingCalendarLoader({
    super.key,
    required this.doctorId,
    this.doctor,
    this.initialWorkplaceId,
  });

  final String doctorId;
  final DoctorDetailModel? doctor;
  final String? initialWorkplaceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (doctor != null) {
      return BookingCalendarScreen(
        doctor: doctor!,
        initialWorkplaceId: initialWorkplaceId,
      );
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
      data: (d) => BookingCalendarScreen(
        doctor: d,
        initialWorkplaceId: initialWorkplaceId,
      ),
    );
  }
}
