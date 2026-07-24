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
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/models/review_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _hasReview = widget.appointment.hasReview;
    _canEditReview = widget.appointment.canEditReview;
    _review = widget.appointment.review;
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
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
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
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(context.t.appointments.cancelAction),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _cancelling = true);
    try {
      await ref
          .read(appointmentRepositoryProvider)
          .cancelAppointment(widget.appointment.id);
      ref.invalidate(patientAppointmentsProvider);
      if (mounted) context.pop();
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
      appBar: AppBar(title: Text(context.t.appointments.detailTitle)),
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
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
                      Text(
                        StatusChip.labelFor(appt.status).toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 0.5,
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
                    ? _InfoCard(
                        label: context.t.appointments.patient,
                        icon: Icons.person_outline_rounded,
                        child: Text(appt.patient.fullName,
                            style: Theme.of(context).textTheme.titleSmall),
                      )
                    : _InfoCard(
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
                child: _InfoCard(
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
                child: _InfoCard(
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
                  child: _InfoCard(
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
                  child: _InfoCard(
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
                  child: _InfoCard(
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
                      minimumSize: const Size.fromHeight(52),
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
              minimumSize: const Size.fromHeight(52),
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
                  minimumSize: const Size.fromHeight(52),
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
                    minimumSize: const Size.fromHeight(52),
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
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md)),
                  ),
                ),
              ),
          ],
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
        body: Center(child: Text(context.t.common.somethingWrong)),
      ),
      data: (appt) => AppointmentDetailScreen(appointment: appt, asDoctor: asDoctor),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.label,
    required this.icon,
    required this.child,
  });

  final String label;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: c.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
        border: Border.all(color: c.border, width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Full-height accent bar. IntrinsicHeight gives the Row a bounded
            // height so `stretch` can size this without an infinite constraint.
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.md + 2),
                  bottomLeft: Radius.circular(AppRadius.md + 2),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, size: 14, color: c.primaryText),
                        const Gap(5),
                        Text(
                          label.toUpperCase(),
                          style: TextStyle(
                            color: c.primaryText,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    child,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
