import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';

class DoctorOnboardingScreen extends ConsumerWidget {
  const DoctorOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        actions: [
          TextButton(
            onPressed: () => ref.read(authProvider.notifier).logout(),
            child: const Text('Sign Out'),
          ),
        ],
      ),
      body: const EmptyState(
        icon: Icons.assignment_outlined,
        title: 'Doctor onboarding',
        subtitle: 'Guided profile setup is coming soon.',
      ),
    );
  }
}
