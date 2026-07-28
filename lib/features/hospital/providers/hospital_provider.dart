import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_appointment_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_profile_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';

/// GET /api/hospital/profile/ — the hospital's own account details.
final hospitalProfileProvider =
    FutureProvider.autoDispose<HospitalProfileModel>((ref) {
  return ref.watch(hospitalRepositoryProvider).getProfile();
});

/// Doctor links grouped by status — one provider per tab on the doctors
/// screen (confirmed / pending / invited), each independently
/// invalidatable so approving a request only re-fetches the two lists it
/// actually moved between.
final hospitalLinksProvider =
    FutureProvider.autoDispose.family<List<HospitalDoctorLinkModel>, String?>((ref, status) {
  return ref.watch(hospitalRepositoryProvider).getLinks(status: status);
});

/// Invalidates every links list — call after any action that changes a
/// link's status (approve/reject/remove/invite).
void refreshHospitalLinks(WidgetRef ref) {
  ref.invalidate(hospitalLinksProvider(HospitalDoctorLinkModel.statusConfirmed));
  ref.invalidate(hospitalLinksProvider(HospitalDoctorLinkModel.statusPending));
  ref.invalidate(hospitalLinksProvider(HospitalDoctorLinkModel.statusInvited));
}

final hospitalAppointmentsProvider =
    FutureProvider.autoDispose<List<HospitalAppointmentModel>>((ref) {
  return ref.watch(hospitalRepositoryProvider).getAppointments();
});
