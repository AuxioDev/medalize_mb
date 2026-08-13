import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/payments/data/models/payment_model.dart';
import 'package:medalize_mb/features/payments/providers/payment_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

/// Small colored pill for a payment status. Deliberately not the shared
/// `StatusChip` (core/widgets/status_chip.dart): that widget's color/label
/// switch is keyed to appointment status codes (`confirmed`, `pending`, …)
/// and its labels come from the global `status.*` i18n section — payment
/// statuses need their own `payments.status*` strings. This copies
/// `StatusChip`'s exact visual language (same padding, radius, font) so it
/// still reads as the same design system.
class PaymentStatusChip extends StatelessWidget {
  const PaymentStatusChip({super.key, required this.status});

  final String status;

  static Color colorFor(String status) => switch (status) {
        PaymentModel.statusPaid => AppColors.success,
        PaymentModel.statusFailed => AppColors.error,
        PaymentModel.statusRefundFailed => AppColors.error,
        PaymentModel.statusCancelled => const Color(0xFF94A3B8),
        PaymentModel.statusRefunded => const Color(0xFF94A3B8),
        _ => AppColors.warning,
      };

  static String labelFor(BuildContext context, String status) => switch (status) {
        PaymentModel.statusPaid => context.t.payments.statusPaid,
        PaymentModel.statusFailed => context.t.payments.statusFailed,
        PaymentModel.statusRefundFailed => context.t.payments.statusRefundFailed,
        PaymentModel.statusCancelled => context.t.payments.statusCancelled,
        PaymentModel.statusRefunded => context.t.payments.statusRefunded,
        _ => context.t.payments.statusPending,
      };

  @override
  Widget build(BuildContext context) {
    final color = colorFor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Text(
        labelFor(context, status),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key, required this.appointmentId});

  final String appointmentId;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen>
    with WidgetsBindingObserver {
  bool _opening = false;
  bool _refreshing = false;

  /// Local mirror of the latest confirmed payment, set only by
  /// [_refreshStatus]. Once populated it takes priority over
  /// [paymentProvider]'s own value in [build] so a background resume-refresh
  /// updates the screen calmly and immediately, without depending on exactly
  /// how the provider's `AsyncLoading` transition behaves in-between —
  /// same "local mirror" pattern `AppointmentDetailScreen` uses for its
  /// review state.
  PaymentModel? _payment;

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
    // The patient completes checkout in the external browser Payriff opens;
    // returning to the app is the only signal we get that something may have
    // changed, so re-fetch the authoritative status from the backend. Mirrors
    // the WidgetsBindingObserver pattern in main.dart (biometric re-lock),
    // scoped locally to this screen rather than touching global lifecycle
    // code.
    if (state == AppLifecycleState.resumed) {
      _refreshStatus();
    }
  }

  Future<void> _refreshStatus() async {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    // Consider whatever is currently on screen — the local mirror if a
    // previous refresh already set one, otherwise the provider's initial
    // load — so a *first* resume-refresh on an appointment that was already
    // paid before the patient ever left the app doesn't mistake that for a
    // fresh confirmation.
    final current = _payment ?? ref.read(paymentProvider(widget.appointmentId)).valueOrNull;
    final wasAlreadyPaid = current?.isPaid ?? false;
    try {
      refreshPaymentStatus(ref, widget.appointmentId);
      final updated = await ref.read(paymentProvider(widget.appointmentId).future);
      if (!mounted) return;
      setState(() => _payment = updated);
      if (updated != null && updated.isPaid && !wasAlreadyPaid) {
        AppSnackBar.show(context, context.t.payments.paymentConfirmed,
            type: SnackBarType.success);
      }
    } catch (_) {
      // Best-effort: a failed re-check just leaves whatever was already on
      // screen rather than surfacing a scary error for what is, from the
      // patient's point of view, simply "I came back to the app".
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  Future<void> _openCheckout(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    HapticFeedback.lightImpact();
    AppSnackBar.show(context, context.t.payments.openingBrowser);
    setState(() => _opening = true);
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && mounted) {
        AppSnackBar.show(context, context.t.common.somethingWrong,
            type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _opening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(paymentProvider(widget.appointmentId));
    final payment = _payment ?? async.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(context.t.payments.title, icon: Icons.payment_outlined),
      ),
      body: ResponsiveBody(child: _body(context, async, payment)),
      bottomNavigationBar: BottomActionBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (payment != null &&
                payment.isPending &&
                payment.paymentUrl.isNotEmpty) ...[
              SizedBox(
                width: double.infinity,
                child: LoadingFilledButton(
                  label: context.t.payments.payNow,
                  icon: Icons.open_in_new_rounded,
                  loading: _opening,
                  onPressed: () => _openCheckout(payment.paymentUrl),
                ),
              ),
              const Gap(AppSpacing.sm),
            ],
            TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                context.pop();
              },
              child: Text(context.t.payments.payLater),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, AsyncValue<PaymentModel?> async, PaymentModel? payment) {
    if (payment != null) {
      final c = context.colors;
      final reducedMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.t.payments.amount,
                        style: TextStyle(
                          color: c.primaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      PaymentStatusChip(status: payment.status),
                    ],
                  ),
                  const Gap(6),
                  Text(
                    '${payment.amount} ${payment.currency}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (payment.isPaid) ...[
                    const Gap(14),
                    _PaymentConfirmedRow(reducedMotion: reducedMotion),
                  ],
                ],
              ),
            ),
            const Gap(AppSpacing.sm),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _refreshing ? null : _refreshStatus,
                icon: _refreshing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh_rounded, size: 16),
                label: Text(context.t.payments.checkStatus),
              ),
            ),
          ],
        ),
      );
    }

    if (async.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(children: [ShimmerSkeleton(height: 160)]),
      );
    }

    return EmptyState(
      icon: Icons.cloud_off_outlined,
      title: context.t.common.somethingWrong,
      subtitle: context.t.common.tryAgain,
      actionLabel: context.t.common.retry,
      onAction: () => ref.invalidate(paymentProvider(widget.appointmentId)),
    );
  }
}

/// Scale + fade reveal for the "payment confirmed" checkmark — booking
/// success itself is now a plain snackbar (booking_calendar_screen.dart), so
/// this is the one high-relief celebratory moment left in the patient
/// journey. Mirrors the splash screen's literal `elasticOut` icon "pop"
/// followed by a delayed text
/// fade-in (see splash_screen.dart's `_Logo`/tagline) rather than the routine
/// `AppCurve` tokens, which read too subtle for a one-off celebratory reveal.
/// Honors reduced-motion like the assistant chat's typing indicator and
/// [EmptyState].
class _PaymentConfirmedRow extends StatelessWidget {
  const _PaymentConfirmedRow({required this.reducedMotion});

  final bool reducedMotion;

  @override
  Widget build(BuildContext context) {
    Widget icon = const Icon(Icons.check_circle_outline_rounded,
        color: AppColors.success, size: 18);
    Widget label = Text(
      context.t.payments.paymentConfirmed,
      style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600),
    );
    if (!reducedMotion) {
      icon = icon
          .animate()
          .scale(
            begin: const Offset(0.4, 0.4),
            end: const Offset(1.0, 1.0),
            duration: 450.ms,
            curve: Curves.elasticOut,
          )
          .fadeIn(duration: 200.ms);
      label = label.animate().fadeIn(delay: 150.ms, duration: 250.ms);
    }
    return Row(
      children: [
        icon,
        const Gap(8),
        Expanded(child: label),
      ],
    );
  }
}
