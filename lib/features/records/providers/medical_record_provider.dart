import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/records/data/models/medical_record_model.dart';
import 'package:medalize_mb/features/records/data/repository/medical_record_repository.dart';

final medicalRecordsProvider = FutureProvider<List<MedicalRecordModel>>((ref) {
  return ref.watch(medicalRecordRepositoryProvider).getRecords();
});

/// Groups the flat record list by `recordType`, preserving each group's
/// server order. Depends on [medicalRecordsProvider] so it shares its
/// loading/error/data lifecycle automatically.
final medicalRecordsByTypeProvider =
    Provider<AsyncValue<Map<String, List<MedicalRecordModel>>>>((ref) {
  final async = ref.watch(medicalRecordsProvider);
  return async.whenData((records) {
    final map = <String, List<MedicalRecordModel>>{};
    for (final r in records) {
      map.putIfAbsent(r.recordType, () => []).add(r);
    }
    return map;
  });
});
