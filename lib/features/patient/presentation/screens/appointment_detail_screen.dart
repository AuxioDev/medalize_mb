import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/utils/booking_route.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/labeled_info_card.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/models/review_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/family/presentation/screens/family_list_screen.dart'
    show relationshipLabel;
import 'package:medalize_mb/features/messaging/data/repository/messaging_repository.dart';
import 'package:medalize_mb/features/payments/presentation/screens/payment_screen.dart';
import 'package:medalize_mb/features/payments/providers/payment_provider.dart';
import 'package:medalize_mb/features/prescriptions/providers/prescription_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class AppointmentDetailScreen extends ConsumerStatefulWidget {
  const AppointmentDetailScreen({
    super.key,
    required this.appointment,
    this.asDoctor = false,
  });

  final AppointmentModel appointment;

  /// When true, the screen is shown to the doctor: it surfaces the patient
  /// (instead of the doctor) and offers confirm/decline actions for pending
  /// requests instead of the patient's cancel action.
  final bool asDoctor;

  @override
  ConsumerState<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState
    extends ConsumerState<AppointmentDetailScreen> {
  bool _cancelling = false;
  bool _updatingStatus = false;
  bool _rescheduling = false;
  bool _submittingReview = false;
  bool _deletingReview = false;

  // Local mirror of the review state so submit/update/delete reflect on
  // screen immediately — the appointment itself arrives immutable via the
  // widget (router extra) and doesn't refresh in place.
  late bool _hasReview;
  late bool _canEditReview;
  ReviewModel? _review;
  bool _disputing = false;
  late bool _hasOpenDispute;

  @override
  void initState() {
    super.initState();
    _hasReview = widget.appointment.hasReview;
    _canEditReview = widget.appointment.canEditReview;
    _review = widget.appointment.review;
    _hasOpenDispute = widget.appointment.hasOpenDispute;
  }

  void _invalidateAppointment() {
    ref.invalidate(patientAppointmentsProvider);
    ref.invalidate(appointmentByIdProvider(widget.appointment.id));
  }

  Future<void> _setStatus(String status) async {
    setState(() => _updatingStatus = true);
    try {
      await ref
          .read(appointmentRepositoryProvider)
          .updateAppointmentStatus(widget.appointment.id, status);
      ref.invalidate(doctorAppointmentsProvider);
      if (mounted) context.pop();
    } on ApiException catch (e) {
      if (mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _updatingStatus = false);
    }
  }

  /// Doctor action: record that the patient did not attend.
  Future<void> _markNoShow() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.t.appointments.markNoShowTitle),
        content: Text(context.t.appointments.markNoShowConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.t.appointments.markNoShow),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await _setStatus('no_show');
  }

  /// Doctor action: ask the patient to pick a new time. Moves the appointment
  /// to `requires_rescheduling`, which the patient can act on from their side.
  Future<void> _requestReschedule() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.t.appointments.requestRescheduleTitle),
        content: Text(context.t.appointments.requestRescheduleConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.t.appointments.requestReschedule),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _updatingStatus = true);
    try {
      await ref
          .read(appointmentRepositoryProvider)
          .updateAppointmentStatus(widget.appointment.id, 'requires_rescheduling');
      ref.invalidate(doctorAppointmentsProvider);
      if (mounted) {
        AppSnackBar.show(context, context.t.appointments.requestRescheduleSuccess,
            type: SnackBarType.success);
        context.pop();
      }
    } on ApiException catch (e) {
      if (mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _updatingStatus = false);
    }
  }

  Future<void> _reschedule() async {
    final appt = widget.appointment;
    final result = await context.push<DateTime?>(
      '/patient/reschedule/${appt.id}',
      extra: appt,
    );
    if (result == null || !mounted) return;

    setState(() => _rescheduling = true);
    try {
      await ref.read(appointmentRepositoryProvider).rescheduleAppointment(appt.id, result);
      ref.invalidate(patientAppointmentsProvider);
      if (mounted) {
        AppSnackBar.show(context, context.t.appointments.rescheduledSuccess);
        context.pop();
      }
    } on ApiException catch (e) {
      if (mounted) AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _rescheduling = false);
    }
  }

  /// Patient action: contest a `no_show` mark filed against this appointment.
  Future<void> _disputeNoShow() async {
    final reasonCtrl = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.t.appointments.disputeNoShowTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.t.appointments.disputeNoShowHint,
                style: Theme.of(ctx).textTheme.bodySmall),
            const Gap(12),
            TextField(
              controller: reasonCtrl,
              maxLines: 4,
              autofocus: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(context.t.appointments.disputeNoShowSubmit),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final reason = reasonCtrl.text.trim();
    if (reason.isEmpty) return;

    setState(() => _disputing = true);
    try {
      await ref
          .read(appointmentRepositoryProvider)
          .disputeNoShow(widget.appointment.id, reason);
      _invalidateAppointment();
      if (mounted) {
        setState(() => _hasOpenDispute = true);
        AppSnackBar.show(context, context.t.appointments.disputeNoShowSubmitted,
            type: SnackBarType.success);
      }
    } on ApiException catch (e) {
      if (mounted) AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _disputing = false);
    }
  }

  /// Opens the star-rating dialog. With [existing] set, it is prefilled and
  /// submits an update to the existing review instead of creating one.
  Future<void> _showReviewDialog({ReviewModel? existing}) async {
    int selectedRating = existing?.rating ?? 5;
    final commentCtrl = TextEditingController(text: existing?.comment ?? '');
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(existing == null
              ? context.t.appointments.reviewTitle
              : context.t.appointments.editReviewTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.t.appointments.reviewRating),
              const Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  final star = i + 1;
                  return IconButton(
                    icon: Icon(
                      star <= selectedRating ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: AppColors.warning,
                      size: 32,
                    ),
                    onPressed: () => setState(() => selectedRating = star),
                  );
                }),
              ),
              const Gap(8),
              TextField(
                controller: commentCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: context.t.appointments.reviewComment,
                  alignLabelWithHint: true,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.t.common.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(existing == null
                  ? context.t.appointments.reviewSubmit
                  : context.t.common.save),
            ),
          ],
        ),
      ),
    );
    final comment = commentCtrl.text.trim();
    // Dispose only after the dialog's pop transition has finished — the
    // TextField still listens to the controller while animating out.
    Future.delayed(const Duration(milliseconds: 400), commentCtrl.dispose);
    if (confirmed != true || !mounted) return;

    setState(() => _submittingReview = true);
    try {
      final repo = ref.read(appointmentRepositoryProvider);
      if (existing == null) {
        await repo.submitReview(widget.appointment.id, selectedRating, comment);
        if (mounted) {
          setState(() {
            _hasReview = true;
            _canEditReview = true;
            // Placeholder until the appointment refetch delivers the
            // server copy — enough for the read-only card below.
            _review = ReviewModel(
              id: '',
              rating: selectedRating,
              comment: comment,
              patientName: widget.appointment.patient.fullName,
              createdAt: DateTime.now(),
            );
          });
        }
      } else {
        final updated = await repo.updateReview(
          widget.appointment.id,
          selectedRating,
          comment,
        );
        if (mounted) setState(() => _review = updated);
      }
      _invalidateAppointment();
      if (mounted) {
        AppSnackBar.show(
          context,
          existing == null
              ? context.t.appointments.reviewSubmitted
              : context.t.appointments.reviewUpdated,
          type: SnackBarType.success,
        );
      }
    } on ApiException catch (e) {
      if (mounted) AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _submittingReview = false);
    }
  }

  Future<void> _deleteReview() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.t.appointments.deleteReviewTitle),
        content: Text(context.t.appointments.deleteReviewConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: AppButtonStyles.destructiveFilled,
            child: Text(context.t.common.delete),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _deletingReview = true);
    try {
      await ref
          .read(appointmentRepositoryProvider)
          .deleteReview(widget.appointment.id);
      _invalidateAppointment();
      if (mounted) {
        setState(() {
          _hasReview = false;
          _canEditReview = false;
          _review = null;
        });
        AppSnackBar.show(context, context.t.appointments.reviewDeleted,
            type: SnackBarType.success);
      }
    } on ApiException catch (e) {
      if (mounted) AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _deletingReview = false);
    }
  }

  Future<void> _cancel() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.t.appointments.cancelTitle),
        content: Text(context.t.appointments.cancelConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t.common.keep),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: AppButtonStyles.destructiveFilled,
            child: Text(context.t.appointments.cancelAction),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _cancelling = true);
    try {
      final result = await ref
          .read(appointmentRepositoryProvider)
          .cancelAppointment(widget.appointment.id);
      ref.invalidate(patientAppointmentsProvider);
      if (mounted) {
        // Shown before popping — same order as SecurityScreen's
        // post-deactivate snackbar, so it survives the navigation below.
        AppSnackBar.show(
          context,
          result.wasRefunded
              ? context.t.appointments.cancelledRefunded
              : (result.payment != null
                  ? context.t.appointments.cancelledNoRefund
                  : context.t.appointments.cancelledSuccess),
          type: SnackBarType.success,
        );
        context.pop();
      }
    } on ApiException catch (e) {
      if (mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _cancelling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appt = widget.appointment;
    final fmt = DateFormat('d MMM y');
    final timeFmt = DateFormat('HH:mm');
    final statusColor = StatusChip.colorFor(appt.status);

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          context.t.appointments.detailTitle,
          icon: Icons.event_outlined,
        ),
      ),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedEntrance(
                slideY: 0.05,
                child: Container(
                  width: double.infinity,
                  // Horizontal padding added alongside the titleSmall font
                  // bump below — a long RU/TR status label now wraps to a
                  // second line instead of overflowing, and needs breathing
                  // room from the rounded border when it does.
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border:
                        Border.all(color: statusColor.withValues(alpha: 0.30)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_statusIcon(appt.status), color: statusColor, size: 18),
                      const Gap(8),
                      // The single most important piece of text on this
                      // screen — bumped a step up the type scale
                      // (titleSmall/14, vs. StatusChip's labelSmall/11 used
                      // everywhere else) for legibility. Flexible + no
                      // maxLines so long RU/TR status translations wrap
                      // instead of overflowing the banner.
                      Flexible(
                        child: Text(
                          StatusChip.labelFor(appt.status).toUpperCase(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              AnimatedEntrance(
                index: 1,
                child: widget.asDoctor
                    ? (appt.dependent != null
                        // Patient-safety point (see PHASE4_FAMILY_PROFILES_PROMPT.md):
                        // when this visit is for a family member, the doctor
                        // needs to immediately know *who they're actually
                        // treating* — that must never be buried as a small
                        // badge under the account holder's name. The
                        // dependent is shown as the prominent, primary
                        // identity here; the account holder becomes
                        // secondary "booked by" contact/payer info below it.
                        ? LabeledInfoCard(
                            label: context.t.appointments.patient,
                            icon: Icons.person_outline_rounded,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appt.dependent!.fullName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                const Gap(2),
                                Text(
                                  [
                                    relationshipLabel(appt.dependent!.relationship),
                                    if (appt.dependent!.age != null)
                                      context.t.family
                                          .ageYears(age: appt.dependent!.age!),
                                  ].join(' · '),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Gap(8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: context.colors.surface,
                                    borderRadius: BorderRadius.circular(AppRadius.sm),
                                    border: Border.all(color: context.colors.border),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.badge_outlined,
                                          size: 12, color: context.colors.textSecondary),
                                      const Gap(4),
                                      Flexible(
                                        child: Text(
                                          context.t.family
                                              .bookedByLabel(name: appt.patient.fullName),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: context.colors.textSecondary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : LabeledInfoCard(
                            label: context.t.appointments.patient,
                            icon: Icons.person_outline_rounded,
                            child: Text(appt.patient.fullName,
                                style: Theme.of(context).textTheme.titleSmall),
                          ))
                    : LabeledInfoCard(
                        label: context.t.appointments.doctor,
                        icon: Icons.person_outline_rounded,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appt.doctor.fullName,
                                style: Theme.of(context).textTheme.titleSmall),
                            const Gap(2),
                            Text(appt.doctor.specializationDisplay,
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
              ),
              AnimatedEntrance(
                index: 2,
                child: LabeledInfoCard(
                  label: context.t.appointments.workplace,
                  icon: Icons.business_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appt.workplace.name,
                          style: Theme.of(context).textTheme.titleSmall),
                      const Gap(2),
                      Text('${appt.workplace.address}, ${appt.workplace.city}',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
              AnimatedEntrance(
                index: 3,
                child: LabeledInfoCard(
                  label: context.t.appointments.dateTime,
                  icon: Icons.calendar_today_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fmt.format(appt.startsAt),
                          style: Theme.of(context).textTheme.titleSmall),
                      const Gap(2),
                      Text(
                        '${timeFmt.format(appt.startsAt)} – ${timeFmt.format(appt.endsAt)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              if (appt.reason.isNotEmpty)
                AnimatedEntrance(
                  index: 4,
                  child: LabeledInfoCard(
                    label: context.t.appointments.reason,
                    icon: Icons.notes_outlined,
                    child: Text(appt.reason,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: context.colors.textPrimary,
                            )),
                  ),
                ),
              if (appt.notes.isNotEmpty)
                AnimatedEntrance(
                  index: 5,
                  child: LabeledInfoCard(
                    label: context.t.appointments.doctorNotes,
                    icon: Icons.medical_information_outlined,
                    child: Text(appt.notes,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: context.colors.textPrimary,
                            )),
                  ),
                ),
              if (!widget.asDoctor && _hasReview)
                AnimatedEntrance(
                  index: 6,
                  child: LabeledInfoCard(
                    label: context.t.appointments.yourReview,
                    icon: Icons.star_outline_rounded,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_review != null) ...[
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < _review!.rating
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                size: 18,
                                color: AppColors.warning,
                              );
                            }),
                          ),
                          if (_review!.comment.isNotEmpty) ...[
                            const Gap(6),
                            Text(_review!.comment,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: context.colors.textPrimary,
                                    )),
                          ],
                          const Gap(4),
                        ],
                        Row(
                          children: [
                            if (_canEditReview) ...[
                              TextButton.icon(
                                onPressed: _submittingReview || _deletingReview
                                    ? null
                                    : () => _showReviewDialog(existing: _review),
                                icon: const Icon(Icons.edit_outlined, size: 16),
                                label: Text(context.t.common.edit),
                              ),
                              const Gap(4),
                            ],
                            TextButton.icon(
                              onPressed: _submittingReview || _deletingReview
                                  ? null
                                  : _deleteReview,
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.error,
                              ),
                              icon: const Icon(Icons.delete_outline, size: 16),
                              label: Text(context.t.common.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (appt.status == 'completed')
                AnimatedEntrance(
                  index: 7,
                  child: _PrescriptionSection(appointment: appt, asDoctor: widget.asDoctor),
                ),
              AnimatedEntrance(
                index: 8,
                child: _PaymentSection(appointment: appt, asDoctor: widget.asDoctor),
              ),
              AnimatedEntrance(
                index: 9,
                child: _MessageSection(appointment: appt, asDoctor: widget.asDoctor),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomBar(appt),
    );
  }

  Widget? _bottomBar(AppointmentModel appt) {
    if (widget.asDoctor) {
      if (appt.status == 'confirmed') {
        final isPast = appt.startsAt.isBefore(DateTime.now());
        // Past confirmed appointment → can be marked completed.
        // Upcoming confirmed appointment → doctor can ask the patient to
        // reschedule (e.g. an emergency came up).
        if (isPast) {
          return BottomActionBar(
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _updatingStatus
                        ? null
                        : () {
                            HapticFeedback.lightImpact();
                            _markNoShow();
                          },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: StatusChip.colorFor('no_show'),
                      side: BorderSide(
                          color: StatusChip.colorFor('no_show')
                              .withValues(alpha: 0.4)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md)),
                    ),
                    child: Text(context.t.appointments.markNoShow,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: FilledButton(
                    onPressed: _updatingStatus
                        ? null
                        : () {
                            HapticFeedback.lightImpact();
                            _setStatus('completed');
                          },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md)),
                    ),
                    child: _updatingStatus
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : Text(context.t.appointments.markCompleted,
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          );
        }
        return BottomActionBar(
          child: OutlinedButton.icon(
            onPressed: _updatingStatus
                ? null
                : () {
                    HapticFeedback.lightImpact();
                    _requestReschedule();
                  },
            icon: const Icon(Icons.schedule_outlined, size: 18),
            label: Text(context.t.appointments.requestReschedule,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md)),
            ),
          ),
        );
      }
      if (appt.status != 'pending') return null;
      return BottomActionBar(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed:
                    _updatingStatus ? null : () => _setStatus('declined'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side:
                      BorderSide(color: AppColors.error.withValues(alpha: 0.6)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md)),
                ),
                child: Text(context.t.common.decline,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            const Gap(10),
            Expanded(
              child: FilledButton(
                onPressed: _updatingStatus
                    ? null
                    : () {
                        HapticFeedback.lightImpact();
                        _setStatus('confirmed');
                      },
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md)),
                ),
                child: _updatingStatus
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(context.t.common.confirm,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      );
    }

    if (appt.status == 'completed' && !_hasReview) {
      return BottomActionBar(
        child: FilledButton.icon(
          onPressed: _submittingReview ? null : _showReviewDialog,
          icon: const Icon(Icons.star_outline_rounded, size: 18),
          label: Text(context.t.appointments.reviewTitle),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md)),
          ),
        ),
      );
    }

    // Doctor asked the patient to choose a new time.
    if (appt.status == 'requires_rescheduling') {
      return BottomActionBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.t.appointments.rescheduleNeededHint,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Gap(10),
            FilledButton.icon(
              onPressed: _rescheduling
                  ? null
                  : () {
                      HapticFeedback.lightImpact();
                      _reschedule();
                    },
              icon: _rescheduling
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.schedule_outlined, size: 18),
              label: Text(context.t.appointments.reschedule,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md)),
              ),
            ),
          ],
        ),
      );
    }

    if (appt.status == 'no_show') {
      if (_hasOpenDispute) {
        return BottomActionBar(
          child: OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.hourglass_top_rounded, size: 18),
            label: Text(context.t.appointments.disputeNoShowOpen,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md)),
            ),
          ),
        );
      }
      return BottomActionBar(
        child: OutlinedButton(
          onPressed: _disputing
              ? null
              : () {
                  HapticFeedback.lightImpact();
                  _disputeNoShow();
                },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md)),
          ),
          child: _disputing
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(context.t.appointments.disputeNoShow,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      );
    }

    if (appt.canCancel || appt.canReschedule) {
      return BottomActionBar(
        child: Row(
          children: [
            if (appt.canCancel) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: _cancelling
                      ? null
                      : () {
                          HapticFeedback.lightImpact();
                          _cancel();
                        },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side:
                        BorderSide(color: AppColors.error.withValues(alpha: 0.6)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md)),
                  ),
                  child: _cancelling
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.error),
                        )
                      : Text(context.t.appointments.cancelAction,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              const Gap(10),
            ],
            if (appt.canReschedule)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _rescheduling
                      ? null
                      : () {
                          HapticFeedback.lightImpact();
                          _reschedule();
                        },
                  icon: const Icon(Icons.schedule_outlined, size: 16),
                  label: Text(context.t.appointments.reschedule),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md)),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    // Closed appointments (reviewed-completed, declined, cancelled) get a
    // one-tap way back into booking with the same doctor/workplace, rather
    // than sending the patient all the way back through search. Deliberately
    // not a blanket fallback: an upcoming confirmed/pending appointment
    // outside the cancel window also reaches this point with neither
    // canCancel nor canReschedule, and "book again" would be confusing there
    // — they already have one coming up.
    if (!widget.asDoctor &&
        {'completed', 'declined', 'cancelled'}.contains(appt.status)) {
      return BottomActionBar(
        child: OutlinedButton.icon(
          onPressed: () {
            HapticFeedback.lightImpact();
            context.push(
              bookingCalendarPath(appt.doctor.id, workplaceId: appt.workplace.id),
            );
          },
          icon: const Icon(Icons.calendar_month_outlined, size: 18),
          label: Text(context.t.appointments.bookAgain,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md)),
          ),
        ),
      );
    }

    return null;
  }

  IconData _statusIcon(String status) => switch (status) {
        'confirmed' => Icons.check_circle_outline,
        'completed' => Icons.task_alt_outlined,
        'pending' => Icons.schedule_outlined,
        'cancelled' || 'declined' => Icons.cancel_outlined,
        'requires_rescheduling' => Icons.sync_problem_outlined,
        'no_show' => Icons.person_off_outlined,
        _ => Icons.info_outline,
      };
}

