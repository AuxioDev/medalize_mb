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

  /// Contact channel for an adult (18+) dependent's own consent notice —
  /// see [consentNoticeSentAt]. `contactEmail` is the one that actually
  /// matters: it's the only channel the backend can deliver the notice
  /// through (no SMS infrastructure exists), so it's required client-side
  /// once [age] computes to 18+ (see AddEditDependentScreen). `contactPhone`
  /// is optional/supplementary and kept only for the account holder's own
  /// reference.
  final String contactEmail;
  final String contactPhone;

  /// When the backend last emailed this adult dependent's contact_email to
  /// let them know they were added (see apps.family.services.
  /// issue_consent_notice on the backend) — `null` for a minor dependent, or
  /// an adult dependent whose notice hasn't gone out yet. Never cleared by
  /// editing; only relevant for showing a "notice sent" indicator (see
  /// FamilyListScreen's badge and AddEditDependentScreen's banner) since a
  /// dependent who *objects* via their no-login link is soft-deleted
  /// server-side and simply stops appearing in `dependentsProvider` (same
  /// active-only filtering as an ordinary deleted dependent).
  final DateTime? consentNoticeSentAt;

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
    this.contactEmail = '',
    this.contactPhone = '',
    this.consentNoticeSentAt,
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
        contactEmail: j['contact_email'] as String? ?? '',
        contactPhone: j['contact_phone'] as String? ?? '',
        consentNoticeSentAt: j['consent_notice_sent_at'] != null
            ? DateTime.parse(j['consent_notice_sent_at'] as String)
            : null,
        isActive: j['is_active'] as bool? ?? true,
      );

  String get fullName => '$firstName $lastName'.trim();

  /// Whole years old as of today for a given date of birth; `null` when
  /// [dob] isn't known. A static helper (rather than only an instance
  /// getter) so AddEditDependentScreen can compute this from the date
  /// picker's raw value *before* a DependentModel exists yet (i.e. while
  /// still filling out the "add" form) — see [age] below for the instance
  /// form of the same calculation, and apps.family.services.dependent_age
  /// on the backend for the (intentionally identical) server-side version
  /// this mirrors.
  static int? ageFromDob(DateTime? dob) {
    if (dob == null) return null;
    final now = DateTime.now();
    var years = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      years--;
    }
    return years;
  }

  /// Whole years old as of today; `null` when [dateOfBirth] isn't known (e.g.
  /// parsed from the brief embed, which never includes it).
  int? get age => ageFromDob(dateOfBirth);
}
