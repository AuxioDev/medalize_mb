class WaitlistModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final DateTime joinedAt;

  const WaitlistModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.joinedAt,
  });

  factory WaitlistModel.fromJson(Map<String, dynamic> j) => WaitlistModel(
        id: j['id'] as String,
        doctorId: j['doctor_id'] as String,
        doctorName: j['doctor_name'] as String? ?? '',
        joinedAt: DateTime.parse(j['joined_at'] as String),
      );
}
