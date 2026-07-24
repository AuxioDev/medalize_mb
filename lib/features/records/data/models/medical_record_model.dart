class MedicalRecordModel {
  static const typeLabResult = 'lab_result';
  static const typeImaging = 'imaging';
  static const typeDocument = 'document';
  static const typeOther = 'other';

  final String id;
  final String recordType;
  final String title;

  /// Already-signed Cloudinary URL — safe to open directly, no extra auth
  /// header needed (see `apps/core/storage.py::PrivateRawCloudinaryStorage`
  /// on the backend).
  final String fileUrl;
  final DateTime? recordDate;
  final String notes;
  final DateTime createdAt;

  const MedicalRecordModel({
    required this.id,
    this.recordType = typeOther,
    required this.title,
    this.fileUrl = '',
    this.recordDate,
    this.notes = '',
    required this.createdAt,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> j) => MedicalRecordModel(
        id: j['id'] as String,
        recordType: j['record_type'] as String? ?? typeOther,
        title: j['title'] as String? ?? '',
        fileUrl: j['file'] as String? ?? '',
        recordDate: j['record_date'] != null
            ? DateTime.parse(j['record_date'] as String)
            : null,
        notes: j['notes'] as String? ?? '',
        createdAt: j['created_at'] != null
            ? DateTime.parse(j['created_at'] as String)
            : DateTime.now(),
      );
}
