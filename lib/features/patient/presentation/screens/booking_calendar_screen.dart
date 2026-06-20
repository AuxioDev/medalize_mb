import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendarScreen extends ConsumerStatefulWidget {
  const BookingCalendarScreen({super.key, required this.doctor});
  final DoctorDetailModel doctor;

  @override
  ConsumerState<BookingCalendarScreen> createState() => _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends ConsumerState<BookingCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedWorkplaceId;

  @override
  void initState() {
    super.initState();
    if (widget.doctor.workplaces.isNotEmpty) {
      final primary = widget.doctor.workplaces.firstWhere(
        (w) => w.isPrimary,
        orElse: () => widget.doctor.workplaces.first,
      );
      _selectedWorkplaceId = primary.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final slotsAsync = _selectedDay != null && _selectedWorkplaceId != null
        ? ref.watch(slotsProvider(SlotsParams(
            doctorId: widget.doctor.id,
            workplaceId: _selectedWorkplaceId!,
            date: _selectedDay!,
          )))
        : null;

    return Scaffold(
      appBar: AppBar(title: Text('Book — ${widget.doctor.fullName}')),
      body: Column(
        children: [
          if (widget.doctor.workplaces.length > 1) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DropdownButtonFormField<String>(
                value: _selectedWorkplaceId,
                decoration: const InputDecoration(
                  labelText: 'Select Workplace',
                  border: OutlineInputBorder(),
                ),
                items: widget.doctor.workplaces
                    .map((wp) => DropdownMenuItem(value: wp.id, child: Text(wp.name)))
                    .toList(),
                onChanged: (v) => setState(() {
                  _selectedWorkplaceId = v;
                  _selectedDay = null;
                }),
              ),
            ),
          ],
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 60)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (d) => isSameDay(_selectedDay, d),
            onDaySelected: (selected, focused) => setState(() {
              _selectedDay = selected;
              _focusedDay = focused;
            }),
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(formatButtonVisible: false),
          ),
          if (_selectedDay != null && _selectedWorkplaceId != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                DateFormat('EEEE, d MMMM y').format(_selectedDay!),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Expanded(
              child: slotsAsync!.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (slots) {
                  if (slots.isEmpty) {
                    return const Center(child: Text('No available slots for this day'));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: slots.length,
                    itemBuilder: (_, i) {
                      final slot = slots[i];
                      return OutlinedButton(
                        onPressed: () => context.push(
                          '/patient/booking-confirm',
                          extra: {
                            'doctor': widget.doctor,
                            'slot': slot,
                            'workplaceId': _selectedWorkplaceId,
                          },
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                        ),
                        child: Text(DateFormat('HH:mm').format(slot.startsAt)),
                      );
                    },
                  );
                },
              ),
            ),
          ] else
            const Expanded(child: Center(child: Text('Select a date to see available slots'))),
        ],
      ),
    );
  }
}
