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
        city: j['city'] as String? ?? '',
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
      );

  bool get isUpcoming =>
      status == 'pending' || status == 'confirmed' || status == 'requires_rescheduling';

  bool get canCancel {
    if (status != 'pending' && status != 'confirmed') return false;
    return startsAt.isAfter(DateTime.now().add(const Duration(hours: 2)));
  }
}
