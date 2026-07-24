class PrescriptionItemModel {
  final String id;
  final String drugName;
  final String dosage;
  final String frequency;
  final String duration;
  final String instructions;

  const PrescriptionItemModel({
    this.id = '',
    required this.drugName,
    this.dosage = '',
    this.frequency = '',
    this.duration = '',
    this.instructions = '',
  });

  factory PrescriptionItemModel.fromJson(Map<String, dynamic> j) =>
      PrescriptionItemModel(
        id: j['id'] as String? ?? '',
        drugName: j['drug_name'] as String? ?? '',
        dosage: j['dosage'] as String? ?? '',
        frequency: j['frequency'] as String? ?? '',
        duration: j['duration'] as String? ?? '',
        instructions: j['instructions'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'drug_name': drugName,
        'dosage': dosage,
        'frequency': frequency,
        'duration': duration,
        'instructions': instructions,
      };
}

class PrescriptionModel {
  final String id;
  final String appointmentId;
  final String doctorName;
  final String patientName;
  final String notes;
  final DateTime issuedAt;
  final List<PrescriptionItemModel> items;

  const PrescriptionModel({
    required this.id,
    this.appointmentId = '',
    this.doctorName = '',
    this.patientName = '',
    this.notes = '',
    required this.issuedAt,
    this.items = const [],
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> j) => PrescriptionModel(
        id: j['id'] as String,
        // `appointment` may or may not be serialized as a flat id depending
        // on the exact backend serializer fields — tolerate its absence
        // since callers that need it usually already know it from context.
        appointmentId: j['appointment'] as String? ?? '',
        doctorName: j['doctor_name'] as String? ?? '',
        patientName: j['patient_name'] as String? ?? '',
        notes: j['notes'] as String? ?? '',
        issuedAt: j['issued_at'] != null
            ? DateTime.parse(j['issued_at'] as String)
            : DateTime.now(),
        items: ((j['items'] as List<dynamic>?) ?? const [])
            .map((e) => PrescriptionItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
