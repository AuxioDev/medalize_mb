class DoctorWorkplace {
  final String id;
  final String name;
  final String city;
  final String address;
  final String type;
  final bool isPrimary;

  const DoctorWorkplace({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.type,
    required this.isPrimary,
  });

  factory DoctorWorkplace.fromJson(Map<String, dynamic> j) => DoctorWorkplace(
        id: j['id'] as String,
        name: j['name'] as String? ?? '',
        city: j['city'] as String? ?? '',
        address: j['address'] as String? ?? '',
        type: j['type'] as String? ?? '',
        isPrimary: j['is_primary'] as bool? ?? false,
      );
}

class DoctorModel {
  final String id;
  final String firstName;
  final String lastName;
  final String specialization;
  final String specializationDisplay;
  final int slotDurationMin;
  final String? consultationFee;
  final double? averageRating;
  final int reviewCount;
  final String? primaryWorkplaceName;
  final String? primaryWorkplaceCity;
  final String? primaryWorkplaceId;
  final String? avatarUrl;

  const DoctorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.specialization,
    required this.specializationDisplay,
    required this.slotDurationMin,
    this.consultationFee,
    this.averageRating,
    this.reviewCount = 0,
    this.primaryWorkplaceName,
    this.primaryWorkplaceCity,
    this.primaryWorkplaceId,
    this.avatarUrl,
  });

  String get fullName => 'Dr. $firstName $lastName'.trim();

  factory DoctorModel.fromJson(Map<String, dynamic> j) {
    final wp = j['primary_workplace'] as Map<String, dynamic>?;
    return DoctorModel(
      id: j['id'] as String,
      firstName: j['first_name'] as String? ?? '',
      lastName: j['last_name'] as String? ?? '',
      specialization: j['specialization'] as String? ?? '',
      specializationDisplay: j['specialization_display'] as String? ?? '',
      slotDurationMin: j['slot_duration_min'] as int? ?? 30,
      consultationFee: j['consultation_fee'] as String?,
      averageRating: (j['average_rating'] as num?)?.toDouble(),
      reviewCount: j['review_count'] as int? ?? 0,
      primaryWorkplaceName: wp?['name'] as String?,
      primaryWorkplaceCity: wp?['city'] as String?,
      primaryWorkplaceId: wp?['id'] as String?,
      avatarUrl: j['avatar_url'] as String?,
    );
  }
}

class DoctorDetailModel extends DoctorModel {
  final String bio;
  final List<DoctorWorkplace> workplaces;

  const DoctorDetailModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.specialization,
    required super.specializationDisplay,
    required super.slotDurationMin,
    super.consultationFee,
    super.averageRating,
    super.reviewCount,
    super.primaryWorkplaceName,
    super.primaryWorkplaceCity,
    super.primaryWorkplaceId,
    super.avatarUrl,
    required this.bio,
    required this.workplaces,
  });

  factory DoctorDetailModel.fromJson(Map<String, dynamic> j) {
    final base = DoctorModel.fromJson(j);
    return DoctorDetailModel(
      id: base.id,
      firstName: base.firstName,
      lastName: base.lastName,
      specialization: base.specialization,
      specializationDisplay: base.specializationDisplay,
      slotDurationMin: base.slotDurationMin,
      consultationFee: base.consultationFee,
      averageRating: base.averageRating,
      reviewCount: base.reviewCount,
      primaryWorkplaceName: base.primaryWorkplaceName,
      primaryWorkplaceCity: base.primaryWorkplaceCity,
      primaryWorkplaceId: base.primaryWorkplaceId,
      avatarUrl: base.avatarUrl,
      bio: j['bio'] as String? ?? '',
      workplaces: (j['workplaces'] as List<dynamic>? ?? [])
          .map((w) => DoctorWorkplace.fromJson(w as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SlotModel {
  final DateTime startsAt;
  final DateTime endsAt;

  const SlotModel({required this.startsAt, required this.endsAt});

  factory SlotModel.fromJson(Map<String, dynamic> j) => SlotModel(
        startsAt: DateTime.parse(j['starts_at'] as String),
        endsAt: DateTime.parse(j['ends_at'] as String),
      );
}