/// Wraps [AppointmentDetailScreen] to handle cases where the GoRouter [extra]
/// state is unavailable (deep link, app restoration after kill). Falls back to
/// loading the appointment from the API by [appointmentId].
class AppointmentDetailLoader extends ConsumerWidget {
  const AppointmentDetailLoader({
    super.key,
    required this.appointmentId,
    this.appointment,
    this.asDoctor = false,
  });

  final String appointmentId;
  final AppointmentModel? appointment;
  final bool asDoctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (appointment != null) {
      return AppointmentDetailScreen(appointment: appointment!, asDoctor: asDoctor);
    }
    final async = ref.watch(appointmentByIdProvider(appointmentId));
    return async.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(children: [
            ShimmerSkeleton(height: 64),
            ShimmerSkeleton(height: 120),
            ShimmerSkeleton(height: 120),
            ShimmerSkeleton(height: 80),
          ]),
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
      data: (appt) => AppointmentDetailScreen(appointment: appt, asDoctor: asDoctor),
    );
  }
}


/// Doctor's "write prescription" entry point and patient's "view prescription"
/// summary card both live here — same file, role-gated via [asDoctor] — per
/// the shared appointment-detail convention this screen already follows for
/// reviews. Only ever built for completed appointments (see the `build()`
/// call site above), so it's the sole place that watches
/// [appointmentPrescriptionProvider] — non-completed appointments never issue
/// the network call.
class _PrescriptionSection extends ConsumerWidget {
  const _PrescriptionSection({required this.appointment, required this.asDoctor});

