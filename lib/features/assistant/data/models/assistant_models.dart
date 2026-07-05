/// A compact doctor card the assistant attaches to a message when it called
/// the `search_doctors` tool on the backend.
class SuggestedDoctor {
  final String id;
  final String firstName;
  final String lastName;
  final String specializationDisplay;
  final double? averageRating;
  final String city;

  const SuggestedDoctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.specializationDisplay,
    this.averageRating,
    this.city = '',
  });

  String get fullName => 'Dr. $firstName $lastName'.trim();

  factory SuggestedDoctor.fromJson(Map<String, dynamic> j) => SuggestedDoctor(
        id: '${j['id']}',
        firstName: j['first_name'] as String? ?? '',
        lastName: j['last_name'] as String? ?? '',
        specializationDisplay: j['specialization_display'] as String? ?? '',
        averageRating: (j['average_rating'] as num?)?.toDouble(),
        city: j['city'] as String? ?? j['primary_workplace_city'] as String? ?? '',
      );
}

class MessageModel {
  static const roleUser = 'user';
  static const roleAssistant = 'assistant';

  final String id;
  final String role;
  final String content;
  final List<SuggestedDoctor> suggestedDoctors;
  final bool flagged;
  final DateTime createdAt;

  /// Backend-localized disclaimer, when the serializer exposes it as its own
  /// field. The disclaimer is also appended to [content] as a final paragraph.
  final String? disclaimer;

  const MessageModel({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
    this.suggestedDoctors = const [],
    this.flagged = false,
    this.disclaimer,
  });

  bool get isUser => role == roleUser;
  bool get isAssistant => role == roleAssistant;

  MessageModel copyWith({bool? flagged}) => MessageModel(
        id: id,
        role: role,
        content: content,
        createdAt: createdAt,
        suggestedDoctors: suggestedDoctors,
        flagged: flagged ?? this.flagged,
        disclaimer: disclaimer,
      );

  factory MessageModel.fromJson(Map<String, dynamic> j) => MessageModel(
        id: j['id'] as String,
        role: j['role'] as String? ?? roleAssistant,
        content: j['content'] as String? ?? '',
        suggestedDoctors: (j['suggested_doctors'] as List<dynamic>? ?? [])
            .map((e) => SuggestedDoctor.fromJson(e as Map<String, dynamic>))
            .toList(),
        flagged: j['flagged'] as bool? ?? false,
        disclaimer: j['disclaimer'] as String?,
        createdAt: DateTime.tryParse(j['created_at'] as String? ?? '') ??
            DateTime.now(),
      );
}

class ConversationModel {
  final String id;
  final DateTime updatedAt;
  final String lastMessagePreview;

  const ConversationModel({
    required this.id,
    required this.updatedAt,
    this.lastMessagePreview = '',
  });

  factory ConversationModel.fromJson(Map<String, dynamic> j) {
    // The list serializer may expose the preview as a plain string or as a
    // nested last-message object — accept both.
    final lm = j['last_message'];
    var preview = switch (lm) {
      final Map<dynamic, dynamic> m => m['content'] as String? ?? '',
      final String s => s,
      _ => '',
    };
    if (preview.isEmpty) {
      preview = j['last_message_preview'] as String? ?? '';
    }
    return ConversationModel(
      id: j['id'] as String,
      updatedAt: DateTime.tryParse(j['updated_at'] as String? ?? '') ??
          DateTime.now(),
      lastMessagePreview: preview,
    );
  }
}

class ConversationDetailModel {
  final String id;
  final List<MessageModel> messages;

  const ConversationDetailModel({required this.id, required this.messages});

  factory ConversationDetailModel.fromJson(Map<String, dynamic> j) =>
      ConversationDetailModel(
        id: j['id'] as String,
        messages: (j['messages'] as List<dynamic>? ?? [])
            .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
