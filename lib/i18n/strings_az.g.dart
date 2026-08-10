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
	@override String get appName => 'Medoro';
	@override late final _Translations$common$az common = _Translations$common$az._(_root);
	@override late final _Translations$auth$az auth = _Translations$auth$az._(_root);
	@override late final _Translations$forgotPassword$az forgotPassword = _Translations$forgotPassword$az._(_root);
	@override late final _Translations$resetPassword$az resetPassword = _Translations$resetPassword$az._(_root);
	@override late final _Translations$verifyEmail$az verifyEmail = _Translations$verifyEmail$az._(_root);
	@override late final _Translations$validation$az validation = _Translations$validation$az._(_root);
	@override late final _Translations$errors$az errors = _Translations$errors$az._(_root);
	@override late final _Translations$settings$az settings = _Translations$settings$az._(_root);
	@override late final _Translations$security$az security = _Translations$security$az._(_root);
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
	@override late final _Translations$locations$az locations = _Translations$locations$az._(_root);
	@override late final _Translations$splash$az splash = _Translations$splash$az._(_root);
	@override late final _Translations$appIntro$az appIntro = _Translations$appIntro$az._(_root);
	@override late final _Translations$agenda$az agenda = _Translations$agenda$az._(_root);
	@override late final _Translations$favorites$az favorites = _Translations$favorites$az._(_root);
	@override late final _Translations$assistant$az assistant = _Translations$assistant$az._(_root);
	@override late final _Translations$messaging$az messaging = _Translations$messaging$az._(_root);
	@override late final _Translations$legal$az legal = _Translations$legal$az._(_root);
	@override late final _Translations$medications$az medications = _Translations$medications$az._(_root);
	@override late final _Translations$prescriptions$az prescriptions = _Translations$prescriptions$az._(_root);
	@override late final _Translations$records$az records = _Translations$records$az._(_root);
	@override late final _Translations$payments$az payments = _Translations$payments$az._(_root);
	@override late final _Translations$family$az family = _Translations$family$az._(_root);
	@override late final _Translations$subscription$az subscription = _Translations$subscription$az._(_root);
	@override late final _Translations$hospitalPicker$az hospitalPicker = _Translations$hospitalPicker$az._(_root);
	@override late final _Translations$hospitalRegistration$az hospitalRegistration = _Translations$hospitalRegistration$az._(_root);
	@override late final _Translations$hospitalHome$az hospitalHome = _Translations$hospitalHome$az._(_root);
	@override late final _Translations$hospitalDoctors$az hospitalDoctors = _Translations$hospitalDoctors$az._(_root);
	@override late final _Translations$hospitalInvite$az hospitalInvite = _Translations$hospitalInvite$az._(_root);
	@override late final _Translations$hospitalAppointments$az hospitalAppointments = _Translations$hospitalAppointments$az._(_root);
	@override late final _Translations$hospitalProfile$az hospitalProfile = _Translations$hospitalProfile$az._(_root);
	@override late final _Translations$hospitalDoctorHours$az hospitalDoctorHours = _Translations$hospitalDoctorHours$az._(_root);
	@override late final _Translations$doctorHospitals$az doctorHospitals = _Translations$doctorHospitals$az._(_root);
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
	@override String get noRatings => 'Hələ qiymət yoxdur';
	@override String get hospital => 'Xəstəxana';
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
	@override String get joinMedalize => 'Bu gün Medoro-ya qoşulun';
	@override String get iAmA => 'Mən';
	@override String get emailHint => 'you@example.com';
	@override String get passwordHint => '••••••••';
	@override String get backToSignIn => 'Girişə qayıt';
	@override String get verificationCode => 'Təsdiq kodu';
	@override String get continueWithGoogle => 'Google ilə davam et';
	@override String get continueWithApple => 'Apple ilə davam et';
	@override String get orDivider => 'və ya';
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

// Path: verifyEmail
class _Translations$verifyEmail$az extends Translations$verifyEmail$en {
	_Translations$verifyEmail$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Email ünvanınızı təsdiqləyin';
	@override String subtitle({required Object email}) => '${email} ünvanına 6 rəqəmli kod göndərdik';
	@override String get button => 'Təsdiqlə';
	@override String get resend => 'Kodu yenidən göndər';
	@override String get resendSent => 'Yeni kod göndərildi.';
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
	@override String get socialLoginFailed => 'Giriş uğursuz oldu. Yenidən cəhd edin və ya e-poçt və şifrənizi istifadə edin.';
	@override String get conflict => 'Bu əməliyyat hazırda tamamlana bilmir.';
	@override String get onboardingIncomplete => 'Qeydiyyatı tamamlamaq üçün bütün tələb olunan sahələri doldurun.';
	@override String get planLimitReached => 'Planınızın limitinə çatmısınız. Daha çoxu üçün planı yüksəldin.';
	@override String get chatUnavailable => 'Bu həkim cari planında çat təklif etmir.';
	@override String get emailNotVerified => 'Daxil olmadan əvvəl email ünvanınızı təsdiqləyin.';
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
	@override String get version => 'Medoro v1.0.0';
	@override String get legal => 'Məxfilik və Şərtlər';
}

// Path: security
class _Translations$security$az extends Translations$security$en {
	_Translations$security$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Təhlükəsizlik';
	@override String get biometricLogin => 'Biometrik Giriş';
	@override String get biometricLoginSubtitle => 'Tətbiqin kilidini açmaq üçün Face ID / Touch ID istifadə edin';
	@override String get biometricPrompt => 'Medoro-ya daxil olmaq üçün doğrulayın';
	@override String get biometricUnavailable => 'Bu cihazda biometrik autentifikasiya mövcud deyil';
	@override String get biometricEnableFailed => 'Biometrik məlumatlarınız təsdiqlənə bilmədi. Yenidən cəhd edin.';
	@override String get activeSessions => 'Aktiv Sessiyalar';
	@override String get activeSessionsSubtitle => 'Hesabınıza hazırda daxil olan cihazlar';
	@override String get thisDevice => 'Bu cihaz';
	@override String lastActive({required Object date}) => 'Son fəaliyyət: ${date}';
	@override String get revoke => 'Ləğv et';
	@override String get revokeConfirmTitle => 'Cihaz ləğv edilsin?';
	@override String revokeConfirmMessage({required Object name}) => '${name} hesabdan çıxarılacaq. Hesab məlumatları ilə yenidən daxil ola bilər.';
	@override String get revokeCurrentConfirmMessage => 'Bu sizin cari cihazınızdır — onu ləğv etsəniz dərhal çıxış edəcəksiniz.';
	@override String get revokeFailed => 'Bu cihaz ləğv edilə bilmədi. Yenidən cəhd edin.';
	@override String get signOutAllDevices => 'Bütün cihazlardan çıx';
	@override String get signOutAllConfirmTitle => 'Hər yerdən çıxılsın?';
	@override String get signOutAllConfirmMessage => 'Bu daxil olmaqla bütün cihazlardan çıxacaqsınız.';
	@override String get signOutAllFailed => 'Bütün cihazlardan çıxış uğursuz oldu. Yenidən cəhd edin.';
	@override String get noDevices => 'Aktiv sessiya tapılmadı';
	@override String get loadFailed => 'Aktiv sessiyalarınız yüklənə bilmədi';
	@override String get changeEmail => 'Email-i dəyiş';
	@override String get changeEmailSubtitle => 'Yeni email ünvanınıza təsdiq kodu göndərəcəyik. Təsdiqdən sonra yeni email ilə daxil olacaqsınız.';
	@override String get newEmailLabel => 'Yeni email';
	@override String get sendCode => 'Kod göndər';
	@override String codeSentTo({required Object email}) => '${email} ünvanına göndərdiyimiz 6 rəqəmli kodu daxil edin';
	@override String get confirmNewEmail => 'Yeni email-i təsdiqlə';
	@override String get changeEmailSuccess => 'Email dəyişdirildi. Yeni email ilə yenidən daxil olun.';
	@override String get dangerZone => 'Təhlükəli zona';
	@override String get deactivateAccount => 'Hesabı deaktiv et';
	@override String get deactivateAccountSubtitle => 'Məlumatları silmədən hesabı deaktiv edin';
	@override String get deactivateConfirmTitle => 'Hesab deaktiv edilsin?';
	@override String get deactivateConfirmMessage => 'Hesabınız deaktiv ediləcək və bütün cihazlarda çıxış ediləcək. Məlumatlarınız silinmir. Bərpa üçün dəstək xidmətinə müraciət edin.';
	@override String get deactivate => 'Deaktiv et';
	@override String get deactivateSuccess => 'Hesabınız deaktiv edildi.';
	@override String get deleteAccount => 'Hesabı Həmişəlik Sil';
	@override String get deleteAccountSubtitle => 'Məlumatlarınızı silin. Bu geri qaytarıla bilməz.';
	@override String get deleteConfirmTitle => 'Hesabınız həmişəlik silinsin?';
	@override String get deleteConfirmWarning => 'Bu əməliyyat geri qaytarıla bilməz.';
	@override String get deleteConfirmMessage => 'Profiliniz, tibbi qeydləriniz, resepetləriniz və mesajlarınız həmişəlik silinəcək. Gələcək görüşləriniz ləğv ediləcək və uyğun olduqda geri ödəniləcək. Ödəniş qeydləri qanun tələb etdiyi kimi mühasibat uçotu məqsədləri üçün anonimləşdirilmiş formada saxlanılır.';
	@override String get deleteAccountSuccess => 'Hesabınız həmişəlik silindi.';
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
	@override String get requiresRescheduling => 'Yenidən planlaşdırılmalıdır';
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
	@override String get aiAssistant => 'AI Köməkçi';
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
	@override String get myWaitlist => 'Gözləmə siyahı';
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
	@override String get cancelledSuccess => 'Görüş ləğv edildi.';
	@override String get cancelledRefunded => 'Görüş ləğv edildi. Ödənişiniz geri qaytarıldı.';
	@override String get cancelledNoRefund => 'Görüş ləğv edildi. Görüş vaxtına çox yaxın olduğu üçün geri ödəmə edilmədi.';
	@override String get bookedTitle => 'Təyin edildi!';
	@override String get bookedMessage => 'Görüş sorğunuz göndərildi.';
	@override String get reschedule => 'Yenidən planla';
	@override String get rescheduleTitle => 'Görüşü yenidən planlaşdır';
	@override String get reviewTitle => 'Rəy yaz';
	@override String get reviewRating => 'Qiymət';
	@override String get reviewComment => 'Şərh (istəyə bağlı)';
	@override String get reviewSubmit => 'Göndər';
	@override String get markCompleted => 'Tamamlandı kimi işarələ';
	@override String get rescheduledSuccess => 'Görüş uğurla yenidən planlaşdırıldı.';
	@override String get reviewSubmitted => 'Rəy göndərildi. Təşəkkür edirik!';
	@override String get yourReview => 'Rəyiniz';
	@override String get editReviewTitle => 'Rəyi redaktə et';
	@override String get reviewUpdated => 'Rəy yeniləndi.';
	@override String get deleteReviewTitle => 'Rəyi sil';
	@override String get deleteReviewConfirm => 'Rəyinizi silmək istədiyinizə əminsiniz?';
	@override String get reviewDeleted => 'Rəy silindi.';
	@override String get requestReschedule => 'Vaxtın dəyişdirilməsini istə';
	@override String get requestRescheduleTitle => 'Vaxtın dəyişdirilməsi';
	@override String get requestRescheduleConfirm => 'Pasiyentdən yeni vaxt seçməsini istəyirsiniz? Görüş “vaxtın dəyişdirilməsi tələb olunur” kimi işarələnəcək.';
	@override String get requestRescheduleSuccess => 'Vaxtın dəyişdirilməsi istənildi. Pasiyentə bildiriş göndəriləcək.';
	@override String get rescheduleNeededHint => 'Həkim sizdən yeni vaxt seçməyinizi xahiş etdi.';
	@override String get markNoShow => 'Gəlmədi qeyd et';
	@override String get markNoShowTitle => 'Gəlmədi kimi qeyd et';
	@override String get markNoShowConfirm => 'Bu görüşü “gəlmədi” kimi qeyd edək? Bu, pasiyentin gəlmədiyini qeyd edir.';
	@override String get disputeNoShow => 'Etiraz et';
	@override String get disputeNoShowTitle => 'Gəlmədi qeydinə etiraz';
	@override String get disputeNoShowHint => 'Niyə bunun səhv qeyd edildiyini düşündüyünüzü bizə bildirin — dəstək komandamız nəzərdən keçirəcək.';
	@override String get disputeNoShowSubmit => 'Göndər';
	@override String get disputeNoShowSubmitted => 'Etirazınız göndərildi. Onu nəzərdən keçirib sizinlə əlaqə saxlayacağıq.';
	@override String get disputeNoShowOpen => 'Etiraz göndərildi — nəzərdən keçirilir';
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
	@override String get loadMore => 'Daha çox göstər';
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
	@override String get sortNearestSlot => 'Ən erkən boş vaxt';
	@override String get sortDistance => 'Mənə ən yaxın';
	@override String get locationDenied => 'Məsafəyə görə sıralamaq üçün məkan icazəsi lazımdır. Parametrlərdə icazə verin və ya şəhər filtrindən istifadə edin.';
	@override String get locationUnavailable => 'Məkanınızı təyin etmək mümkün olmadı. Məkan xidmətlərinin aktiv olduğunu yoxlayın və ya şəhər filtrindən istifadə edin.';
	@override String distanceKm({required Object km}) => '${km} km';
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
	@override String reviewsCount({required Object count}) => '${count} rəy';
	@override String get joinWaitlist => 'Növbəyə yazıl';
	@override String get leaveWaitlist => 'Növbədən çıx';
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
	@override String get cancellationWindow => 'Ləğvetmə müddəti';
	@override String get cancellationWindowHint => 'Pasiyentlərin görüşdən neçə saat əvvələ qədər ləğv/dəyişiklik edə biləcəyi.';
	@override String hoursValue({required Object h}) => '${h} saat';
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
	@override String get settingsTitle => 'Bildiriş parametrləri';
	@override String get pushEnabled => 'Push bildirişlər';
	@override String get pushEnabledSubtitle => 'Qeydiyyatlar və yeniliklər üçün bu cihazda bildirişlər';
	@override String get emailEnabled => 'E-poçt bildirişləri';
	@override String get emailEnabledSubtitle => 'Yeniliklər e-poçt ünvanınıza göndəriləcək';
	@override String get categoriesTitle => 'Push kateqoriyaları';
	@override String get careCategory => 'Görüşlər və qulluq';
	@override String get careCategorySubtitle => 'Bronlar, xatırlatmalar, reseptlər';
	@override String get messagesCategory => 'Mesajlar';
	@override String get messagesCategorySubtitle => 'Yeni çat mesajları';
	@override String get accountCategory => 'Hesab və ödənişlər';
	@override String get accountCategorySubtitle => 'Təsdiqləmə, ödənişlər, abunəlik';
	@override String get quietHoursTitle => 'Sakit saatlar';
	@override String get quietHoursEnabled => 'Sakit saatları aktivləşdir';
	@override String get quietHoursSubtitle => 'Bu vaxt aralığında push bildirişləri dayandırılır';
	@override String get quietHoursStart => 'Başlanğıc';
	@override String get quietHoursEnd => 'Son';
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
	@override String get address => 'Küçə ünvanı';
	@override String get city => 'Şəhər';
	@override String get type => 'Növ';
	@override String get clinic => 'Klinika';
	@override String get hospital => 'Xəstəxana';
	@override String get privatePractice => 'Şəxsi praktika';
	@override String get failedToSave => 'İş yeri yadda saxlanıla bilmədi.';
	@override String get addButton => 'İş yeri əlavə et';
	@override String get saveChanges => 'Dəyişiklikləri yadda saxla';
	@override String get pickOnMap => 'Xəritədə göstər';
	@override String get mapPickerTitle => 'Yerləşməni seçin';
	@override String get useMyLocation => 'Mənim yerimi istifadə et';
	@override String get confirmLocation => 'Yerləşməni təsdiqlə';
	@override String get locationSet => 'Xəritədən yer seçildi ✓';
	@override String get locationPermissionDenied => 'Cari yerinizi istifadə etmək üçün icazə lazımdır. Xəritəni əl ilə də hərəkət etdirə bilərsiniz.';
	@override String get locationUnavailable => 'Yerləşməniz alınmadı. Xəritəni əl ilə də hərəkət etdirə bilərsiniz.';
}

