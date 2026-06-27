class ReviewModel {
  final String id;
  final int rating;
  final String comment;
  final String patientName;
  final DateTime createdAt;

  const ReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.patientName,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> j) {
    final patient = j['patient'] as Map<String, dynamic>?;
    final first = patient?['first_name'] as String? ?? '';
    final last = patient?['last_name'] as String? ?? '';
    final name = '$first $last'.trim();
    return ReviewModel(
      id: j['id'] as String,
      rating: j['rating'] as int,
      comment: j['comment'] as String? ?? '',
      patientName: name.isNotEmpty ? name : 'Patient',
      createdAt: DateTime.parse(j['created_at'] as String),
    );
  }
}
