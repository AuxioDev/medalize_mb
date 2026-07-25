import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';

final familyRepositoryProvider = Provider<FamilyRepository>(
  (ref) => FamilyRepository(ref.read(dioClientProvider)),
);

final DateFormat _dateOnlyFmt = DateFormat('yyyy-MM-dd');

class FamilyRepository {
  FamilyRepository(this._dio);
  final Dio _dio;

  Future<List<DependentModel>> getDependents() async {
    try {
      final res = await _dio.get('/dependents/');
      final data = res.data;
      final results = (data is Map ? data['results'] as List<dynamic>? : null) ??
          data as List<dynamic>;
      return results
          .map((e) => DependentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<DependentModel> createDependent({
    required String firstName,
    String lastName = '',
    required String relationship,
    DateTime? dateOfBirth,
    String bloodType = '',
    String allergies = '',
    String chronicConditions = '',
    String medications = '',
  }) async {
    try {
      final res = await _dio.post('/dependents/', data: {
        'first_name': firstName,
        'last_name': lastName,
        'relationship': relationship,
        if (dateOfBirth != null) 'date_of_birth': _dateOnlyFmt.format(dateOfBirth),
        'blood_type': bloodType,
        'allergies': allergies,
        'chronic_conditions': chronicConditions,
        'medications': medications,
      });
      return DependentModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<DependentModel> updateDependent(
    String id, {
    String? firstName,
    String? lastName,
    String? relationship,
    DateTime? dateOfBirth,
    String? bloodType,
    String? allergies,
    String? chronicConditions,
    String? medications,
  }) async {
    try {
      final res = await _dio.patch('/dependents/$id/', data: {
        'first_name': ?firstName,
        'last_name': ?lastName,
        'relationship': ?relationship,
        if (dateOfBirth != null) 'date_of_birth': _dateOnlyFmt.format(dateOfBirth),
        'blood_type': ?bloodType,
        'allergies': ?allergies,
        'chronic_conditions': ?chronicConditions,
        'medications': ?medications,
      });
      return DependentModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Soft-delete (server sets `is_active=False`) — historical
  /// appointments/medications/records attached to this dependent are kept.
  Future<void> deleteDependent(String id) async {
    try {
      await _dio.delete('/dependents/$id/');
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
