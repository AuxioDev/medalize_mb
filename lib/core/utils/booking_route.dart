/// Builds the path to the booking-calendar screen, optionally preselecting a
/// workplace — the one entry point for jumping straight into booking with an
/// already-known doctor. Used by the doctor-card "Book" button
/// ([BookNowButton]), the "Book again" action on a closed appointment, and
/// the home screen's quick-book card.
///
/// `workplaceId` travels as a query parameter rather than through GoRouter's
/// `extra` because none of these callers have a full `DoctorDetailModel` to
/// pass — `BookingCalendarLoader` already fetches the doctor by id on its
/// own (the same path a deep link takes).
String bookingCalendarPath(String doctorId, {String? workplaceId}) =>
    workplaceId == null
        ? '/patient/booking-calendar/$doctorId'
        : '/patient/booking-calendar/$doctorId?workplace=$workplaceId';
