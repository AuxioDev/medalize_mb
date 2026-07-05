import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';

final assistantRepositoryProvider = Provider<AssistantRepository>(
  (ref) => AssistantRepository(ref.read(dioClientProvider)),
);

class AssistantRepository {
  AssistantRepository(this._dio);
  final Dio _dio;

  /// When the assistant feature is disabled server-side, every endpoint
  /// returns 503 with an already-localized, user-facing `detail` — surface it
  /// as-is instead of the generic "server error (503)".
  ApiException _mapError(DioException e) {
    final data = e.response?.data;
    if (e.response?.statusCode == 503 &&
        data is Map &&
        data['detail'] is String) {
      return NetworkException(data['detail'] as String);
    }
    return mapDioError(e);
  }

  Future<ConversationModel> createConversation() async {
    try {
      final res = await _dio.post('/assistant/conversations/');
      return ConversationModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<List<ConversationModel>> getConversations() async {
    try {
      final res = await _dio.get('/assistant/conversations/');
      final results =
          (res.data['results'] as List<dynamic>?) ?? res.data as List<dynamic>;
      return results
          .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<ConversationDetailModel> getConversation(String id) async {
    try {
      final res = await _dio.get('/assistant/conversations/$id/');
      return ConversationDetailModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> deleteConversation(String id) async {
    try {
      await _dio.delete('/assistant/conversations/$id/');
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Sends the patient's message and returns the assistant's reply
  /// (including any suggested doctors).
  Future<MessageModel> sendMessage(String conversationId, String content) async {
    try {
      final res = await _dio.post(
        '/assistant/conversations/$conversationId/messages/',
        data: {'content': content},
      );
      return MessageModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<void> flagMessage(String messageId, {String reason = ''}) async {
    try {
      await _dio.post(
        '/assistant/messages/$messageId/flag/',
        data: {'reason': reason},
      );
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
