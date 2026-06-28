import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/data/repository/doctor_repository.dart';

/// Locally persisted set of favorite doctor IDs. Backed by [SecureStorage]; no
/// server sync (see roadmap — can move to backend later).
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super(const {}) {
    _load();
  }

  final _storage = SecureStorage();

  Future<void> _load() async {
    state = (await _storage.getFavoriteDoctors()).toSet();
  }

  bool isFavorite(String doctorId) => state.contains(doctorId);

  Future<void> toggle(String doctorId) async {
    final next = {...state};
    // Set.add returns false when the element was already present → toggle off.
    if (!next.add(doctorId)) next.remove(doctorId);
    state = next;
    await _storage.saveFavoriteDoctors(next.toList());
  }
}

/// Resolves the favorite IDs into full doctor models for the favorites screen.
/// One detail fetch per favorite — fine for the small, local-only list.
final favoriteDoctorsProvider =
    FutureProvider.autoDispose<List<DoctorDetailModel>>((ref) async {
  final ids = ref.watch(favoritesProvider);
  if (ids.isEmpty) return [];
  final repo = ref.read(doctorRepositoryProvider);
  return Future.wait(ids.map(repo.getDoctorDetail));
});
