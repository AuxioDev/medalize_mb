import 'package:medalize_mb/features/appointments/data/models/review_model.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/payments/data/models/payment_model.dart';

class AppointmentDoctor {
  final String id;
  final String firstName;
  final String lastName;
  final String specialization;
  final String specializationDisplay;

  const AppointmentDoctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.specialization,
    required this.specializationDisplay,
  });

  factory AppointmentDoctor.fromJson(Map<String, dynamic> j) => AppointmentDoctor(
        id: j['id'] as String,
        firstName: j['first_name'] as String? ?? '',
        lastName: j['last_name'] as String? ?? '',
        specialization: j['specialization'] as String? ?? '',
        specializationDisplay: j['specialization_display'] as String? ?? '',
      );

  String get fullName => '$firstName $lastName'.trim();
}

class AppointmentPatient {
  final String id;
  final String firstName;
  final String lastName;

  const AppointmentPatient({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory AppointmentPatient.fromJson(Map<String, dynamic> j) => AppointmentPatient(
        id: j['id'] as String,
        firstName: j['first_name'] as String? ?? '',
        lastName: j['last_name'] as String? ?? '',
      );

  String get fullName => '$firstName $lastName'.trim();
}

class AppointmentWorkplace {
  final String id;
  final String name;
  final String address;
  final String city;

  const AppointmentWorkplace({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
  });

  factory AppointmentWorkplace.fromJson(Map<String, dynamic> j) => AppointmentWorkplace(
        id: j['id'] as String,
        name: j['name'] as String? ?? '',
        address: j['address'] as String? ?? '',
        // Localized display name, not the raw registry key — see
        // apps.core.i18n.city_label on the backend.
        city: j['city_display'] as String? ?? j['city'] as String? ?? '',
      );
}

class AppointmentModel {
  final String id;
  final AppointmentDoctor doctor;
  final AppointmentPatient patient;
  final AppointmentWorkplace workplace;
  final DateTime startsAt;
  final DateTime endsAt;
  final String status;
  final String reason;
  final String notes;
  final DateTime createdAt;

  /// Set when this visit is for one of [patient]'s managed family members
  /// rather than for the account holder themselves. `patient` remains the
  /// account owner (contact/payer) either way — `dependent`, when present,
  /// is who the visit is clinically *for*. See the doctor-facing rendering
  /// in `appointment_detail_screen.dart`, which must make this unmistakable.
  final DependentModel? dependent;

  /// Server-computed cancel/reschedule eligibility (`can_cancel`/`can_reschedule`).
  /// Null when the backend didn't send them — we then fall back to the local
  /// rule below so older responses keep working.
  final bool? canCancelOverride;
  final bool? canRescheduleOverride;
  final bool hasReview;

  /// The patient's own review, embedded by the backend when one exists.
  final ReviewModel? review;

  /// Server-computed: whether the review is still inside the edit window.
  final bool canEditReview;

  /// Whether the patient already has an open dispute filed against this
  /// appointment's status (in practice, always a `no_show` dispute) — used
  /// to swap the "Dispute" action for a submitted/pending state instead of
  /// letting the patient file duplicates.
  final bool hasOpenDispute;

  const AppointmentModel({
    required this.id,
    required this.doctor,
    required this.patient,
    required this.workplace,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    required this.reason,
    required this.notes,
    required this.createdAt,
    this.canCancelOverride,
    this.canRescheduleOverride,
    this.hasReview = false,
    this.review,
    this.canEditReview = false,
    this.dependent,
    this.hasOpenDispute = false,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> j) => AppointmentModel(
        id: j['id'] as String,
        doctor: AppointmentDoctor.fromJson(j['doctor'] as Map<String, dynamic>),
        patient: AppointmentPatient.fromJson(j['patient'] as Map<String, dynamic>),
        workplace: AppointmentWorkplace.fromJson(j['workplace'] as Map<String, dynamic>),
        startsAt: DateTime.parse(j['starts_at'] as String),
        endsAt: DateTime.parse(j['ends_at'] as String),
        status: j['status'] as String,
        reason: j['reason'] as String? ?? '',
        notes: j['notes'] as String? ?? '',
        createdAt: DateTime.parse(j['created_at'] as String),
        canCancelOverride: j['can_cancel'] as bool?,
        canRescheduleOverride: j['can_reschedule'] as bool?,
        hasReview: j['has_review'] as bool? ?? false,
        review: j['review'] != null
            ? ReviewModel.fromJson(j['review'] as Map<String, dynamic>)
            : null,
        canEditReview: j['can_edit_review'] as bool? ?? false,
        dependent: j['dependent'] != null
            ? DependentModel.fromJson(j['dependent'] as Map<String, dynamic>)
            : null,
        hasOpenDispute: j['has_open_dispute'] as bool? ?? false,
      );

  bool get isUpcoming {
    if (status == 'pending' || status == 'confirmed' || status == 'requires_rescheduling') {
      return true;
    }
    // no_show set before the appointment time is an unusual edge case;
    // keep it in upcoming so the patient sees it as actionable.
    if (status == 'no_show' && startsAt.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  /// Prefer the server's decision; fall back to the local window rule.
  bool get canCancel => canCancelOverride ?? _withinCancelWindow;

  bool get canReschedule =>
      canRescheduleOverride ??
      (status == 'requires_rescheduling' || _withinCancelWindow);

  bool get _withinCancelWindow {
    if (status != 'pending' && status != 'confirmed') return false;
    return startsAt.isAfter(DateTime.now().add(const Duration(hours: 2)));
  }
}

/// The body `DELETE /appointments/{id}/` now returns (backend contract —
/// see `PatientAppointmentDetailView.delete`): the cancellation itself is
/// unconditional (patients can always cancel a pending/confirmed
/// appointment), but whether it was refund-eligible depends on the
/// doctor's cancellation window, and [payment] is the post-refund-attempt
/// snapshot (or null when the appointment was never paid for).
class AppointmentCancelResult {
  final bool refundEligible;
  final PaymentModel? payment;

  const AppointmentCancelResult({
    required this.refundEligible,
    this.payment,
  });

  factory AppointmentCancelResult.fromJson(Map<String, dynamic> j) =>
      AppointmentCancelResult(
        refundEligible: j['refund_eligible'] as bool? ?? false,
        payment: j['payment'] != null
            ? PaymentModel.fromJson(j['payment'] as Map<String, dynamic>)
            : null,
      );

  /// True only when a refund was actually issued — checked against the
  /// payment's own status rather than derived from [refundEligible] alone:
  /// eligibility can still resolve to no refund at all (nothing was ever
  /// paid) or to `refund_failed` (the provider call itself failed — see
  /// apps.payments.service.refund_payment, which never blocks the
  /// cancellation on that failure).
  bool get wasRefunded => payment?.isRefunded ?? false;
}
