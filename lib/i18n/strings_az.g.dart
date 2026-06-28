///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsAz extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAz({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.az,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <az>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsAz _root = this; // ignore: unused_field

	@override 
	TranslationsAz $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAz(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'Medalize';
	@override late final _Translations$common$az common = _Translations$common$az._(_root);
	@override late final _Translations$auth$az auth = _Translations$auth$az._(_root);
	@override late final _Translations$forgotPassword$az forgotPassword = _Translations$forgotPassword$az._(_root);
	@override late final _Translations$resetPassword$az resetPassword = _Translations$resetPassword$az._(_root);
	@override late final _Translations$validation$az validation = _Translations$validation$az._(_root);
	@override late final _Translations$errors$az errors = _Translations$errors$az._(_root);
	@override late final _Translations$settings$az settings = _Translations$settings$az._(_root);
	@override late final _Translations$status$az status = _Translations$status$az._(_root);
	@override late final _Translations$home$az home = _Translations$home$az._(_root);
	@override late final _Translations$appointments$az appointments = _Translations$appointments$az._(_root);
	@override late final _Translations$booking$az booking = _Translations$booking$az._(_root);
	@override late final _Translations$doctorSearch$az doctorSearch = _Translations$doctorSearch$az._(_root);
	@override late final _Translations$doctorDetail$az doctorDetail = _Translations$doctorDetail$az._(_root);
	@override late final _Translations$profile$az profile = _Translations$profile$az._(_root);
	@override late final _Translations$notifications$az notifications = _Translations$notifications$az._(_root);
	@override late final _Translations$workplaces$az workplaces = _Translations$workplaces$az._(_root);
	@override late final _Translations$addWorkplace$az addWorkplace = _Translations$addWorkplace$az._(_root);
	@override late final _Translations$workingHours$az workingHours = _Translations$workingHours$az._(_root);
	@override late final _Translations$blockTime$az blockTime = _Translations$blockTime$az._(_root);
	@override late final _Translations$onboarding$az onboarding = _Translations$onboarding$az._(_root);
	@override late final _Translations$pendingVerification$az pendingVerification = _Translations$pendingVerification$az._(_root);
	@override late final _Translations$phoneField$az phoneField = _Translations$phoneField$az._(_root);
	@override late final _Translations$splash$az splash = _Translations$splash$az._(_root);
	@override late final _Translations$agenda$az agenda = _Translations$agenda$az._(_root);
	@override late final _Translations$favorites$az favorites = _Translations$favorites$az._(_root);
}

// Path: common
class _Translations$common$az extends Translations$common$en {
	_Translations$common$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Ləğv et';
	@override String get logout => 'Çıxış';
	@override String get doctor => 'Həkim';
	@override String get patient => 'Pasiyent';
	@override String get save => 'Yadda saxla';
	@override String get edit => 'Redaktə et';
	@override String get retry => 'Yenidən cəhd et';
	@override String get back => 'Geri';
	@override String get ok => 'OK';
	@override String get delete => 'Sil';
	@override String get keep => 'Saxla';
	@override String get confirm => 'Təsdiqlə';
	@override String get decline => 'İmtina et';
	@override String get primary => 'Əsas';
	@override String get somethingWrong => 'Nə isə səhv getdi';
	@override String get seeAll => 'Hamısına bax';
	@override String get signOut => 'Çıxış';
	@override String get search => 'Axtar';
	@override String get tryAgain => 'Zəhmət olmasa yenidən cəhd edin';
	@override String get required => 'Tələb olunur';
}

// Path: auth
class _Translations$auth$az extends Translations$auth$en {
	_Translations$auth$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get login => 'Daxil ol';
	@override String get register => 'Hesab yarat';
	@override String get signIn => 'Daxil ol';
	@override String get signUp => 'Qeydiyyatdan keç';
	@override String get email => 'E-poçt';
	@override String get password => 'Şifrə';
	@override String get confirmPassword => 'Şifrəni təsdiqlə';
	@override String get firstName => 'Ad';
	@override String get lastName => 'Soyad';
	@override String get rememberMe => 'Məni xatırla';
	@override String get forgotPassword => 'Şifrəni unutmusunuz?';
	@override String get sendResetLink => 'Bərpa kodu göndər';
	@override String get noAccount => 'Hesabınız yoxdur?';
	@override String get haveAccount => 'Artıq hesabınız var?';
	@override String get welcomeBack => 'Yenidən xoş gəldiniz';
	@override String get signInToContinue => 'Davam etmək üçün hesabınıza daxil olun';
	@override String get createYourAccount => 'Hesabınızı yaradın';
	@override String get joinMedalize => 'Bu gün Medalize-ə qoşulun';
	@override String get iAmA => 'Mən';
	@override String get emailHint => 'you@example.com';
	@override String get passwordHint => '••••••••';
	@override String get backToSignIn => 'Girişə qayıt';
	@override String get verificationCode => 'Təsdiq kodu';
}

// Path: forgotPassword
class _Translations$forgotPassword$az extends Translations$forgotPassword$en {
	_Translations$forgotPassword$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Şifrəni unutmusunuz?';
	@override String get subtitle => 'E-poçtunuzu daxil edin, sizə 6 rəqəmli bərpa kodu göndərək';
}

// Path: resetPassword
class _Translations$resetPassword$az extends Translations$resetPassword$en {
	_Translations$resetPassword$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Şifrəni bərpa et';
	@override String get subtitle => 'E-poçtunuza göndərilən kodu daxil edin və yeni şifrə seçin';
	@override String get button => 'Şifrəni bərpa et';
	@override String get success => 'Şifrə uğurla bərpa edildi. Zəhmət olmasa daxil olun.';
}

// Path: validation
class _Translations$validation$az extends Translations$validation$en {
	_Translations$validation$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => 'E-poçt tələb olunur';
	@override String get emailInvalid => 'Düzgün e-poçt ünvanı daxil edin';
	@override String get passwordRequired => 'Şifrə tələb olunur';
	@override String get passwordTooShort => 'Ən azı 8 simvol tələb olunur';
	@override String get passwordNeedsLetter => 'Ən azı bir hərf əlavə edin';
	@override String get passwordNeedsDigit => 'Ən azı bir rəqəm əlavə edin';
	@override String get passwordMismatch => 'Şifrələr uyğun gəlmir';
	@override String get passwordConfirmRequired => 'Zəhmət olmasa şifrəni təsdiqləyin';
	@override String get nameMinLength => 'Ən azı 2 simvol olmalıdır';
	@override String get roleRequired => 'Zəhmət olmasa rol seçin';
	@override String get phoneRequired => 'Telefon nömrəsi tələb olunur';
	@override String get phoneTooShort => 'Nömrə çox qısadır';
	@override String get phoneTooLong => 'Nömrə çox uzundur';
	@override String fieldRequired({required Object field}) => '${field} tələb olunur';
	@override String fieldInvalid({required Object field}) => '${field} yanlış simvollar ehtiva edir';
}

