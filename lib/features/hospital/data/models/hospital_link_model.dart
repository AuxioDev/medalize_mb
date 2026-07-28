/// Minimal doctor identity as returned to a hospital — name + specialization
/// only, deliberately no email/phone (mirrors
/// apps.hospitals.serializers.DoctorBriefSerializer on the backend).
class DoctorBriefModel {
  const DoctorBriefModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.specialization = '',
    this.specializationDisplay = '',
  });

  final String id;
  final String firstName;
  final String lastName;
  final String specialization;
  final String specializationDisplay;

  String get fullName => '$firstName $lastName'.trim();

  factory DoctorBriefModel.fromJson(Map<String, dynamic> j) => DoctorBriefModel(
        id: j['id'] as String,
        firstName: j['first_name'] as String? ?? '',
        lastName: j['last_name'] as String? ?? '',
        specialization: j['specialization'] as String? ?? '',
        specializationDisplay: j['specialization_display'] as String? ?? '',
      );
}

/// The hospital<->doctor affiliation — mirrors
/// apps.hospitals.models.HospitalDoctorLink / HospitalLinkSerializer.
class HospitalDoctorLinkModel {
  static const statusPending = 'pending';
  static const statusInvited = 'invited';
  static const statusConfirmed = 'confirmed';
  static const statusRejected = 'rejected';
  static const statusRemoved = 'removed';

  const HospitalDoctorLinkModel({
    required this.id,
    required this.doctor,
    required this.status,
    required this.requestedBy,
  });

  final String id;
  final DoctorBriefModel doctor;
  final String status;

  /// 'doctor' or 'hospital' — who initiated this link.
  final String requestedBy;

  factory HospitalDoctorLinkModel.fromJson(Map<String, dynamic> j) => HospitalDoctorLinkModel(
        id: j['id'] as String,
        doctor: DoctorBriefModel.fromJson(j['doctor'] as Map<String, dynamic>),
        status: j['status'] as String,
        requestedBy: j['requested_by'] as String? ?? '',
      );
}
