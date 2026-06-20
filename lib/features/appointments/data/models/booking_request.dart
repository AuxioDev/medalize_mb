class BookingRequest {
  final String doctorId;
  final String workplaceId;
  final DateTime startsAt;
  final String reason;

  const BookingRequest({
    required this.doctorId,
    required this.workplaceId,
    required this.startsAt,
    this.reason = '',
  });

  Map<String, dynamic> toJson() => {
        'doctor_id': doctorId,
        'workplace_id': workplaceId,
        'starts_at': startsAt.toIso8601String(),
        'reason': reason,
      };
}
