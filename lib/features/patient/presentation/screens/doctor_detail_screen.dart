import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';

class DoctorDetailScreen extends ConsumerWidget {
  const DoctorDetailScreen({super.key, required this.doctorId, this.doctor});

  final String doctorId;
  final DoctorModel? doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(doctorDetailProvider(doctorId));

    return Scaffold(
      appBar: AppBar(title: Text(doctor?.fullName ?? 'Doctor Profile')),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (detail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Text(
                      detail.firstName.isNotEmpty ? detail.firstName[0].toUpperCase() : 'D',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(detail.fullName,
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(detail.specializationDisplay,
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('${detail.slotDurationMin} min slots',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              if (detail.bio.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text('About', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(detail.bio),
              ],
              const SizedBox(height: 20),
              Text('Workplaces', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...detail.workplaces.map((wp) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: AppColors.primary),
                      title: Text(wp.name),
                      subtitle: Text('${wp.address}, ${wp.city}'),
                      trailing: wp.isPrimary
                          ? const Chip(label: Text('Primary'))
                          : null,
                    ),
                  )),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push(
                    '/patient/booking-calendar/${detail.id}',
                    extra: detail,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Book Appointment'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
