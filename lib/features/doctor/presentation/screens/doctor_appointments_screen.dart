import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';

class DoctorAppointmentsScreen extends ConsumerStatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  ConsumerState<DoctorAppointmentsScreen> createState() => _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends ConsumerState<DoctorAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: 'Pending'), Tab(text: 'All')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _DoctorAppList(
            filterFn: (a) => a.status == 'pending',
            showActions: true,
            onRefresh: () => ref.invalidate(doctorAppointmentsProvider),
          ),
          _DoctorAppList(
            filterFn: (_) => true,
            showActions: false,
            onRefresh: () => ref.invalidate(doctorAppointmentsProvider),
          ),
        ],
      ),
    );
  }
}

class _DoctorAppList extends ConsumerWidget {
  const _DoctorAppList({
    required this.filterFn,
    required this.showActions,
    required this.onRefresh,
  });

  final bool Function(AppointmentModel) filterFn;
  final bool showActions;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(doctorAppointmentsProvider(null));
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (all) {
        final items = all.where(filterFn).toList();
        if (items.isEmpty) return const Center(child: Text('No appointments'));
        return RefreshIndicator(
          onRefresh: () async => onRefresh(),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) => _DoctorAppCard(
              appointment: items[i],
              showActions: showActions,
              onUpdated: onRefresh,
            ),
          ),
        );
      },
    );
  }
}

class _DoctorAppCard extends ConsumerWidget {
  const _DoctorAppCard({
    required this.appointment,
    required this.showActions,
    required this.onUpdated,
  });

  final AppointmentModel appointment;
  final bool showActions;
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

  Color _statusColor(String s) => switch (s) {
        'confirmed' => Colors.green,
        'pending' => Colors.orange,
        'cancelled' || 'declined' => Colors.grey,
        'requires_rescheduling' => Colors.red,
        _ => Colors.blueGrey,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fmt = DateFormat('d MMM y, HH:mm');
    final statusColor = _statusColor(appointment.status);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    appointment.patient.fullName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    appointment.status.replaceAll('_', ' '),
                    style: TextStyle(color: statusColor, fontSize: 11),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(fmt.format(appointment.startsAt),
                style: Theme.of(context).textTheme.bodySmall),
            Text(appointment.workplace.name,
                style: Theme.of(context).textTheme.bodySmall),
            if (appointment.reason.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text('Reason: ${appointment.reason}',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
            if (showActions) ...[
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
                      child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
