import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';

class AppointmentDetailScreen extends ConsumerStatefulWidget {
  const AppointmentDetailScreen({super.key, required this.appointment});
  final AppointmentModel appointment;

  @override
  ConsumerState<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState
    extends ConsumerState<AppointmentDetailScreen> {
  bool _cancelling = false;

  Future<void> _cancel() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content:
            const Text('Are you sure you want to cancel this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text('Cancel Appointment'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _cancelling = true);
    try {
      await ref
          .read(appointmentRepositoryProvider)
          .cancelAppointment(widget.appointment.id);
      ref.invalidate(patientAppointmentsProvider);
      if (mounted) context.pop();
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.userMessage)));
      }
    } finally {
      if (mounted) setState(() => _cancelling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appt = widget.appointment;
    final fmt = DateFormat('d MMM y');
    final timeFmt = DateFormat('HH:mm');
    final statusColor = StatusChip.colorFor(appt.status);

    return Scaffold(
      appBar: AppBar(title: const Text('Appointment')),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedEntrance(
                slideY: 0.05,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border:
                        Border.all(color: statusColor.withValues(alpha: 0.30)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_statusIcon(appt.status), color: statusColor, size: 18),
                      const Gap(8),
                      Text(
                        StatusChip.labelFor(appt.status).toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              AnimatedEntrance(
                index: 1,
                child: _InfoCard(
                  label: 'Doctor',
                  icon: Icons.person_outline_rounded,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appt.doctor.fullName,
                          style: Theme.of(context).textTheme.titleSmall),
                      const Gap(2),
                      Text(appt.doctor.specializationDisplay,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
              AnimatedEntrance(
                index: 2,
                child: _InfoCard(
                  label: 'Workplace',
                  icon: Icons.business_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appt.workplace.name,
                          style: Theme.of(context).textTheme.titleSmall),
                      const Gap(2),
                      Text('${appt.workplace.address}, ${appt.workplace.city}',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
              AnimatedEntrance(
                index: 3,
                child: _InfoCard(
                  label: 'Date & Time',
                  icon: Icons.calendar_today_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fmt.format(appt.startsAt),
                          style: Theme.of(context).textTheme.titleSmall),
                      const Gap(2),
                      Text(
                        '${timeFmt.format(appt.startsAt)} – ${timeFmt.format(appt.endsAt)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              if (appt.reason.isNotEmpty)
                AnimatedEntrance(
                  index: 4,
                  child: _InfoCard(
                    label: 'Reason',
                    icon: Icons.notes_outlined,
                    child: Text(appt.reason,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: context.colors.textPrimary,
                            )),
                  ),
                ),
              if (appt.notes.isNotEmpty)
                AnimatedEntrance(
                  index: 5,
                  child: _InfoCard(
                    label: 'Doctor Notes',
                    icon: Icons.medical_information_outlined,
                    child: Text(appt.notes,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: context.colors.textPrimary,
                            )),
                  ),
                ),
              const Gap(16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: appt.canCancel
          ? BottomActionBar(
              child: OutlinedButton(
                onPressed: _cancelling
                    ? null
                    : () {
                        HapticFeedback.lightImpact();
                        _cancel();
                      },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: BorderSide(color: AppColors.error.withValues(alpha: 0.6)),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md)),
                ),
                child: _cancelling
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: AppColors.error),
                      )
                    : const Text('Cancel Appointment',
                        style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            )
          : null,
    );
  }

  IconData _statusIcon(String status) => switch (status) {
        'confirmed' => Icons.check_circle_outline,
        'pending' => Icons.schedule_outlined,
        'cancelled' || 'declined' => Icons.cancel_outlined,
        'requires_rescheduling' => Icons.sync_problem_outlined,
        _ => Icons.info_outline,
      };
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.label,
    required this.icon,
    required this.child,
  });

  final String label;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: c.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.md + 2),
        border: Border.all(color: c.border, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: double.infinity,
            constraints: const BoxConstraints(minHeight: 60),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.md + 2),
                bottomLeft: Radius.circular(AppRadius.md + 2),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 14, color: c.primaryText),
                      const Gap(5),
                      Text(
                        label.toUpperCase(),
                        style: TextStyle(
                          color: c.primaryText,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
