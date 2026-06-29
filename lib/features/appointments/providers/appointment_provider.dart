import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';

final patientAppointmentsProvider =
    FutureProvider.family<List<AppointmentModel>, String?>((ref, status) {
  return ref.watch(appointmentRepositoryProvider).getPatientAppointments(status: status);
});

final doctorAppointmentsProvider =
    FutureProvider.family<List<AppointmentModel>, String?>((ref, status) {
  return ref.watch(appointmentRepositoryProvider).getDoctorAppointments(status: status);
});

/// Fetches a single appointment by ID. Used when navigating to the detail
/// screen via deep link or state restoration where [extra] is unavailable.
final appointmentByIdProvider =
    FutureProvider.family<AppointmentModel, String>((ref, id) {
  return ref.watch(appointmentRepositoryProvider).getAppointment(id);
});
