import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/notifications/data/models/notification_model.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => NotificationRepository(ref.read(dioClientProvider)),
);

class NotificationRepository {
  NotificationRepository(this._dio);
  final Dio _dio;

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final res = await _dio.get('/notifications/');
      final results = (res.data['results'] as List<dynamic>?) ?? res.data as List<dynamic>;
      return results.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> markRead(String id) async {
    try {
      await _dio.patch('/notifications/$id/read/');
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> markAllRead() async {
    try {
      await _dio.post('/notifications/read-all/');
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await _dio.delete('/notifications/$id/read/');
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> registerFCMToken(String token) async {
    try {
      await _dio.post('/notifications/fcm/', data: {'token': token});
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<void> deregisterFCMToken(String token) async {
    try {
      await _dio.delete('/notifications/fcm/', data: {'token': token});
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
