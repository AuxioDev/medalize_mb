import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/patient/data/repository/favorites_repository.dart';

/// Favorite doctor IDs, synced with the backend (`/favorites/`). The
/// [SecureStorage] copy is kept as an offline fallback: reads use it when the
/// network is down, and every successful server round-trip refreshes it.
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) => FavoritesNotifier(ref.read(favoritesRepositoryProvider)),
);

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier(this._repo) : super(const {}) {
    _load();
  }

  final FavoritesRepository _repo;
  final _storage = SecureStorage();

  Future<void> _load() async {
    try {
      final doctors = await _repo.getFavorites();
      final ids = doctors.map((d) => d.id).toSet();
      if (!mounted) return;
      state = ids;
      await _storage.saveFavoriteDoctors(ids.toList());
    } catch (_) {
      // Offline / server error — fall back to the last known local copy.
      final cached = (await _storage.getFavoriteDoctors()).toSet();
      if (mounted) state = cached;
    }
  }

  bool isFavorite(String doctorId) => state.contains(doctorId);

  /// Returns true when the server accepted the change. On failure the local
  /// state is left untouched (no optimistic flip), so the heart icon always
  /// reflects what the backend actually has.
  Future<bool> toggle(String doctorId) async {
    final removing = state.contains(doctorId);
    try {
      if (removing) {
        await _repo.removeFavorite(doctorId);
      } else {
        await _repo.addFavorite(doctorId);
      }
    } catch (_) {
      return false;
    }
    if (!mounted) return true;
    final next = {...state};
    removing ? next.remove(doctorId) : next.add(doctorId);
    state = next;
    await _storage.saveFavoriteDoctors(next.toList());
    return true;
  }
}

/// Full doctor cards for the favorites screen, straight from
/// `GET /favorites/`. Watches [favoritesProvider] so a toggle anywhere in the
/// app refreshes the list.
final favoriteDoctorsProvider =
    FutureProvider.autoDispose<List<DoctorModel>>((ref) {
  ref.watch(favoritesProvider);
  return ref.watch(favoritesRepositoryProvider).getFavorites();
});
