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

  /// Exchanges a provider-issued id_token for our JWT pair — or, for a
  /// brand-new social sign-up with no matching account yet, a
  /// `SocialLoginException` carrying `pendingSocialToken` (see
  /// mapDioError's `phone_required` case): phone is the unique login
  /// identifier now, so a first-time social sign-up can't create an
  /// account in one round trip and must continue via [completeSocialSignup].
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
      final data = res.data as Map<String, dynamic>;
      // Unlike every other error case here, this one comes back as a 200 —
      // it's not a failure, just an "unfinished" sign-up — so it can't be
      // mapped by mapDioError (which only inspects non-2xx responses) and
      // must be detected from the body before parsing it as a LoginResponse.
      if (data['code'] == 'phone_required') {
        throw SocialPhoneRequiredException(
          data['pending_social_token'] as String,
          data['message'] as String?,
        );
      }
      return LoginResponse.fromJson(data);
    } on DioException catch (e) {
      throw mapDioError(e);
    } on SocialPhoneRequiredException {
      rethrow;
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Second step of a first-time social sign-up (see [socialLogin]'s doc):
  /// creates the account with [phone] and sends a verification OTP to it,
  /// same response shape as [register] — the caller then drives the same
  /// verify-phone screen/flow as a password sign-up.
  Future<Map<String, dynamic>> completeSocialSignup({
    required String pendingSocialToken,
    required String phone,
  }) async {
    try {
      final res = await _dio.post('/auth/social/complete/', data: {
        'pending_social_token': pendingSocialToken,
        'phone': phone,
      });
      return res.data as Map<String, dynamic>;
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

  /// Persists the UI language on the server so SMS/notifications are sent
  /// in the user's language. [code] must be a concrete language code
  /// (`en`/`ru`/`az`/`tr`/`fr`/`zh`), never the local `'system'` sentinel.
  Future<void> updateLanguage(String code) async {
    try {
      await _dio.patch('/auth/me/', data: {'language': code});
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> requestPasswordReset(String phone) async {
    try {
      await _dio.post('/auth/password/reset/', data: {'phone': phone});
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> confirmPasswordReset({
    required String phone,
    required String code,
    required String newPassword,
  }) async {
    try {
      await _dio.post('/auth/password/reset/confirm/', data: {
        'phone': phone,
        'code': code,
        'new_password': newPassword,
      });
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Resends the registration verification code — see RegisterView, which
  /// already sends one on signup; this covers "I didn't get it"/expired.
  Future<void> resendPhoneVerification(String phone) async {
    try {
      await _dio.post('/auth/phone/verify/', data: {'phone': phone});
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Confirms the 6-digit registration code and, on success, signs the user
  /// straight in — same login payload shape as [login].
  Future<LoginResponse> confirmPhoneVerification({
    required String phone,
    required String code,
  }) async {
    try {
      final res = await _dio.post('/auth/phone/verify/confirm/', data: {
        'phone': phone,
        'code': code,
      });
      return LoginResponse.fromJson(res.data as Map<String, dynamic>);
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

  /// Deactivates the account (data is kept; reactivation is manual/support).
  /// The backend revokes every session, so callers must force a local logout
  /// on success.
  Future<void> deactivateAccount({required String password}) async {
    try {
      await _dio.post('/auth/deactivate/', data: {'password': password});
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Permanently and irreversibly deletes the account: PII and medical
  /// content are erased, payments/reviews are retained but anonymized, and
  /// future appointments are cancelled (refunded where eligible) — see
  /// `apps.users.services.delete_account` on the backend for the full
  /// cascade. The backend revokes every session as part of this, so
  /// callers must force a local logout on success, same as
  /// [deactivateAccount].
  Future<void> deleteAccount({required String password}) async {
    try {
      await _dio.post('/auth/delete/', data: {'password': password});
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Step 1 of the phone change flow: sends a 6-digit code to [newPhone].
  Future<void> requestPhoneChange({
    required String newPhone,
    required String password,
  }) async {
    try {
      await _dio.post('/auth/phone/change/', data: {
        'new_phone': newPhone,
        'password': password,
      });
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Step 2 of the phone change flow. On success the backend revokes every
  /// session, so callers must force a local logout.
  Future<void> confirmPhoneChange({required String code}) async {
    try {
      await _dio.post('/auth/phone/change/confirm/', data: {'code': code});
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
