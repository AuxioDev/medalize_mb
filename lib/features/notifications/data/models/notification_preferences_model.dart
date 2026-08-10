class NotificationPreferences {
  final bool pushEnabled;
  final bool emailEnabled;
  final bool carePushEnabled;
  final bool messagesPushEnabled;
  final bool accountPushEnabled;
  final bool quietHoursEnabled;
  // Backend TimeField serialized as "HH:MM:SS" — kept as a raw string here,
  // parsed into a TimeOfDay only where the UI needs one (see
  // notification_settings_screen.dart), so this model stays a thin mirror
  // of the wire format.
  final String quietHoursStart;
  final String quietHoursEnd;

  const NotificationPreferences({
    required this.pushEnabled,
    required this.emailEnabled,
    this.carePushEnabled = true,
    this.messagesPushEnabled = true,
    this.accountPushEnabled = true,
    this.quietHoursEnabled = false,
    this.quietHoursStart = '22:00:00',
    this.quietHoursEnd = '08:00:00',
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> j) =>
      NotificationPreferences(
        pushEnabled: j['push_enabled'] as bool? ?? true,
        emailEnabled: j['email_enabled'] as bool? ?? true,
        carePushEnabled: j['care_push_enabled'] as bool? ?? true,
        messagesPushEnabled: j['messages_push_enabled'] as bool? ?? true,
        accountPushEnabled: j['account_push_enabled'] as bool? ?? true,
        quietHoursEnabled: j['quiet_hours_enabled'] as bool? ?? false,
        quietHoursStart: j['quiet_hours_start'] as String? ?? '22:00:00',
        quietHoursEnd: j['quiet_hours_end'] as String? ?? '08:00:00',
      );
}
