import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/config/app_config.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_badge.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/core/widgets/tinted_notice_banner.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/subscription/data/models/subscription_model.dart';
import 'package:medalize_mb/features/subscription/data/repository/subscription_repository.dart';
import 'package:medalize_mb/features/subscription/providers/subscription_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

/// The doctor-only paywall/status screen. Reached two ways:
/// - [fromGate]=true: pushed by the router's `_homeFor` redirect when the
///   subscription has expired — full-screen, no way back except subscribing
///   or signing out (mirrors DoctorPendingVerificationScreen).
/// - [fromGate]=false: opened voluntarily (e.g. from the profile screen) to
///   check status or change plans — a normal pushed screen with a back
///   button.
class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key, required this.fromGate});

  final bool fromGate;

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen>
    with WidgetsBindingObserver {
  String? _checkingOutPlan;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Same pattern as PaymentScreen: the doctor completes checkout in the
    // external browser Payriff opens, so returning to the app is the only
    // signal that something may have changed.
    if (state == AppLifecycleState.resumed) {
      _refresh();
    }
  }

  Future<void> _refresh() async {
    final wasEntitled = ref.read(subscriptionProvider).valueOrNull?.isExpired == false;
    refreshSubscriptionStatus(ref);
    await ref.read(authProvider.notifier).refreshProfile();
    final updated = await ref.read(subscriptionProvider.future);
    if (!mounted) return;
    if (widget.fromGate && !updated.isExpired) {
      context.go('/doctor/home');
      return;
    }
    if (!wasEntitled && !updated.isExpired) {
      AppSnackBar.show(context, context.t.subscription.nowActive,
          type: SnackBarType.success);
    }
  }

  Future<void> _subscribe(String plan) async {
    setState(() => _checkingOutPlan = plan);
    try {
      final url =
          await ref.read(subscriptionRepositoryProvider).checkout(plan);
      if (!mounted) return;
      final uri = Uri.tryParse(url);
      if (uri == null) return;
      HapticFeedback.lightImpact();
      AppSnackBar.show(context, context.t.payments.openingBrowser);
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && mounted) {
        AppSnackBar.show(context, context.t.common.somethingWrong,
            type: SnackBarType.error);
      }
    } on SubscriptionUnavailableException {
      if (mounted) {
        AppSnackBar.show(context, context.t.subscription.unavailable,
            type: SnackBarType.error);
      }
    } on ApiException catch (e) {
      if (mounted) AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => _checkingOutPlan = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(subscriptionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.subscription.title),
        automaticallyImplyLeading: !widget.fromGate,
        actions: widget.fromGate
            ? [
                TextButton(
                  onPressed: () => ref.read(authProvider.notifier).logout(),
                  child: Text(context.t.common.signOut),
                ),
              ]
            : null,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: AppColors.primary,
        child: ResponsiveBody(
          child: async.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(children: [
                ShimmerSkeleton(height: 80),
                Gap(AppSpacing.md),
                ShimmerSkeleton(height: 220),
              ]),
            ),
            error: (_, _) => EmptyState(
              icon: Icons.cloud_off_outlined,
              title: context.t.common.somethingWrong,
              subtitle: context.t.subscription.couldNotLoad,
              actionLabel: context.t.common.retry,
              onAction: () => ref.invalidate(subscriptionProvider),
            ),
            data: (sub) => _body(context, sub),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, SubscriptionModel sub) {
    final plansAsync = ref.watch(subscriptionPlansProvider);
    return ListView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        _statusBanner(context, sub),
        const Gap(AppSpacing.lg),
        plansAsync.when(
          loading: () => const Column(children: [
            ShimmerSkeleton(height: 200),
            Gap(AppSpacing.sm),
            ShimmerSkeleton(height: 200),
          ]),
          error: (_, _) => Text(context.t.subscription.couldNotLoad),
          data: (plans) => Column(
            children: [
              for (final plan in plans) ...[
                _PlanCard(
                  plan: plan,
                  isCurrent: sub.plan == plan.plan &&
                      (sub.status == SubscriptionModel.statusActive ||
                          sub.status == SubscriptionModel.statusPastDue),
                  loading: _checkingOutPlan == plan.plan,
                  onSubscribe: () => _subscribe(plan.plan),
                ),
                const Gap(AppSpacing.sm),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusBanner(BuildContext context, SubscriptionModel sub) {
    final now = DateTime.now();
    switch (sub.status) {
      case SubscriptionModel.statusTrialing:
        final days = sub.trialEndsAt != null
            ? sub.trialEndsAt!.difference(now).inDays.clamp(0, 999)
            : 0;
        return TintedNoticeBanner(
          color: AppColors.primary,
          icon: Icons.hourglass_top_rounded,
          child: Text(context.t.subscription.trialDaysLeft(days: days)),
        );
      case SubscriptionModel.statusPastDue:
        final days = sub.graceEndsAt != null
            ? sub.graceEndsAt!.difference(now).inDays.clamp(0, 999)
            : 0;
        return TintedNoticeBanner(
          color: AppColors.warning,
          icon: Icons.error_outline_rounded,
          child: Text(context.t.subscription.graceDaysLeft(days: days)),
        );
      case SubscriptionModel.statusExpired:
        return TintedNoticeBanner(
          color: AppColors.error,
          icon: Icons.visibility_off_outlined,
          child: Text(context.t.subscription.expiredNotice),
        );
      case SubscriptionModel.statusActive:
        return TintedNoticeBanner(
          color: AppColors.success,
          icon: Icons.check_circle_outline_rounded,
          child: Text(context.t.subscription.activeNotice),
        );
      default:
        return TintedNoticeBanner(
          color: AppColors.primary,
          icon: Icons.info_outline_rounded,
          child: Text(context.t.subscription.choosePlan),
        );
    }
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.isCurrent,
    required this.loading,
    required this.onSubscribe,
  });

  final SubscriptionPlanModel plan;
  final bool isCurrent;
  final bool loading;
  final VoidCallback onSubscribe;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final isPro = plan.plan == SubscriptionPlanModel.pro;

    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(_planDisplayName(context, plan.plan),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ),
              if (isCurrent)
                AppBadge(label: context.t.subscription.currentPlan, color: AppColors.success)
              else if (isPro)
                AppBadge(label: context.t.subscription.mostPopular, color: AppColors.primary),
            ],
          ),
          const Gap(6),
          if (AppConfig.showSubscriptionPricing) ...[
            Text(
              '${plan.price} ${plan.currency}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(context.t.subscription.perMonth,
                style: TextStyle(color: c.textSecondary, fontSize: 12)),
          ] else
            Text(context.t.subscription.manageOnWeb,
                style: TextStyle(color: c.textSecondary)),
          const Gap(12),
          _FeatureRow(
            included: true,
            label: plan.limits.workplaces == null
                ? context.t.subscription.featureUnlimitedWorkplaces
                : context.t.subscription.featureWorkplaces(count: plan.limits.workplaces!),
          ),
          _FeatureRow(
            included: true,
            label: plan.limits.appointmentsPerMonth == null
                ? context.t.subscription.featureUnlimitedBookings
                : context.t.subscription
                    .featureBookingsPerMonth(count: plan.limits.appointmentsPerMonth!),
          ),
          _FeatureRow(included: plan.limits.chat, label: context.t.subscription.featureChat),
          _FeatureRow(
              included: plan.limits.promoted,
              label: context.t.subscription.featurePromoted),
          if (AppConfig.showSubscriptionPricing) ...[
            const Gap(12),
            SizedBox(
              width: double.infinity,
              child: LoadingFilledButton(
                label: isCurrent
                    ? context.t.subscription.renew
                    : context.t.subscription.subscribe,
                loading: loading,
                onPressed: onSubscribe,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Localizes the tier name for display — the backend's `plan.name` field
/// (apps.subscriptions.plans.PLAN_NAMES) is always the Azerbaijani brand
/// name ("Başlanğıc"/"Peşəkar"), since it's also baked into notification
/// copy and Payriff's checkout description where a single canonical name is
/// wanted. The paywall screen itself localizes it per viewer language;
/// falls back to the raw backend name for a plan code the client doesn't
/// recognize yet, so a future third tier degrades gracefully instead of
/// showing a blank string.
String _planDisplayName(BuildContext context, String planCode) => switch (planCode) {
      SubscriptionPlanModel.basic => context.t.subscription.planNameBasic,
      SubscriptionPlanModel.pro => context.t.subscription.planNamePro,
      _ => planCode,
    };

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.included, required this.label});

  final bool included;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            included ? Icons.check_circle_rounded : Icons.remove_circle_outline_rounded,
            size: 16,
            color: included ? AppColors.success : c.textSecondary,
          ),
          const Gap(8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: included ? c.textPrimary : c.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
