import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/doctor/data/models/doctor_stats_model.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/data/repository/doctor_repository.dart';
import 'package:medalize_mb/features/patient/data/models/waitlist_model.dart';

class SearchParams {
  final String? name;
  final String? specialization;
  final String? city;
  final int? minRating;
  final String? ordering;
  final double? lat;
  final double? lng;

  const SearchParams({
    this.name,
    this.specialization,
    this.city,
    this.minRating,
    this.ordering,
    this.lat,
    this.lng,
  });

  @override
  bool operator ==(Object other) =>
      other is SearchParams &&
      other.name == name &&
      other.specialization == specialization &&
      other.city == city &&
      other.minRating == minRating &&
      other.ordering == ordering &&
      other.lat == lat &&
      other.lng == lng;

  @override
  int get hashCode =>
      Object.hash(name, specialization, city, minRating, ordering, lat, lng);
}

class SlotsParams {
  final String doctorId;
  final String workplaceId;
  final DateTime date;

  const SlotsParams({
    required this.doctorId,
    required this.workplaceId,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      other is SlotsParams &&
      other.doctorId == doctorId &&
      other.workplaceId == workplaceId &&
      other.date == date;

  @override
  int get hashCode => Object.hash(doctorId, workplaceId, date);
}

enum DoctorSearchStatus { initial, loading, loadingMore, loaded, error }

class DoctorSearchState {
  const DoctorSearchState({
    this.status = DoctorSearchStatus.initial,
    this.doctors = const [],
    this.hasMore = false,
    this.page = 1,
  });

  final DoctorSearchStatus status;
  final List<DoctorModel> doctors;
  final bool hasMore;
  final int page;

  DoctorSearchState copyWith({
    DoctorSearchStatus? status,
    List<DoctorModel>? doctors,
    bool? hasMore,
    int? page,
  }) =>
      DoctorSearchState(
        status: status ?? this.status,
        doctors: doctors ?? this.doctors,
        hasMore: hasMore ?? this.hasMore,
        page: page ?? this.page,
      );
}

/// Drives doctor search with server-side pagination: [search] replaces the
/// result set for a new filter combination, [loadMore] appends the next
/// page. Kept as a single (non-family) notifier — the screen re-triggers
/// [search] explicitly on every filter change instead of relying on
/// Riverpod's family-keyed rebuilds, so "load more" state doesn't have to be
/// tracked per filter combination.
class DoctorSearchNotifier extends StateNotifier<DoctorSearchState> {
  DoctorSearchNotifier(this._repo) : super(const DoctorSearchState());

  final DoctorRepository _repo;
  SearchParams _params = const SearchParams();

  Future<void> search(SearchParams params) async {
    _params = params;
    state = const DoctorSearchState(status: DoctorSearchStatus.loading);
    try {
      final result = await _repo.searchDoctors(
        name: params.name,
        specialization: params.specialization,
        city: params.city,
        minRating: params.minRating,
        ordering: params.ordering,
        lat: params.lat,
        lng: params.lng,
      );
      if (!mounted) return;
      state = DoctorSearchState(
        status: DoctorSearchStatus.loaded,
        doctors: result.doctors,
        hasMore: result.hasMore,
        page: 1,
      );
    } catch (_) {
      if (!mounted) return;
      state = const DoctorSearchState(status: DoctorSearchStatus.error);
    }
  }

  /// Returns false if the fetch failed, so the screen can show a retry
  /// affordance while keeping the already-loaded results on screen.
  Future<bool> loadMore() async {
    if (!state.hasMore || state.status == DoctorSearchStatus.loadingMore) {
      return true;
    }
    state = state.copyWith(status: DoctorSearchStatus.loadingMore);
    final nextPage = state.page + 1;
    try {
      final result = await _repo.searchDoctors(
        name: _params.name,
        specialization: _params.specialization,
        city: _params.city,
        minRating: _params.minRating,
        ordering: _params.ordering,
        lat: _params.lat,
        lng: _params.lng,
        page: nextPage,
      );
      if (!mounted) return true;
      state = state.copyWith(
        status: DoctorSearchStatus.loaded,
        doctors: [...state.doctors, ...result.doctors],
        hasMore: result.hasMore,
        page: nextPage,
      );
      return true;
    } catch (_) {
      if (!mounted) return false;
      state = state.copyWith(status: DoctorSearchStatus.loaded);
      return false;
    }
  }
}

final doctorSearchProvider =
    StateNotifierProvider<DoctorSearchNotifier, DoctorSearchState>(
  (ref) => DoctorSearchNotifier(ref.read(doctorRepositoryProvider)),
);

final doctorDetailProvider =
    FutureProvider.family<DoctorDetailModel, String>((ref, id) {
  return ref.watch(doctorRepositoryProvider).getDoctorDetail(id);
});

final slotsProvider =
    FutureProvider.family<List<SlotModel>, SlotsParams>((ref, params) {
  return ref.watch(doctorRepositoryProvider).getSlots(
        params.doctorId,
        params.workplaceId,
        params.date,
      );
});

final nextAvailableDateProvider =
    FutureProvider.family<DateTime?, String>((ref, doctorId) {
  return ref.watch(doctorRepositoryProvider).getNextAvailableDate(doctorId);
});

final doctorStatsProvider = FutureProvider<DoctorStatsModel>((ref) {
  return ref.watch(doctorRepositoryProvider).getStats();
});

final myWaitlistProvider = FutureProvider<List<WaitlistModel>>((ref) {
  return ref.watch(doctorRepositoryProvider).getMyWaitlist();
});

final selectedDoctorProvider = StateProvider<DoctorModel?>((ref) => null);
final selectedSlotProvider = StateProvider<SlotModel?>((ref) => null);
final selectedWorkplaceIdProvider = StateProvider<String?>((ref) => null);
