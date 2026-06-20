import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';

final patientAppointmentsProvider =
    FutureProvider.family<List<AppointmentModel>, String?>((ref, status) {
  return ref.read(appointmentRepositoryProvider).getPatientAppointments(status: status);
});

final doctorAppointmentsProvider =
    FutureProvider.family<List<AppointmentModel>, String?>((ref, status) {
  return ref.read(appointmentRepositoryProvider).getDoctorAppointments(status: status);
});
