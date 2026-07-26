import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/records/data/repository/medical_record_repository.dart';

/// Records every request and answers with canned responses (one per call, in
/// order) — same pattern as `test/messaging_repository_test.dart`.
class _CapturingAdapter implements HttpClientAdapter {
  _CapturingAdapter(List<Object> bodies, {List<int>? statusCodes})
      : _bodies = List.of(bodies),
        _statusCodes = statusCodes ?? List.filled(bodies.length, 200);

  final List<Object> _bodies;
  final List<int> _statusCodes;
  var _i = 0;
  final requests = <RequestOptions>[];

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final body = _bodies[_i];
    final status = _statusCodes[_i];
    _i++;
    return ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

MedicalRecordRepository _repo(_CapturingAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
  dio.httpClientAdapter = adapter;
  return MedicalRecordRepository(dio);
}

Map<String, dynamic> _recordJson({String id = 'rec-1', String title = 'Blood test'}) => {
      'id': id,
      'record_type': 'lab_result',
      'title': title,
      'file': 'https://res.cloudinary.com/example/$id.pdf',
      'record_date': '2026-07-01',
      'notes': '',
      'created_at': '2026-07-24T10:00:00',
      'dependent': null,
    };

void main() {
  test('getRecords tolerates a plain (non-paginated) list response', () async {
    final adapter = _CapturingAdapter([
      [_recordJson(id: 'rec-1', title: 'Blood test')],
    ]);

    final records = await _repo(adapter).getRecords();

    expect(adapter.requests.single.method, 'GET');
    expect(adapter.requests.single.path, '/records/');
    expect(adapter.requests.single.queryParameters, {'page': 1});
    expect(records, hasLength(1));
    expect(records[0].id, 'rec-1');
    expect(records[0].title, 'Blood test');
  });

  test('getRecords parses a single paginated page', () async {
    final adapter = _CapturingAdapter([
      {
        'count': 1,
        'next': null,
        'previous': null,
        'results': [_recordJson()],
      },
    ]);

    final records = await _repo(adapter).getRecords();

    expect(adapter.requests, hasLength(1));
    expect(records.single.id, 'rec-1');
  });

  test('getRecords walks every page via next until null', () async {
    final adapter = _CapturingAdapter([
      {
        'count': 2,
        'next': 'http://localhost/api/records/?page=2',
        'previous': null,
        'results': [_recordJson(id: 'rec-1')],
      },
      {
        'count': 2,
        'next': null,
        'previous': null,
        'results': [_recordJson(id: 'rec-2')],
      },
    ]);

    final records = await _repo(adapter).getRecords();

    expect(adapter.requests, hasLength(2));
    expect(adapter.requests[0].queryParameters, {'page': 1});
    expect(adapter.requests[1].queryParameters, {'page': 2});
    expect(records.map((r) => r.id), ['rec-1', 'rec-2']);
  });
}
