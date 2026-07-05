import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/models/booking_request.dart';
import 'package:medalize_mb/features/appointments/data/models/review_model.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>(
  (ref) => AppointmentRepository(ref.read(dioClientProvider)),
);

class AppointmentRepository {
  AppointmentRepository(this._dio);
  final Dio _dio;

  /// Fetches every page from a paginated DRF endpoint and returns all results.
  Future<List<T>> _fetchAllPages<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? params,
  }) async {
    final results = <T>[];
    int page = 1;
    while (true) {
      final res = await _dio.get(
        path,
        queryParameters: {...?params, 'page': page},
      );
      final data = res.data as Map<String, dynamic>;
      final pageResults = (data['results'] as List<dynamic>?) ?? [];
      results.addAll(pageResults.map((e) => fromJson(e as Map<String, dynamic>)));
      if (data['next'] == null) break;
      page++;
    }
    return results;
  }

  Future<List<AppointmentModel>> getPatientAppointments({String? status}) async {
    try {
      final params = <String, dynamic>{};
      if (status != null) params['status'] = status;
      return await _fetchAllPages('/appointments/', AppointmentModel.fromJson, params: params);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<AppointmentModel> getAppointment(String id) async {
    try {
      final res = await _dio.get('/appointments/$id/');
      return AppointmentModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<AppointmentModel> bookAppointment(BookingRequest req) async {
    try {
      final res = await _dio.post('/appointments/', data: req.toJson());
      return AppointmentModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> cancelAppointment(String id) async {
    try {
      await _dio.delete('/appointments/$id/');
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<List<AppointmentModel>> getDoctorAppointments({
    String? status,
    String? date,
    String? workplaceId,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (status != null) params['status'] = status;
      if (date != null) params['date'] = date;
      if (workplaceId != null) params['workplace_id'] = workplaceId;
      return await _fetchAllPages('/doctor/appointments/', AppointmentModel.fromJson, params: params);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> updateAppointmentStatus(String id, String newStatus) async {
    try {
      await _dio.patch('/doctor/appointments/$id/status/', data: {'status': newStatus});
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> updateAppointmentNotes(String id, String notes) async {
    try {
      await _dio.patch('/doctor/appointments/$id/notes/', data: {'notes': notes});
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<AppointmentModel> rescheduleAppointment(String id, DateTime startsAt) async {
    try {
      final res = await _dio.patch(
        '/appointments/$id/reschedule/',
        data: {'starts_at': startsAt.toUtc().toIso8601String()},
      );
      return AppointmentModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> submitReview(String appointmentId, int rating, String comment) async {
    try {
      await _dio.post(
        '/appointments/$appointmentId/review/',
        data: {'rating': rating, 'comment': comment},
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<ReviewModel> updateReview(String appointmentId, int rating, String comment) async {
    try {
      final res = await _dio.patch(
        '/appointments/$appointmentId/review/',
        data: {'rating': rating, 'comment': comment},
      );
      return ReviewModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> deleteReview(String appointmentId) async {
    try {
      await _dio.delete('/appointments/$appointmentId/review/');
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<List<ReviewModel>> getDoctorReviews(String doctorId) async {
    try {
      return await _fetchAllPages('/doctors/$doctorId/reviews/', ReviewModel.fromJson);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
