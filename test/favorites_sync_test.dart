import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/patient/data/repository/favorites_repository.dart';
import 'package:medalize_mb/features/patient/providers/favorites_provider.dart';

/// Records every request and answers with a canned JSON body, so the
/// repository's paths and payloads can be asserted without a live server.
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

FavoritesRepository _repo(_CapturingAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
  dio.httpClientAdapter = adapter;
  return FavoritesRepository(dio);
}

/// Stands in for the network-backed repository so notifier tests control
/// server behavior (success vs failure) directly.
class _FakeFavoritesRepository extends FavoritesRepository {
  _FakeFavoritesRepository({this.doctors = const [], this.failing = false})
      : super(Dio());

  List<DoctorModel> doctors;
  bool failing;
  final added = <String>[];
  final removed = <String>[];

  @override
  Future<List<DoctorModel>> getFavorites() async {
    if (failing) throw const NetworkException();
    return doctors;
  }

  @override
  Future<void> addFavorite(String doctorId) async {
    if (failing) throw const NetworkException();
    added.add(doctorId);
  }

  @override
  Future<void> removeFavorite(String doctorId) async {
    if (failing) throw const NetworkException();
    removed.add(doctorId);
  }
}

DoctorModel _doctor(String id) => DoctorModel(
      id: id,
      firstName: 'Doc',
      lastName: id,
      specialization: 'cardiology',
      specializationDisplay: 'Cardiology',
      slotDurationMin: 30,
    );

/// Reads the notifier and waits out its async `_load()` bootstrap so tests
/// don't race the initial server fetch.
Future<FavoritesNotifier> _readSettled(ProviderContainer container) async {
  container.read(favoritesProvider);
  await Future<void>.delayed(Duration.zero);
  return container.read(favoritesProvider.notifier);
}

ProviderContainer _container(_FakeFavoritesRepository repo) {
  final container = ProviderContainer(overrides: [
    favoritesRepositoryProvider.overrideWithValue(repo),
  ]);
  addTearDown(container.dispose);
  return container;
}

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  group('FavoritesRepository contract', () {
    test('getFavorites hits GET /favorites/ and parses doctor cards', () async {
      final adapter = _CapturingAdapter([
        {'id': 'doc-1', 'first_name': 'Aysel', 'last_name': 'Mammadova'},
      ]);

      final doctors = await _repo(adapter).getFavorites();

      final req = adapter.requests.single;
      expect(req.method, 'GET');
      expect(req.path, '/favorites/');
      expect(doctors.single.id, 'doc-1');
    });

    test('getFavorites also accepts a paginated payload', () async {
      final adapter = _CapturingAdapter({
        'results': [
          {'id': 'doc-2', 'first_name': 'Rauf', 'last_name': 'Aliyev'},
        ],
      });

      final doctors = await _repo(adapter).getFavorites();

      expect(doctors.single.id, 'doc-2');
    });

    test('addFavorite posts the doctor id, removeFavorite hits the id path',
        () async {
      final adapter = _CapturingAdapter({'id': 'fav-1', 'doctor_id': 'doc-1'});
      final repo = _repo(adapter);

      await repo.addFavorite('doc-1');
      await repo.removeFavorite('doc-1');

      final post = adapter.requests[0];
      expect(post.method, 'POST');
      expect(post.path, '/favorites/');
      expect(post.data, {'doctor_id': 'doc-1'});
      final delete = adapter.requests[1];
      expect(delete.method, 'DELETE');
      expect(delete.path, '/favorites/doc-1/');
    });
  });

  group('FavoritesNotifier sync', () {
    test('loads the favorite set from the server and refreshes the cache',
        () async {
      final repo =
          _FakeFavoritesRepository(doctors: [_doctor('d1'), _doctor('d2')]);
      final container = _container(repo);

      await _readSettled(container);

      expect(container.read(favoritesProvider), {'d1', 'd2'});
      expect(await SecureStorage().getFavoriteDoctors(),
          unorderedEquals(['d1', 'd2']));
    });

    test('falls back to the local cache when the server is unreachable',
        () async {
      FlutterSecureStorage.setMockInitialValues({
        'favorite_doctors': jsonEncode(['d9']),
      });
      final repo = _FakeFavoritesRepository(failing: true);
      final container = _container(repo);

      await _readSettled(container);

      expect(container.read(favoritesProvider), {'d9'});
    });

    test('toggle adds via POST and only then updates state and cache',
        () async {
      final repo = _FakeFavoritesRepository();
      final container = _container(repo);
      final notifier = await _readSettled(container);

      final ok = await notifier.toggle('d1');

      expect(ok, isTrue);
      expect(repo.added, ['d1']);
      expect(container.read(favoritesProvider), {'d1'});
      expect(await SecureStorage().getFavoriteDoctors(), ['d1']);
    });

    test('toggle removes via DELETE when the doctor is already a favorite',
        () async {
      final repo = _FakeFavoritesRepository(doctors: [_doctor('d1')]);
      final container = _container(repo);
      final notifier = await _readSettled(container);

      final ok = await notifier.toggle('d1');

      expect(ok, isTrue);
      expect(repo.removed, ['d1']);
      expect(container.read(favoritesProvider), isEmpty);
      expect(await SecureStorage().getFavoriteDoctors(), isEmpty);
    });

    test('a failed toggle leaves state and cache untouched', () async {
      final repo = _FakeFavoritesRepository(doctors: [_doctor('d1')]);
      final container = _container(repo);
      final notifier = await _readSettled(container);
      repo.failing = true;

      final ok = await notifier.toggle('d2');

      expect(ok, isFalse);
      expect(container.read(favoritesProvider), {'d1'});
      expect(await SecureStorage().getFavoriteDoctors(), ['d1']);
    });
  });
}
