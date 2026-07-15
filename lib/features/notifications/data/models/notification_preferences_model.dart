class NotificationPreferences {
  final bool pushEnabled;
  final bool emailEnabled;

  const NotificationPreferences({
    required this.pushEnabled,
    required this.emailEnabled,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> j) =>
      NotificationPreferences(
        pushEnabled: j['push_enabled'] as bool? ?? true,
        emailEnabled: j['email_enabled'] as bool? ?? true,
      );
}