// Path: workingHours
class _Translations$workingHours$az extends Translations$workingHours$en {
	_Translations$workingHours$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'İş saatları';
	@override String get sectionHint => 'Bu ünvanda pasiyentlərin sizi qəbul edə biləcəyi günləri və saatları seçin.';
	@override String get invalidRange => 'Aktiv hər gün üçün bitmə vaxtı başlama vaxtından sonra olmalıdır.';
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
	@override String get checkStatus => 'Statusu yoxla';
	@override String get stillPending => 'Hələ də nəzərdən keçirilir. Təsdiqləndikdən sonra sizə bildiriş göndərəcəyik.';
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

// Path: locations
class _Translations$locations$az extends Translations$locations$en {
	_Translations$locations$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get pickCity => 'Şəhər seçin';
	@override String get searchHint => 'Şəhər və ya region axtar…';
	@override String get noResultsFound => 'Şəhər tapılmadı';
	@override String get couldNotLoad => 'Şəhərlər yüklənmədi. Yenidən cəhd etmək üçün toxunun.';
	@override String get allCities => 'Bütün şəhərlər';
}

// Path: splash
class _Translations$splash$az extends Translations$splash$en {
	_Translations$splash$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Sağlamlığınız, sadələşdirilmiş';
}

// Path: appIntro
class _Translations$appIntro$az extends Translations$appIntro$en {
	_Translations$appIntro$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get page1Title => 'Doğru həkimi tapın';
	@override String get page1Subtitle => 'İxtisas, şəhər və reytinqə görə axtarın — sizə uyğun vaxta yazılın.';
	@override String get page2Title => 'Süni intellekt köməkçisinə sual verin';
	@override String get page2Subtitle => 'Simptomlarınızı təsvir edin və hansı həkimə müraciət etməli olduğunuzu öyrənin.';
	@override String get page3Title => 'Hər şey bir tətbiqdə';
	@override String get page3Subtitle => 'Qəbulları idarə edin, müalicənizi izləyin və tətbiqi öz dilinizdə istifadə edin — təhlükəsiz şəkildə.';
	@override String get skip => 'Keç';
	@override String get next => 'Növbəti';
	@override String get getStarted => 'Başla';
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

// Path: assistant
class _Translations$assistant$az extends Translations$assistant$en {
	_Translations$assistant$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'AI Köməkçi';
	@override String get newChat => 'Yeni söhbət';
	@override String get empty => 'Hələ söhbət yoxdur';
	@override String get emptySubtitle => 'Simptomlarınızı təsvir edin — köməkçi hansı həkimə müraciət edəcəyinizi məsləhət görəcək';
	@override String get couldNotLoad => 'Söhbətləri yükləmək mümkün olmadı';
	@override String get couldNotLoadChat => 'Söhbəti yükləmək mümkün olmadı';
	@override String get newConversation => 'Yeni söhbət';
	@override String get deleteTitle => 'Söhbət silinsin?';
	@override String get deleteConfirm => 'Söhbət və onun bütün mesajları silinəcək.';
	@override String get inputHint => 'Simptomlarınızı təsvir edin…';
	@override String get send => 'Göndər';
	@override String get sendFailed => 'Mesajı göndərmək mümkün olmadı. Yenidən cəhd edin.';
	@override String get typing => 'Köməkçi yazır…';
	@override String get startTitle => 'Necə kömək edə bilərəm?';
	@override String get startSubtitle => 'Başlamaq üçün sizi narahat edəni təsvir edin';
	@override String get book => 'Qəbula yazıl';
	@override String get reportTooltip => 'Cavabdan şikayət et';
	@override String get reportTitle => 'Cavabdan şikayət et';
	@override String get reportHint => 'Səbəb (istəyə bağlı)';
	@override String get reportSubmit => 'Göndər';
	@override String get reportSuccess => 'Təşəkkürlər, şikayət göndərildi.';
	@override String get reportFailed => 'Şikayəti göndərmək mümkün olmadı. Yenidən cəhd edin.';
	@override String get topicsTooltip => 'Mövzular';
	@override String get topicsSheetTitle => 'Mövzu seçin';
}

// Path: messaging
class _Translations$messaging$az extends Translations$messaging$en {
	_Translations$messaging$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mesajlar';
	@override String get sendMessage => 'Mesaj yaz';
	@override String get typeMessage => 'Mesaj yazın…';
	@override String get send => 'Göndər';
	@override String get empty => 'Hələ yazışma yoxdur';
	@override String get emptySubtitle => 'Yazışmalarınız burada görünəcək.';
	@override String get disclaimer => 'Bu təcili yardım xətti deyil. Təcili hallarda təcili yardım xidmətinə zəng edin.';
	@override String get noSharedHistory => 'Həkimə yalnız onunla ortaq qəbul tarixçəniz olduqdan sonra yaza bilərsiniz.';
	@override String get newMessage => 'Yeni mesajınız var';
}

// Path: legal
class _Translations$legal$az extends Translations$legal$en {
	_Translations$legal$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Məxfilik və Şərtlər';
	@override String get controllerNotice => 'Medoro AuxioDev (auxiodev.com) tərəfindən Azərbaycanda yaradılıb və idarə olunur («biz»). Son yenilənmə: iyul 2026.';
	@override String get privacyTitle => 'Məxfilik Siyasəti';
	@override String get privacyIntro => 'Bu sənəd Medoro-nun hansı şəxsi məlumatları, nə üçün topladığını və necə qoruduğunu izah edir. Həkim təyinatlarının bronlanması və idarə olunması qaçılmaz olaraq sağlamlıq məlumatlarınızı əhatə edir — bu, aşağıda ətraflı izah olunur.';
	@override late final _Translations$legal$sections$az sections = _Translations$legal$sections$az._(_root);
	@override String get termsTitle => 'İstifadə Şərtləri';
	@override String get termsIntro => 'Hesab yaratmaqla aşağıdakılarla razılaşırsınız.';
	@override String get termsBody => 'Özünüz haqqında dəqiq məlumat verin. Medoro-dan yalnız həkim tapmaq, təyinat bron etmək və idarə etmək üçün istifadə edin. Giriş məlumatlarınızı məxfi saxlayın. Medoro sizi müstəqil, lisenziyalı tibb mütəxəssisləri ilə əlaqələndirir — biz özümüz tibb müəssisəsi deyilik, simptom yoxlama süni intellekt köməkçisi peşəkar tibbi diaqnoz və ya məsləhəti əvəz etmir. Təcili tibbi vəziyyətdə birbaşa təcili yardım xidmətinə müraciət edin, bu tətbiqə deyil. Bu şərtləri pozan və ya platformadan sui-istifadə edən hesabları dayandıra və ya silə bilərik.';
	@override String get contact => 'Məlumatlarınızla bağlı sualınız var? support@auxiodev.com ünvanına yazın';
	@override String get consentPrefix => 'Mən ';
	@override String get consentPrivacyLink => 'Məxfilik Siyasəti';
	@override String get consentMiddle => ' və ';
	@override String get consentTermsLink => 'İstifadə Şərtləri';
	@override String get consentSuffix => ' ilə tanış oldum, onlarla razıyam və orada təsvir olunduğu kimi sağlamlıq məlumatlarımın işlənməsinə açıq razılıq verirəm.';
	@override String get viewAsPdf => 'PDF kimi bax';
	@override String get pdfDocumentTitle => 'Medoro — Məxfilik Siyasəti və İstifadə Şərtləri';
	@override String get pdfLoadError => 'Sənəd yüklənmədi. İnternet bağlantınızı yoxlayıb yenidən cəhd edin.';
}

// Path: medications
class _Translations$medications$az extends Translations$medications$en {
	_Translations$medications$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dərmanlar';
	@override String get editMedication => 'Dərmanı redaktə et';
	@override String get name => 'Ad';
	@override String get dosage => 'Dozaj';
	@override String get notes => 'Qeydlər';
	@override String get form => 'Forma';
	@override String get formPill => 'Həb';
	@override String get formCapsule => 'Kapsul';
	@override String get formLiquid => 'Maye';
	@override String get formInjection => 'İnyeksiya';
	@override String get formOther => 'Digər';
	@override String get schedule => 'Qəbul cədvəli';
	@override String get times => 'Qəbul vaxtları';
	@override String get addTime => 'Vaxt əlavə et';
	@override String get daysOfWeek => 'Həftənin günləri';
	@override String get everyDay => 'Hər gün';
	@override String get startDate => 'Başlama tarixi';
	@override String get endDate => 'Bitmə tarixi';
	@override String get save => 'Yadda saxla';
	@override String get delete => 'Sil';
	@override String get deleteConfirmTitle => 'Dərmanı sil';
	@override String get deleteConfirmBody => 'Bu dərmanı silmək istədiyinizə əminsiniz? Qəbul tarixçəsi saxlanılacaq.';
	@override String get emptyTitle => 'Hələ dərman yoxdur';
	@override String get emptySubtitle => 'Həkiminizin təyin etdiyi dərmanlar qəbuldan sonra burada görünəcək.';
	@override String get todaysDoses => 'Bu günkü qəbullar';
	@override String get markTaken => 'Qəbul edildi';
	@override String get markSkipped => 'Buraxıldı';
	@override String get statusTaken => 'Qəbul edildi';
	@override String get statusSkipped => 'Buraxıldı';
	@override String get statusPending => 'Gözləyir';
	@override String reminderTitle({required Object name}) => '${name} qəbul etmə vaxtıdır';
	@override String reminderBody({required Object dosage}) => 'Doza: ${dosage}';
	@override String get tabActive => 'Aktiv';
	@override String get tabArchive => 'Arxiv';
	@override String get fromPrescription => 'Resept üzrə';
	@override String get noSchedule => 'Cədvəl təyin edilməyib — xatırlatma vaxtı əlavə etmək üçün toxunun';
	@override String get dayMon => 'B.e';
	@override String get dayTue => 'Ç.a';
	@override String get dayWed => 'Ç';
	@override String get dayThu => 'C.a';
	@override String get dayFri => 'C';
	@override String get daySat => 'Ş';
	@override String get daySun => 'B';
	@override String get updatedSuccess => 'Dərman yeniləndi.';
	@override String get deletedSuccess => 'Dərman silindi.';
	@override String get atLeastOneTime => 'Ən azı bir xatırlatma vaxtı əlavə edin';
}

// Path: prescriptions
class _Translations$prescriptions$az extends Translations$prescriptions$en {
	_Translations$prescriptions$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Reseptlər';
	@override String get writeTitle => 'Resept yaz';
	@override String get addDrug => 'Dərman əlavə et';
	@override String get drugName => 'Dərmanın adı';
	@override String get dosage => 'Dozaj';
	@override String get frequency => 'Qəbul tezliyi';
	@override String get duration => 'Müddət';
	@override String get instructions => 'Təlimatlar';
	@override String get notes => 'Qeydlər';
	@override String get save => 'Yadda saxla';
	@override String get empty => 'Hələ resept yoxdur';
	@override String get emptySubtitle => 'Həkiminizin yazdığı reseptlər burada görünəcək.';
	@override String get viewDetails => 'Ətraflı';
	@override String issuedBy({required Object name}) => 'Dr. ${name} tərəfindən yazılıb';
	@override String issuedOn({required Object date}) => 'Verilmə tarixi: ${date}';
	@override String get applyToMedications => 'Dərmanlarıma əlavə et';
	@override String get applySuccess => 'Dərmanlarınıza əlavə edildi. Xatırlatma vaxtlarını təyin edin.';
	@override String get alreadyApplied => 'Artıq dərmanlarınıza əlavə edilib';
	@override String get noPrescriptionYet => 'Bu qəbul üçün hələ resept yazılmayıb';
	@override String get writePrescription => 'Resept yaz';
	@override String get prescriptionIssued => 'Resept yazıldı.';
	@override String get removeDrug => 'Sil';
	@override String get atLeastOneDrug => 'Ən azı bir dərman əlavə edin';
	@override String get drugNameRequired => 'Dərmanın adını daxil edin';
	@override String get summaryTitle => 'Resept';
	@override String itemsCount({required Object count}) => '${count} dərman';
	@override String get newPrescription => 'Yeni resept';
	@override String get youHavePrescription => 'Bu qəbul üçün resept mövcuddur';
}

// Path: records
class _Translations$records$az extends Translations$records$en {
	_Translations$records$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tibbi sənədlər';
	@override String get upload => 'Sənəd yüklə';
	@override String get recordType => 'Sənəd növü';
	@override String get typeLabResult => 'Analiz nəticəsi';
	@override String get typeImaging => 'Görüntüləmə';
	@override String get typeDocument => 'Sənəd';
	@override String get typeOther => 'Digər';
	@override String get recordTitle => 'Başlıq';
	@override String get recordDate => 'Tarix';
	@override String get notes => 'Qeydlər';
	@override String get chooseFile => 'Fayl seç';
	@override String get changeFile => 'Faylı dəyiş';
	@override String get noFileChosen => 'Fayl seçilməyib';
	@override String get save => 'Yadda saxla';
	@override String get delete => 'Sil';
	@override String get deleteConfirmTitle => 'Sənədi sil';
	@override String get deleteConfirmBody => 'Bu sənədi silmək istədiyinizə əminsiniz? Bu geri qaytarıla bilməz.';
	@override String get empty => 'Hələ tibbi sənəd yoxdur';
	@override String get emptySubtitle => 'Analiz nəticələrini, görüntüləri və digər sənədləri bir yerdə saxlayın.';
	@override String get view => 'Bax';
	@override String get fileRequired => 'Yükləmək üçün fayl seçin';
	@override String get fileTooLarge => 'Fayl həddindən artıq böyükdür (maks. 15 MB)';
	@override String get titleRequired => 'Başlıq tələb olunur';
	@override String get uploadSuccess => 'Sənəd yükləndi.';
	@override String get deletedSuccess => 'Sənəd silindi.';
	@override String get couldNotOpen => 'Fayl açılmadı';
}

// Path: payments
class _Translations$payments$az extends Translations$payments$en {
	_Translations$payments$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ödəniş';
	@override String get amount => 'Məbləğ';
	@override String get payNow => 'İndi ödə';
	@override String get payLater => 'Sonra ödə';
	@override String get statusPending => 'Ödəniş gözlənilir';
	@override String get statusPaid => 'Ödənilib';
	@override String get statusFailed => 'Ödəniş uğursuz oldu';
	@override String get statusCancelled => 'Ləğv edilib';
	@override String get statusRefunded => 'Geri qaytarıldı';
	@override String get statusRefundFailed => 'Geri ödəmə uğursuz oldu';
	@override String get paymentConfirmed => 'Ödəniş təsdiqləndi. Təşəkkür edirik!';
	@override String get openingBrowser => 'Brauzer açılır…';
	@override String get checkStatus => 'Statusu yoxla';
}

// Path: family
class _Translations$family$az extends Translations$family$en {
	_Translations$family$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ailə';
	@override String get myself => 'Özüm';
	@override String get addFamilyMember => 'Ailə üzvü əlavə et';
	@override String get editFamilyMember => 'Ailə üzvünü redaktə et';
	@override String get firstName => 'Ad';
	@override String get lastName => 'Soyad';
	@override String get relationship => 'Qohumluq';
	@override String get relationshipChild => 'Övlad';
	@override String get relationshipSpouse => 'Həyat yoldaşı';
	@override String get relationshipParent => 'Valideyn';
	@override String get relationshipSibling => 'Bacı/qardaş';
	@override String get relationshipOther => 'Digər';
	@override String get dateOfBirth => 'Doğum tarixi';
	@override String get bloodType => 'Qan qrupu';
	@override String get allergies => 'Allergiyalar';
	@override String get chronicConditions => 'Xroniki xəstəliklər';
	@override String get medications => 'Cari dərmanlar';
	@override String get save => 'Yadda saxla';
	@override String get delete => 'Sil';
	@override String get deleteConfirmTitle => 'Ailə üzvünü sil';
	@override String get deleteConfirmBody => 'Bu ailə üzvünü silmək istədiyinizə əminsiniz? Qəbul, dərman və sənəd tarixçəsi saxlanılacaq.';
	@override String get empty => 'Hələ ailə üzvü yoxdur';
	@override String get emptySubtitle => 'Görüşlərini, dərmanlarını və sənədlərini idarə etmək üçün övladınızı, həyat yoldaşınızı və ya digər qohumunuzu əlavə edin.';
	@override String get bookingForQuestion => 'Bu qəbul kim üçündür?';
	@override String bookingForLabel({required Object name}) => 'Qəbul kimin üçündür: ${name}';
	@override String forLabel({required Object name}) => '${name} üçün';
	@override String ageYears({required Object age}) => '${age} yaşında';
	@override String bookedByLabel({required Object name}) => 'Qeyd edən: ${name}';
	@override String get contactEmail => 'Əlaqə e-poçtu';
	@override String get contactEmailHelp => 'Əlavə edildiklərini onlara bildirəcəyik və rədd etmək üçün asan bir yol təqdim edəcəyik.';
	@override String get contactPhoneOptional => 'Əlaqə telefonu (istəyə bağlı)';
	@override String get contactEmailRequiredForAdult => 'Bu ailə üzvünə bildiriş göndərə bilmək üçün e-poçt ünvanı tələb olunur';
	@override String get adultConsentNotice => '18 yaşdan böyük olduqları üçün onlara sizin tərəfinizdən əlavə edildiklərini bildirən e-poçt göndərəcəyik — tətbiqə ehtiyacları yoxdur və istənilən vaxt bu əlaqəni kəsə bilərlər.';
	@override String get noticeAlreadySent => 'Əlavə edildikləri barədə onlara bildiriş göndərdik. İstənilən vaxt bu əlaqəni kəsə bilərlər.';
	@override String get noticePendingBadge => 'Bildiriş göndərildi';
}

// Path: subscription
class _Translations$subscription$az extends Translations$subscription$en {
	_Translations$subscription$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Abunəlik';
	@override String get planNameBasic => 'Başlanğıc';
	@override String get planNamePro => 'Peşəkar';
	@override String get couldNotLoad => 'Abunəlik məlumatı yüklənmədi.';
	@override String get nowActive => 'Abunəliyiniz aktivləşdirildi!';
	@override String get unavailable => 'Abunəlik hazırda əlçatan deyil. Zəhmət olmasa sonra yenidən cəhd edin.';
	@override String trialDaysLeft({required Object days}) => 'Pulsuz sınaq — ${days} gün qalıb';
	@override String graceDaysLeft({required Object days}) => 'Güzəşt müddəti — yeniləmək üçün ${days} gün qalıb';
	@override String get expiredNotice => 'Abunəliyinizin müddəti bitib. Pasiyentlərə yenidən görünmək üçün abunə olun.';
	@override String get activeNotice => 'Abunəliyiniz aktivdir.';
	@override String get choosePlan => 'Başlamaq üçün plan seçin.';
	@override String get currentPlan => 'Cari Plan';
	@override String get mostPopular => 'Ən Populyar';
	@override String get perMonth => 'aylıq';
	@override String get manageOnWeb => 'Abunəliyinizi auxiodev.com saytında idarə edin';
	@override String get featureUnlimitedWorkplaces => 'Limitsiz klinika';
	@override String featureWorkplaces({required Object count}) => '${count} klinikaya qədər';
	@override String get featureUnlimitedBookings => 'Aylıq limitsiz qeydiyyat';
	@override String featureBookingsPerMonth({required Object count}) => 'Ayda ${count} qeydiyyata qədər';
	@override String get featureChat => 'Pasiyentlərlə çat';
	@override String get featurePromoted => 'Axtarışda prioritet + «Peşəkar» nişanı';
	@override String get renew => 'Yenilə';
	@override String get subscribe => 'Abunə ol';
	@override String get planNameHospitalBasic => 'Klinika';
	@override String get planNameHospitalPro => 'Klinika Plus';
	@override String featureDoctors({required Object count}) => '${count} həkimə qədər';
	@override String get featureUnlimitedDoctors => 'Limitsiz həkim';
	@override String get featureAdvancedStats => 'Ətraflı statistika';
}

// Path: hospitalPicker
class _Translations$hospitalPicker$az extends Translations$hospitalPicker$en {
	_Translations$hospitalPicker$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Xəstəxana seçin';
	@override String get searchHint => 'Xəstəxananın adını axtarın…';
	@override String get noResultsFound => 'Xəstəxana tapılmadı';
	@override String get selectCityFirst => 'Əvvəlcə şəhəri seçin';
	@override String addVariant({required Object name}) => '"${name}" əlavə et';
	@override String get pendingReview => 'Yoxlanılır';
}

// Path: hospitalRegistration
class _Translations$hospitalRegistration$az extends Translations$hospitalRegistration$en {
	_Translations$hospitalRegistration$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Xəstəxana məlumatları';
	@override String get subtitle => 'Şəhərinizi seçin, sonra xəstəxananızı siyahıdan tapın və ya əlavə edin.';
	@override String get cityStep => '1. Şəhər';
	@override String get hospitalStep => '2. Xəstəxana';
	@override String get searchHint => 'Xəstəxananın adını axtarın…';
	@override String get noResultsFound => 'Xəstəxana tapılmadı';
	@override String get notFoundPrompt => 'Xəstəxananızı tapa bilmirsiniz?';
	@override String get addManually => 'Əl ilə əlavə et';
	@override String get useSearchInstead => 'Yenidən axtar';
	@override String get newHospitalName => 'Xəstəxananın adı';
	@override String get selectedPrefix => 'Seçildi:';
	@override String get pendingReviewNotice => 'Yeni xəstəxanalar başqalarına görünməzdən əvvəl komandamız tərəfindən yoxlanılır.';
	@override String get submit => 'Hesab yarat';
	@override String get hospitalRequired => 'Davam etmək üçün xəstəxananızı seçin və ya əlavə edin';
}

// Path: hospitalHome
class _Translations$hospitalHome$az extends Translations$hospitalHome$en {
	_Translations$hospitalHome$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Salam, ${name}';
	@override String get subtitle => 'Həkimlərinizi və qəbulları idarə edin';
	@override String get doctors => 'Həkimlər';
	@override String get inviteDoctor => 'Həkim dəvət et';
	@override String get appointments => 'Qəbullar';
	@override String get profile => 'Profil';
	@override String pendingRequests({required Object count}) => '${count} müraciət gözləyir';
}

// Path: hospitalDoctors
class _Translations$hospitalDoctors$az extends Translations$hospitalDoctors$en {
	_Translations$hospitalDoctors$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Həkimlər';
	@override String get tabConfirmed => 'Təsdiqlənmiş';
	@override String get tabRequests => 'Müraciətlər';
	@override String get tabInvited => 'Dəvət olunmuş';
	@override String get noConfirmedDoctors => 'Hələ təsdiqlənmiş həkim yoxdur';
	@override String get noRequests => 'Gözləyən müraciət yoxdur';
	@override String get noInvited => 'Gözləyən dəvət yoxdur';
	@override String get approve => 'Təsdiqlə';
	@override String get reject => 'Rədd et';
	@override String get remove => 'Sil';
	@override String get removeConfirmTitle => 'Həkim silinsin?';
	@override String removeConfirmMessage({required Object name}) => '${name} artıq xəstəxananızla əlaqəli olmayacaq. Bu, onun iş yerinə və qəbullarına təsir etməyəcək.';
	@override String get requestedToJoin => 'Qoşulmaq üçün müraciət edib';
	@override String get invitedAwaiting => 'Dəvət olunub — cavab gözlənilir';
	@override String get editHours => 'Saatları dəyiş';
}

// Path: hospitalInvite
class _Translations$hospitalInvite$az extends Translations$hospitalInvite$en {
	_Translations$hospitalInvite$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Həkim dəvət et';
	@override String get searchHint => 'Ad və ya ixtisas üzrə axtarın…';
	@override String get noResultsFound => 'Həkim tapılmadı';
	@override String get invite => 'Dəvət et';
	@override String get invited => 'Dəvət olunub';
}

// Path: hospitalAppointments
class _Translations$hospitalAppointments$az extends Translations$hospitalAppointments$en {
	_Translations$hospitalAppointments$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qəbullar';
	@override String get empty => 'Hələ qəbul yoxdur';
}

// Path: hospitalProfile
class _Translations$hospitalProfile$az extends Translations$hospitalProfile$en {
	_Translations$hospitalProfile$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Xəstəxana profili';
	@override String usageDoctors({required Object limit, required Object count}) => '${limit} həkimdən ${count}';
	@override String usageDoctorsUnlimited({required Object count}) => '${count} həkim (limitsiz)';
	@override String get manageSubscription => 'Abunəliyi idarə et';
}

// Path: hospitalDoctorHours
class _Translations$hospitalDoctorHours$az extends Translations$hospitalDoctorHours$en {
	_Translations$hospitalDoctorHours$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'İş saatları';
	@override String get selectWorkplace => 'İş yerini seçin';
	@override String get saved => 'Saatlar saxlanıldı';
}

// Path: doctorHospitals
class _Translations$doctorHospitals$az extends Translations$doctorHospitals$en {
	_Translations$doctorHospitals$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Xəstəxanalarım';
	@override String get tabInvitations => 'Dəvətlər';
	@override String get tabRequests => 'Müraciətlər';
	@override String get tabConfirmed => 'Xəstəxanalar';
	@override String get noInvitations => 'Gözləyən dəvət yoxdur';
	@override String get noRequests => 'Gözləyən müraciət yoxdur';
	@override String get noConfirmed => 'Hələ heç bir xəstəxana ilə əlaqəniz yoxdur';
	@override String get accept => 'Qəbul et';
	@override String get decline => 'Rədd et';
	@override String get cancelRequest => 'Müraciəti ləğv et';
	@override String get invitedYouToJoin => 'Sizi qoşulmağa dəvət etdi';
	@override String get awaitingApproval => 'Xəstəxananın təsdiqini gözləyir';
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

// Path: legal.sections
class _Translations$legal$sections$az extends Translations$legal$sections$en {
	_Translations$legal$sections$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override late final _Translations$legal$sections$identity$az identity = _Translations$legal$sections$identity$az._(_root);
	@override late final _Translations$legal$sections$health$az health = _Translations$legal$sections$health$az._(_root);
	@override late final _Translations$legal$sections$professional$az professional = _Translations$legal$sections$professional$az._(_root);
	@override late final _Translations$legal$sections$location$az location = _Translations$legal$sections$location$az._(_root);
	@override late final _Translations$legal$sections$device$az device = _Translations$legal$sections$device$az._(_root);
	@override late final _Translations$legal$sections$payment$az payment = _Translations$legal$sections$payment$az._(_root);
	@override late final _Translations$legal$sections$family$az family = _Translations$legal$sections$family$az._(_root);
	@override late final _Translations$legal$sections$purposes$az purposes = _Translations$legal$sections$purposes$az._(_root);
	@override late final _Translations$legal$sections$legalBasis$az legalBasis = _Translations$legal$sections$legalBasis$az._(_root);
	@override late final _Translations$legal$sections$thirdParties$az thirdParties = _Translations$legal$sections$thirdParties$az._(_root);
	@override late final _Translations$legal$sections$retention$az retention = _Translations$legal$sections$retention$az._(_root);
	@override late final _Translations$legal$sections$rights$az rights = _Translations$legal$sections$rights$az._(_root);
	@override late final _Translations$legal$sections$security$az security = _Translations$legal$sections$security$az._(_root);
	@override late final _Translations$legal$sections$permissions$az permissions = _Translations$legal$sections$permissions$az._(_root);
	@override late final _Translations$legal$sections$children$az children = _Translations$legal$sections$children$az._(_root);
}

// Path: legal.sections.identity
class _Translations$legal$sections$identity$az extends Translations$legal$sections$identity$en {
	_Translations$legal$sections$identity$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Şəxsiyyət məlumatları';
	@override String get body => 'Ad və soyad, e-poçt ünvanı, telefon nömrəsi (istəyə bağlı), parolunuz (geri qaytarılmaz hash şəklində saxlanılır, heç vaxt açıq mətn kimi deyil) və seçdiyiniz tətbiq dili.';
}

// Path: legal.sections.health
class _Translations$legal$sections$health$az extends Translations$legal$sections$health$en {
	_Translations$legal$sections$health$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sağlamlıq məlumatları';
	@override String get body => 'Pasiyent kimi: qan qrupu, allergiyalar, xroniki xəstəliklər, qəbul etdiyiniz dərmanlar, təyinat bron edərkən qeyd etdiyiniz səbəb, yüklədiyiniz tibbi sənədlər (analiz nəticələri, görüntüləmə, digər qeydlər), sizə yazılan reseptlər və həkiminizlə yazışmalarınızın məzmunu. Simptom yoxlama süni intellekt köməkçisindən istifadə etdikdə, suallarınız və onun cavabları da eyni şəkildə işlənir. Sağlamlıq məlumatları Azərbaycan qanunvericiliyinə əsasən ən yüksək qoruma səviyyəsinə malikdir və biz onları yalnız ayrıca, açıq razılığınızla toplayırıq (aşağıda "Hüquqi əsas" bölməsinə baxın).';
}

// Path: legal.sections.professional
class _Translations$legal$sections$professional$az extends Translations$legal$sections$professional$en {
	_Translations$legal$sections$professional$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Peşəkar məlumatlar (həkimlər)';
	@override String get body => 'İxtisas, lisenziya nömrəsi, diplom və ya digər təsdiqləyici sənəd, iş yeri məlumatları və konsultasiya haqqı. Bu məlumatlar profiliniz pasiyentlərə görünməzdən əvvəl komandamız tərəfindən yoxlanılır.';
}

// Path: legal.sections.location
class _Translations$legal$sections$location$az extends Translations$legal$sections$location$en {
	_Translations$legal$sections$location$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Məkan';
	@override String get body => 'İcazənizlə — həkimləri sizə olan məsafəyə görə sıralamaq üçün təxmini və ya dəqiq məkan. Yalnız tətbiq açıq olduğu müddətdə istifadə olunur və heç vaxt serverlərimizdə saxlanılmır.';
}

// Path: legal.sections.device
class _Translations$legal$sections$device$az extends Translations$legal$sections$device$en {
	_Translations$legal$sections$device$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cihaz və texniki məlumatlar';
	@override String get body => 'Aktiv girişlərinizi "Tənzimləmələr" bölməsində görmək və ləğv etmək üçün cihaz identifikatorları və sessiya məlumatları, həmçinin təyinat xatırlatmaları və mesajları çatdırmaq üçün push-bildiriş tokeni.';
}

// Path: legal.sections.payment
class _Translations$legal$sections$payment$az extends Translations$legal$sections$payment$en {
	_Translations$legal$sections$payment$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ödəniş məlumatları';
	@override String get body => 'Tətbiq daxilində konsultasiya üçün ödəniş etdiyiniz halda, ödəniş tamamilə ödəniş tərəfdaşımız Payriff tərəfindən emal olunur — biz heç vaxt kart nömrənizi görmürük və saxlamırıq. Biz yalnız ödəniş məbləğini, statusunu və təyinat tarixçəniz üçün istinad nömrəsini saxlayırıq.';
}

// Path: legal.sections.family
class _Translations$legal$sections$family$az extends Translations$legal$sections$family$en {
	_Translations$legal$sections$family$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ailə üzvü profilləri';
	@override String get body => 'Ailə üzvünün (öz girişi olmayan uşaq və ya himayədə olan şəxsin) profilini idarə etdiyiniz halda, yuxarıdakı eyni sağlamlıq məlumatı kateqoriyaları onun üçün sizin hesabınız altında qeydə alına bilər. Ailə üzvü əlavə etməklə, onun valideyni, qəyyumu və ya sağlamlıq məlumatlarını onun adından idarə etməyə səlahiyyətli olduğunuzu təsdiq edirsiniz.';
}

// Path: legal.sections.purposes
class _Translations$legal$sections$purposes$az extends Translations$legal$sections$purposes$en {
	_Translations$legal$sections$purposes$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Məlumatlarınızdan niyə istifadə edirik';
	@override String get body => 'Həkim tapmağınız və onlara təyinat almağınız üçün; həkimlərin cədvəlini və pasiyentlərini idarə etməsi üçün; təyinat xatırlatmaları və yeniliklər göndərmək üçün; konsultasiya ödənişlərini emal etmək üçün; istəyə bağlı simptom yoxlama süni intellekt funksiyasını təmin etmək üçün; hesabınızın təhlükəsizliyini qorumaq üçün.';
}

// Path: legal.sections.legalBasis
class _Translations$legal$sections$legalBasis$az extends Translations$legal$sections$legalBasis$en {
	_Translations$legal$sections$legalBasis$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hüquqi əsas və razılığınız';
	@override String get body => 'Məlumatlarınızı qeydiyyatdan keçərkən verdiyiniz razılıq əsasında işləyirik. Sağlamlıq məlumatları Azərbaycan Respublikasının "Fərdi məlumatlar haqqında" Qanununa (№998-IIIQ) əsasən xüsusi kateqoriya fərdi məlumat sayılır və toplanmazdan əvvəl açıq, yazılı razılığınızı tələb edir — qeydiyyat ekranındakı checkbox məhz bunu qeydə alır. Hesabınızı silməklə razılığınızı istənilən vaxt geri götürə bilərsiniz, lakin qanunla tələb olunduğu hallarda (məsələn, vergi məqsədləri üçün maliyyə qeydləri) məhdud qeydləri saxlaya bilərik.';
}

// Path: legal.sections.thirdParties
class _Translations$legal$sections$thirdParties$az extends Translations$legal$sections$thirdParties$en {
	_Translations$legal$sections$thirdParties$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Məlumatlarınızı daha kim işləyir';
	@override String get body => 'Yalnız bizim tapşırığımızla və burada təsvir olunan məqsədlər üçün fəaliyyət göstərən etibarlı xidmət təchizatçıları: Cloudinary (sənəd və şəkillərin təhlükəsiz saxlanması — heç vaxt ictimai əlçatan deyil, yalnız imzalanmış, məhdud müddətli keçidlərlə); Firebase/Google (push-bildirişlər və seçdiyiniz halda Google ilə giriş); Apple (seçdiyiniz halda Apple ilə giriş); Payriff (tətbiq daxili ödənişlər). Şəxsi məlumatlarınızı heç kimə satmırıq.';
}

// Path: legal.sections.retention
class _Translations$legal$sections$retention$az extends Translations$legal$sections$retention$en {
	_Translations$legal$sections$retention$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Məlumatları nə qədər saxlayırıq';
	@override String get body => 'Hesabınız aktiv olduğu müddətcə. Hesabınızı sildikdə, qanunla saxlamağa borclu olduğumuz qeydlər (məsələn, vergi məqsədləri üçün ödəniş qeydləri) istisna olmaqla, şəxsi məlumatlarınızı ağlabatan müddət ərzində siliriz.';
}

// Path: legal.sections.rights
class _Translations$legal$sections$rights$az extends Translations$legal$sections$rights$en {
	_Translations$legal$sections$rights$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hüquqlarınız';
	@override String get body => 'Haqqınızda saxladığımız məlumatlara giriş əldə edə, yanlış məlumatların düzəldilməsini tələb edə, hesabınızın və məlumatlarınızın silinməsini tələb edə və istənilən vaxt razılığınızı geri götürə bilərsiniz. Bunların əksəriyyəti birbaşa "Profil" → "Tənzimləmələr" bölməsində mövcuddur; digər hallarda aşağıdakı əlaqə vasitəsilə bizimlə əlaqə saxlayın.';
}

// Path: legal.sections.security
class _Translations$legal$sections$security$az extends Translations$legal$sections$security$en {
	_Translations$legal$sections$security$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Məlumatlarınızı necə qoruyuruq';
	@override String get body => 'Həkiminizlə yazışmalarınız və süni intellekt köməkçisi ilə söhbətləriniz şifrələnir. Yüklənmiş sənədlər və şəkillər məxfi saxlanılır, yalnız təhlükəsiz imzalanmış keçidlərlə əlçatandır, heç vaxt ictimai fayl kimi deyil. Parollar heç vaxt oxuna bilən formada saxlanılmır.';
}

// Path: legal.sections.permissions
class _Translations$legal$sections$permissions$az extends Translations$legal$sections$permissions$en {
	_Translations$legal$sections$permissions$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tələb etdiyimiz icazələr';
	@override String get body => 'Kamera və foto qalereya — profil şəkli qoymaq və tibbi sənədlər yükləmək üçün. Məkan — həkimləri sizə olan məsafəyə görə sıralamaq üçün. Bildirişlər — təyinat xatırlatmaları və mesajlar çatdırmaq üçün. Biometrik (Face ID / barmaq izi) — tətbiqi kilidlədən açmağın istəyə bağlı, daha sürətli üsulu; biometrik məlumatlarınız heç vaxt cihazınızdan kənara çıxmır, biz yalnız cihazın əməliyyat sistemindən "bəli/xeyr" təsdiqi alırıq.';
}

// Path: legal.sections.children
class _Translations$legal$sections$children$az extends Translations$legal$sections$children$en {
	_Translations$legal$sections$children$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Yaş tələbi';
	@override String get body => 'Medoro hesabları böyüklər üçün nəzərdə tutulub. 18 yaşınız tamam olmayıbsa, ailə üzvü profili funksiyasından istifadə edərək valideyniniz və ya qəyyumunuzdan sizin adınızdan hesab yaratmasını və idarə etməsini xahiş edin.';
}

/// The flat map containing all translations for locale <az>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAz {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'Medoro',
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
			'common.noRatings' => 'Hələ qiymət yoxdur',
			'common.hospital' => 'Xəstəxana',
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
			'auth.joinMedalize' => 'Bu gün Medoro-ya qoşulun',
			'auth.iAmA' => 'Mən',
			'auth.emailHint' => 'you@example.com',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => 'Girişə qayıt',
			'auth.verificationCode' => 'Təsdiq kodu',
			'auth.continueWithGoogle' => 'Google ilə davam et',
			'auth.continueWithApple' => 'Apple ilə davam et',
			'auth.orDivider' => 'və ya',
			'forgotPassword.title' => 'Şifrəni unutmusunuz?',
			'forgotPassword.subtitle' => 'E-poçtunuzu daxil edin, sizə 6 rəqəmli bərpa kodu göndərək',
			'resetPassword.title' => 'Şifrəni bərpa et',
			'resetPassword.subtitle' => 'E-poçtunuza göndərilən kodu daxil edin və yeni şifrə seçin',
			'resetPassword.button' => 'Şifrəni bərpa et',
			'resetPassword.success' => 'Şifrə uğurla bərpa edildi. Zəhmət olmasa daxil olun.',
			'verifyEmail.title' => 'Email ünvanınızı təsdiqləyin',
			'verifyEmail.subtitle' => ({required Object email}) => '${email} ünvanına 6 rəqəmli kod göndərdik',
			'verifyEmail.button' => 'Təsdiqlə',
			'verifyEmail.resend' => 'Kodu yenidən göndər',
			'verifyEmail.resendSent' => 'Yeni kod göndərildi.',
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
			'errors.socialLoginFailed' => 'Giriş uğursuz oldu. Yenidən cəhd edin və ya e-poçt və şifrənizi istifadə edin.',
			'errors.conflict' => 'Bu əməliyyat hazırda tamamlana bilmir.',
			'errors.onboardingIncomplete' => 'Qeydiyyatı tamamlamaq üçün bütün tələb olunan sahələri doldurun.',
			'errors.planLimitReached' => 'Planınızın limitinə çatmısınız. Daha çoxu üçün planı yüksəldin.',
			'errors.chatUnavailable' => 'Bu həkim cari planında çat təklif etmir.',
			'errors.emailNotVerified' => 'Daxil olmadan əvvəl email ünvanınızı təsdiqləyin.',
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
			'settings.version' => 'Medoro v1.0.0',
			'settings.legal' => 'Məxfilik və Şərtlər',
			'security.title' => 'Təhlükəsizlik',
			'security.biometricLogin' => 'Biometrik Giriş',
			'security.biometricLoginSubtitle' => 'Tətbiqin kilidini açmaq üçün Face ID / Touch ID istifadə edin',
			'security.biometricPrompt' => 'Medoro-ya daxil olmaq üçün doğrulayın',
			'security.biometricUnavailable' => 'Bu cihazda biometrik autentifikasiya mövcud deyil',
			'security.biometricEnableFailed' => 'Biometrik məlumatlarınız təsdiqlənə bilmədi. Yenidən cəhd edin.',
			'security.activeSessions' => 'Aktiv Sessiyalar',
			'security.activeSessionsSubtitle' => 'Hesabınıza hazırda daxil olan cihazlar',
			'security.thisDevice' => 'Bu cihaz',
			'security.lastActive' => ({required Object date}) => 'Son fəaliyyət: ${date}',
			'security.revoke' => 'Ləğv et',
			'security.revokeConfirmTitle' => 'Cihaz ləğv edilsin?',
			'security.revokeConfirmMessage' => ({required Object name}) => '${name} hesabdan çıxarılacaq. Hesab məlumatları ilə yenidən daxil ola bilər.',
			'security.revokeCurrentConfirmMessage' => 'Bu sizin cari cihazınızdır — onu ləğv etsəniz dərhal çıxış edəcəksiniz.',
			'security.revokeFailed' => 'Bu cihaz ləğv edilə bilmədi. Yenidən cəhd edin.',
			'security.signOutAllDevices' => 'Bütün cihazlardan çıx',
			'security.signOutAllConfirmTitle' => 'Hər yerdən çıxılsın?',
			'security.signOutAllConfirmMessage' => 'Bu daxil olmaqla bütün cihazlardan çıxacaqsınız.',
			'security.signOutAllFailed' => 'Bütün cihazlardan çıxış uğursuz oldu. Yenidən cəhd edin.',
			'security.noDevices' => 'Aktiv sessiya tapılmadı',
			'security.loadFailed' => 'Aktiv sessiyalarınız yüklənə bilmədi',
			'security.changeEmail' => 'Email-i dəyiş',
			'security.changeEmailSubtitle' => 'Yeni email ünvanınıza təsdiq kodu göndərəcəyik. Təsdiqdən sonra yeni email ilə daxil olacaqsınız.',
			'security.newEmailLabel' => 'Yeni email',
			'security.sendCode' => 'Kod göndər',
			'security.codeSentTo' => ({required Object email}) => '${email} ünvanına göndərdiyimiz 6 rəqəmli kodu daxil edin',
			'security.confirmNewEmail' => 'Yeni email-i təsdiqlə',
			'security.changeEmailSuccess' => 'Email dəyişdirildi. Yeni email ilə yenidən daxil olun.',
			'security.dangerZone' => 'Təhlükəli zona',
			'security.deactivateAccount' => 'Hesabı deaktiv et',
			'security.deactivateAccountSubtitle' => 'Məlumatları silmədən hesabı deaktiv edin',
			'security.deactivateConfirmTitle' => 'Hesab deaktiv edilsin?',
			'security.deactivateConfirmMessage' => 'Hesabınız deaktiv ediləcək və bütün cihazlarda çıxış ediləcək. Məlumatlarınız silinmir. Bərpa üçün dəstək xidmətinə müraciət edin.',
			'security.deactivate' => 'Deaktiv et',
			'security.deactivateSuccess' => 'Hesabınız deaktiv edildi.',
			'security.deleteAccount' => 'Hesabı Həmişəlik Sil',
			'security.deleteAccountSubtitle' => 'Məlumatlarınızı silin. Bu geri qaytarıla bilməz.',
			'security.deleteConfirmTitle' => 'Hesabınız həmişəlik silinsin?',
			'security.deleteConfirmWarning' => 'Bu əməliyyat geri qaytarıla bilməz.',
			'security.deleteConfirmMessage' => 'Profiliniz, tibbi qeydləriniz, resepetləriniz və mesajlarınız həmişəlik silinəcək. Gələcək görüşləriniz ləğv ediləcək və uyğun olduqda geri ödəniləcək. Ödəniş qeydləri qanun tələb etdiyi kimi mühasibat uçotu məqsədləri üçün anonimləşdirilmiş formada saxlanılır.',
			'security.deleteAccountSuccess' => 'Hesabınız həmişəlik silindi.',
			'status.confirmed' => 'Təsdiqləndi',
			'status.pending' => 'Gözləyir',
			'status.cancelled' => 'Ləğv edildi',
			'status.declined' => 'Rədd edildi',
			'status.requiresRescheduling' => 'Yenidən planlaşdırılmalıdır',
			'status.completed' => 'Tamamlandı',
			'status.noShow' => 'Gəlmədi',
			'home.helloDoctor' => ({required Object name}) => 'Salam, Dr. ${name}!',
			'home.helloPatient' => ({required Object name}) => 'Salam, ${name}!',
			'home.doctorSubtitle' => 'Cədvəlinizi və\ngörüşlərinizi idarə edin.',
			'home.patientSubtitle' => 'Həkim tapın və\ngörüş təyin edin.',
			'home.pendingRequests' => 'Gözləyən sorğular',
			'home.upcoming' => 'Yaxınlaşan',
			'home.findDoctor' => 'Həkim tap',
			'home.aiAssistant' => 'AI Köməkçi',
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
			'home.myWaitlist' => 'Gözləmə siyahı',
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
			'appointments.cancelledSuccess' => 'Görüş ləğv edildi.',
			'appointments.cancelledRefunded' => 'Görüş ləğv edildi. Ödənişiniz geri qaytarıldı.',
			'appointments.cancelledNoRefund' => 'Görüş ləğv edildi. Görüş vaxtına çox yaxın olduğu üçün geri ödəmə edilmədi.',
			'appointments.bookedTitle' => 'Təyin edildi!',
			'appointments.bookedMessage' => 'Görüş sorğunuz göndərildi.',
			'appointments.reschedule' => 'Yenidən planla',
			'appointments.rescheduleTitle' => 'Görüşü yenidən planlaşdır',
			'appointments.reviewTitle' => 'Rəy yaz',
			'appointments.reviewRating' => 'Qiymət',
			'appointments.reviewComment' => 'Şərh (istəyə bağlı)',
			'appointments.reviewSubmit' => 'Göndər',
			'appointments.markCompleted' => 'Tamamlandı kimi işarələ',
			'appointments.rescheduledSuccess' => 'Görüş uğurla yenidən planlaşdırıldı.',
			'appointments.reviewSubmitted' => 'Rəy göndərildi. Təşəkkür edirik!',
			'appointments.yourReview' => 'Rəyiniz',
			'appointments.editReviewTitle' => 'Rəyi redaktə et',
			'appointments.reviewUpdated' => 'Rəy yeniləndi.',
			'appointments.deleteReviewTitle' => 'Rəyi sil',
			'appointments.deleteReviewConfirm' => 'Rəyinizi silmək istədiyinizə əminsiniz?',
			'appointments.reviewDeleted' => 'Rəy silindi.',
			'appointments.requestReschedule' => 'Vaxtın dəyişdirilməsini istə',
			'appointments.requestRescheduleTitle' => 'Vaxtın dəyişdirilməsi',
			'appointments.requestRescheduleConfirm' => 'Pasiyentdən yeni vaxt seçməsini istəyirsiniz? Görüş “vaxtın dəyişdirilməsi tələb olunur” kimi işarələnəcək.',
			'appointments.requestRescheduleSuccess' => 'Vaxtın dəyişdirilməsi istənildi. Pasiyentə bildiriş göndəriləcək.',
			'appointments.rescheduleNeededHint' => 'Həkim sizdən yeni vaxt seçməyinizi xahiş etdi.',
			'appointments.markNoShow' => 'Gəlmədi qeyd et',
			'appointments.markNoShowTitle' => 'Gəlmədi kimi qeyd et',
			'appointments.markNoShowConfirm' => 'Bu görüşü “gəlmədi” kimi qeyd edək? Bu, pasiyentin gəlmədiyini qeyd edir.',
			'appointments.disputeNoShow' => 'Etiraz et',
			'appointments.disputeNoShowTitle' => 'Gəlmədi qeydinə etiraz',
			'appointments.disputeNoShowHint' => 'Niyə bunun səhv qeyd edildiyini düşündüyünüzü bizə bildirin — dəstək komandamız nəzərdən keçirəcək.',
			'appointments.disputeNoShowSubmit' => 'Göndər',
			'appointments.disputeNoShowSubmitted' => 'Etirazınız göndərildi. Onu nəzərdən keçirib sizinlə əlaqə saxlayacağıq.',
			'appointments.disputeNoShowOpen' => 'Etiraz göndərildi — nəzərdən keçirilir',
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
			'doctorSearch.loadMore' => 'Daha çox göstər',
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
			'doctorSearch.sortNearestSlot' => 'Ən erkən boş vaxt',
			'doctorSearch.sortDistance' => 'Mənə ən yaxın',
			'doctorSearch.locationDenied' => 'Məsafəyə görə sıralamaq üçün məkan icazəsi lazımdır. Parametrlərdə icazə verin və ya şəhər filtrindən istifadə edin.',
			'doctorSearch.locationUnavailable' => 'Məkanınızı təyin etmək mümkün olmadı. Məkan xidmətlərinin aktiv olduğunu yoxlayın və ya şəhər filtrindən istifadə edin.',
			'doctorSearch.distanceKm' => ({required Object km}) => '${km} km',
			'doctorDetail.profileTitle' => 'Həkim profili',
			'doctorDetail.couldNotLoadProfile' => 'Profil yüklənə bilmədi',
			'doctorDetail.about' => 'Haqqında',
			'doctorDetail.workplaces' => 'İş yerləri',
			'doctorDetail.minPerSlot' => ({required Object min}) => 'hər aralıq ${min} dəq',
			'doctorDetail.bookAppointment' => 'Görüş təyin et',
			'doctorDetail.consultationFee' => 'Konsultasiya haqqı',
			'doctorDetail.reviews' => 'Rəylər',
			'doctorDetail.reviewsCount' => ({required Object count}) => '${count} rəy',
			'doctorDetail.joinWaitlist' => 'Növbəyə yazıl',
			'doctorDetail.leaveWaitlist' => 'Növbədən çıx',
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
			'profile.cancellationWindow' => 'Ləğvetmə müddəti',
			'profile.cancellationWindowHint' => 'Pasiyentlərin görüşdən neçə saat əvvələ qədər ləğv/dəyişiklik edə biləcəyi.',
			'profile.hoursValue' => ({required Object h}) => '${h} saat',
			'notifications.title' => 'Bildirişlər',
			'notifications.noNotifications' => 'Bildiriş yoxdur',
			'notifications.allCaughtUp' => 'Hər şey qaydasındadır',
			'notifications.couldNotLoad' => 'Bildirişlər yüklənə bilmədi',
			'notifications.markAllRead' => 'Hamısını oxunmuş işarələ',
			'notifications.settingsTitle' => 'Bildiriş parametrləri',
			'notifications.pushEnabled' => 'Push bildirişlər',
			'notifications.pushEnabledSubtitle' => 'Qeydiyyatlar və yeniliklər üçün bu cihazda bildirişlər',
			'notifications.emailEnabled' => 'E-poçt bildirişləri',
			'notifications.emailEnabledSubtitle' => 'Yeniliklər e-poçt ünvanınıza göndəriləcək',
			'notifications.categoriesTitle' => 'Push kateqoriyaları',
			'notifications.careCategory' => 'Görüşlər və qulluq',
			'notifications.careCategorySubtitle' => 'Bronlar, xatırlatmalar, reseptlər',
			'notifications.messagesCategory' => 'Mesajlar',
			'notifications.messagesCategorySubtitle' => 'Yeni çat mesajları',
			'notifications.accountCategory' => 'Hesab və ödənişlər',
			'notifications.accountCategorySubtitle' => 'Təsdiqləmə, ödənişlər, abunəlik',
			'notifications.quietHoursTitle' => 'Sakit saatlar',
			'notifications.quietHoursEnabled' => 'Sakit saatları aktivləşdir',
			'notifications.quietHoursSubtitle' => 'Bu vaxt aralığında push bildirişləri dayandırılır',
			'notifications.quietHoursStart' => 'Başlanğıc',
			'notifications.quietHoursEnd' => 'Son',
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
			'addWorkplace.address' => 'Küçə ünvanı',
			'addWorkplace.city' => 'Şəhər',
			'addWorkplace.type' => 'Növ',
			'addWorkplace.clinic' => 'Klinika',
			'addWorkplace.hospital' => 'Xəstəxana',
			'addWorkplace.privatePractice' => 'Şəxsi praktika',
			'addWorkplace.failedToSave' => 'İş yeri yadda saxlanıla bilmədi.',
			'addWorkplace.addButton' => 'İş yeri əlavə et',
			'addWorkplace.saveChanges' => 'Dəyişiklikləri yadda saxla',
			'addWorkplace.pickOnMap' => 'Xəritədə göstər',
			'addWorkplace.mapPickerTitle' => 'Yerləşməni seçin',
			'addWorkplace.useMyLocation' => 'Mənim yerimi istifadə et',
			'addWorkplace.confirmLocation' => 'Yerləşməni təsdiqlə',
			'addWorkplace.locationSet' => 'Xəritədən yer seçildi ✓',
			'addWorkplace.locationPermissionDenied' => 'Cari yerinizi istifadə etmək üçün icazə lazımdır. Xəritəni əl ilə də hərəkət etdirə bilərsiniz.',
			'addWorkplace.locationUnavailable' => 'Yerləşməniz alınmadı. Xəritəni əl ilə də hərəkət etdirə bilərsiniz.',
			'workingHours.title' => 'İş saatları',
			'workingHours.sectionHint' => 'Bu ünvanda pasiyentlərin sizi qəbul edə biləcəyi günləri və saatları seçin.',
			'workingHours.invalidRange' => 'Aktiv hər gün üçün bitmə vaxtı başlama vaxtından sonra olmalıdır.',
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
			'pendingVerification.checkStatus' => 'Statusu yoxla',
			'pendingVerification.stillPending' => 'Hələ də nəzərdən keçirilir. Təsdiqləndikdən sonra sizə bildiriş göndərəcəyik.',
			'phoneField.label' => 'Telefon nömrəsi',
			'phoneField.labelOptional' => 'Telefon nömrəsi (istəyə bağlı)',
			'phoneField.selectCountry' => 'Ölkə seçin',
			'phoneField.searchCountry' => 'Ölkə və ya kod axtar…',
			'phoneField.noCountriesFound' => 'Ölkə tapılmadı',
			'locations.pickCity' => 'Şəhər seçin',
			'locations.searchHint' => 'Şəhər və ya region axtar…',
			'locations.noResultsFound' => 'Şəhər tapılmadı',
			'locations.couldNotLoad' => 'Şəhərlər yüklənmədi. Yenidən cəhd etmək üçün toxunun.',
			'locations.allCities' => 'Bütün şəhərlər',
			'splash.tagline' => 'Sağlamlığınız, sadələşdirilmiş',
			'appIntro.page1Title' => 'Doğru həkimi tapın',
			'appIntro.page1Subtitle' => 'İxtisas, şəhər və reytinqə görə axtarın — sizə uyğun vaxta yazılın.',
			'appIntro.page2Title' => 'Süni intellekt köməkçisinə sual verin',
			'appIntro.page2Subtitle' => 'Simptomlarınızı təsvir edin və hansı həkimə müraciət etməli olduğunuzu öyrənin.',
			'appIntro.page3Title' => 'Hər şey bir tətbiqdə',
			'appIntro.page3Subtitle' => 'Qəbulları idarə edin, müalicənizi izləyin və tətbiqi öz dilinizdə istifadə edin — təhlükəsiz şəkildə.',
			'appIntro.skip' => 'Keç',
			'appIntro.next' => 'Növbəti',
			'appIntro.getStarted' => 'Başla',
			'agenda.title' => 'Cədvəl',
			'agenda.today' => 'Bu gün',
			'agenda.empty' => 'Görüş yoxdur',
			'agenda.emptySubtitle' => 'Bu gün üçün heç nə planlaşdırılmayıb',
			'favorites.title' => 'Sevimlilər',
			'favorites.empty' => 'Hələ sevimli yoxdur',
			'favorites.emptySubtitle' => 'Həkimi yadda saxlamaq üçün ürək işarəsinə toxunun',
			'favorites.add' => 'Sevimlilərə əlavə et',
			'favorites.remove' => 'Sevimlilərdən sil',
			'assistant.title' => 'AI Köməkçi',
			'assistant.newChat' => 'Yeni söhbət',
			'assistant.empty' => 'Hələ söhbət yoxdur',
			'assistant.emptySubtitle' => 'Simptomlarınızı təsvir edin — köməkçi hansı həkimə müraciət edəcəyinizi məsləhət görəcək',
			'assistant.couldNotLoad' => 'Söhbətləri yükləmək mümkün olmadı',
			'assistant.couldNotLoadChat' => 'Söhbəti yükləmək mümkün olmadı',
			'assistant.newConversation' => 'Yeni söhbət',
			'assistant.deleteTitle' => 'Söhbət silinsin?',
			'assistant.deleteConfirm' => 'Söhbət və onun bütün mesajları silinəcək.',
			'assistant.inputHint' => 'Simptomlarınızı təsvir edin…',
			'assistant.send' => 'Göndər',
			'assistant.sendFailed' => 'Mesajı göndərmək mümkün olmadı. Yenidən cəhd edin.',
			'assistant.typing' => 'Köməkçi yazır…',
			'assistant.startTitle' => 'Necə kömək edə bilərəm?',
			'assistant.startSubtitle' => 'Başlamaq üçün sizi narahat edəni təsvir edin',
			'assistant.book' => 'Qəbula yazıl',
			'assistant.reportTooltip' => 'Cavabdan şikayət et',
			'assistant.reportTitle' => 'Cavabdan şikayət et',
			'assistant.reportHint' => 'Səbəb (istəyə bağlı)',
			'assistant.reportSubmit' => 'Göndər',
			'assistant.reportSuccess' => 'Təşəkkürlər, şikayət göndərildi.',
			'assistant.reportFailed' => 'Şikayəti göndərmək mümkün olmadı. Yenidən cəhd edin.',
			'assistant.topicsTooltip' => 'Mövzular',
			'assistant.topicsSheetTitle' => 'Mövzu seçin',
			'messaging.title' => 'Mesajlar',
			'messaging.sendMessage' => 'Mesaj yaz',
			'messaging.typeMessage' => 'Mesaj yazın…',
			'messaging.send' => 'Göndər',
			'messaging.empty' => 'Hələ yazışma yoxdur',
			'messaging.emptySubtitle' => 'Yazışmalarınız burada görünəcək.',
			'messaging.disclaimer' => 'Bu təcili yardım xətti deyil. Təcili hallarda təcili yardım xidmətinə zəng edin.',
			'messaging.noSharedHistory' => 'Həkimə yalnız onunla ortaq qəbul tarixçəniz olduqdan sonra yaza bilərsiniz.',
			'messaging.newMessage' => 'Yeni mesajınız var',
			'legal.title' => 'Məxfilik və Şərtlər',
			'legal.controllerNotice' => 'Medoro AuxioDev (auxiodev.com) tərəfindən Azərbaycanda yaradılıb və idarə olunur («biz»). Son yenilənmə: iyul 2026.',
			'legal.privacyTitle' => 'Məxfilik Siyasəti',
			'legal.privacyIntro' => 'Bu sənəd Medoro-nun hansı şəxsi məlumatları, nə üçün topladığını və necə qoruduğunu izah edir. Həkim təyinatlarının bronlanması və idarə olunması qaçılmaz olaraq sağlamlıq məlumatlarınızı əhatə edir — bu, aşağıda ətraflı izah olunur.',
			'legal.sections.identity.title' => 'Şəxsiyyət məlumatları',
			'legal.sections.identity.body' => 'Ad və soyad, e-poçt ünvanı, telefon nömrəsi (istəyə bağlı), parolunuz (geri qaytarılmaz hash şəklində saxlanılır, heç vaxt açıq mətn kimi deyil) və seçdiyiniz tətbiq dili.',
			'legal.sections.health.title' => 'Sağlamlıq məlumatları',
			'legal.sections.health.body' => 'Pasiyent kimi: qan qrupu, allergiyalar, xroniki xəstəliklər, qəbul etdiyiniz dərmanlar, təyinat bron edərkən qeyd etdiyiniz səbəb, yüklədiyiniz tibbi sənədlər (analiz nəticələri, görüntüləmə, digər qeydlər), sizə yazılan reseptlər və həkiminizlə yazışmalarınızın məzmunu. Simptom yoxlama süni intellekt köməkçisindən istifadə etdikdə, suallarınız və onun cavabları da eyni şəkildə işlənir. Sağlamlıq məlumatları Azərbaycan qanunvericiliyinə əsasən ən yüksək qoruma səviyyəsinə malikdir və biz onları yalnız ayrıca, açıq razılığınızla toplayırıq (aşağıda "Hüquqi əsas" bölməsinə baxın).',
			'legal.sections.professional.title' => 'Peşəkar məlumatlar (həkimlər)',
			'legal.sections.professional.body' => 'İxtisas, lisenziya nömrəsi, diplom və ya digər təsdiqləyici sənəd, iş yeri məlumatları və konsultasiya haqqı. Bu məlumatlar profiliniz pasiyentlərə görünməzdən əvvəl komandamız tərəfindən yoxlanılır.',
			'legal.sections.location.title' => 'Məkan',
			'legal.sections.location.body' => 'İcazənizlə — həkimləri sizə olan məsafəyə görə sıralamaq üçün təxmini və ya dəqiq məkan. Yalnız tətbiq açıq olduğu müddətdə istifadə olunur və heç vaxt serverlərimizdə saxlanılmır.',
			'legal.sections.device.title' => 'Cihaz və texniki məlumatlar',
			'legal.sections.device.body' => 'Aktiv girişlərinizi "Tənzimləmələr" bölməsində görmək və ləğv etmək üçün cihaz identifikatorları və sessiya məlumatları, həmçinin təyinat xatırlatmaları və mesajları çatdırmaq üçün push-bildiriş tokeni.',
			'legal.sections.payment.title' => 'Ödəniş məlumatları',
			'legal.sections.payment.body' => 'Tətbiq daxilində konsultasiya üçün ödəniş etdiyiniz halda, ödəniş tamamilə ödəniş tərəfdaşımız Payriff tərəfindən emal olunur — biz heç vaxt kart nömrənizi görmürük və saxlamırıq. Biz yalnız ödəniş məbləğini, statusunu və təyinat tarixçəniz üçün istinad nömrəsini saxlayırıq.',
			'legal.sections.family.title' => 'Ailə üzvü profilləri',
			'legal.sections.family.body' => 'Ailə üzvünün (öz girişi olmayan uşaq və ya himayədə olan şəxsin) profilini idarə etdiyiniz halda, yuxarıdakı eyni sağlamlıq məlumatı kateqoriyaları onun üçün sizin hesabınız altında qeydə alına bilər. Ailə üzvü əlavə etməklə, onun valideyni, qəyyumu və ya sağlamlıq məlumatlarını onun adından idarə etməyə səlahiyyətli olduğunuzu təsdiq edirsiniz.',
			'legal.sections.purposes.title' => 'Məlumatlarınızdan niyə istifadə edirik',
			'legal.sections.purposes.body' => 'Həkim tapmağınız və onlara təyinat almağınız üçün; həkimlərin cədvəlini və pasiyentlərini idarə etməsi üçün; təyinat xatırlatmaları və yeniliklər göndərmək üçün; konsultasiya ödənişlərini emal etmək üçün; istəyə bağlı simptom yoxlama süni intellekt funksiyasını təmin etmək üçün; hesabınızın təhlükəsizliyini qorumaq üçün.',
			'legal.sections.legalBasis.title' => 'Hüquqi əsas və razılığınız',
			'legal.sections.legalBasis.body' => 'Məlumatlarınızı qeydiyyatdan keçərkən verdiyiniz razılıq əsasında işləyirik. Sağlamlıq məlumatları Azərbaycan Respublikasının "Fərdi məlumatlar haqqında" Qanununa (№998-IIIQ) əsasən xüsusi kateqoriya fərdi məlumat sayılır və toplanmazdan əvvəl açıq, yazılı razılığınızı tələb edir — qeydiyyat ekranındakı checkbox məhz bunu qeydə alır. Hesabınızı silməklə razılığınızı istənilən vaxt geri götürə bilərsiniz, lakin qanunla tələb olunduğu hallarda (məsələn, vergi məqsədləri üçün maliyyə qeydləri) məhdud qeydləri saxlaya bilərik.',
			'legal.sections.thirdParties.title' => 'Məlumatlarınızı daha kim işləyir',
			'legal.sections.thirdParties.body' => 'Yalnız bizim tapşırığımızla və burada təsvir olunan məqsədlər üçün fəaliyyət göstərən etibarlı xidmət təchizatçıları: Cloudinary (sənəd və şəkillərin təhlükəsiz saxlanması — heç vaxt ictimai əlçatan deyil, yalnız imzalanmış, məhdud müddətli keçidlərlə); Firebase/Google (push-bildirişlər və seçdiyiniz halda Google ilə giriş); Apple (seçdiyiniz halda Apple ilə giriş); Payriff (tətbiq daxili ödənişlər). Şəxsi məlumatlarınızı heç kimə satmırıq.',
			'legal.sections.retention.title' => 'Məlumatları nə qədər saxlayırıq',
			'legal.sections.retention.body' => 'Hesabınız aktiv olduğu müddətcə. Hesabınızı sildikdə, qanunla saxlamağa borclu olduğumuz qeydlər (məsələn, vergi məqsədləri üçün ödəniş qeydləri) istisna olmaqla, şəxsi məlumatlarınızı ağlabatan müddət ərzində siliriz.',
			'legal.sections.rights.title' => 'Hüquqlarınız',
			'legal.sections.rights.body' => 'Haqqınızda saxladığımız məlumatlara giriş əldə edə, yanlış məlumatların düzəldilməsini tələb edə, hesabınızın və məlumatlarınızın silinməsini tələb edə və istənilən vaxt razılığınızı geri götürə bilərsiniz. Bunların əksəriyyəti birbaşa "Profil" → "Tənzimləmələr" bölməsində mövcuddur; digər hallarda aşağıdakı əlaqə vasitəsilə bizimlə əlaqə saxlayın.',
			_ => null,
		} ?? switch (path) {
			'legal.sections.security.title' => 'Məlumatlarınızı necə qoruyuruq',
			'legal.sections.security.body' => 'Həkiminizlə yazışmalarınız və süni intellekt köməkçisi ilə söhbətləriniz şifrələnir. Yüklənmiş sənədlər və şəkillər məxfi saxlanılır, yalnız təhlükəsiz imzalanmış keçidlərlə əlçatandır, heç vaxt ictimai fayl kimi deyil. Parollar heç vaxt oxuna bilən formada saxlanılmır.',
			'legal.sections.permissions.title' => 'Tələb etdiyimiz icazələr',
			'legal.sections.permissions.body' => 'Kamera və foto qalereya — profil şəkli qoymaq və tibbi sənədlər yükləmək üçün. Məkan — həkimləri sizə olan məsafəyə görə sıralamaq üçün. Bildirişlər — təyinat xatırlatmaları və mesajlar çatdırmaq üçün. Biometrik (Face ID / barmaq izi) — tətbiqi kilidlədən açmağın istəyə bağlı, daha sürətli üsulu; biometrik məlumatlarınız heç vaxt cihazınızdan kənara çıxmır, biz yalnız cihazın əməliyyat sistemindən "bəli/xeyr" təsdiqi alırıq.',
			'legal.sections.children.title' => 'Yaş tələbi',
			'legal.sections.children.body' => 'Medoro hesabları böyüklər üçün nəzərdə tutulub. 18 yaşınız tamam olmayıbsa, ailə üzvü profili funksiyasından istifadə edərək valideyniniz və ya qəyyumunuzdan sizin adınızdan hesab yaratmasını və idarə etməsini xahiş edin.',
			'legal.termsTitle' => 'İstifadə Şərtləri',
			'legal.termsIntro' => 'Hesab yaratmaqla aşağıdakılarla razılaşırsınız.',
			'legal.termsBody' => 'Özünüz haqqında dəqiq məlumat verin. Medoro-dan yalnız həkim tapmaq, təyinat bron etmək və idarə etmək üçün istifadə edin. Giriş məlumatlarınızı məxfi saxlayın. Medoro sizi müstəqil, lisenziyalı tibb mütəxəssisləri ilə əlaqələndirir — biz özümüz tibb müəssisəsi deyilik, simptom yoxlama süni intellekt köməkçisi peşəkar tibbi diaqnoz və ya məsləhəti əvəz etmir. Təcili tibbi vəziyyətdə birbaşa təcili yardım xidmətinə müraciət edin, bu tətbiqə deyil. Bu şərtləri pozan və ya platformadan sui-istifadə edən hesabları dayandıra və ya silə bilərik.',
			'legal.contact' => 'Məlumatlarınızla bağlı sualınız var? support@auxiodev.com ünvanına yazın',
			'legal.consentPrefix' => 'Mən ',
			'legal.consentPrivacyLink' => 'Məxfilik Siyasəti',
			'legal.consentMiddle' => ' və ',
			'legal.consentTermsLink' => 'İstifadə Şərtləri',
			'legal.consentSuffix' => ' ilə tanış oldum, onlarla razıyam və orada təsvir olunduğu kimi sağlamlıq məlumatlarımın işlənməsinə açıq razılıq verirəm.',
			'legal.viewAsPdf' => 'PDF kimi bax',
			'legal.pdfDocumentTitle' => 'Medoro — Məxfilik Siyasəti və İstifadə Şərtləri',
			'legal.pdfLoadError' => 'Sənəd yüklənmədi. İnternet bağlantınızı yoxlayıb yenidən cəhd edin.',
			'medications.title' => 'Dərmanlar',
			'medications.editMedication' => 'Dərmanı redaktə et',
			'medications.name' => 'Ad',
			'medications.dosage' => 'Dozaj',
			'medications.notes' => 'Qeydlər',
			'medications.form' => 'Forma',
			'medications.formPill' => 'Həb',
			'medications.formCapsule' => 'Kapsul',
			'medications.formLiquid' => 'Maye',
			'medications.formInjection' => 'İnyeksiya',
			'medications.formOther' => 'Digər',
			'medications.schedule' => 'Qəbul cədvəli',
			'medications.times' => 'Qəbul vaxtları',
			'medications.addTime' => 'Vaxt əlavə et',
			'medications.daysOfWeek' => 'Həftənin günləri',
			'medications.everyDay' => 'Hər gün',
			'medications.startDate' => 'Başlama tarixi',
			'medications.endDate' => 'Bitmə tarixi',
			'medications.save' => 'Yadda saxla',
			'medications.delete' => 'Sil',
			'medications.deleteConfirmTitle' => 'Dərmanı sil',
			'medications.deleteConfirmBody' => 'Bu dərmanı silmək istədiyinizə əminsiniz? Qəbul tarixçəsi saxlanılacaq.',
			'medications.emptyTitle' => 'Hələ dərman yoxdur',
			'medications.emptySubtitle' => 'Həkiminizin təyin etdiyi dərmanlar qəbuldan sonra burada görünəcək.',
			'medications.todaysDoses' => 'Bu günkü qəbullar',
			'medications.markTaken' => 'Qəbul edildi',
			'medications.markSkipped' => 'Buraxıldı',
			'medications.statusTaken' => 'Qəbul edildi',
			'medications.statusSkipped' => 'Buraxıldı',
			'medications.statusPending' => 'Gözləyir',
			'medications.reminderTitle' => ({required Object name}) => '${name} qəbul etmə vaxtıdır',
			'medications.reminderBody' => ({required Object dosage}) => 'Doza: ${dosage}',
			'medications.tabActive' => 'Aktiv',
			'medications.tabArchive' => 'Arxiv',
			'medications.fromPrescription' => 'Resept üzrə',
			'medications.noSchedule' => 'Cədvəl təyin edilməyib — xatırlatma vaxtı əlavə etmək üçün toxunun',
			'medications.dayMon' => 'B.e',
			'medications.dayTue' => 'Ç.a',
			'medications.dayWed' => 'Ç',
			'medications.dayThu' => 'C.a',
			'medications.dayFri' => 'C',
			'medications.daySat' => 'Ş',
			'medications.daySun' => 'B',
			'medications.updatedSuccess' => 'Dərman yeniləndi.',
			'medications.deletedSuccess' => 'Dərman silindi.',
			'medications.atLeastOneTime' => 'Ən azı bir xatırlatma vaxtı əlavə edin',
			'prescriptions.title' => 'Reseptlər',
			'prescriptions.writeTitle' => 'Resept yaz',
			'prescriptions.addDrug' => 'Dərman əlavə et',
			'prescriptions.drugName' => 'Dərmanın adı',
			'prescriptions.dosage' => 'Dozaj',
			'prescriptions.frequency' => 'Qəbul tezliyi',
			'prescriptions.duration' => 'Müddət',
			'prescriptions.instructions' => 'Təlimatlar',
			'prescriptions.notes' => 'Qeydlər',
			'prescriptions.save' => 'Yadda saxla',
			'prescriptions.empty' => 'Hələ resept yoxdur',
			'prescriptions.emptySubtitle' => 'Həkiminizin yazdığı reseptlər burada görünəcək.',
			'prescriptions.viewDetails' => 'Ətraflı',
			'prescriptions.issuedBy' => ({required Object name}) => 'Dr. ${name} tərəfindən yazılıb',
			'prescriptions.issuedOn' => ({required Object date}) => 'Verilmə tarixi: ${date}',
			'prescriptions.applyToMedications' => 'Dərmanlarıma əlavə et',
			'prescriptions.applySuccess' => 'Dərmanlarınıza əlavə edildi. Xatırlatma vaxtlarını təyin edin.',
			'prescriptions.alreadyApplied' => 'Artıq dərmanlarınıza əlavə edilib',
			'prescriptions.noPrescriptionYet' => 'Bu qəbul üçün hələ resept yazılmayıb',
			'prescriptions.writePrescription' => 'Resept yaz',
			'prescriptions.prescriptionIssued' => 'Resept yazıldı.',
			'prescriptions.removeDrug' => 'Sil',
			'prescriptions.atLeastOneDrug' => 'Ən azı bir dərman əlavə edin',
			'prescriptions.drugNameRequired' => 'Dərmanın adını daxil edin',
			'prescriptions.summaryTitle' => 'Resept',
			'prescriptions.itemsCount' => ({required Object count}) => '${count} dərman',
			'prescriptions.newPrescription' => 'Yeni resept',
			'prescriptions.youHavePrescription' => 'Bu qəbul üçün resept mövcuddur',
			'records.title' => 'Tibbi sənədlər',
			'records.upload' => 'Sənəd yüklə',
			'records.recordType' => 'Sənəd növü',
			'records.typeLabResult' => 'Analiz nəticəsi',
			'records.typeImaging' => 'Görüntüləmə',
			'records.typeDocument' => 'Sənəd',
			'records.typeOther' => 'Digər',
			'records.recordTitle' => 'Başlıq',
			'records.recordDate' => 'Tarix',
			'records.notes' => 'Qeydlər',
			'records.chooseFile' => 'Fayl seç',
			'records.changeFile' => 'Faylı dəyiş',
			'records.noFileChosen' => 'Fayl seçilməyib',
			'records.save' => 'Yadda saxla',
			'records.delete' => 'Sil',
			'records.deleteConfirmTitle' => 'Sənədi sil',
			'records.deleteConfirmBody' => 'Bu sənədi silmək istədiyinizə əminsiniz? Bu geri qaytarıla bilməz.',
			'records.empty' => 'Hələ tibbi sənəd yoxdur',
			'records.emptySubtitle' => 'Analiz nəticələrini, görüntüləri və digər sənədləri bir yerdə saxlayın.',
			'records.view' => 'Bax',
			'records.fileRequired' => 'Yükləmək üçün fayl seçin',
			'records.fileTooLarge' => 'Fayl həddindən artıq böyükdür (maks. 15 MB)',
			'records.titleRequired' => 'Başlıq tələb olunur',
			'records.uploadSuccess' => 'Sənəd yükləndi.',
			'records.deletedSuccess' => 'Sənəd silindi.',
			'records.couldNotOpen' => 'Fayl açılmadı',
			'payments.title' => 'Ödəniş',
			'payments.amount' => 'Məbləğ',
			'payments.payNow' => 'İndi ödə',
			'payments.payLater' => 'Sonra ödə',
			'payments.statusPending' => 'Ödəniş gözlənilir',
			'payments.statusPaid' => 'Ödənilib',
			'payments.statusFailed' => 'Ödəniş uğursuz oldu',
			'payments.statusCancelled' => 'Ləğv edilib',
			'payments.statusRefunded' => 'Geri qaytarıldı',
			'payments.statusRefundFailed' => 'Geri ödəmə uğursuz oldu',
			'payments.paymentConfirmed' => 'Ödəniş təsdiqləndi. Təşəkkür edirik!',
			'payments.openingBrowser' => 'Brauzer açılır…',
			'payments.checkStatus' => 'Statusu yoxla',
			'family.title' => 'Ailə',
			'family.myself' => 'Özüm',
			'family.addFamilyMember' => 'Ailə üzvü əlavə et',
			'family.editFamilyMember' => 'Ailə üzvünü redaktə et',
			'family.firstName' => 'Ad',
			'family.lastName' => 'Soyad',
			'family.relationship' => 'Qohumluq',
			'family.relationshipChild' => 'Övlad',
			'family.relationshipSpouse' => 'Həyat yoldaşı',
			'family.relationshipParent' => 'Valideyn',
			'family.relationshipSibling' => 'Bacı/qardaş',
			'family.relationshipOther' => 'Digər',
			'family.dateOfBirth' => 'Doğum tarixi',
			'family.bloodType' => 'Qan qrupu',
			'family.allergies' => 'Allergiyalar',
			'family.chronicConditions' => 'Xroniki xəstəliklər',
			'family.medications' => 'Cari dərmanlar',
			'family.save' => 'Yadda saxla',
			'family.delete' => 'Sil',
			'family.deleteConfirmTitle' => 'Ailə üzvünü sil',
			'family.deleteConfirmBody' => 'Bu ailə üzvünü silmək istədiyinizə əminsiniz? Qəbul, dərman və sənəd tarixçəsi saxlanılacaq.',
			'family.empty' => 'Hələ ailə üzvü yoxdur',
			'family.emptySubtitle' => 'Görüşlərini, dərmanlarını və sənədlərini idarə etmək üçün övladınızı, həyat yoldaşınızı və ya digər qohumunuzu əlavə edin.',
			'family.bookingForQuestion' => 'Bu qəbul kim üçündür?',
			'family.bookingForLabel' => ({required Object name}) => 'Qəbul kimin üçündür: ${name}',
			'family.forLabel' => ({required Object name}) => '${name} üçün',
			'family.ageYears' => ({required Object age}) => '${age} yaşında',
			'family.bookedByLabel' => ({required Object name}) => 'Qeyd edən: ${name}',
			'family.contactEmail' => 'Əlaqə e-poçtu',
			'family.contactEmailHelp' => 'Əlavə edildiklərini onlara bildirəcəyik və rədd etmək üçün asan bir yol təqdim edəcəyik.',
			'family.contactPhoneOptional' => 'Əlaqə telefonu (istəyə bağlı)',
			'family.contactEmailRequiredForAdult' => 'Bu ailə üzvünə bildiriş göndərə bilmək üçün e-poçt ünvanı tələb olunur',
			'family.adultConsentNotice' => '18 yaşdan böyük olduqları üçün onlara sizin tərəfinizdən əlavə edildiklərini bildirən e-poçt göndərəcəyik — tətbiqə ehtiyacları yoxdur və istənilən vaxt bu əlaqəni kəsə bilərlər.',
			'family.noticeAlreadySent' => 'Əlavə edildikləri barədə onlara bildiriş göndərdik. İstənilən vaxt bu əlaqəni kəsə bilərlər.',
			'family.noticePendingBadge' => 'Bildiriş göndərildi',
			'subscription.title' => 'Abunəlik',
			'subscription.planNameBasic' => 'Başlanğıc',
			'subscription.planNamePro' => 'Peşəkar',
			'subscription.couldNotLoad' => 'Abunəlik məlumatı yüklənmədi.',
			'subscription.nowActive' => 'Abunəliyiniz aktivləşdirildi!',
			'subscription.unavailable' => 'Abunəlik hazırda əlçatan deyil. Zəhmət olmasa sonra yenidən cəhd edin.',
			'subscription.trialDaysLeft' => ({required Object days}) => 'Pulsuz sınaq — ${days} gün qalıb',
			'subscription.graceDaysLeft' => ({required Object days}) => 'Güzəşt müddəti — yeniləmək üçün ${days} gün qalıb',
			'subscription.expiredNotice' => 'Abunəliyinizin müddəti bitib. Pasiyentlərə yenidən görünmək üçün abunə olun.',
			'subscription.activeNotice' => 'Abunəliyiniz aktivdir.',
			'subscription.choosePlan' => 'Başlamaq üçün plan seçin.',
			'subscription.currentPlan' => 'Cari Plan',
			'subscription.mostPopular' => 'Ən Populyar',
			'subscription.perMonth' => 'aylıq',
			'subscription.manageOnWeb' => 'Abunəliyinizi auxiodev.com saytında idarə edin',
			'subscription.featureUnlimitedWorkplaces' => 'Limitsiz klinika',
			'subscription.featureWorkplaces' => ({required Object count}) => '${count} klinikaya qədər',
			'subscription.featureUnlimitedBookings' => 'Aylıq limitsiz qeydiyyat',
			'subscription.featureBookingsPerMonth' => ({required Object count}) => 'Ayda ${count} qeydiyyata qədər',
			'subscription.featureChat' => 'Pasiyentlərlə çat',
			'subscription.featurePromoted' => 'Axtarışda prioritet + «Peşəkar» nişanı',
			'subscription.renew' => 'Yenilə',
			'subscription.subscribe' => 'Abunə ol',
			'subscription.planNameHospitalBasic' => 'Klinika',
			'subscription.planNameHospitalPro' => 'Klinika Plus',
			'subscription.featureDoctors' => ({required Object count}) => '${count} həkimə qədər',
			'subscription.featureUnlimitedDoctors' => 'Limitsiz həkim',
			'subscription.featureAdvancedStats' => 'Ətraflı statistika',
			'hospitalPicker.title' => 'Xəstəxana seçin',
			'hospitalPicker.searchHint' => 'Xəstəxananın adını axtarın…',
			'hospitalPicker.noResultsFound' => 'Xəstəxana tapılmadı',
			'hospitalPicker.selectCityFirst' => 'Əvvəlcə şəhəri seçin',
			'hospitalPicker.addVariant' => ({required Object name}) => '"${name}" əlavə et',
			'hospitalPicker.pendingReview' => 'Yoxlanılır',
			'hospitalRegistration.title' => 'Xəstəxana məlumatları',
			'hospitalRegistration.subtitle' => 'Şəhərinizi seçin, sonra xəstəxananızı siyahıdan tapın və ya əlavə edin.',
			'hospitalRegistration.cityStep' => '1. Şəhər',
			'hospitalRegistration.hospitalStep' => '2. Xəstəxana',
			'hospitalRegistration.searchHint' => 'Xəstəxananın adını axtarın…',
			'hospitalRegistration.noResultsFound' => 'Xəstəxana tapılmadı',
			'hospitalRegistration.notFoundPrompt' => 'Xəstəxananızı tapa bilmirsiniz?',
			'hospitalRegistration.addManually' => 'Əl ilə əlavə et',
			'hospitalRegistration.useSearchInstead' => 'Yenidən axtar',
			'hospitalRegistration.newHospitalName' => 'Xəstəxananın adı',
			'hospitalRegistration.selectedPrefix' => 'Seçildi:',
			'hospitalRegistration.pendingReviewNotice' => 'Yeni xəstəxanalar başqalarına görünməzdən əvvəl komandamız tərəfindən yoxlanılır.',
			'hospitalRegistration.submit' => 'Hesab yarat',
			'hospitalRegistration.hospitalRequired' => 'Davam etmək üçün xəstəxananızı seçin və ya əlavə edin',
			'hospitalHome.greeting' => ({required Object name}) => 'Salam, ${name}',
			'hospitalHome.subtitle' => 'Həkimlərinizi və qəbulları idarə edin',
			'hospitalHome.doctors' => 'Həkimlər',
			'hospitalHome.inviteDoctor' => 'Həkim dəvət et',
			'hospitalHome.appointments' => 'Qəbullar',
			'hospitalHome.profile' => 'Profil',
			'hospitalHome.pendingRequests' => ({required Object count}) => '${count} müraciət gözləyir',
			'hospitalDoctors.title' => 'Həkimlər',
			'hospitalDoctors.tabConfirmed' => 'Təsdiqlənmiş',
			'hospitalDoctors.tabRequests' => 'Müraciətlər',
			'hospitalDoctors.tabInvited' => 'Dəvət olunmuş',
			'hospitalDoctors.noConfirmedDoctors' => 'Hələ təsdiqlənmiş həkim yoxdur',
			'hospitalDoctors.noRequests' => 'Gözləyən müraciət yoxdur',
			'hospitalDoctors.noInvited' => 'Gözləyən dəvət yoxdur',
			'hospitalDoctors.approve' => 'Təsdiqlə',
			'hospitalDoctors.reject' => 'Rədd et',
			'hospitalDoctors.remove' => 'Sil',
			'hospitalDoctors.removeConfirmTitle' => 'Həkim silinsin?',
			'hospitalDoctors.removeConfirmMessage' => ({required Object name}) => '${name} artıq xəstəxananızla əlaqəli olmayacaq. Bu, onun iş yerinə və qəbullarına təsir etməyəcək.',
			'hospitalDoctors.requestedToJoin' => 'Qoşulmaq üçün müraciət edib',
			'hospitalDoctors.invitedAwaiting' => 'Dəvət olunub — cavab gözlənilir',
			'hospitalDoctors.editHours' => 'Saatları dəyiş',
			'hospitalInvite.title' => 'Həkim dəvət et',
			'hospitalInvite.searchHint' => 'Ad və ya ixtisas üzrə axtarın…',
			'hospitalInvite.noResultsFound' => 'Həkim tapılmadı',
			'hospitalInvite.invite' => 'Dəvət et',
			'hospitalInvite.invited' => 'Dəvət olunub',
			'hospitalAppointments.title' => 'Qəbullar',
			'hospitalAppointments.empty' => 'Hələ qəbul yoxdur',
			'hospitalProfile.title' => 'Xəstəxana profili',
			'hospitalProfile.usageDoctors' => ({required Object limit, required Object count}) => '${limit} həkimdən ${count}',
			'hospitalProfile.usageDoctorsUnlimited' => ({required Object count}) => '${count} həkim (limitsiz)',
			'hospitalProfile.manageSubscription' => 'Abunəliyi idarə et',
			'hospitalDoctorHours.title' => 'İş saatları',
			'hospitalDoctorHours.selectWorkplace' => 'İş yerini seçin',
			'hospitalDoctorHours.saved' => 'Saatlar saxlanıldı',
			'doctorHospitals.title' => 'Xəstəxanalarım',
			'doctorHospitals.tabInvitations' => 'Dəvətlər',
			'doctorHospitals.tabRequests' => 'Müraciətlər',
			'doctorHospitals.tabConfirmed' => 'Xəstəxanalar',
			'doctorHospitals.noInvitations' => 'Gözləyən dəvət yoxdur',
			'doctorHospitals.noRequests' => 'Gözləyən müraciət yoxdur',
			'doctorHospitals.noConfirmed' => 'Hələ heç bir xəstəxana ilə əlaqəniz yoxdur',
			'doctorHospitals.accept' => 'Qəbul et',
			'doctorHospitals.decline' => 'Rədd et',
			'doctorHospitals.cancelRequest' => 'Müraciəti ləğv et',
			'doctorHospitals.invitedYouToJoin' => 'Sizi qoşulmağa dəvət etdi',
			'doctorHospitals.awaitingApproval' => 'Xəstəxananın təsdiqini gözləyir',
			_ => null,
		};
	}
}
