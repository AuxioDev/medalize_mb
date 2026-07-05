class ReviewModel {
  final String id;
  final int rating;
  final String comment;
  final String patientName;
  final DateTime createdAt;

  /// Set when the backend sends `updated_at`; kept nullable so older
  /// responses (without the field) keep parsing.
  final DateTime? updatedAt;

  const ReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.patientName,
    required this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> j) {
    final patient = j['patient'] as Map<String, dynamic>?;
    final first = patient?['first_name'] as String? ?? '';
    final last = patient?['last_name'] as String? ?? '';
    // The public reviews list nests `patient`; the appointment-embedded
    // review sends a flat `patient_name` instead. Accept both.
    final name = '$first $last'.trim().isNotEmpty
        ? '$first $last'.trim()
        : (j['patient_name'] as String? ?? '').trim();
    final updated = j['updated_at'] as String?;
    return ReviewModel(
      id: j['id'] as String,
      rating: j['rating'] as int,
      comment: j['comment'] as String? ?? '',
      patientName: name.isNotEmpty ? name : 'Patient',
      createdAt: DateTime.parse(j['created_at'] as String),
      updatedAt: updated != null ? DateTime.parse(updated) : null,
    );
  }
}
