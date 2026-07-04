import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/auth/data/models/login_request.dart';
import 'package:medalize_mb/features/auth/data/models/login_response.dart';
import 'package:medalize_mb/features/auth/data/models/register_request.dart';
import 'package:medalize_mb/features/auth/data/models/user_device_model.dart';
import 'package:medalize_mb/features/auth/data/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read(dioClientProvider)),
);

class AuthRepository {
  const AuthRepository(this._dio);

  final Dio _dio;

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final res = await _dio.post('/auth/login/', data: request.toJson());
      return LoginResponse.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Exchanges a provider-issued id_token for our JWT pair.
  /// [provider] is `google` or `apple`; [device] is the map produced by
  /// `DeviceIdentity.describe()`.
  Future<LoginResponse> socialLogin(
    String provider, {
    required String idToken,
    Map<String, String> device = const {},
  }) async {
    try {
      final res = await _dio.post(
        '/auth/social/$provider/',
        data: {'id_token': idToken, ...device},
      );
      return LoginResponse.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> register(RegisterRequest request) async {
    try {
      await _dio.post('/auth/register/', data: request.toJson());
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<LoginResponse> refreshToken(
    String refreshToken, {
    Map<String, String> device = const {},
  }) async {
    try {
      final res = await _dio.post(
        '/auth/token/refresh/',
        data: {'refresh': refreshToken, ...device},
      );
      return LoginResponse.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> logout({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await _dio.post(
        '/auth/logout/',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<UserModel> getMe() async {
    try {
      final res = await _dio.get('/auth/me/');
      return UserModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      await _dio.post('/auth/password/reset/', data: {'email': email});
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> confirmPasswordReset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      await _dio.post('/auth/password/reset/confirm/', data: {
        'email': email,
        'code': code,
        'new_password': newPassword,
      });
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<List<UserDeviceModel>> getDevices() async {
    try {
      final res = await _dio.get('/auth/devices/');
      final data = res.data;
      // Tolerate both a bare list and a paginated {results: [...]} payload.
      final items = data is List
          ? data
          : (data as Map<String, dynamic>)['results'] as List? ?? [];
      return items
          .map((e) => UserDeviceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> revokeDevice(String id) async {
    try {
      await _dio.delete('/auth/devices/$id/');
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> revokeAllDevices() async {
    try {
      await _dio.post('/auth/devices/revoke-all/');
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String refreshToken,
  }) async {
    try {
      await _dio.post('/auth/password/change/', data: {
        'old_password': oldPassword,
        'new_password': newPassword,
        'refresh': refreshToken,
      });
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
