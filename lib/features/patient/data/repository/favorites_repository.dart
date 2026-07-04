import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>(
  (ref) => FavoritesRepository(ref.read(dioClientProvider)),
);

class FavoritesRepository {
  FavoritesRepository(this._dio);
  final Dio _dio;

  /// `GET /favorites/` returns the favorite doctors as full public cards
  /// (same shape as `/doctors/`), so no per-ID detail fetches are needed.
  Future<List<DoctorModel>> getFavorites() async {
    try {
      final res = await _dio.get('/favorites/');
      final results =
          (res.data is Map ? res.data['results'] : res.data) as List<dynamic>;
      return results
          .map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> addFavorite(String doctorId) async {
    try {
      await _dio.post('/favorites/', data: {'doctor_id': doctorId});
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> removeFavorite(String doctorId) async {
    try {
      await _dio.delete('/favorites/$doctorId/');
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
