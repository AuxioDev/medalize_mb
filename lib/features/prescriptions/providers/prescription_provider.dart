import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';

/// `null` (not an error) means the appointment has no prescription yet.
final appointmentPrescriptionProvider =
    FutureProvider.family<PrescriptionModel?, String>((ref, appointmentId) {
  return ref.watch(prescriptionRepositoryProvider).getPrescriptionForAppointment(appointmentId);
});

final patientPrescriptionsProvider = FutureProvider<List<PrescriptionModel>>((ref) {
  return ref.watch(prescriptionRepositoryProvider).getPrescriptions();
});

final prescriptionByIdProvider =
    FutureProvider.family<PrescriptionModel, String>((ref, id) {
  return ref.watch(prescriptionRepositoryProvider).getPrescription(id);
});
