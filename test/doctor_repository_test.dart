import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/doctors/data/repository/doctor_repository.dart';

/// Records every request and answers with a canned JSON body, so the
/// repository's query building can be asserted without a live server.
class _CapturingAdapter implements HttpClientAdapter {
  _CapturingAdapter(this.body);
  final Object body;
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
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

DoctorRepository _repo(_CapturingAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
  dio.httpClientAdapter = adapter;
  return DoctorRepository(dio);
}

void main() {
  test('searchDoctors sends ordering, lat and lng for distance sort', () async {
    final adapter = _CapturingAdapter({'results': <Object>[]});

    await _repo(adapter).searchDoctors(
      ordering: 'distance',
      lat: 40.4093,
      lng: 49.8671,
    );

    final req = adapter.requests.single;
    expect(req.path, '/doctors/');
    expect(req.queryParameters['ordering'], 'distance');
    expect(req.queryParameters['lat'], 40.4093);
    expect(req.queryParameters['lng'], 49.8671);
  });

  test('searchDoctors sends ordering=next_slot without coordinates', () async {
    final adapter = _CapturingAdapter({'results': <Object>[]});

    await _repo(adapter).searchDoctors(ordering: 'next_slot');

    final req = adapter.requests.single;
    expect(req.queryParameters['ordering'], 'next_slot');
    expect(req.queryParameters.containsKey('lat'), isFalse);
    expect(req.queryParameters.containsKey('lng'), isFalse);
  });

  test('searchDoctors omits ordering when none is chosen and keeps filters',
      () async {
    final adapter = _CapturingAdapter({'results': <Object>[]});

    await _repo(adapter).searchDoctors(city: 'Baku', minRating: 4);

    final req = adapter.requests.single;
    expect(req.queryParameters.containsKey('ordering'), isFalse);
    expect(req.queryParameters['city'], 'Baku');
    expect(req.queryParameters['min_rating'], 4);
  });

  test('searchDoctors parses next_slot_at and distance_km from the response',
      () async {
    final adapter = _CapturingAdapter({
      'results': [
        {
          'id': 'doc-1',
          'first_name': 'Aysel',
          'last_name': 'Mammadova',
          'next_slot_at': '2026-07-05T09:30:00',
          'distance_km': 2.3,
        },
        {
          'id': 'doc-2',
          'first_name': 'Rauf',
          'last_name': 'Aliyev',
          'next_slot_at': null,
          'distance_km': null,
        },
      ],
    });

    final page = await _repo(adapter).searchDoctors(ordering: 'next_slot');

    expect(page.doctors, hasLength(2));
    expect(page.doctors[0].nextSlotAt, DateTime(2026, 7, 5, 9, 30));
    expect(page.doctors[0].distanceKm, 2.3);
    expect(page.doctors[1].nextSlotAt, isNull);
    expect(page.doctors[1].distanceKm, isNull);
  });

  test('searchDoctors defaults to page 1 and reports hasMore from `next`',
      () async {
    final adapter = _CapturingAdapter({
      'results': <Object>[],
      'next': 'http://localhost/api/doctors/?page=2',
    });

    final page = await _repo(adapter).searchDoctors();

    expect(adapter.requests.single.queryParameters['page'], 1);
    expect(page.hasMore, isTrue);
  });

  test('searchDoctors requests the given page and reports hasMore false '
      'on the last page', () async {
    final adapter = _CapturingAdapter({'results': <Object>[], 'next': null});

    final page = await _repo(adapter).searchDoctors(page: 3);

    expect(adapter.requests.single.queryParameters['page'], 3);
    expect(page.hasMore, isFalse);
  });
}