// Path: errors
class _Translations$errors$az extends Translations$errors$en {
	_Translations$errors$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get network => 'Şəbəkə xətası. Bağlantınızı yoxlayın.';
	@override String get rateLimit => 'Çox cəhd edildi. Zəhmət olmasa gözləyib yenidən cəhd edin.';
	@override String rateLimitWithSeconds({required Object seconds}) => 'Çox cəhd edildi. ${seconds} saniyə sonra yenidən cəhd edin.';
	@override String get invalidCredentials => 'Yanlış e-poçt və ya şifrə';
	@override String get sessionExpired => 'Sessiyanın vaxtı bitdi. Zəhmət olmasa yenidən daxil olun.';
	@override String get authError => 'Autentifikasiya xətası. Zəhmət olmasa yenidən daxil olun.';
	@override String get sessionRevoked => 'Sessiya ləğv edildi. Zəhmət olmasa yenidən daxil olun.';
	@override String get permissionDenied => 'Bunu etməyə icazəniz yoxdur.';
	@override String get validationError => 'Doğrulama xətası';
	@override String serverError({required Object code}) => 'Server xətası (${code}). Zəhmət olmasa yenidən cəhd edin.';
}

// Path: settings
class _Translations$settings$az extends Translations$settings$en {
	_Translations$settings$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parametrlər';
	@override String get account => 'Hesab';
	@override String get profile => 'Profil';
	@override String get notifications => 'Bildirişlər';
	@override String get appearance => 'Görünüş';
	@override String get themeSystem => 'Sistem';
	@override String get themeLight => 'İşıqlı';
	@override String get themeDark => 'Qaranlıq';
	@override String get language => 'Dil';
	@override String get languageSystem => 'Sistem default';
	@override String get logoutTitle => 'Çıxış';
	@override String get logoutConfirm => 'Çıxmaq istədiyinizə əminsiniz?';
	@override String get version => 'Medalize v1.0.0';
}

// Path: status
class _Translations$status$az extends Translations$status$en {
	_Translations$status$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'Təsdiqləndi';
	@override String get pending => 'Gözləyir';
	@override String get cancelled => 'Ləğv edildi';
	@override String get declined => 'Rədd edildi';
	@override String get requiresRescheduling => 'Yenidən planlaşdırma tələb edir';
	@override String get completed => 'Tamamlandı';
	@override String get noShow => 'Gəlmədi';
}

// Path: home
class _Translations$home$az extends Translations$home$en {
	_Translations$home$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String helloDoctor({required Object name}) => 'Salam, Dr. ${name}!';
	@override String helloPatient({required Object name}) => 'Salam, ${name}!';
	@override String get doctorSubtitle => 'Cədvəlinizi və\ngörüşlərinizi idarə edin.';
	@override String get patientSubtitle => 'Həkim tapın və\ngörüş təyin edin.';
	@override String get pendingRequests => 'Gözləyən sorğular';
	@override String get upcoming => 'Yaxınlaşan';
	@override String get findDoctor => 'Həkim tap';
	@override String get myAppointments => 'Görüşlərim';
	@override String get appointments => 'Görüşlər';
	@override String get workplaces => 'İş yerləri';
	@override String get blockTime => 'Vaxtı blokla';
	@override String get profile => 'Profil';
	@override String get allCaughtUp => 'Hər şey qaydasındadır';
	@override String get noPendingRequests => 'Gözləyən görüş sorğusu yoxdur';
	@override String get couldNotLoadAppointments => 'Görüşlər yüklənə bilmədi';
	@override String get noUpcoming => 'Yaxınlaşan görüş yoxdur';
	@override String get bookFirst => 'Həkimlə ilk görüşünüzü təyin edin';
	@override String get findADoctor => 'Həkim tap';
	@override String get myWaitlist => 'Gözləmə siyahım';
	@override String get leaveWaitlist => 'Çıx';
	@override String get statsThisMonth => 'Bu ay';
	@override String get statsPatients => 'Pasiyentlər';
	@override String get statsAcceptRate => 'Qəbul faizi';
	@override String get statsPending => 'Gözlənilir';
	@override String get schedule => 'Cədvəl';
}

