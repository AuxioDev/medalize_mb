import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/hospital/data/models/doctor_hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_appointment_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_profile_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';

/// GET /api/hospital/profile/ — the hospital's own account details.
final hospitalProfileProvider =
    FutureProvider.autoDispose<HospitalProfileModel>((ref) {
      return ref.watch(hospitalRepositoryProvider).getProfile();
    });

/// GET /api/hospitals/`<id>`/ — a registry entry's public profile, for the
/// patient-facing hospital detail screen (workplace card tap, or a
/// shared link/QR opened into the app).
final publicHospitalProvider = FutureProvider.autoDispose
    .family<HospitalModel, String>((ref, id) {
      return ref.watch(hospitalRepositoryProvider).getById(id);
    });

/// GET /api/hospitals/`<id>`/doctors/ — this hospital's public doctor
/// roster, shown on the same screen.
final publicHospitalDoctorsProvider = FutureProvider.autoDispose
    .family<List<DoctorModel>, String>((ref, id) {
      return ref.watch(hospitalRepositoryProvider).getDoctors(id);
    });

/// Doctor links grouped by status — one provider per tab on the doctors
/// screen (confirmed / pending / invited), each independently
/// invalidatable so approving a request only re-fetches the two lists it
/// actually moved between.
final hospitalLinksProvider = FutureProvider.autoDispose
    .family<List<HospitalDoctorLinkModel>, String?>((ref, status) {
      return ref.watch(hospitalRepositoryProvider).getLinks(status: status);
    });

/// Invalidates every links list — call after any action that changes a
/// link's status (approve/reject/remove/invite).
void refreshHospitalLinks(WidgetRef ref) {
  ref.invalidate(
    hospitalLinksProvider(HospitalDoctorLinkModel.statusConfirmed),
  );
  ref.invalidate(hospitalLinksProvider(HospitalDoctorLinkModel.statusPending));
  ref.invalidate(hospitalLinksProvider(HospitalDoctorLinkModel.statusInvited));
}

final hospitalAppointmentsProvider =
    FutureProvider.autoDispose<List<HospitalAppointmentModel>>((ref) {
      return ref.watch(hospitalRepositoryProvider).getAppointments();
    });

/// GET /api/doctor/hospital-links/ — this doctor's own affiliations with
/// any hospital: invitations to answer, their own pending requests, and
/// confirmed affiliations. A single unfiltered list (unlike
/// hospitalLinksProvider above) because the backend doesn't paginate or
/// filter this endpoint — the screen splits it into tabs client-side.
final doctorHospitalLinksProvider =
    FutureProvider.autoDispose<List<DoctorHospitalLinkModel>>((ref) {
      return ref.watch(hospitalRepositoryProvider).getDoctorHospitalLinks();
    });

/// Call after accept/decline changes a link's status.
void refreshDoctorHospitalLinks(WidgetRef ref) {
  ref.invalidate(doctorHospitalLinksProvider);
}
