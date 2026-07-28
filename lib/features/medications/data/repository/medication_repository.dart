import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';

final medicationRepositoryProvider = Provider<MedicationRepository>(
  (ref) => MedicationRepository(ref.read(dioClientProvider)),
);

class MedicationRepository {
  MedicationRepository(this._dio);
  final Dio _dio;

  /// Accepts both a plain list and a paginated `{results: [...]}` payload —
  /// the exact shape depends on whether the backend view sets a pagination
  /// class, which isn't guaranteed from this side of the API contract.
  List<dynamic> _asList(dynamic data) =>
      (data is Map ? data['results'] as List<dynamic>? : null) ??
      data as List<dynamic>;

  Future<List<MedicationModel>> getMedications() async {
    try {
      final res = await _dio.get('/medications/');
      return _asList(res.data)
          .map((e) => MedicationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Reminder schedule only — a Medication's identity (name/dosage/form/
  /// notes) comes solely from the doctor's prescription and isn't
  /// patient-editable, so this is the only field the backend accepts here.
  Future<MedicationModel> updateMedication(
    String id, {
    required List<MedicationScheduleModel> schedules,
  }) async {
    try {
      final res = await _dio.patch('/medications/$id/', data: {
        'schedules': schedules.map((s) => s.toJson()).toList(),
      });
      return MedicationModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Soft-delete (server sets `is_active=False`) — dose history is preserved.
  Future<void> deleteMedication(String id) async {
    try {
      await _dio.delete('/medications/$id/');
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<DoseLogModel> logDose(
    String scheduleId,
    DateTime scheduledAt,
    String status,
  ) async {
    try {
      final res = await _dio.post('/medications/dose-logs/', data: {
        'schedule': scheduleId,
        'scheduled_at': scheduledAt.toUtc().toIso8601String(),
        'status': status,
      });
      return DoseLogModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<List<DoseLogModel>> getDoseLogs({DateTime? date}) async {
    try {
      final params = <String, dynamic>{};
      if (date != null) params['date'] = DateFormat('yyyy-MM-dd').format(date);
      final res =
          await _dio.get('/medications/dose-logs/', queryParameters: params);
      return _asList(res.data)
          .map((e) => DoseLogModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
