import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';

/// A selectable specialization returned by `/doctors/specializations/`.
class SpecializationOption {
  const SpecializationOption({required this.value, required this.label});

  final String value;
  final String label;

  factory SpecializationOption.fromJson(Map<String, dynamic> json) =>
      SpecializationOption(
        value: json['value'] as String,
        label: json['label'] as String,
      );
}

final doctorProfileRepositoryProvider = Provider<DoctorProfileRepository>(
  (ref) => DoctorProfileRepository(ref.read(dioClientProvider)),
);

/// The full specialization list (value + display label) from the backend.
final specializationsProvider =
    FutureProvider<List<SpecializationOption>>((ref) {
  return ref.watch(doctorProfileRepositoryProvider).fetchSpecializations();
});

class DoctorProfileRepository {
  DoctorProfileRepository(this._dio);
  final Dio _dio;

  Future<List<SpecializationOption>> fetchSpecializations() async {
    try {
      final res = await _dio.get('/doctors/specializations/');
      final list = res.data as List<dynamic>;
      return list
          .map((e) => SpecializationOption.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> updateProfile({
    String? specialization,
    String? licenseNumber,
    String? bio,
    int? slotDurationMin,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (specialization != null) data['specialization'] = specialization;
      if (licenseNumber != null) data['license_number'] = licenseNumber;
      if (bio != null) data['bio'] = bio;
      if (slotDurationMin != null) data['slot_duration_min'] = slotDurationMin;
      await _dio.patch('/doctor/profile/', data: data);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> uploadDiploma(String filePath, {String? fileName}) async {
    try {
      final form = FormData.fromMap({
        'diploma': await MultipartFile.fromFile(filePath, filename: fileName),
      });
      await _dio.post('/doctor/verify/diploma/', data: form);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> completeOnboarding() async {
    try {
      await _dio.post('/doctor/onboarding/complete/');
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
