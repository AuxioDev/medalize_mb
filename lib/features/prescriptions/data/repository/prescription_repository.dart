import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';

final prescriptionRepositoryProvider = Provider<PrescriptionRepository>(
  (ref) => PrescriptionRepository(ref.read(dioClientProvider)),
);

class PrescriptionRepository {
  PrescriptionRepository(this._dio);
  final Dio _dio;

  /// Fetches every page from a paginated DRF endpoint and returns all results.
  Future<List<T>> _fetchAllPages<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final results = <T>[];
    int page = 1;
    while (true) {
      final res = await _dio.get(path, queryParameters: {'page': page});
      final data = res.data;
      // Tolerate a plain (non-paginated) list too.
      if (data is List) {
        results.addAll(data.map((e) => fromJson(e as Map<String, dynamic>)));
        break;
      }
      final map = data as Map<String, dynamic>;
      final pageResults = (map['results'] as List<dynamic>?) ?? [];
      results.addAll(pageResults.map((e) => fromJson(e as Map<String, dynamic>)));
      if (map['next'] == null) break;
      page++;
    }
    return results;
  }

  /// `null` means the appointment has no prescription yet — not an error.
  Future<PrescriptionModel?> getPrescriptionForAppointment(String appointmentId) async {
    try {
      final res = await _dio.get('/appointments/$appointmentId/prescription/');
      return PrescriptionModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<PrescriptionModel> createPrescription(
    String appointmentId, {
    String notes = '',
    required List<PrescriptionItemModel> items,
  }) async {
    try {
      final res = await _dio.post('/appointments/$appointmentId/prescription/', data: {
        'notes': notes,
        'items': items.map((i) => i.toJson()).toList(),
      });
      return PrescriptionModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<List<PrescriptionModel>> getPrescriptions() async {
    try {
      return await _fetchAllPages('/prescriptions/', PrescriptionModel.fromJson);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<PrescriptionModel> getPrescription(String id) async {
    try {
      final res = await _dio.get('/prescriptions/$id/');
      return PrescriptionModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Applies every item in the prescription as a new [MedicationModel]
  /// (without a schedule — the patient sets reminder times separately).
  /// Idempotent server-side: calling this again for an already-applied
  /// prescription returns the existing medications instead of duplicating.
  Future<List<MedicationModel>> applyPrescription(String id) async {
    try {
      final res = await _dio.post('/prescriptions/$id/apply/');
      final data = res.data;
      final results = (data is Map ? data['results'] as List<dynamic>? : null) ??
          data as List<dynamic>;
      return results.map((e) => MedicationModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
