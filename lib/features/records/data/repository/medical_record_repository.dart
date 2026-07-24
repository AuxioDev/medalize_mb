import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/records/data/models/medical_record_model.dart';

final medicalRecordRepositoryProvider = Provider<MedicalRecordRepository>(
  (ref) => MedicalRecordRepository(ref.read(dioClientProvider)),
);

class MedicalRecordRepository {
  MedicalRecordRepository(this._dio);
  final Dio _dio;

  Future<List<MedicalRecordModel>> getRecords() async {
    try {
      final res = await _dio.get('/records/');
      final data = res.data;
      final results = (data is Map ? data['results'] as List<dynamic>? : null) ??
          data as List<dynamic>;
      return results
          .map((e) => MedicalRecordModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Uploads a new record. Follows the same `Dio` + `FormData.fromMap` +
  /// `MultipartFile.fromFile` pattern already used for the avatar upload in
  /// `ProfileScreen._pickAndUploadAvatar`.
  Future<MedicalRecordModel> uploadRecord({
    required String recordType,
    required String title,
    DateTime? recordDate,
    String notes = '',
    required String filePath,
  }) async {
    try {
      final form = FormData.fromMap({
        'record_type': recordType,
        'title': title,
        if (recordDate != null) 'record_date': DateFormat('yyyy-MM-dd').format(recordDate),
        'notes': notes,
        'file': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });
      final res = await _dio.post('/records/', data: form);
      return MedicalRecordModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> deleteRecord(String id) async {
    try {
      await _dio.delete('/records/$id/');
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
