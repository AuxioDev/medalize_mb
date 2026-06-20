import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/notifications/providers/notification_provider.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';

class DoctorHomeScreen extends ConsumerWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final name = auth is AuthAuthenticated ? auth.email.split('@')[0] : '';
    final unread = ref.watch(unreadCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medalize'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () => context.push('/shared/notifications'),
              ),
              if (unread > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                    child: Text(
                      '$unread',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/shared/settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(doctorAppointmentsProvider),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Hello, Dr. $name!',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text('Manage your schedule and appointments.',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            _DoctorQuickActions(),
            const SizedBox(height: 24),
            Text('Pending Requests',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _PendingAppointmentsList(),
          ],
        ),
      ),
    );
  }
}

class _DoctorQuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _ActionCard(
          icon: Icons.calendar_month_outlined,
          label: 'Appointments',
          onTap: () => context.push('/doctor/appointments'),
        ),
        _ActionCard(
          icon: Icons.business_outlined,
          label: 'Workplaces',
          onTap: () => context.push('/doctor/workplaces'),
        ),
        _ActionCard(
          icon: Icons.block_outlined,
          label: 'Block Time',
          onTap: () => context.push('/doctor/block-time'),
        ),
        _ActionCard(
          icon: Icons.person_outline,
          label: 'Profile',
          onTap: () => context.push('/shared/profile'),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.primary, size: 28),
                const SizedBox(height: 6),
                Text(label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
        ),
      );
}

class _PendingAppointmentsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(doctorAppointmentsProvider(null));
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const Text('Failed to load appointments'),
      data: (all) {
        final pending = all.where((a) => a.status == 'pending').take(5).toList();
        if (pending.isEmpty) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: Text('No pending requests')),
            ),
          );
        }
        return Column(
          children: pending
              .map((a) => _PendingCard(
                    appointment: a,
                    onUpdated: () => ref.invalidate(doctorAppointmentsProvider),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _PendingCard extends ConsumerWidget {
  const _PendingCard({required this.appointment, required this.onUpdated});
  final AppointmentModel appointment;
  final VoidCallback onUpdated;

  Future<void> _updateStatus(WidgetRef ref, BuildContext context, String status) async {
    try {
      await ref.read(appointmentRepositoryProvider).updateAppointmentStatus(appointment.id, status);
      ref.invalidate(doctorAppointmentsProvider);
      onUpdated();
    } on ApiException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.userMessage)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fmt = DateFormat('d MMM y, HH:mm');
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appointment.patient.fullName,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(fmt.format(appointment.startsAt),
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _updateStatus(ref, context, 'declined'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _updateStatus(ref, context, 'confirmed'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    child: const Text('Confirm',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
