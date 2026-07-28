class SubscriptionLimits {
  final int? workplaces;
  final int? appointmentsPerMonth;
  final bool chat;
  final bool promoted;
  final bool advancedStats;

  /// Hospital plans only (apps.subscriptions.plans.HOSPITAL_PLAN_LIMITS) —
  /// null for doctor plans, which have no such concept.
  final int? doctors;

  const SubscriptionLimits({
    this.workplaces,
    this.appointmentsPerMonth,
    this.chat = false,
    this.promoted = false,
    this.advancedStats = false,
    this.doctors,
  });

  factory SubscriptionLimits.fromJson(Map<String, dynamic> j) => SubscriptionLimits(
        workplaces: j['workplaces'] as int?,
        appointmentsPerMonth: j['appointments_per_month'] as int?,
        chat: j['chat'] as bool? ?? false,
        promoted: j['promoted'] as bool? ?? false,
        advancedStats: j['advanced_stats'] as bool? ?? false,
        doctors: j['doctors'] as int?,
      );
}

class SubscriptionUsage {
  final int workplaces;
  final int appointmentsThisMonth;

  /// Hospital plans only (GET /hospital/subscription/'s `usage.doctors` —
  /// a distinct key from the doctor-plan `usage` shape, never both at once).
  final int doctors;

  const SubscriptionUsage({
    this.workplaces = 0,
    this.appointmentsThisMonth = 0,
    this.doctors = 0,
  });

  factory SubscriptionUsage.fromJson(Map<String, dynamic> j) => SubscriptionUsage(
        workplaces: j['workplaces'] as int? ?? 0,
        appointmentsThisMonth: j['appointments_this_month'] as int? ?? 0,
        doctors: j['doctors'] as int? ?? 0,
      );
}

/// Mirrors the `subscription` block returned by GET /doctor/subscription/,
/// and embedded (minus [usage]) in the login response and GET /auth/me/ —
/// one shape everywhere, matching the backend's
/// `apps.subscriptions.entitlements.subscription_summary`.
class SubscriptionModel {
  static const statusPending = 'pending';
  static const statusTrialing = 'trialing';
  static const statusActive = 'active';
  static const statusPastDue = 'past_due';
  static const statusExpired = 'expired';

  final String status;
  final String plan;
  final String effectivePlan;
  final DateTime? trialEndsAt;
  final DateTime? currentPeriodEnd;
  final DateTime? graceEndsAt;
  final SubscriptionLimits limits;
  final SubscriptionUsage? usage;

  const SubscriptionModel({
    this.status = statusPending,
    this.plan = '',
    this.effectivePlan = 'none',
    this.trialEndsAt,
    this.currentPeriodEnd,
    this.graceEndsAt,
    this.limits = const SubscriptionLimits(),
    this.usage,
  });

  bool get isTrialing => status == statusTrialing;
  bool get isPastDue => status == statusPastDue;
  bool get isExpired => status == statusExpired;

  factory SubscriptionModel.fromJson(Map<String, dynamic> j) => SubscriptionModel(
        status: j['status'] as String? ?? statusPending,
        plan: j['plan'] as String? ?? '',
        effectivePlan: j['effective_plan'] as String? ?? 'none',
        trialEndsAt: j['trial_ends_at'] != null
            ? DateTime.tryParse(j['trial_ends_at'] as String)
            : null,
        currentPeriodEnd: j['current_period_end'] != null
            ? DateTime.tryParse(j['current_period_end'] as String)
            : null,
        graceEndsAt: j['grace_ends_at'] != null
            ? DateTime.tryParse(j['grace_ends_at'] as String)
            : null,
        limits: SubscriptionLimits.fromJson(
            j['limits'] as Map<String, dynamic>? ?? const {}),
        usage: j['usage'] != null
            ? SubscriptionUsage.fromJson(j['usage'] as Map<String, dynamic>)
            : null,
      );
}

/// One entry from GET /doctor/subscription/plans/ — the paywall catalog.
class SubscriptionPlanModel {
  static const basic = 'basic';
  static const pro = 'pro';
  static const hospitalBasic = 'hospital_basic';
  static const hospitalPro = 'hospital_pro';

  final String plan;
  final String name;

  /// Kept as the raw decimal string from the backend (e.g. `"19.99"`) — same
  /// convention as `PaymentModel.amount`.
  final String price;
  final String currency;
  final SubscriptionLimits limits;

  const SubscriptionPlanModel({
    required this.plan,
    required this.name,
    this.price = '0',
    this.currency = 'AZN',
    this.limits = const SubscriptionLimits(),
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> j) => SubscriptionPlanModel(
        plan: j['plan'] as String,
        name: j['name'] as String,
        price: j['price']?.toString() ?? '0',
        currency: j['currency'] as String? ?? 'AZN',
        limits: SubscriptionLimits.fromJson(
            j['limits'] as Map<String, dynamic>? ?? const {}),
      );
}
