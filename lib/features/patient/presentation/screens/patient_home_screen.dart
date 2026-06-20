import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/notifications/providers/notification_provider.dart';
import 'package:intl/intl.dart';

class PatientHomeScreen extends ConsumerWidget {
  const PatientHomeScreen({super.key});

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
        onRefresh: () async => ref.invalidate(patientAppointmentsProvider),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Hello, $name!', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text('Find a doctor and book an appointment.',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            _QuickActionsRow(),
            const SizedBox(height: 24),
            Text('Upcoming Appointments',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _UpcomingAppointments(),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            icon: Icons.search,
            label: 'Find Doctor',
            onTap: () => context.push('/patient/doctor-search'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            icon: Icons.calendar_month_outlined,
            label: 'My Appointments',
            onTap: () => context.push('/patient/appointments'),
          ),
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
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 32),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpcomingAppointments extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(patientAppointmentsProvider(null));
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const Text('Failed to load appointments'),
      data: (all) {
        final upcoming = all.where((a) => a.isUpcoming).take(3).toList();
        if (upcoming.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      color: Colors.grey, size: 40),
                  const SizedBox(height: 8),
                  const Text('No upcoming appointments'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.push('/patient/doctor-search'),
                    child: const Text('Book Now'),
                  ),
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            ...upcoming.map((a) => _MiniAppointmentCard(a)),
            if (all.where((a) => a.isUpcoming).length > 3)
              TextButton(
                onPressed: () => context.push('/patient/appointments'),
                child: const Text('See all'),
              ),
          ],
        );
      },
    );
  }
}

class _MiniAppointmentCard extends StatelessWidget {
  const _MiniAppointmentCard(this.appt);
  final AppointmentModel appt;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM, HH:mm');
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.calendar_today, color: AppColors.primary),
        title: Text(appt.doctor.fullName),
        subtitle: Text(fmt.format(appt.startsAt)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(
          '/patient/appointment-detail/${appt.id}',
          extra: appt,
        ),
      ),
    );
  }
}
