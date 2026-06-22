import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/appointments/data/models/booking_request.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';

class BookingConfirmScreen extends ConsumerStatefulWidget {
  const BookingConfirmScreen({
    super.key,
    required this.doctor,
    required this.slot,
    required this.workplaceId,
  });

  final DoctorDetailModel doctor;
  final SlotModel slot;
  final String workplaceId;

  @override
  ConsumerState<BookingConfirmScreen> createState() =>
      _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends ConsumerState<BookingConfirmScreen> {
  final _reasonController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final repo = ref.read(appointmentRepositoryProvider);
      await repo.bookAppointment(BookingRequest(
        doctorId: widget.doctor.id,
        workplaceId: widget.workplaceId,
        startsAt: widget.slot.startsAt,
        reason: _reasonController.text.trim(),
      ));
      if (mounted) {
        showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            icon: const Icon(Icons.check_circle_outline,
                color: AppColors.success, size: 40),
            title: const Text('Booked!'),
            content:
                const Text('Your appointment request has been sent.'),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/patient/home');
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } on ApiException catch (e) {
      setState(() => _error = e.userMessage);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM y, HH:mm');
    final workplace = widget.doctor.workplaces.firstWhere(
      (w) => w.id == widget.workplaceId,
      orElse: () => widget.doctor.workplaces.first,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking')),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCard(
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(label: 'Doctor', value: widget.doctor.fullName),
                    _InfoRow(label: 'Workplace', value: workplace.name),
                    _InfoRow(
                        label: 'Address',
                        value: '${workplace.address}, ${workplace.city}'),
                    _InfoRow(
                        label: 'Start', value: fmt.format(widget.slot.startsAt)),
                    _InfoRow(
                        label: 'End',
                        value: fmt.format(widget.slot.endsAt),
                        last: true),
                  ],
                ),
              ),
              const Gap(AppSpacing.md),
              TextField(
                controller: _reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason for visit (optional)',
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
              ),
              if (_error != null) ...[
                const Gap(12),
                Text(_error!, style: const TextStyle(color: AppColors.error)),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: LoadingFilledButton(
          label: 'Confirm Booking',
          loading: _loading,
          onPressed: _confirm,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.last = false});
  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: context.colors.primaryText,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                    )),
          ),
        ],
      ),
    );
  }
}
