import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';

/// `null` (not an error) means the appointment has no prescription yet.
/// `autoDispose`: holds per-user prescription data — must not survive a
/// logout/login as someone else on a shared device. Disposed once nothing is
/// watching it, which the auth redirect guarantees happens on both logout
/// and the next login (see `medicationsProvider` for the full rationale).
final appointmentPrescriptionProvider =
    FutureProvider.autoDispose.family<PrescriptionModel?, String>((ref, appointmentId) {
  return ref.watch(prescriptionRepositoryProvider).getPrescriptionForAppointment(appointmentId);
});

/// `autoDispose` — same per-user-data rationale as [appointmentPrescriptionProvider].
final patientPrescriptionsProvider = FutureProvider.autoDispose<List<PrescriptionModel>>((ref) {
  return ref.watch(prescriptionRepositoryProvider).getPrescriptions();
});

/// `autoDispose` — same per-user-data rationale as [appointmentPrescriptionProvider].
final prescriptionByIdProvider =
    FutureProvider.autoDispose.family<PrescriptionModel, String>((ref, id) {
  return ref.watch(prescriptionRepositoryProvider).getPrescription(id);
});
