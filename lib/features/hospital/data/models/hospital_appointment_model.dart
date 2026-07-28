import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';

class HospitalWorkplaceBriefModel {
  const HospitalWorkplaceBriefModel({required this.id, required this.name});

  final String id;
  final String name;

  factory HospitalWorkplaceBriefModel.fromJson(Map<String, dynamic> j) =>
      HospitalWorkplaceBriefModel(
        id: j['id'] as String,
        name: j['name'] as String? ?? '',
      );
}

/// One row from the hospital's appointments feed. Deliberately carries no
/// patient identity or clinical notes — mirrors
/// apps.hospitals.serializers.HospitalAppointmentSerializer, which excludes
/// them on purpose (a hospital administrator is not a treating clinician).
class HospitalAppointmentModel {
  const HospitalAppointmentModel({
    required this.id,
    required this.doctor,
    required this.workplace,
    required this.startsAt,
    required this.endsAt,
    required this.status,
  });

  final String id;
  final DoctorBriefModel doctor;
  final HospitalWorkplaceBriefModel workplace;
  final DateTime startsAt;
  final DateTime endsAt;
  final String status;

  factory HospitalAppointmentModel.fromJson(Map<String, dynamic> j) => HospitalAppointmentModel(
        id: j['id'] as String,
        doctor: DoctorBriefModel.fromJson(j['doctor'] as Map<String, dynamic>),
        workplace:
            HospitalWorkplaceBriefModel.fromJson(j['workplace'] as Map<String, dynamic>),
        startsAt: DateTime.parse(j['starts_at'] as String),
        endsAt: DateTime.parse(j['ends_at'] as String),
        status: j['status'] as String,
      );
}