// Path: appointments
class _Translations$appointments$az extends Translations$appointments$en {
	_Translations$appointments$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Görüşlər';
	@override String get myTitle => 'Görüşlərim';
	@override String get tabPending => 'Gözləyən';
	@override String get tabAll => 'Hamısı';
	@override String get tabUpcoming => 'Yaxınlaşan';
	@override String get tabPast => 'Keçmiş';
	@override String get noPendingRequests => 'Gözləyən sorğu yoxdur';
	@override String get newRequestsAppear => 'Yeni görüş sorğuları burada görünəcək';
	@override String get noAppointments => 'Görüş yoxdur';
	@override String get appointmentsAppear => 'Görüşləriniz burada görünəcək';
	@override String get noUpcoming => 'Yaxınlaşan görüş yoxdur';
	@override String get bookFirst => 'Həkimlə ilk görüşünüzü təyin edin';
	@override String get noPast => 'Keçmiş görüş yoxdur';
	@override String get pastAppear => 'Tamamlanmış və ləğv edilmiş görüşlər burada görünür';
	@override String get couldNotLoad => 'Görüşlər yüklənə bilmədi';
	@override String get detailTitle => 'Görüş';
	@override String get patient => 'Pasiyent';
	@override String get doctor => 'Həkim';
	@override String get workplace => 'İş yeri';
	@override String get dateTime => 'Tarix və vaxt';
	@override String get reason => 'Səbəb';
	@override String get doctorNotes => 'Həkim qeydləri';
	@override String get cancelTitle => 'Görüşü ləğv et';
	@override String get cancelConfirm => 'Bu görüşü ləğv etmək istədiyinizə əminsiniz?';
	@override String get cancelAction => 'Görüşü ləğv et';
	@override String get bookedTitle => 'Təyin edildi!';
	@override String get bookedMessage => 'Görüş sorğunuz göndərildi.';
	@override String get reschedule => 'Yenidən planlaşdır';
	@override String get rescheduleTitle => 'Görüşü yenidən planlaşdır';
	@override String get reviewTitle => 'Rəy yaz';
	@override String get reviewRating => 'Qiymət';
	@override String get reviewComment => 'Şərh (istəyə bağlı)';
	@override String get reviewSubmit => 'Göndər';
	@override String get markCompleted => 'Tamamlandı kimi işarələ';
	@override String get rescheduledSuccess => 'Görüş uğurla yenidən planlaşdırıldı.';
	@override String get reviewSubmitted => 'Rəy göndərildi. Təşəkkür edirik!';
	@override String get requestReschedule => 'Vaxtın dəyişdirilməsini istə';
	@override String get requestRescheduleTitle => 'Vaxtın dəyişdirilməsi';
	@override String get requestRescheduleConfirm => 'Pasiyentdən yeni vaxt seçməsini istəyirsiniz? Görüş “vaxtın dəyişdirilməsi tələb olunur” kimi işarələnəcək.';
	@override String get requestRescheduleSuccess => 'Vaxtın dəyişdirilməsi istənildi. Pasiyentə bildiriş göndəriləcək.';
	@override String get rescheduleNeededHint => 'Həkim sizdən yeni vaxt seçməyinizi xahiş etdi.';
	@override String get markNoShow => 'Gəlmədi kimi qeyd et';
	@override String get markNoShowTitle => 'Gəlmədi kimi qeyd et';
	@override String get markNoShowConfirm => 'Bu görüşü “gəlmədi” kimi qeyd edək? Bu, pasiyentin gəlmədiyini qeyd edir.';
}

// Path: booking
class _Translations$booking$az extends Translations$booking$en {
	_Translations$booking$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String bookWith({required Object name}) => 'Təyin et — ${name}';
	@override String get selectWorkplace => 'İş yerini seçin';
	@override String get pickDate => 'Tarix seçin';
	@override String get slotsAppear => 'Mövcud vaxt aralıqları burada görünəcək';
	@override String get couldNotLoadSlots => 'Vaxt aralıqları yüklənə bilmədi';
	@override String get noAvailableSlots => 'Mövcud vaxt yoxdur';
	@override String get noOpenSlots => 'Bu tarix üçün boş vaxt yoxdur. Başqa gün seçin.';
	@override String get confirmTitle => 'Təyinatı təsdiqlə';
	@override String get reasonForVisit => 'Ziyarət səbəbi (istəyə bağlı)';
	@override String get confirmButton => 'Təyinatı təsdiqlə';
	@override String get doctorLabel => 'Həkim';
	@override String get workplaceLabel => 'İş yeri';
	@override String get addressLabel => 'Ünvan';
	@override String get startLabel => 'Başlanğıc';
	@override String get endLabel => 'Son';
	@override String get tryDifferentDate => 'Başqa tarix seçin';
}

// Path: doctorSearch
class _Translations$doctorSearch$az extends Translations$doctorSearch$en {
	_Translations$doctorSearch$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Həkim tap';
	@override String get searchByName => 'Ada görə axtar...';
	@override String get city => 'Şəhər';
	@override String get search => 'Axtar';
	@override String get noDoctorsFound => 'Həkim tapılmadı';
	@override String get adjustSearch => 'Axtarış və ya filtrləri dəyişməyə cəhd edin';
	@override String get couldNotLoadDoctors => 'Həkimlər yüklənə bilmədi';
	@override late final _Translations$doctorSearch$spec$az spec = _Translations$doctorSearch$spec$az._(_root);
	@override String get noAvailability => 'Vaxt yoxdur';
	@override String get availableToday => 'Bugün müsaittir';
	@override String get availableTomorrow => 'Sabah müsaittir';
	@override String availableOn({required Object date}) => '${date} müsaittir';
	@override String get sortBy => 'Sırala';
	@override String get sortDefault => 'Uyğunluq';
	@override String get sortRating => 'Ən yüksək reytinq';
	@override String get sortPriceLow => 'Ən aşağı qiymət';
	@override String get sortName => 'Ad (A–Z)';
}

// Path: doctorDetail
class _Translations$doctorDetail$az extends Translations$doctorDetail$en {
	_Translations$doctorDetail$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get profileTitle => 'Həkim profili';
	@override String get couldNotLoadProfile => 'Profil yüklənə bilmədi';
	@override String get about => 'Haqqında';
	@override String get workplaces => 'İş yerləri';
	@override String minPerSlot({required Object min}) => 'hər aralıq ${min} dəq';
	@override String get bookAppointment => 'Görüş təyin et';
	@override String get consultationFee => 'Konsultasiya haqqı';
	@override String get reviews => 'Rəylər';
}

// Path: profile
class _Translations$profile$az extends Translations$profile$en {
	_Translations$profile$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profil';
	@override String get changePassword => 'Şifrəni dəyiş';
	@override String get currentPassword => 'Cari şifrə';
	@override String get newPassword => 'Yeni şifrə';
	@override String get confirmNewPassword => 'Yeni şifrəni təsdiqlə';
	@override String get firstName => 'Ad';
	@override String get lastName => 'Soyad';
	@override String get phone => 'Telefon';
	@override String get failedToSave => 'Profil yadda saxlanıla bilmədi.';
	@override String get professionalInfo => 'Peşəkar məlumat';
	@override String get bio => 'Bioqrafiya';
	@override String get bioHint => 'Təcrübənizin qısa təsviri';
	@override String get consultationFee => 'Konsultasiya haqqı';
	@override String get medicalInfo => 'Tibbi məlumat';
	@override String get allergies => 'Allergiyalar';
	@override String get allergiesHint => 'məs. Penisilin, fıstıq';
	@override String get chronicConditions => 'Xroniki xəstəliklər';
	@override String get chronicConditionsHint => 'məs. Diabet, hipertansiyon';
	@override String get medications => 'Cari dərmanlar';
	@override String get medicationsHint => 'məs. Metformin 500mq';
	@override String get appointmentLength => 'Görüşün müddəti';
}