  final AppointmentModel appointment;
  final bool asDoctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(appointmentPrescriptionProvider(appointment.id));
    return async.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (prescription) {
        if (prescription == null) {
          // Only the issuing doctor gets a call-to-action; a patient simply
          // sees nothing until one exists.
          if (!asDoctor) return const SizedBox.shrink();
          return LabeledInfoCard(
            label: context.t.prescriptions.title,
            icon: Icons.receipt_long_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.prescriptions.noPrescriptionYet,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Gap(10),
                OutlinedButton.icon(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.push(
                      '/doctor/write-prescription/${appointment.id}',
                      extra: appointment,
                    );
                  },
                  icon: const Icon(Icons.edit_note_outlined, size: 18),
                  label: Text(context.t.prescriptions.writePrescription),
                ),
              ],
            ),
          );
        }

        return LabeledInfoCard(
          label: context.t.prescriptions.title,
          icon: Icons.receipt_long_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.prescriptions.itemsCount(count: prescription.items.length),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (!asDoctor) ...[
                const Gap(6),
                TextButton.icon(
                  onPressed: () =>
                      context.push('/patient/prescriptions/${prescription.id}'),
                  icon: const Icon(Icons.chevron_right, size: 16),
                  label: Text(context.t.prescriptions.viewDetails),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// Small payment-status badge — same file, role-gated via [asDoctor], right
/// alongside [_PrescriptionSection]/[_MessageSection] per the established
/// appointment-detail convention. Shown for any appointment status (unlike
/// [_PrescriptionSection], which only applies once completed): a `Payment`
/// is created immediately after booking succeeds, before the doctor even
/// confirms the request, so it can exist alongside a `pending` appointment
/// too. Visible to both roles — the doctor benefits from seeing whether the
/// visit has been paid for.
class _PaymentSection extends ConsumerWidget {
  const _PaymentSection({required this.appointment, required this.asDoctor});

  final AppointmentModel appointment;
  final bool asDoctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(paymentProvider(appointment.id));
    return async.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (payment) {
        // No payment created for this appointment (yet, or ever — payment is
        // optional) — nothing to show for either role. Unlike prescriptions
        // there's no "create payment" CTA here: that only happens right
        // after booking, from booking_calendar_screen.dart.
        if (payment == null) return const SizedBox.shrink();
        return LabeledInfoCard(
          label: context.t.payments.title,
          icon: Icons.payments_outlined,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${payment.amount} ${payment.currency}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              PaymentStatusChip(status: payment.status),
            ],
          ),
        );
      },
    );
  }
}

