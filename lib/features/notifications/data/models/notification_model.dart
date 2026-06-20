class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String message;
  final bool isRead;
  final DateTime sentAt;
  final String? appointmentId;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    required this.sentAt,
    this.appointmentId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> j) => NotificationModel(
        id: j['id'] as String,
        type: j['type'] as String? ?? '',
        title: j['title'] as String? ?? '',
        message: j['message'] as String? ?? '',
        isRead: j['is_read'] as bool? ?? false,
        sentAt: DateTime.parse(j['sent_at'] as String),
        appointmentId: j['appointment_id'] as String?,
      );
}
