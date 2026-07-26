import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/messaging/data/models/messaging_models.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

final messagingRepositoryProvider = Provider<MessagingRepository>(
  (ref) => MessagingRepository(ref.read(dioClientProvider)),
);

class MessagingRepository {
  MessagingRepository(this._dio);
  final Dio _dio;

  /// `POST /messaging/threads/` denies thread creation with
  /// `{'code': 'no_shared_history', ...}` (403) when the two users have never
  /// had an appointment together — surface that as the dedicated, localized
  /// message instead of a generic server-error string.
  ApiException _mapError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['code'] == 'no_shared_history') {
      return ConflictException(t.messaging.noSharedHistory);
    }
    return mapDioError(e);
  }

  /// Fetches every page and concatenates them, same pattern as
  /// [getAllMessages] below — the backend paginates at 20/page, so a user
  /// with more threads than that would otherwise silently lose the rest.
  Future<List<ThreadModel>> getThreads() async {
    try {
      final all = <ThreadModel>[];
      var page = 1;
      while (true) {
        final res = await _dio.get('/messaging/threads/', queryParameters: {'page': page});
        final data = res.data;
        if (data is List) {
          all.addAll(data.map((e) => ThreadModel.fromJson(e as Map<String, dynamic>)));
          break;
        }
        final map = data as Map<String, dynamic>;
        final pageResults = (map['results'] as List<dynamic>?) ?? [];
        all.addAll(pageResults.map((e) => ThreadModel.fromJson(e as Map<String, dynamic>)));
        if (map['next'] == null) break;
        page++;
      }
      return all;
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<ThreadModel> getOrCreateThread(String participantId) async {
    try {
      final res = await _dio.post(
        '/messaging/threads/',
        data: {'participant_id': participantId},
      );
      return ThreadModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Fetches a single page of `GET /messaging/threads/<id>/messages/`
  /// (backend `PageNumberPagination`, oldest-first). Also marks every message
  /// not sent by the current user as read as a side effect on the backend.
  Future<List<MessageModel>> getMessages(String threadId, {int page = 1}) async {
    try {
      final res = await _dio.get(
        '/messaging/threads/$threadId/messages/',
        queryParameters: {'page': page},
      );
      final data = res.data;
      final results = data is List ? data : (data['results'] as List<dynamic>? ?? []);
      return results
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Fetches every page and concatenates them in chronological order. The
  /// chat screen always renders the full thread rather than lazy-loading
  /// older messages in this phase, so this is what both the initial load and
  /// the periodic poll use.
  Future<List<MessageModel>> getAllMessages(String threadId) async {
    try {
      final all = <MessageModel>[];
      var page = 1;
      while (true) {
        final res = await _dio.get(
          '/messaging/threads/$threadId/messages/',
          queryParameters: {'page': page},
        );
        final data = res.data;
        if (data is List) {
          all.addAll(data.map((e) => MessageModel.fromJson(e as Map<String, dynamic>)));
          break;
        }
        final map = data as Map<String, dynamic>;
        final pageResults = (map['results'] as List<dynamic>?) ?? [];
        all.addAll(pageResults.map((e) => MessageModel.fromJson(e as Map<String, dynamic>)));
        if (map['next'] == null) break;
        page++;
      }
      return all;
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<MessageModel> sendMessage(String threadId, String body) async {
    try {
      final res = await _dio.post(
        '/messaging/threads/$threadId/messages/',
        data: {'body': body},
      );
      return MessageModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final res = await _dio.get('/messaging/threads/unread-count/');
      final data = res.data;
      return (data is Map ? data['unread_count'] as int? : null) ?? 0;
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
