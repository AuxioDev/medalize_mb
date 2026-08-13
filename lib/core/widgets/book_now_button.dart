import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/utils/booking_route.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Full-width "Book" shortcut for a doctor card — pushes straight to
/// `/patient/booking-calendar/:id`, which already tolerates a missing
/// `extra` doctor by loading it itself (see `BookingCalendarLoader`), so
/// this button skips the doctor-profile screen entirely rather than
/// requiring it as a stop on the way to booking.
class BookNowButton extends StatelessWidget {
  const BookNowButton({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          HapticFeedback.lightImpact();
          context.push(bookingCalendarPath(doctorId));
        },
        icon: const Icon(Icons.calendar_month_outlined, size: 16),
        label: Text(context.t.doctorSearch.book),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 34),
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
        ),
      ),
    );
  }
}
