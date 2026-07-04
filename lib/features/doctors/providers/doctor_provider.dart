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

final doctorSearchProvider =
    FutureProvider.family<List<DoctorModel>, SearchParams>((ref, params) {
  return ref.watch(doctorRepositoryProvider).searchDoctors(
        name: params.name,
        specialization: params.specialization,
        city: params.city,
        minRating: params.minRating,
        ordering: params.ordering,
        lat: params.lat,
        lng: params.lng,
      );
});

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
