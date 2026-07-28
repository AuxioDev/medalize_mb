import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Mirrors DoctorPendingVerificationScreen (same poll-based pattern — the
/// claim approval is a Django-admin staff action, no push tells the client
/// it happened) with one difference: on approval this always routes to
/// `/hospital/subscription`, never `/hospital/home` — hospitals get no
/// trial (see plans.TRIAL_ROLES on the backend), so approval goes straight
/// to the paywall.
const _pollInterval = Duration(seconds: 20);

class HospitalPendingApprovalScreen extends ConsumerStatefulWidget {
  const HospitalPendingApprovalScreen({super.key});

  @override
  ConsumerState<HospitalPendingApprovalScreen> createState() =>
      _HospitalPendingApprovalScreenState();
}

class _HospitalPendingApprovalScreenState
    extends ConsumerState<HospitalPendingApprovalScreen> {
  Timer? _pollTimer;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    _pollTimer = Timer.periodic(_pollInterval, (_) => _checkStatus());
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkStatus({bool silent = true}) async {
    if (_checking) return;
    setState(() => _checking = true);
    await ref.read(authProvider.notifier).refreshProfile();
    if (!mounted) return;
    setState(() => _checking = false);

    final state = ref.read(authProvider);
    if (state is AuthAuthenticated && state.isVerified == true) {
      _pollTimer?.cancel();
      context.go('/hospital/subscription');
      return;
    }
    if (!silent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.pendingVerification.stillPending)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.hourglass_top_rounded,
                    size: 72, color: AppColors.warning),
                const SizedBox(height: AppSpacing.lg),
                Text(context.t.pendingVerification.title,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  context.t.pendingVerification.message,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xl),
                LoadingFilledButton(
                  label: context.t.pendingVerification.checkStatus,
                  loading: _checking,
                  onPressed: () => _checkStatus(silent: false),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: () => ref.read(authProvider.notifier).logout(),
                  child: Text(context.t.common.signOut),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
