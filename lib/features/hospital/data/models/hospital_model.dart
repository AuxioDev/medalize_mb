/// A hospital registry entry — what the doctor's workplace-hospital picker
/// (HospitalPickerField) and the hospital-registration claim search both
/// return. Mirrors apps.hospitals.serializers.HospitalRegistrySerializer.
class HospitalModel {
  const HospitalModel({
    required this.id,
    required this.name,
    this.address = '',
    this.city = '',
    this.cityDisplay = '',
    this.region = '',
    this.regionDisplay = '',
    this.latitude,
    this.longitude,
    this.status = statusConfirmed,
    this.logoUrl,
  });

  static const statusPendingReview = 'pending_review';
  static const statusConfirmed = 'confirmed';

  final String id;
  final String name;
  final String address;
  final String city;
  final String cityDisplay;
  final String region;
  final String regionDisplay;
  final double? latitude;
  final double? longitude;
  final String status;
  final String? logoUrl;

  bool get isPendingReview => status == statusPendingReview;

  factory HospitalModel.fromJson(Map<String, dynamic> j) => HospitalModel(
    id: j['id'] as String,
    name: j['name'] as String,
    address: j['address'] as String? ?? '',
    city: j['city'] as String? ?? '',
    cityDisplay: j['city_display'] as String? ?? '',
    region: j['region'] as String? ?? '',
    regionDisplay: j['region_display'] as String? ?? '',
    latitude: (j['latitude'] as num?)?.toDouble(),
    longitude: (j['longitude'] as num?)?.toDouble(),
    status: j['status'] as String? ?? statusConfirmed,
    logoUrl: j['logo'] as String?,
  );
}
