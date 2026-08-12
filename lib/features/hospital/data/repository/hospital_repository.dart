import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/doctor/presentation/widgets/working_hours_fields.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/hospital/data/models/doctor_hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_appointment_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_profile_model.dart';

final hospitalRepositoryProvider = Provider<HospitalRepository>(
  (ref) => HospitalRepository(ref.read(dioClientProvider)),
);

class HospitalRepository {
  HospitalRepository(this._dio);
  final Dio _dio;

  /// GET /api/hospitals/?q=&city= — the picker's search. The backend
  /// paginates; the picker re-queries per keystroke rather than paging
  /// through, so only this page's results are returned.
  Future<List<HospitalModel>> search({String q = '', String? city}) async {
    try {
      final res = await _dio.get(
        '/hospitals/',
        queryParameters: {
          if (q.isNotEmpty) 'q': q,
          if (city != null && city.isNotEmpty) 'city': city,
        },
      );
      final data = res.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];
      return results
          .map((e) => HospitalModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// GET /api/hospitals/`<id>`/ — a single registry entry's public profile
  /// (AllowAny on the backend). Used by the patient-facing hospital detail
  /// screen, reached from a doctor's workplace card or a shared link/QR.
  Future<HospitalModel> getById(String id) async {
    try {
      final res = await _dio.get('/hospitals/$id/');
      return HospitalModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// GET /api/hospitals/`<id>`/doctors/ — this hospital's public doctor
  /// roster (QR_SHARE_PROFILE_PLAN.md Phase 4), for the public hospital
  /// detail screen. Reuses DoctorModel — the roster response is a subset of
  /// its fields, and the rest already default sensibly when absent.
  Future<List<DoctorModel>> getDoctors(String hospitalId) async {
    try {
      final res = await _dio.get('/hospitals/$hospitalId/doctors/');
      return (res.data as List)
          .map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// POST /api/hospitals/ — "add your variant" when the picker's search
  /// found nothing. Returns either the newly-created entry (201) or an
  /// existing near-duplicate the backend matched instead (200) — either
  /// way, the hospital the caller should now use; the two cases are
  /// indistinguishable (and don't need to be) from this method's contract.
  Future<HospitalModel> create({
    required String name,
    required String city,
    String address = '',
  }) async {
    try {
      final res = await _dio.post(
        '/hospitals/',
        data: {
          'name': name,
          'city': city,
          if (address.isNotEmpty) 'address': address,
        },
      );
      return HospitalModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  // ─── Account ──────────────────────────────────────────────────────────

  Future<HospitalProfileModel> getProfile() async {
    try {
      final res = await _dio.get('/hospital/profile/');
      return HospitalProfileModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<HospitalProfileModel> updateProfile(Map<String, dynamic> data) async {
    try {
      final res = await _dio.patch('/hospital/profile/', data: data);
      return HospitalProfileModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  // ─── Dashboard: doctor links ─────────────────────────────────────────

  /// [status] filters to one of HospitalDoctorLinkModel.status* — omit for
  /// every link regardless of status.
  Future<List<HospitalDoctorLinkModel>> getLinks({String? status}) async {
    try {
      final res = await _dio.get(
        '/hospital/doctors/links/',
        queryParameters: {'status': ?status},
      );
      final data = res.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];
      return results
          .map(
            (e) => HospitalDoctorLinkModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<HospitalDoctorLinkModel> approveLink(String linkId) async {
    try {
      final res = await _dio.post('/hospital/doctors/links/$linkId/approve/');
      return HospitalDoctorLinkModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<HospitalDoctorLinkModel> rejectLink(String linkId) async {
    try {
      final res = await _dio.post('/hospital/doctors/links/$linkId/reject/');
      return HospitalDoctorLinkModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> removeLink(String linkId) async {
    try {
      await _dio.delete('/hospital/doctors/links/$linkId/remove/');
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Verified doctors not already linked to this hospital — name and
  /// specialization only, no contact details (see DoctorBriefModel).
  Future<List<DoctorBriefModel>> searchDoctors({String q = ''}) async {
    try {
      final res = await _dio.get(
        '/hospital/doctors/search/',
        queryParameters: {if (q.isNotEmpty) 'q': q},
      );
      final data = res.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];
      return results
          .map((e) => DoctorBriefModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<HospitalDoctorLinkModel> inviteDoctor(String doctorId) async {
    try {
      final res = await _dio.post(
        '/hospital/doctors/invite/',
        data: {'doctor_id': doctorId},
      );
      return HospitalDoctorLinkModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  // ─── Dashboard: a confirmed doctor's workplace hours ────────────────

  Future<List<Map<String, dynamic>>> getDoctorWorkplaces(
    String doctorId,
  ) async {
    try {
      final res = await _dio.get('/hospital/doctors/$doctorId/workplaces/');
      return (res.data as List).cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<List<WorkingHoursDay>> getWorkplaceHours(String workplaceId) async {
    try {
      final res = await _dio.get('/hospital/workplaces/$workplaceId/hours/');
      return WorkingHoursDay.fromApiList(res.data as List<dynamic>?);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> putWorkplaceHours(
    String workplaceId,
    List<WorkingHoursDay> days,
  ) async {
    try {
      await _dio.put(
        '/hospital/workplaces/$workplaceId/hours/',
        data: WorkingHoursDay.toPayload(days),
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  // ─── Dashboard: appointments feed ───────────────────────────────────

  Future<List<HospitalAppointmentModel>> getAppointments({
    String? doctorId,
    String? status,
  }) async {
    try {
      final res = await _dio.get(
        '/hospital/appointments/',
        queryParameters: {'doctor': ?doctorId, 'status': ?status},
      );
      final data = res.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];
      return results
          .map(
            (e) => HospitalAppointmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  // ─── Doctor-side: this doctor's own hospital affiliations ──────────

  /// GET /api/doctor/hospital-links/ — every affiliation this doctor has
  /// with any hospital, any status (invites to answer, their own pending
  /// requests, confirmed affiliations, and past decisions). Not paginated
  /// on the backend — a doctor realistically has a handful of these.
  Future<List<DoctorHospitalLinkModel>> getDoctorHospitalLinks() async {
    try {
      final res = await _dio.get('/doctor/hospital-links/');
      return (res.data as List)
          .map(
            (e) => DoctorHospitalLinkModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// `POST /api/doctor/hospital-links/<id>/accept/` — confirms a hospital's
  /// invite.
  Future<DoctorHospitalLinkModel> acceptHospitalInvite(String linkId) async {
    try {
      final res = await _dio.post('/doctor/hospital-links/$linkId/accept/');
      return DoctorHospitalLinkModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// `POST /api/doctor/hospital-links/<id>/decline/` — declines a hospital's
  /// invite, or withdraws the doctor's own still-pending request (the
  /// backend's reject_link accepts either starting status, so this single
  /// method covers both actions).
  Future<DoctorHospitalLinkModel> declineHospitalLink(String linkId) async {
    try {
      final res = await _dio.post('/doctor/hospital-links/$linkId/decline/');
      return DoctorHospitalLinkModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