// Path: notifications
class _Translations$notifications$az extends Translations$notifications$en {
	_Translations$notifications$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bildirişlər';
	@override String get noNotifications => 'Bildiriş yoxdur';
	@override String get allCaughtUp => 'Hər şey qaydasındadır';
	@override String get couldNotLoad => 'Bildirişlər yüklənə bilmədi';
	@override String get markAllRead => 'Hamısını oxunmuş işarələ';
}

// Path: workplaces
class _Translations$workplaces$az extends Translations$workplaces$en {
	_Translations$workplaces$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'İş yerlərim';
	@override String get noWorkplacesYet => 'Hələ iş yeri yoxdur';
	@override String get tapToAdd => 'İlk iş yerinizi əlavə etmək üçün + düyməsinə toxunun';
	@override String get couldNotLoad => 'İş yerləri yüklənə bilmədi';
	@override String get deleteTitle => 'İş yerini sil';
	@override String deleteConfirm({required Object name}) => '"${name}" silinsin?';
	@override String get cannotDelete => 'İş yeri silinə bilmir';
	@override String get workingHours => 'İş saatları';
	@override String get setAsPrimary => 'Əsas kimi təyin et';
}

// Path: addWorkplace
class _Translations$addWorkplace$az extends Translations$addWorkplace$en {
	_Translations$addWorkplace$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'İş yeri əlavə et';
	@override String get editTitle => 'İş yerini redaktə et';
	@override String get name => 'Ad';
	@override String get address => 'Ünvan';
	@override String get city => 'Şəhər';
	@override String get type => 'Növ';
	@override String get clinic => 'Klinika';
	@override String get hospital => 'Xəstəxana';
	@override String get privatePractice => 'Şəxsi praktika';
	@override String get failedToSave => 'İş yeri yadda saxlanıla bilmədi.';
	@override String get addButton => 'İş yeri əlavə et';
	@override String get saveChanges => 'Dəyişiklikləri yadda saxla';
}

// Path: workingHours
class _Translations$workingHours$az extends Translations$workingHours$en {
	_Translations$workingHours$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'İş saatları';
	@override String get saved => 'İş saatları yadda saxlanıldı';
	@override String get failedToSave => 'İş saatları yadda saxlanıla bilmədi';
	@override late final _Translations$workingHours$days$az days = _Translations$workingHours$days$az._(_root);
}

// Path: blockTime
class _Translations$blockTime$az extends Translations$blockTime$en {
	_Translations$blockTime$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vaxtı blokla';
	@override String get dateRange => 'Tarix aralığı';
	@override String get tapToSelect => 'Tarixləri seçmək üçün toxunun';
	@override String get reason => 'Səbəb (istəyə bağlı)';
	@override String get notifyPatients => 'Təsirlənən pasiyentlərə bildir';
	@override String get notifyDesc => 'Bu dövrdə görüşü olan pasiyentlərə bildiriş göndər';
	@override String get selectDateRange => 'Zəhmət olmasa tarix aralığı seçin.';
	@override String get failedToBlock => 'Vaxt bloklana bilmədi. Zəhmət olmasa yenidən cəhd edin.';
	@override String get blockButton => 'Dövrü blokla';
}

// Path: onboarding
class _Translations$onboarding$az extends Translations$onboarding$en {
	_Translations$onboarding$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profilinizi tamamlayın';
	@override String get professionalInfo => 'Peşəkar məlumat';
	@override String get tellPatients => 'Pasiyentlərə praktikanız haqqında məlumat verin.';
	@override String get specialization => 'İxtisas';
	@override String get selectSpecialization => 'İxtisasınızı seçin';
	@override String get couldNotLoadSpecs => 'İxtisaslar yüklənə bilmədi. Geri çəkin və yenidən cəhd edin.';
	@override String get licenseNumber => 'Lisenziya nömrəsi';
	@override String get licenseHint => 'məs. AZ-123456';
	@override String get bio => 'Bioqrafiya (istəyə bağlı)';
	@override String get bioHint => 'Pasiyentlərin profilinizdə görəcəyi qısa təqdimat.';
	@override String get appointmentLength => 'Görüş müddəti';
	@override String get slotQuestion => 'Bir görüş aralığı nə qədərdir?';
	@override String get changeLater => 'Bunu sonradan profilinizdən dəyişə bilərsiniz.';
	@override String minutes({required Object min}) => '${min} dəq';
	@override String get verificationDoc => 'Təsdiq sənədi';
	@override String get uploadDiploma => 'Tibbi diplomunuzu və ya lisenziyanızı yükləyin. Hesabınız təsdiqlənməzdən əvvəl admin onu yoxlayır.';
	@override String get tapToChoose => 'Fayl seçmək üçün toxunun';
	@override String get tapToReplace => 'Dəyişmək üçün toxunun';
	@override String get anyFileType => 'İstənilən fayl növü, 10 MB-a qədər';
	@override String get selectSpecError => 'Zəhmət olmasa ixtisasınızı seçin.';
	@override String get licenseError => 'Zəhmət olmasa lisenziya nömrənizi daxil edin.';
	@override String get diplomaError => 'Zəhmət olmasa diplomunuzu əlavə edin.';
	@override String get checkDetails => 'Zəhmət olmasa məlumatlarınızı yoxlayıb yenidən cəhd edin.';
	@override String get continueButton => 'Davam et';
	@override String get finish => 'Bitir';
}

// Path: pendingVerification
class _Translations$pendingVerification$az extends Translations$pendingVerification$en {
	_Translations$pendingVerification$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Təsdiq gözlənilir';
	@override String get message => 'Hesabınız nəzərdən keçirilir. Təsdiqləndikdən sonra sizə bildiriş göndərəcəyik.';
}

// Path: phoneField
class _Translations$phoneField$az extends Translations$phoneField$en {
	_Translations$phoneField$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get label => 'Telefon nömrəsi';
	@override String get labelOptional => 'Telefon nömrəsi (istəyə bağlı)';
	@override String get selectCountry => 'Ölkə seçin';
	@override String get searchCountry => 'Ölkə və ya kod axtar…';
	@override String get noCountriesFound => 'Ölkə tapılmadı';
}

// Path: splash
class _Translations$splash$az extends Translations$splash$en {
	_Translations$splash$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Sağlamlığınız, sadələşdirilmiş';
}

// Path: agenda
class _Translations$agenda$az extends Translations$agenda$en {
	_Translations$agenda$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cədvəl';
	@override String get today => 'Bu gün';
	@override String get empty => 'Görüş yoxdur';
	@override String get emptySubtitle => 'Bu gün üçün heç nə planlaşdırılmayıb';
}

