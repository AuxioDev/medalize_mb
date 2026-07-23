import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/doctor/data/models/doctor_stats_model.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/patient/data/models/waitlist_model.dart';

final doctorRepositoryProvider = Provider<DoctorRepository>(
  (ref) => DoctorRepository(ref.read(dioClientProvider)),
);

/// One page of doctor search results, plus whether the backend has more
/// (derived from DRF's `next` field) so the UI knows whether to show a
/// "Load more" affordance.
class DoctorSearchPage {
  const DoctorSearchPage({required this.doctors, required this.hasMore});
  final List<DoctorModel> doctors;
  final bool hasMore;
}

class DoctorRepository {
  DoctorRepository(this._dio);
  final Dio _dio;

  Future<DoctorSearchPage> searchDoctors({
    String? name,
    String? specialization,
    String? city,
    int? minRating,
    String? ordering,
    double? lat,
    double? lng,
    int page = 1,
  }) async {
    try {
      final params = <String, dynamic>{'page': page};
      if (name != null && name.isNotEmpty) params['name'] = name;
      if (specialization != null && specialization.isNotEmpty) params['specialization'] = specialization;
      if (city != null && city.isNotEmpty) params['city'] = city;
      if (minRating != null) params['min_rating'] = minRating;
      if (ordering != null && ordering.isNotEmpty) params['ordering'] = ordering;
      if (lat != null) params['lat'] = lat;
      if (lng != null) params['lng'] = lng;
      final res = await _dio.get('/doctors/', queryParameters: params);
      final data = res.data;
      if (data is Map<String, dynamic>) {
        final results = (data['results'] as List<dynamic>?) ?? const [];
        return DoctorSearchPage(
          doctors: results.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>)).toList(),
          hasMore: data['next'] != null,
        );
      }
      // Defensive fallback for a non-paginated flat array response.
      final results = data as List<dynamic>;
      return DoctorSearchPage(
        doctors: results.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>)).toList(),
        hasMore: false,
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<DoctorDetailModel> getDoctorDetail(String id) async {
    try {
      final res = await _dio.get('/doctors/$id/');
      return DoctorDetailModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<DateTime?> getNextAvailableDate(String doctorId) async {
    try {
      final res = await _dio.get('/doctors/$doctorId/next-slot/');
      final dateStr = res.data['next_available_date'] as String?;
      return dateStr != null ? DateTime.parse(dateStr) : null;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<DoctorStatsModel> getStats() async {
    try {
      final res = await _dio.get('/doctor/stats/');
      return DoctorStatsModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<List<WaitlistModel>> getMyWaitlist() async {
    try {
      final res = await _dio.get('/waitlist/');
      return (res.data as List<dynamic>)
          .map((e) => WaitlistModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<WaitlistModel> joinWaitlist(String doctorId) async {
    try {
      final res = await _dio.post('/waitlist/', data: {'doctor_id': doctorId});
      return WaitlistModel.fromJson({
        'id': res.data['id'] as String,
        'doctor_id': res.data['doctor_id'] as String,
        'doctor_name': '',
        'joined_at': DateTime.now().toIso8601String(),
      });
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> leaveWaitlist(String entryId) async {
    try {
      await _dio.delete('/waitlist/$entryId/');
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<List<SlotModel>> getSlots(
    String doctorId,
    String workplaceId,
    DateTime date,
  ) async {
    try {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final res = await _dio.get(
        '/doctors/$doctorId/slots/',
        queryParameters: {'workplace_id': workplaceId, 'date': dateStr},
      );
      final slots = res.data['slots'] as List<dynamic>;
      return slots.map((s) => SlotModel.fromJson(s as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
