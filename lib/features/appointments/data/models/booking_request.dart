class BookingRequest {
  final String doctorId;
  final String workplaceId;
  final DateTime startsAt;
  final String reason;

  /// Non-null when this booking is for a managed family member instead of
  /// the account holder — see `activeProfileProvider`
  /// (`lib/features/family/providers/family_provider.dart`).
  final String? dependentId;

  const BookingRequest({
    required this.doctorId,
    required this.workplaceId,
    required this.startsAt,
    this.reason = '',
    this.dependentId,
  });

  Map<String, dynamic> toJson() => {
        'doctor_id': doctorId,
        'workplace_id': workplaceId,
        'starts_at': startsAt.toIso8601String(),
        'reason': reason,
        if (dependentId != null) 'dependent_id': dependentId,
      };
}
