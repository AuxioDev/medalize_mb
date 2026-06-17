class PatientProfile {
  const PatientProfile({
    this.dateOfBirth,
    this.bloodType = '',
    this.address = '',
  });

  final String? dateOfBirth;
  final String bloodType;
  final String address;

  factory PatientProfile.fromJson(Map<String, dynamic> json) => PatientProfile(
        dateOfBirth: json['date_of_birth'] as String?,
        bloodType: json['blood_type'] as String? ?? '',
        address: json['address'] as String? ?? '',
      );
}

class DoctorProfile {
  const DoctorProfile({
    this.specialization = '',
    this.bio = '',
    this.slotDurationMin = 30,
  });

  final String specialization;
  final String bio;
  final int slotDurationMin;

  factory DoctorProfile.fromJson(Map<String, dynamic> json) => DoctorProfile(
        specialization: json['specialization'] as String? ?? '',
        bio: json['bio'] as String? ?? '',
        slotDurationMin: json['slot_duration_min'] as int? ?? 30,
      );
}

class UserModel {
  const UserModel({
    required this.userId,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.isVerified,
    this.onboardingStep,
    this.onboardingComplete,
    this.doctorProfile,
    this.patientProfile,
  });

  final String userId;
  final String email;
  final String role;
  final String firstName;
  final String lastName;
  final bool? isVerified;
  final int? onboardingStep;
  final bool? onboardingComplete;
  final DoctorProfile? doctorProfile;
  final PatientProfile? patientProfile;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final role = json['role'] as String;
    final profile = json['profile'] as Map<String, dynamic>?;
    return UserModel(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      role: role,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      isVerified: json['is_verified'] as bool?,
      onboardingStep: json['onboarding_step'] as int?,
      onboardingComplete: json['onboarding_complete'] as bool?,
      doctorProfile:
          role == 'doctor' && profile != null ? DoctorProfile.fromJson(profile) : null,
      patientProfile:
          role == 'patient' && profile != null ? PatientProfile.fromJson(profile) : null,
    );
  }
}
