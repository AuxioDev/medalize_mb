import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/records/data/models/medical_record_model.dart';
import 'package:medalize_mb/features/records/data/repository/medical_record_repository.dart';

/// `autoDispose`: holds the signed-in patient's own medical records — must
/// not survive a logout/login as another patient on a shared device.
/// Disposed once nothing is watching it, which the auth redirect guarantees
/// happens on both logout and the next login (see `medicationsProvider` for
/// the full rationale).
final medicalRecordsProvider = FutureProvider.autoDispose<List<MedicalRecordModel>>((ref) {
  return ref.watch(medicalRecordRepositoryProvider).getRecords();
});

/// Groups the flat record list by `recordType`, preserving each group's
/// server order. Depends on [medicalRecordsProvider] so it shares its
/// loading/error/data lifecycle automatically. `autoDispose`: required
/// because it watches an `autoDispose` provider.
final medicalRecordsByTypeProvider =
    Provider.autoDispose<AsyncValue<Map<String, List<MedicalRecordModel>>>>((ref) {
  final async = ref.watch(medicalRecordsProvider);
  return async.whenData((records) {
    final map = <String, List<MedicalRecordModel>>{};
    for (final r in records) {
      map.putIfAbsent(r.recordType, () => []).add(r);
    }
    return map;
  });
});
