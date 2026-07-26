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

  /// Fetches every page and concatenates them — the backend paginates at
  /// 20/page, so a patient with more records than that would otherwise
  /// silently lose the rest.
  Future<List<MedicalRecordModel>> getRecords() async {
    try {
      final all = <MedicalRecordModel>[];
      var page = 1;
      while (true) {
        final res = await _dio.get('/records/', queryParameters: {'page': page});
        final data = res.data;
        if (data is List) {
          all.addAll(data.map((e) => MedicalRecordModel.fromJson(e as Map<String, dynamic>)));
          break;
        }
        final map = data as Map<String, dynamic>;
        final pageResults = (map['results'] as List<dynamic>?) ?? [];
        all.addAll(pageResults.map((e) => MedicalRecordModel.fromJson(e as Map<String, dynamic>)));
        if (map['next'] == null) break;
        page++;
      }
      return all;
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
    String? dependentId,
  }) async {
    try {
      final form = FormData.fromMap({
        'record_type': recordType,
        'title': title,
        if (recordDate != null) 'record_date': DateFormat('yyyy-MM-dd').format(recordDate),
        'notes': notes,
        'dependent_id': ?dependentId,
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