/// "Write a message" entry point into the Phase 2 messaging thread with the
/// other participant of this appointment — same file, role-gated via
/// [asDoctor], right next to [_PrescriptionSection] per the established
/// appointment-detail convention. Shown regardless of appointment status:
/// any appointment (even pending/cancelled) already establishes the shared
/// history the backend requires to create a thread.
class _MessageSection extends ConsumerStatefulWidget {
  const _MessageSection({required this.appointment, required this.asDoctor});

  final AppointmentModel appointment;
  final bool asDoctor;

  @override
  ConsumerState<_MessageSection> createState() => _MessageSectionState();
}

class _MessageSectionState extends ConsumerState<_MessageSection> {
  bool _opening = false;

  Future<void> _openChat() async {
    setState(() => _opening = true);
    try {
      final otherId = widget.asDoctor
          ? widget.appointment.patient.id
          : widget.appointment.doctor.id;
      final thread =
          await ref.read(messagingRepositoryProvider).getOrCreateThread(otherId);
      if (!mounted) return;
      final path = widget.asDoctor
          ? '/doctor/messages/${thread.id}'
          : '/patient/messages/${thread.id}';
      context.push(path, extra: thread);
    } on ApiException catch (e) {
      if (mounted) AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _opening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LabeledInfoCard(
      label: context.t.messaging.title,
      icon: Icons.chat_bubble_outline_rounded,
      child: Align(
        alignment: Alignment.centerLeft,
        child: OutlinedButton.icon(
          onPressed: _opening
              ? null
              : () {
                  HapticFeedback.lightImpact();
                  _openChat();
                },
          icon: _opening
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.send_outlined, size: 16),
          label: Text(context.t.messaging.sendMessage),
        ),
      ),
    );
  }
}
