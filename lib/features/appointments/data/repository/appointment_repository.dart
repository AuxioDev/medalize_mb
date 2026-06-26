import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/models/booking_request.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>(
  (ref) => AppointmentRepository(ref.read(dioClientProvider)),
);

class AppointmentRepository {
  AppointmentRepository(this._dio);
  final Dio _dio;

  Future<List<AppointmentModel>> getPatientAppointments({String? status}) async {
    try {
      final params = <String, dynamic>{};
      if (status != null) params['status'] = status;
      final res = await _dio.get('/appointments/', queryParameters: params);
      final results = (res.data['results'] as List<dynamic>?) ?? res.data as List<dynamic>;
      return results.map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>)).toList();
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
      final res = await _dio.get('/doctor/appointments/', queryParameters: params);
      final results = (res.data['results'] as List<dynamic>?) ?? res.data as List<dynamic>;
      return results.map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>)).toList();
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
}
