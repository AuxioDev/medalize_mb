/// A family member (child, spouse, parent, ...) managed by the signed-in
/// account holder. A dependent has no login of their own — it's just a
/// profile the patient manages, so bookings/medications/records can be made
/// "for" them instead of for the account holder. See
/// `lib/features/family/providers/family_provider.dart::activeProfileProvider`
/// for how the active profile selection flows into those creation calls.
class DependentModel {
  static const relationshipChild = 'child';
  static const relationshipSpouse = 'spouse';
  static const relationshipParent = 'parent';
  static const relationshipSibling = 'sibling';
  static const relationshipOther = 'other';

  final String id;
  final String firstName;
  final String lastName;
  final String relationship;
  final DateTime? dateOfBirth;
  final String bloodType;
  final String allergies;
  final String chronicConditions;
  final String medications;
  final bool isActive;

  const DependentModel({
    required this.id,
    required this.firstName,
    this.lastName = '',
    this.relationship = relationshipOther,
    this.dateOfBirth,
    this.bloodType = '',
    this.allergies = '',
    this.chronicConditions = '',
    this.medications = '',
    this.isActive = true,
  });

  /// Parses either a full `DependentSerializer` payload or the smaller
  /// `DependentBriefSerializer` shape (`id, first_name, last_name,
  /// relationship`) embedded on appointments/medications/records — the
  /// fields the brief shape omits simply default (see field defaults above).
  factory DependentModel.fromJson(Map<String, dynamic> j) => DependentModel(
        id: j['id'] as String,
        firstName: j['first_name'] as String? ?? '',
        lastName: j['last_name'] as String? ?? '',
        relationship: j['relationship'] as String? ?? relationshipOther,
        dateOfBirth: j['date_of_birth'] != null
            ? DateTime.parse(j['date_of_birth'] as String)
            : null,
        bloodType: j['blood_type'] as String? ?? '',
        allergies: j['allergies'] as String? ?? '',
        chronicConditions: j['chronic_conditions'] as String? ?? '',
        medications: j['medications'] as String? ?? '',
        isActive: j['is_active'] as bool? ?? true,
      );

  String get fullName => '$firstName $lastName'.trim();

  /// Whole years old as of today; `null` when [dateOfBirth] isn't known (e.g.
  /// parsed from the brief embed, which never includes it).
  int? get age {
    final dob = dateOfBirth;
    if (dob == null) return null;
    final now = DateTime.now();
    var years = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      years--;
    }
    return years;
  }
}
