import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/labeled_info_card.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/profile_switcher.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/appointments/data/models/booking_request.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/features/payments/data/repository/payment_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class BookingConfirmScreen extends ConsumerStatefulWidget {
  const BookingConfirmScreen({
    super.key,
    required this.doctor,
    required this.slot,
    required this.workplaceId,
  });

  final DoctorDetailModel doctor;
  final SlotModel slot;
  final String workplaceId;

  @override
  ConsumerState<BookingConfirmScreen> createState() =>
      _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends ConsumerState<BookingConfirmScreen> {
  final _reasonController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final repo = ref.read(appointmentRepositoryProvider);
      final appointment = await repo.bookAppointment(BookingRequest(
        doctorId: widget.doctor.id,
        workplaceId: widget.workplaceId,
        startsAt: widget.slot.startsAt,
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
      // button appears. The success dialog below renders identically either
      // way.
      var paymentAvailable = false;
      try {
        await ref.read(paymentRepositoryProvider).createPayment(appointment.id);
        paymentAvailable = true;
      } catch (_) {
        paymentAvailable = false;
      }

      if (mounted) {
        final reducedMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
        showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            icon: _SuccessIcon(reducedMotion: reducedMotion),
            title: Text(context.t.appointments.bookedTitle),
            content: Text(context.t.appointments.bookedMessage),
            actions: [
              if (paymentAvailable)
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/patient/home');
                    context.push('/patient/appointments/${appointment.id}/payment');
                  },
                  child: Text(context.t.payments.payNow),
                ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/patient/home');
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(context.t.common.ok),
              ),
            ],
          ),
        );
      }
    } on ApiException catch (e) {
      setState(() => _error = e.userMessage);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM y, HH:mm');
    final workplace = widget.doctor.workplaces.firstWhere(
      (w) => w.id == widget.workplaceId,
      orElse: () => widget.doctor.workplaces.isNotEmpty
          ? widget.doctor.workplaces.first
          : throw StateError('Doctor has no workplaces'),
    );
    // Who this booking is for. Defaults to "myself" (null) and is picked
    // right here via the switcher below, rather than relying solely on
    // whatever was left active on the home screen — a patient shouldn't have
    // to leave the booking flow to book for the right person.
    final activeProfile = ref.watch(activeProfileProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.t.booking.confirmTitle)),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.family.bookingForQuestion,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Gap(8),
              const ProfileSwitcher(),
              const Gap(AppSpacing.md),
              if (activeProfile != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, size: 16, color: AppColors.primary),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          context.t.family.bookingForLabel(name: activeProfile.fullName),
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(AppSpacing.md),
              ],
              LabeledInfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(
                        label: context.t.booking.doctorLabel,
                        value: widget.doctor.fullName),
                    _InfoRow(
                        label: context.t.booking.workplaceLabel,
                        value: workplace.name),
                    _InfoRow(
                        label: context.t.booking.addressLabel,
                        value: '${workplace.address}, ${workplace.city}'),
                    _InfoRow(
                        label: context.t.booking.startLabel,
                        value: fmt.format(widget.slot.startsAt)),
                    _InfoRow(
                        label: context.t.booking.endLabel,
                        value: fmt.format(widget.slot.endsAt),
                        last: true),
                  ],
                ),
              ),
              const Gap(AppSpacing.md),
              TextField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: context.t.booking.reasonForVisit,
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
              ),
              if (_error != null) ...[
                const Gap(12),
                Text(_error!, style: const TextStyle(color: AppColors.error)),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: LoadingFilledButton(
          label: context.t.booking.confirmButton,
          loading: _loading,
          onPressed: _confirm,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.last = false});
  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              label,
              maxLines: 2,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: context.colors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(8),
          Expanded(
            flex: 3,
            child: Text(value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                    )),
          ),
        ],
      ),
    );
  }
}

/// Scale + fade reveal for the booking-confirmed checkmark — the first of the
/// two high-relief success moments in the patient journey (the other is
/// payment confirmation, payment_screen.dart's `_PaymentConfirmedRow`).
/// Mirrors the splash screen's literal `elasticOut` "pop" (see
/// splash_screen.dart's `_Logo`) rather than the routine `AppCurve` tokens,
/// which read too subtle for a one-off celebratory reveal. Honors
/// reduced-motion like the assistant chat's typing indicator and
/// `EmptyState`.
class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon({required this.reducedMotion});

  final bool reducedMotion;

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.check_circle_outline, color: AppColors.success, size: 40);
    if (reducedMotion) return icon;
    return icon
        .animate()
        .scale(
          begin: const Offset(0.4, 0.4),
          end: const Offset(1.0, 1.0),
          duration: 450.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 200.ms);
  }
}
