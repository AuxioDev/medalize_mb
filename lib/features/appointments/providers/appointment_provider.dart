import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';

/// `autoDispose`: keyed only by status filter, not by user — holds the
/// signed-in user's own appointments and must not survive a logout/login as
/// someone else on a shared device. Disposed once nothing is watching it,
/// which the auth redirect guarantees happens on both logout and the next
/// login (see `medicationsProvider` for the full rationale).
final patientAppointmentsProvider =
    FutureProvider.autoDispose.family<List<AppointmentModel>, String?>((ref, status) {
  return ref.watch(appointmentRepositoryProvider).getPatientAppointments(status: status);
});

/// `autoDispose` — same per-user-data rationale as [patientAppointmentsProvider].
final doctorAppointmentsProvider =
    FutureProvider.autoDispose.family<List<AppointmentModel>, String?>((ref, status) {
  return ref.watch(appointmentRepositoryProvider).getDoctorAppointments(status: status);
});

/// Fetches a single appointment by ID. Used when navigating to the detail
/// screen via deep link or state restoration where [extra] is unavailable.
/// `autoDispose` — same per-user-data rationale as [patientAppointmentsProvider].
final appointmentByIdProvider =
    FutureProvider.autoDispose.family<AppointmentModel, String>((ref, id) {
  return ref.watch(appointmentRepositoryProvider).getAppointment(id);
});