// Path: favorites
class _Translations$favorites$az extends Translations$favorites$en {
	_Translations$favorites$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sevimlilər';
	@override String get empty => 'Hələ sevimli yoxdur';
	@override String get emptySubtitle => 'Həkimi yadda saxlamaq üçün ürək işarəsinə toxunun';
	@override String get add => 'Sevimlilərə əlavə et';
	@override String get remove => 'Sevimlilərdən sil';
}

// Path: doctorSearch.spec
class _Translations$doctorSearch$spec$az extends Translations$doctorSearch$spec$en {
	_Translations$doctorSearch$spec$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get general => 'Ümumi';
	@override String get cardiology => 'Kardiologiya';
	@override String get dermatology => 'Dermatologiya';
	@override String get neurology => 'Nevrologiya';
	@override String get orthopedics => 'Ortopediya';
	@override String get pediatrics => 'Pediatriya';
	@override String get psychiatry => 'Psixiatriya';
	@override String get gynecology => 'Ginekologiya';
	@override String get urology => 'Urologiya';
	@override String get ophthalmology => 'Oftalmologiya';
	@override String get ent => 'LOR';
}

// Path: workingHours.days
class _Translations$workingHours$days$az extends Translations$workingHours$days$en {
	_Translations$workingHours$days$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get monday => 'Bazar ertəsi';
	@override String get tuesday => 'Çərşənbə axşamı';
	@override String get wednesday => 'Çərşənbə';
	@override String get thursday => 'Cümə axşamı';
	@override String get friday => 'Cümə';
	@override String get saturday => 'Şənbə';
	@override String get sunday => 'Bazar';
}

