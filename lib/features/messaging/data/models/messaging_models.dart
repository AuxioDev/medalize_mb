/// Brief participant info embedded on a [ThreadModel] — the backend reuses
/// `DoctorBriefSerializer`/`PatientBriefSerializer` from the appointments app,
/// so a patient participant never carries [specializationDisplay] while a
/// doctor participant does.
class ThreadParticipant {
  final String id;
  final String firstName;
  final String lastName;
  final String specializationDisplay;

  const ThreadParticipant({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.specializationDisplay = '',
  });

  String get fullName => '$firstName $lastName'.trim();

  factory ThreadParticipant.fromJson(Map<String, dynamic> j) => ThreadParticipant(
        id: '${j['id']}',
        firstName: j['first_name'] as String? ?? '',
        lastName: j['last_name'] as String? ?? '',
        specializationDisplay: j['specialization_display'] as String? ?? '',
      );
}

/// A single chat message. Unlike the AI assistant's `MessageModel`, [body] is
/// plain human text (no `suggested_doctors`/`flagged`) and [senderId] +
/// [isMine] identify which of the two participants sent it.
class MessageModel {
  final String id;
  final String threadId;
  final String senderId;
  final bool isMine;
  final String body;
  final DateTime? readAt;
  final DateTime createdAt;

  const MessageModel({
    required this.id,
    required this.threadId,
    required this.senderId,
    required this.isMine,
    required this.body,
    this.readAt,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> j) => MessageModel(
        id: '${j['id']}',
        threadId: '${j['thread'] ?? ''}',
        senderId: '${j['sender'] ?? ''}',
        isMine: j['is_mine'] as bool? ?? false,
        body: j['body'] as String? ?? '',
        readAt: j['read_at'] != null
            ? DateTime.tryParse(j['read_at'] as String)
            : null,
        createdAt: DateTime.tryParse(j['created_at'] as String? ?? '') ??
            DateTime.now(),
      );
}

/// One conversation between a patient and a doctor. Exactly one thread ever
/// exists per (patient, doctor) pair — the backend enforces this with
/// `get_or_create`.
class ThreadModel {
  final String id;
  final ThreadParticipant patient;
  final ThreadParticipant doctor;
  final MessageModel? lastMessage;
  final int unreadCount;
  final DateTime updatedAt;

  const ThreadModel({
    required this.id,
    required this.patient,
    required this.doctor,
    this.lastMessage,
    this.unreadCount = 0,
    required this.updatedAt,
  });

  factory ThreadModel.fromJson(Map<String, dynamic> j) => ThreadModel(
        id: '${j['id']}',
        patient: ThreadParticipant.fromJson(j['patient'] as Map<String, dynamic>),
        doctor: ThreadParticipant.fromJson(j['doctor'] as Map<String, dynamic>),
        lastMessage: j['last_message'] != null
            ? MessageModel.fromJson(j['last_message'] as Map<String, dynamic>)
            : null,
        unreadCount: j['unread_count'] as int? ?? 0,
        updatedAt: DateTime.tryParse(j['updated_at'] as String? ?? '') ??
            DateTime.now(),
      );

  /// The other side of the conversation, given which role the current user
  /// has. There are only ever two participants, so this is always exact.
  ThreadParticipant counterpart({required bool asDoctor}) =>
      asDoctor ? patient : doctor;
}
