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

/// A verified doctor is set purely server-side (staff action in Django
/// admin) — there's no push telling this screen it happened, so it polls
/// periodically and also lets the doctor force a check, then routes to
/// `/doctor/home` the moment `isVerified` flips true. Without this the
/// doctor would be stuck here until they manually signed out and back in.
const _pollInterval = Duration(seconds: 20);

class DoctorPendingVerificationScreen extends ConsumerStatefulWidget {
  const DoctorPendingVerificationScreen({super.key});

  @override
  ConsumerState<DoctorPendingVerificationScreen> createState() =>
      _DoctorPendingVerificationScreenState();
}

class _DoctorPendingVerificationScreenState
    extends ConsumerState<DoctorPendingVerificationScreen> {
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
      context.go('/doctor/home');
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
                  onPressed: () =>
                      ref.read(authProvider.notifier).logout(),
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
