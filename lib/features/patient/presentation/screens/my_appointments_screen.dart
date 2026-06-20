import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';

class MyAppointmentsScreen extends ConsumerStatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  ConsumerState<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends ConsumerState<MyAppointmentsScreen>
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
        title: const Text('My Appointments'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Past')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _AppointmentList(
            filterFn: (a) => a.isUpcoming,
            onRefresh: () => ref.refresh(patientAppointmentsProvider(null)),
          ),
          _AppointmentList(
            filterFn: (a) => !a.isUpcoming,
            onRefresh: () => ref.refresh(patientAppointmentsProvider(null)),
          ),
        ],
      ),
    );
  }
}

class _AppointmentList extends ConsumerWidget {
  const _AppointmentList({required this.filterFn, required this.onRefresh});
  final bool Function(AppointmentModel) filterFn;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(patientAppointmentsProvider(null));
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
            itemBuilder: (_, i) => _AppointmentCard(appointment: items[i]),
          ),
        );
      },
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard({required this.appointment});
  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM y, HH:mm');
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.calendar_today, color: AppColors.primary),
        title: Text(appointment.doctor.fullName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appointment.workplace.name),
            Text(fmt.format(appointment.startsAt)),
          ],
        ),
        trailing: _StatusBadge(status: appointment.status),
        isThreeLine: true,
        onTap: () => context.push(
          '/patient/appointment-detail/${appointment.id}',
          extra: appointment,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  Color get _color => switch (status) {
        'confirmed' => Colors.green,
        'pending' => Colors.orange,
        'cancelled' || 'declined' => Colors.grey,
        'requires_rescheduling' => Colors.red,
        _ => Colors.blueGrey,
      };

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status.replaceAll('_', ' '),
          style: TextStyle(color: _color, fontSize: 11, fontWeight: FontWeight.w600),
        ),
      );
}
