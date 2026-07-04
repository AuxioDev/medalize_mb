class UserDeviceModel {
  const UserDeviceModel({
    required this.id,
    required this.deviceId,
    required this.deviceName,
    required this.platform,
    this.lastSeenAt,
    this.createdAt,
    this.isCurrent = false,
  });

  final String id;
  final String deviceId;
  final String deviceName;
  final String platform;
  final DateTime? lastSeenAt;
  final DateTime? createdAt;
  final bool isCurrent;

  factory UserDeviceModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) =>
        value is String ? DateTime.tryParse(value)?.toLocal() : null;

    return UserDeviceModel(
      id: json['id']?.toString() ?? '',
      deviceId: json['device_id'] as String? ?? '',
      deviceName: json['device_name'] as String? ?? '',
      platform: json['platform'] as String? ?? '',
      lastSeenAt: parseDate(json['last_seen_at']),
      createdAt: parseDate(json['created_at']),
      isCurrent: json['is_current'] as bool? ?? false,
    );
  }
}