/// The flat map containing all translations for locale <az>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAz {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'Medalize',
			'common.cancel' => 'Ləğv et',
			'common.logout' => 'Çıxış',
			'common.doctor' => 'Həkim',
			'common.patient' => 'Pasiyent',
			'common.save' => 'Yadda saxla',
			'common.edit' => 'Redaktə et',
			'common.retry' => 'Yenidən cəhd et',
			'common.back' => 'Geri',
			'common.ok' => 'OK',
			'common.delete' => 'Sil',
			'common.keep' => 'Saxla',
			'common.confirm' => 'Təsdiqlə',
			'common.decline' => 'İmtina et',
			'common.primary' => 'Əsas',
			'common.somethingWrong' => 'Nə isə səhv getdi',
			'common.seeAll' => 'Hamısına bax',
			'common.signOut' => 'Çıxış',
			'common.search' => 'Axtar',
			'common.tryAgain' => 'Zəhmət olmasa yenidən cəhd edin',
			'common.required' => 'Tələb olunur',
			'auth.login' => 'Daxil ol',
			'auth.register' => 'Hesab yarat',
			'auth.signIn' => 'Daxil ol',
			'auth.signUp' => 'Qeydiyyatdan keç',
			'auth.email' => 'E-poçt',
			'auth.password' => 'Şifrə',
			'auth.confirmPassword' => 'Şifrəni təsdiqlə',
			'auth.firstName' => 'Ad',
			'auth.lastName' => 'Soyad',
			'auth.rememberMe' => 'Məni xatırla',
			'auth.forgotPassword' => 'Şifrəni unutmusunuz?',
			'auth.sendResetLink' => 'Bərpa kodu göndər',
			'auth.noAccount' => 'Hesabınız yoxdur?',
			'auth.haveAccount' => 'Artıq hesabınız var?',
			'auth.welcomeBack' => 'Yenidən xoş gəldiniz',
			'auth.signInToContinue' => 'Davam etmək üçün hesabınıza daxil olun',
			'auth.createYourAccount' => 'Hesabınızı yaradın',
			'auth.joinMedalize' => 'Bu gün Medalize-ə qoşulun',
			'auth.iAmA' => 'Mən',
			'auth.emailHint' => 'you@example.com',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => 'Girişə qayıt',
			'auth.verificationCode' => 'Təsdiq kodu',
			'forgotPassword.title' => 'Şifrəni unutmusunuz?',
			'forgotPassword.subtitle' => 'E-poçtunuzu daxil edin, sizə 6 rəqəmli bərpa kodu göndərək',
			'resetPassword.title' => 'Şifrəni bərpa et',
			'resetPassword.subtitle' => 'E-poçtunuza göndərilən kodu daxil edin və yeni şifrə seçin',
			'resetPassword.button' => 'Şifrəni bərpa et',
			'resetPassword.success' => 'Şifrə uğurla bərpa edildi. Zəhmət olmasa daxil olun.',
			'validation.emailRequired' => 'E-poçt tələb olunur',
			'validation.emailInvalid' => 'Düzgün e-poçt ünvanı daxil edin',
			'validation.passwordRequired' => 'Şifrə tələb olunur',
			'validation.passwordTooShort' => 'Ən azı 8 simvol tələb olunur',
			'validation.passwordNeedsLetter' => 'Ən azı bir hərf əlavə edin',
			'validation.passwordNeedsDigit' => 'Ən azı bir rəqəm əlavə edin',
			'validation.passwordMismatch' => 'Şifrələr uyğun gəlmir',
			'validation.passwordConfirmRequired' => 'Zəhmət olmasa şifrəni təsdiqləyin',
			'validation.nameMinLength' => 'Ən azı 2 simvol olmalıdır',
			'validation.roleRequired' => 'Zəhmət olmasa rol seçin',
			'validation.phoneRequired' => 'Telefon nömrəsi tələb olunur',
			'validation.phoneTooShort' => 'Nömrə çox qısadır',
			'validation.phoneTooLong' => 'Nömrə çox uzundur',
			'validation.fieldRequired' => ({required Object field}) => '${field} tələb olunur',
			'validation.fieldInvalid' => ({required Object field}) => '${field} yanlış simvollar ehtiva edir',
			'errors.network' => 'Şəbəkə xətası. Bağlantınızı yoxlayın.',
			'errors.rateLimit' => 'Çox cəhd edildi. Zəhmət olmasa gözləyib yenidən cəhd edin.',
			'errors.rateLimitWithSeconds' => ({required Object seconds}) => 'Çox cəhd edildi. ${seconds} saniyə sonra yenidən cəhd edin.',
			'errors.invalidCredentials' => 'Yanlış e-poçt və ya şifrə',
			'errors.sessionExpired' => 'Sessiyanın vaxtı bitdi. Zəhmət olmasa yenidən daxil olun.',
			'errors.authError' => 'Autentifikasiya xətası. Zəhmət olmasa yenidən daxil olun.',
			'errors.sessionRevoked' => 'Sessiya ləğv edildi. Zəhmət olmasa yenidən daxil olun.',
			'errors.permissionDenied' => 'Bunu etməyə icazəniz yoxdur.',
			'errors.validationError' => 'Doğrulama xətası',
			'errors.serverError' => ({required Object code}) => 'Server xətası (${code}). Zəhmət olmasa yenidən cəhd edin.',
			'settings.title' => 'Parametrlər',
			'settings.account' => 'Hesab',
			'settings.profile' => 'Profil',
			'settings.notifications' => 'Bildirişlər',
			'settings.appearance' => 'Görünüş',
			'settings.themeSystem' => 'Sistem',
			'settings.themeLight' => 'İşıqlı',
			'settings.themeDark' => 'Qaranlıq',
			'settings.language' => 'Dil',
			'settings.languageSystem' => 'Sistem default',
			'settings.logoutTitle' => 'Çıxış',
			'settings.logoutConfirm' => 'Çıxmaq istədiyinizə əminsiniz?',
			'settings.version' => 'Medalize v1.0.0',
			'status.confirmed' => 'Təsdiqləndi',
			'status.pending' => 'Gözləyir',
			'status.cancelled' => 'Ləğv edildi',
			'status.declined' => 'Rədd edildi',
			'status.requiresRescheduling' => 'Yenidən planlaşdırma tələb edir',
			'status.completed' => 'Tamamlandı',
			'status.noShow' => 'Gəlmədi',
			'home.helloDoctor' => ({required Object name}) => 'Salam, Dr. ${name}!',
			'home.helloPatient' => ({required Object name}) => 'Salam, ${name}!',
			'home.doctorSubtitle' => 'Cədvəlinizi və\ngörüşlərinizi idarə edin.',
			'home.patientSubtitle' => 'Həkim tapın və\ngörüş təyin edin.',
			'home.pendingRequests' => 'Gözləyən sorğular',
			'home.upcoming' => 'Yaxınlaşan',
			'home.findDoctor' => 'Həkim tap',
			'home.myAppointments' => 'Görüşlərim',
			'home.appointments' => 'Görüşlər',
			'home.workplaces' => 'İş yerləri',
			'home.blockTime' => 'Vaxtı blokla',
			'home.profile' => 'Profil',
			'home.allCaughtUp' => 'Hər şey qaydasındadır',
			'home.noPendingRequests' => 'Gözləyən görüş sorğusu yoxdur',
			'home.couldNotLoadAppointments' => 'Görüşlər yüklənə bilmədi',
			'home.noUpcoming' => 'Yaxınlaşan görüş yoxdur',
			'home.bookFirst' => 'Həkimlə ilk görüşünüzü təyin edin',
			'home.findADoctor' => 'Həkim tap',
			'home.myWaitlist' => 'Gözləmə siyahım',
			'home.leaveWaitlist' => 'Çıx',
			'home.statsThisMonth' => 'Bu ay',
			'home.statsPatients' => 'Pasiyentlər',
			'home.statsAcceptRate' => 'Qəbul faizi',
			'home.statsPending' => 'Gözlənilir',
			'home.schedule' => 'Cədvəl',
			'appointments.title' => 'Görüşlər',
			'appointments.myTitle' => 'Görüşlərim',
			'appointments.tabPending' => 'Gözləyən',
			'appointments.tabAll' => 'Hamısı',
			'appointments.tabUpcoming' => 'Yaxınlaşan',
			'appointments.tabPast' => 'Keçmiş',
			'appointments.noPendingRequests' => 'Gözləyən sorğu yoxdur',
			'appointments.newRequestsAppear' => 'Yeni görüş sorğuları burada görünəcək',
			'appointments.noAppointments' => 'Görüş yoxdur',
			'appointments.appointmentsAppear' => 'Görüşləriniz burada görünəcək',
			'appointments.noUpcoming' => 'Yaxınlaşan görüş yoxdur',
			'appointments.bookFirst' => 'Həkimlə ilk görüşünüzü təyin edin',
			'appointments.noPast' => 'Keçmiş görüş yoxdur',
			'appointments.pastAppear' => 'Tamamlanmış və ləğv edilmiş görüşlər burada görünür',
			'appointments.couldNotLoad' => 'Görüşlər yüklənə bilmədi',
			'appointments.detailTitle' => 'Görüş',
			'appointments.patient' => 'Pasiyent',
			'appointments.doctor' => 'Həkim',
			'appointments.workplace' => 'İş yeri',
			'appointments.dateTime' => 'Tarix və vaxt',
			'appointments.reason' => 'Səbəb',
			'appointments.doctorNotes' => 'Həkim qeydləri',
			'appointments.cancelTitle' => 'Görüşü ləğv et',
			'appointments.cancelConfirm' => 'Bu görüşü ləğv etmək istədiyinizə əminsiniz?',
			'appointments.cancelAction' => 'Görüşü ləğv et',
			'appointments.bookedTitle' => 'Təyin edildi!',
			'appointments.bookedMessage' => 'Görüş sorğunuz göndərildi.',
			'appointments.reschedule' => 'Yenidən planlaşdır',
			'appointments.rescheduleTitle' => 'Görüşü yenidən planlaşdır',
			'appointments.reviewTitle' => 'Rəy yaz',
			'appointments.reviewRating' => 'Qiymət',
			'appointments.reviewComment' => 'Şərh (istəyə bağlı)',
			'appointments.reviewSubmit' => 'Göndər',
			'appointments.markCompleted' => 'Tamamlandı kimi işarələ',
			'appointments.rescheduledSuccess' => 'Görüş uğurla yenidən planlaşdırıldı.',
			'appointments.reviewSubmitted' => 'Rəy göndərildi. Təşəkkür edirik!',
			'appointments.requestReschedule' => 'Vaxtın dəyişdirilməsini istə',
			'appointments.requestRescheduleTitle' => 'Vaxtın dəyişdirilməsi',
			'appointments.requestRescheduleConfirm' => 'Pasiyentdən yeni vaxt seçməsini istəyirsiniz? Görüş “vaxtın dəyişdirilməsi tələb olunur” kimi işarələnəcək.',
			'appointments.requestRescheduleSuccess' => 'Vaxtın dəyişdirilməsi istənildi. Pasiyentə bildiriş göndəriləcək.',
			'appointments.rescheduleNeededHint' => 'Həkim sizdən yeni vaxt seçməyinizi xahiş etdi.',
			'appointments.markNoShow' => 'Gəlmədi kimi qeyd et',
			'appointments.markNoShowTitle' => 'Gəlmədi kimi qeyd et',
			'appointments.markNoShowConfirm' => 'Bu görüşü “gəlmədi” kimi qeyd edək? Bu, pasiyentin gəlmədiyini qeyd edir.',
			'booking.bookWith' => ({required Object name}) => 'Təyin et — ${name}',
			'booking.selectWorkplace' => 'İş yerini seçin',
			'booking.pickDate' => 'Tarix seçin',
			'booking.slotsAppear' => 'Mövcud vaxt aralıqları burada görünəcək',
			'booking.couldNotLoadSlots' => 'Vaxt aralıqları yüklənə bilmədi',
			'booking.noAvailableSlots' => 'Mövcud vaxt yoxdur',
			'booking.noOpenSlots' => 'Bu tarix üçün boş vaxt yoxdur. Başqa gün seçin.',
			'booking.confirmTitle' => 'Təyinatı təsdiqlə',
			'booking.reasonForVisit' => 'Ziyarət səbəbi (istəyə bağlı)',
			'booking.confirmButton' => 'Təyinatı təsdiqlə',
			'booking.doctorLabel' => 'Həkim',
			'booking.workplaceLabel' => 'İş yeri',
			'booking.addressLabel' => 'Ünvan',
			'booking.startLabel' => 'Başlanğıc',
			'booking.endLabel' => 'Son',
			'booking.tryDifferentDate' => 'Başqa tarix seçin',
			'doctorSearch.title' => 'Həkim tap',
			'doctorSearch.searchByName' => 'Ada görə axtar...',
			'doctorSearch.city' => 'Şəhər',
			'doctorSearch.search' => 'Axtar',
			'doctorSearch.noDoctorsFound' => 'Həkim tapılmadı',
			'doctorSearch.adjustSearch' => 'Axtarış və ya filtrləri dəyişməyə cəhd edin',
			'doctorSearch.couldNotLoadDoctors' => 'Həkimlər yüklənə bilmədi',
			'doctorSearch.spec.general' => 'Ümumi',
			'doctorSearch.spec.cardiology' => 'Kardiologiya',
			'doctorSearch.spec.dermatology' => 'Dermatologiya',
			'doctorSearch.spec.neurology' => 'Nevrologiya',
			'doctorSearch.spec.orthopedics' => 'Ortopediya',
			'doctorSearch.spec.pediatrics' => 'Pediatriya',
			'doctorSearch.spec.psychiatry' => 'Psixiatriya',
			'doctorSearch.spec.gynecology' => 'Ginekologiya',
			'doctorSearch.spec.urology' => 'Urologiya',
			'doctorSearch.spec.ophthalmology' => 'Oftalmologiya',
			'doctorSearch.spec.ent' => 'LOR',
			'doctorSearch.noAvailability' => 'Vaxt yoxdur',
			'doctorSearch.availableToday' => 'Bugün müsaittir',
			'doctorSearch.availableTomorrow' => 'Sabah müsaittir',
			'doctorSearch.availableOn' => ({required Object date}) => '${date} müsaittir',
			'doctorSearch.sortBy' => 'Sırala',
			'doctorSearch.sortDefault' => 'Uyğunluq',
			'doctorSearch.sortRating' => 'Ən yüksək reytinq',
			'doctorSearch.sortPriceLow' => 'Ən aşağı qiymət',
			'doctorSearch.sortName' => 'Ad (A–Z)',
			'doctorDetail.profileTitle' => 'Həkim profili',
			'doctorDetail.couldNotLoadProfile' => 'Profil yüklənə bilmədi',
			'doctorDetail.about' => 'Haqqında',
			'doctorDetail.workplaces' => 'İş yerləri',
			'doctorDetail.minPerSlot' => ({required Object min}) => 'hər aralıq ${min} dəq',
			'doctorDetail.bookAppointment' => 'Görüş təyin et',
			'doctorDetail.consultationFee' => 'Konsultasiya haqqı',
			'doctorDetail.reviews' => 'Rəylər',
			'profile.title' => 'Profil',
			'profile.changePassword' => 'Şifrəni dəyiş',
			'profile.currentPassword' => 'Cari şifrə',
			'profile.newPassword' => 'Yeni şifrə',
			'profile.confirmNewPassword' => 'Yeni şifrəni təsdiqlə',
			'profile.firstName' => 'Ad',
			'profile.lastName' => 'Soyad',
			'profile.phone' => 'Telefon',
			'profile.failedToSave' => 'Profil yadda saxlanıla bilmədi.',
			'profile.professionalInfo' => 'Peşəkar məlumat',
			'profile.bio' => 'Bioqrafiya',
			'profile.bioHint' => 'Təcrübənizin qısa təsviri',
			'profile.consultationFee' => 'Konsultasiya haqqı',
			'profile.medicalInfo' => 'Tibbi məlumat',
			'profile.allergies' => 'Allergiyalar',
			'profile.allergiesHint' => 'məs. Penisilin, fıstıq',
			'profile.chronicConditions' => 'Xroniki xəstəliklər',
			'profile.chronicConditionsHint' => 'məs. Diabet, hipertansiyon',
			'profile.medications' => 'Cari dərmanlar',
			'profile.medicationsHint' => 'məs. Metformin 500mq',
			'profile.appointmentLength' => 'Görüşün müddəti',
			'notifications.title' => 'Bildirişlər',
			'notifications.noNotifications' => 'Bildiriş yoxdur',
			'notifications.allCaughtUp' => 'Hər şey qaydasındadır',
			'notifications.couldNotLoad' => 'Bildirişlər yüklənə bilmədi',
			'notifications.markAllRead' => 'Hamısını oxunmuş işarələ',
			'workplaces.title' => 'İş yerlərim',
			'workplaces.noWorkplacesYet' => 'Hələ iş yeri yoxdur',
			'workplaces.tapToAdd' => 'İlk iş yerinizi əlavə etmək üçün + düyməsinə toxunun',
			'workplaces.couldNotLoad' => 'İş yerləri yüklənə bilmədi',
			'workplaces.deleteTitle' => 'İş yerini sil',
			'workplaces.deleteConfirm' => ({required Object name}) => '"${name}" silinsin?',
			'workplaces.cannotDelete' => 'İş yeri silinə bilmir',
			'workplaces.workingHours' => 'İş saatları',
			'workplaces.setAsPrimary' => 'Əsas kimi təyin et',
			'addWorkplace.addTitle' => 'İş yeri əlavə et',
			'addWorkplace.editTitle' => 'İş yerini redaktə et',
			'addWorkplace.name' => 'Ad',
			'addWorkplace.address' => 'Ünvan',
			'addWorkplace.city' => 'Şəhər',
			'addWorkplace.type' => 'Növ',
			'addWorkplace.clinic' => 'Klinika',
			'addWorkplace.hospital' => 'Xəstəxana',
			'addWorkplace.privatePractice' => 'Şəxsi praktika',
			'addWorkplace.failedToSave' => 'İş yeri yadda saxlanıla bilmədi.',
			'addWorkplace.addButton' => 'İş yeri əlavə et',
			'addWorkplace.saveChanges' => 'Dəyişiklikləri yadda saxla',
			'workingHours.title' => 'İş saatları',
			'workingHours.saved' => 'İş saatları yadda saxlanıldı',
			'workingHours.failedToSave' => 'İş saatları yadda saxlanıla bilmədi',
			'workingHours.days.monday' => 'Bazar ertəsi',
			'workingHours.days.tuesday' => 'Çərşənbə axşamı',
			'workingHours.days.wednesday' => 'Çərşənbə',
			'workingHours.days.thursday' => 'Cümə axşamı',
			'workingHours.days.friday' => 'Cümə',
			'workingHours.days.saturday' => 'Şənbə',
			'workingHours.days.sunday' => 'Bazar',
			'blockTime.title' => 'Vaxtı blokla',
			'blockTime.dateRange' => 'Tarix aralığı',
			'blockTime.tapToSelect' => 'Tarixləri seçmək üçün toxunun',
			'blockTime.reason' => 'Səbəb (istəyə bağlı)',
			'blockTime.notifyPatients' => 'Təsirlənən pasiyentlərə bildir',
			'blockTime.notifyDesc' => 'Bu dövrdə görüşü olan pasiyentlərə bildiriş göndər',
			'blockTime.selectDateRange' => 'Zəhmət olmasa tarix aralığı seçin.',
			'blockTime.failedToBlock' => 'Vaxt bloklana bilmədi. Zəhmət olmasa yenidən cəhd edin.',
			'blockTime.blockButton' => 'Dövrü blokla',
			'onboarding.title' => 'Profilinizi tamamlayın',
			'onboarding.professionalInfo' => 'Peşəkar məlumat',
			'onboarding.tellPatients' => 'Pasiyentlərə praktikanız haqqında məlumat verin.',
			'onboarding.specialization' => 'İxtisas',
			'onboarding.selectSpecialization' => 'İxtisasınızı seçin',
			'onboarding.couldNotLoadSpecs' => 'İxtisaslar yüklənə bilmədi. Geri çəkin və yenidən cəhd edin.',
			'onboarding.licenseNumber' => 'Lisenziya nömrəsi',
			'onboarding.licenseHint' => 'məs. AZ-123456',
			'onboarding.bio' => 'Bioqrafiya (istəyə bağlı)',
			'onboarding.bioHint' => 'Pasiyentlərin profilinizdə görəcəyi qısa təqdimat.',
			'onboarding.appointmentLength' => 'Görüş müddəti',
			'onboarding.slotQuestion' => 'Bir görüş aralığı nə qədərdir?',
			'onboarding.changeLater' => 'Bunu sonradan profilinizdən dəyişə bilərsiniz.',
			'onboarding.minutes' => ({required Object min}) => '${min} dəq',
			'onboarding.verificationDoc' => 'Təsdiq sənədi',
			'onboarding.uploadDiploma' => 'Tibbi diplomunuzu və ya lisenziyanızı yükləyin. Hesabınız təsdiqlənməzdən əvvəl admin onu yoxlayır.',
			'onboarding.tapToChoose' => 'Fayl seçmək üçün toxunun',
			'onboarding.tapToReplace' => 'Dəyişmək üçün toxunun',
			'onboarding.anyFileType' => 'İstənilən fayl növü, 10 MB-a qədər',
			'onboarding.selectSpecError' => 'Zəhmət olmasa ixtisasınızı seçin.',
			'onboarding.licenseError' => 'Zəhmət olmasa lisenziya nömrənizi daxil edin.',
			'onboarding.diplomaError' => 'Zəhmət olmasa diplomunuzu əlavə edin.',
			'onboarding.checkDetails' => 'Zəhmət olmasa məlumatlarınızı yoxlayıb yenidən cəhd edin.',
			'onboarding.continueButton' => 'Davam et',
			'onboarding.finish' => 'Bitir',
			'pendingVerification.title' => 'Təsdiq gözlənilir',
			'pendingVerification.message' => 'Hesabınız nəzərdən keçirilir. Təsdiqləndikdən sonra sizə bildiriş göndərəcəyik.',
			'phoneField.label' => 'Telefon nömrəsi',
			'phoneField.labelOptional' => 'Telefon nömrəsi (istəyə bağlı)',
			'phoneField.selectCountry' => 'Ölkə seçin',
			'phoneField.searchCountry' => 'Ölkə və ya kod axtar…',
			'phoneField.noCountriesFound' => 'Ölkə tapılmadı',
			'splash.tagline' => 'Sağlamlığınız, sadələşdirilmiş',
			'agenda.title' => 'Cədvəl',
			'agenda.today' => 'Bu gün',
			'agenda.empty' => 'Görüş yoxdur',
			'agenda.emptySubtitle' => 'Bu gün üçün heç nə planlaşdırılmayıb',
			'favorites.title' => 'Sevimlilər',
			'favorites.empty' => 'Hələ sevimli yoxdur',
			'favorites.emptySubtitle' => 'Həkimi yadda saxlamaq üçün ürək işarəsinə toxunun',
			'favorites.add' => 'Sevimlilərə əlavə et',
			'favorites.remove' => 'Sevimlilərdən sil',
			_ => null,
		};
	}
}
