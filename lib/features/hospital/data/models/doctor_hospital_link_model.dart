import 'package:medalize_mb/features/hospital/data/models/hospital_model.dart';

/// The doctor-side view of a hospital<->doctor affiliation — mirrors
/// apps.hospitals.serializers.DoctorHospitalLinkSerializer. [hospital] is
/// the stripped-down HospitalModel the backend sends here: it never carries
/// `status` (the registry's admin-review state isn't the doctor's business —
/// see HospitalBriefForDoctorSerializer on the backend), so `hospital.status`
/// on an instance built from this endpoint is always the fallback default.
class DoctorHospitalLinkModel {
  static const statusPending = 'pending';
  static const statusInvited = 'invited';
  static const statusConfirmed = 'confirmed';
  static const statusRejected = 'rejected';
  static const statusRemoved = 'removed';

  static const requestedByDoctor = 'doctor';
  static const requestedByHospital = 'hospital';

  const DoctorHospitalLinkModel({
    required this.id,
    required this.hospital,
    required this.status,
    required this.requestedBy,
  });

  final String id;
  final HospitalModel hospital;
  final String status;

  /// 'doctor' or 'hospital' — who initiated this link.
  final String requestedBy;

  factory DoctorHospitalLinkModel.fromJson(Map<String, dynamic> j) => DoctorHospitalLinkModel(
        id: j['id'] as String,
        hospital: HospitalModel.fromJson(j['hospital'] as Map<String, dynamic>),
        status: j['status'] as String,
        requestedBy: j['requested_by'] as String? ?? '',
      );
}
