/// The hospital's own account details — mirrors
/// apps.hospitals.serializers.HospitalProfileSerializer (GET/PATCH
/// /api/hospital/profile/).
class HospitalProfileModel {
  const HospitalProfileModel({
    required this.id,
    required this.name,
    this.address = '',
    this.city = '',
    this.cityDisplay = '',
    this.region = '',
    this.regionDisplay = '',
    this.latitude,
    this.longitude,
    this.phone = '',
    this.website = '',
    this.logoUrl,
    this.status = '',
    this.claimStatus = '',
  });

  final String id;
  final String name;
  final String address;
  final String city;
  final String cityDisplay;
  final String region;
  final String regionDisplay;
  final double? latitude;
  final double? longitude;
  final String phone;
  final String website;
  final String? logoUrl;
  final String status;
  final String claimStatus;

  factory HospitalProfileModel.fromJson(Map<String, dynamic> j) => HospitalProfileModel(
        id: j['id'] as String,
        name: j['name'] as String,
        address: j['address'] as String? ?? '',
        city: j['city'] as String? ?? '',
        cityDisplay: j['city_display'] as String? ?? '',
        region: j['region'] as String? ?? '',
        regionDisplay: j['region_display'] as String? ?? '',
        latitude: (j['latitude'] as num?)?.toDouble(),
        longitude: (j['longitude'] as num?)?.toDouble(),
        phone: j['phone'] as String? ?? '',
        website: j['website'] as String? ?? '',
        logoUrl: j['logo'] as String?,
        status: j['status'] as String? ?? '',
        claimStatus: j['claim_status'] as String? ?? '',
      );
}
