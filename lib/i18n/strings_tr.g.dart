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
class TranslationsTr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.tr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <tr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsTr _root = this; // ignore: unused_field

	@override 
	TranslationsTr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsTr(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'DocLine';
	@override late final _Translations$common$tr common = _Translations$common$tr._(_root);
	@override late final _Translations$auth$tr auth = _Translations$auth$tr._(_root);
	@override late final _Translations$forgotPassword$tr forgotPassword = _Translations$forgotPassword$tr._(_root);
	@override late final _Translations$resetPassword$tr resetPassword = _Translations$resetPassword$tr._(_root);
	@override late final _Translations$verifyPhone$tr verifyPhone = _Translations$verifyPhone$tr._(_root);
	@override late final _Translations$socialComplete$tr socialComplete = _Translations$socialComplete$tr._(_root);
	@override late final _Translations$validation$tr validation = _Translations$validation$tr._(_root);
	@override late final _Translations$errors$tr errors = _Translations$errors$tr._(_root);
	@override late final _Translations$settings$tr settings = _Translations$settings$tr._(_root);
	@override late final _Translations$security$tr security = _Translations$security$tr._(_root);
	@override late final _Translations$status$tr status = _Translations$status$tr._(_root);
	@override late final _Translations$home$tr home = _Translations$home$tr._(_root);
	@override late final _Translations$appointments$tr appointments = _Translations$appointments$tr._(_root);
	@override late final _Translations$booking$tr booking = _Translations$booking$tr._(_root);
	@override late final _Translations$doctorSearch$tr doctorSearch = _Translations$doctorSearch$tr._(_root);
	@override late final _Translations$doctorDetail$tr doctorDetail = _Translations$doctorDetail$tr._(_root);
	@override late final _Translations$profile$tr profile = _Translations$profile$tr._(_root);
	@override late final _Translations$notifications$tr notifications = _Translations$notifications$tr._(_root);
	@override late final _Translations$workplaces$tr workplaces = _Translations$workplaces$tr._(_root);
	@override late final _Translations$addWorkplace$tr addWorkplace = _Translations$addWorkplace$tr._(_root);
	@override late final _Translations$workingHours$tr workingHours = _Translations$workingHours$tr._(_root);
	@override late final _Translations$blockTime$tr blockTime = _Translations$blockTime$tr._(_root);
	@override late final _Translations$onboarding$tr onboarding = _Translations$onboarding$tr._(_root);
	@override late final _Translations$pendingVerification$tr pendingVerification = _Translations$pendingVerification$tr._(_root);
	@override late final _Translations$phoneField$tr phoneField = _Translations$phoneField$tr._(_root);
	@override late final _Translations$locations$tr locations = _Translations$locations$tr._(_root);
	@override late final _Translations$splash$tr splash = _Translations$splash$tr._(_root);
	@override late final _Translations$appIntro$tr appIntro = _Translations$appIntro$tr._(_root);
	@override late final _Translations$agenda$tr agenda = _Translations$agenda$tr._(_root);
	@override late final _Translations$favorites$tr favorites = _Translations$favorites$tr._(_root);
	@override late final _Translations$assistant$tr assistant = _Translations$assistant$tr._(_root);
	@override late final _Translations$messaging$tr messaging = _Translations$messaging$tr._(_root);
	@override late final _Translations$legal$tr legal = _Translations$legal$tr._(_root);
	@override late final _Translations$medications$tr medications = _Translations$medications$tr._(_root);
	@override late final _Translations$prescriptions$tr prescriptions = _Translations$prescriptions$tr._(_root);
	@override late final _Translations$records$tr records = _Translations$records$tr._(_root);
	@override late final _Translations$payments$tr payments = _Translations$payments$tr._(_root);
	@override late final _Translations$family$tr family = _Translations$family$tr._(_root);
	@override late final _Translations$subscription$tr subscription = _Translations$subscription$tr._(_root);
	@override late final _Translations$hospitalPicker$tr hospitalPicker = _Translations$hospitalPicker$tr._(_root);
	@override late final _Translations$hospitalRegistration$tr hospitalRegistration = _Translations$hospitalRegistration$tr._(_root);
	@override late final _Translations$hospitalHome$tr hospitalHome = _Translations$hospitalHome$tr._(_root);
	@override late final _Translations$hospitalDoctors$tr hospitalDoctors = _Translations$hospitalDoctors$tr._(_root);
	@override late final _Translations$hospitalInvite$tr hospitalInvite = _Translations$hospitalInvite$tr._(_root);
	@override late final _Translations$hospitalAppointments$tr hospitalAppointments = _Translations$hospitalAppointments$tr._(_root);
	@override late final _Translations$hospitalProfile$tr hospitalProfile = _Translations$hospitalProfile$tr._(_root);
	@override late final _Translations$hospitalDoctorHours$tr hospitalDoctorHours = _Translations$hospitalDoctorHours$tr._(_root);
	@override late final _Translations$doctorHospitals$tr doctorHospitals = _Translations$doctorHospitals$tr._(_root);
	@override late final _Translations$share$tr share = _Translations$share$tr._(_root);
	@override late final _Translations$hospitalDetail$tr hospitalDetail = _Translations$hospitalDetail$tr._(_root);
}

// Path: common
class _Translations$common$tr extends Translations$common$en {
	_Translations$common$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'İptal';
	@override String get logout => 'Çıkış Yap';
	@override String get doctor => 'Doktor';
	@override String get patient => 'Hasta';
	@override String get save => 'Kaydet';
	@override String get edit => 'Düzenle';
	@override String get retry => 'Tekrar dene';
	@override String get back => 'Geri';
	@override String get ok => 'Tamam';
	@override String get delete => 'Sil';
	@override String get keep => 'Vazgeç';
	@override String get confirm => 'Onayla';
	@override String get decline => 'Reddet';
	@override String get primary => 'Birincil';
	@override String get somethingWrong => 'Bir şeyler ters gitti';
	@override String get seeAll => 'Tümünü gör';
	@override String get signOut => 'Çıkış Yap';
	@override String get search => 'Ara';
	@override String get tryAgain => 'Lütfen tekrar deneyin';
	@override String get required => 'Gerekli';
	@override String get noRatings => 'Henüz değerlendirme yok';
	@override String get hospital => 'Hastane';
}

// Path: auth
class _Translations$auth$tr extends Translations$auth$en {
	_Translations$auth$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get login => 'Giriş Yap';
	@override String get register => 'Hesap Oluştur';
	@override String get signIn => 'Giriş Yap';
	@override String get signUp => 'Kayıt Ol';
	@override String get password => 'Şifre';
	@override String get confirmPassword => 'Şifreyi Onayla';
	@override String get firstName => 'Ad';
	@override String get lastName => 'Soyad';
	@override String get rememberMe => 'Beni hatırla';
	@override String get forgotPassword => 'Şifrenizi mi unuttunuz?';
	@override String get sendResetLink => 'Sıfırlama Kodu Gönder';
	@override String get noAccount => 'Hesabınız yok mu?';
	@override String get haveAccount => 'Zaten hesabınız var mı?';
	@override String get welcomeBack => 'Tekrar hoş geldiniz';
	@override String get signInToContinue => 'Devam etmek için hesabınıza giriş yapın';
	@override String get createYourAccount => 'Hesabınızı oluşturun';
	@override String get joinMedalize => 'Bugün DocLine\'ya katılın';
	@override String get iAmA => 'Ben bir';
	@override String get passwordHint => '••••••••';
	@override String get backToSignIn => 'Girişe dön';
	@override String get verificationCode => 'Doğrulama kodu';
	@override String get continueWithGoogle => 'Google ile devam et';
	@override String get continueWithApple => 'Apple ile devam et';
	@override String get orDivider => 'veya';
}

// Path: forgotPassword
class _Translations$forgotPassword$tr extends Translations$forgotPassword$en {
	_Translations$forgotPassword$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Şifrenizi mi unuttunuz?';
	@override String get subtitle => 'Telefon numaranızı girin, size 6 haneli bir sıfırlama kodu gönderelim';
}

// Path: resetPassword
class _Translations$resetPassword$tr extends Translations$resetPassword$en {
	_Translations$resetPassword$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Şifreyi Sıfırla';
	@override String get subtitle => 'Telefonunuza gönderilen kodu girin ve yeni bir şifre seçin';
	@override String get button => 'Şifreyi Sıfırla';
	@override String get success => 'Şifre başarıyla sıfırlandı. Lütfen giriş yapın.';
}

// Path: verifyPhone
class _Translations$verifyPhone$tr extends Translations$verifyPhone$en {
	_Translations$verifyPhone$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Telefon Numaranızı Doğrulayın';
	@override String subtitle({required Object phone}) => '${phone} numarasına 6 haneli bir kod gönderdik';
	@override String get button => 'Doğrula';
	@override String get resend => 'Kodu tekrar gönder';
	@override String get resendSent => 'Yeni bir kod gönderildi.';
}

// Path: socialComplete
class _Translations$socialComplete$tr extends Translations$socialComplete$en {
	_Translations$socialComplete$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neredeyse tamam';
	@override String get subtitle => 'Hesabınızı oluşturmayı tamamlamak için bir telefon numarası girin ve doğrulayın.';
	@override String get button => 'Devam et';
}

// Path: validation
class _Translations$validation$tr extends Translations$validation$en {
	_Translations$validation$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => 'E-posta gerekli';
	@override String get emailInvalid => 'Geçerli bir e-posta adresi girin';
	@override String get passwordRequired => 'Şifre gerekli';
	@override String get passwordTooShort => 'En az 8 karakter gerekli';
	@override String get passwordNeedsLetter => 'En az bir harf ekleyin';
	@override String get passwordNeedsDigit => 'En az bir rakam ekleyin';
	@override String get passwordMismatch => 'Şifreler eşleşmiyor';
	@override String get passwordConfirmRequired => 'Lütfen şifrenizi onaylayın';
	@override String get nameMinLength => 'En az 2 karakter olmalı';
	@override String get roleRequired => 'Lütfen bir rol seçin';
	@override String get phoneRequired => 'Telefon numarası gerekli';
	@override String get phoneTooShort => 'Numara çok kısa';
	@override String get phoneTooLong => 'Numara çok uzun';
	@override String fieldRequired({required Object field}) => '${field} gerekli';
	@override String fieldInvalid({required Object field}) => '${field} geçersiz karakterler içeriyor';
}

// Path: errors
class _Translations$errors$tr extends Translations$errors$en {
	_Translations$errors$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get network => 'Ağ hatası. Bağlantınızı kontrol edin.';
	@override String get rateLimit => 'Çok fazla deneme. Lütfen bekleyip tekrar deneyin.';
	@override String rateLimitWithSeconds({required Object seconds}) => 'Çok fazla deneme. ${seconds} saniye sonra tekrar deneyin.';
	@override String get invalidCredentials => 'Geçersiz telefon numarası veya şifre';
	@override String get sessionExpired => 'Oturum süresi doldu. Lütfen tekrar giriş yapın.';
	@override String get authError => 'Kimlik doğrulama hatası. Lütfen tekrar giriş yapın.';
	@override String get sessionRevoked => 'Oturum iptal edildi. Lütfen tekrar giriş yapın.';
	@override String get permissionDenied => 'Bunu yapma izniniz yok.';
	@override String get validationError => 'Doğrulama hatası';
	@override String serverError({required Object code}) => 'Sunucu hatası (${code}). Lütfen tekrar deneyin.';
	@override String get socialLoginFailed => 'Giriş başarısız oldu. Tekrar deneyin veya telefon numaranızı ve şifrenizi kullanın.';
	@override String get conflict => 'Bu işlem şu anda tamamlanamıyor.';
	@override String get onboardingIncomplete => 'Kaydı tamamlamak için lütfen tüm zorunlu alanları doldurun.';
	@override String get planLimitReached => 'Plan limitinize ulaştınız. Daha fazlası için planınızı yükseltin.';
	@override String get chatUnavailable => 'Bu hekim mevcut planında sohbet sunmuyor.';
	@override String get phoneNotVerified => 'Giriş yapmadan önce lütfen telefon numaranızı doğrulayın.';
}

// Path: settings
class _Translations$settings$tr extends Translations$settings$en {
	_Translations$settings$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ayarlar';
	@override String get account => 'Hesap';
	@override String get profile => 'Profil';
	@override String get notifications => 'Bildirimler';
	@override String get appearance => 'Görünüm';
	@override String get themeSystem => 'Sistem';
	@override String get themeLight => 'Açık';
	@override String get themeDark => 'Koyu';
	@override String get language => 'Dil';
	@override String get languageSystem => 'Sistem varsayılanı';
	@override String get logoutTitle => 'Çıkış';
	@override String get logoutConfirm => 'Çıkış yapmak istediğinizden emin misiniz?';
	@override String get version => 'DocLine v1.0.0';
	@override String get legal => 'Gizlilik ve Koşullar';
}

// Path: security
class _Translations$security$tr extends Translations$security$en {
	_Translations$security$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Güvenlik';
	@override String get biometricLogin => 'Biyometrik Giriş';
	@override String get biometricLoginSubtitle => 'Uygulamanın kilidini açmak için Face ID / Touch ID kullanın';
	@override String get biometricPrompt => 'DocLine\'ya erişmek için doğrulayın';
	@override String get biometricUnavailable => 'Bu cihazda biyometrik kimlik doğrulama kullanılamıyor';
	@override String get biometricEnableFailed => 'Biyometrik bilgileriniz doğrulanamadı. Tekrar deneyin.';
	@override String get activeSessions => 'Aktif Oturumlar';
	@override String get activeSessionsSubtitle => 'Hesabınıza şu anda giriş yapmış cihazlar';
	@override String get thisDevice => 'Bu cihaz';
	@override String lastActive({required Object date}) => 'Son aktif: ${date}';
	@override String get revoke => 'İptal Et';
	@override String get revokeConfirmTitle => 'Cihaz iptal edilsin mi?';
	@override String revokeConfirmMessage({required Object name}) => '${name} oturumu kapatılacak. Hesap bilgileriyle tekrar giriş yapabilir.';
	@override String get revokeCurrentConfirmMessage => 'Bu sizin mevcut cihazınız — iptal ederseniz hemen çıkış yaparsınız.';
	@override String get revokeFailed => 'Bu cihaz iptal edilemedi. Tekrar deneyin.';
	@override String get signOutAllDevices => 'Tüm cihazlardan çıkış yap';
	@override String get signOutAllConfirmTitle => 'Her yerden çıkış yapılsın mı?';
	@override String get signOutAllConfirmMessage => 'Bu cihaz dahil tüm cihazlarda oturumunuz kapatılacak.';
	@override String get signOutAllFailed => 'Tüm cihazlardan çıkış yapılamadı. Tekrar deneyin.';
	@override String get noDevices => 'Aktif oturum bulunamadı';
	@override String get loadFailed => 'Aktif oturumlarınız yüklenemedi';
	@override String get changePhone => 'Telefon Numarasını Değiştir';
	@override String get changePhoneSubtitle => 'Yeni telefon numaranıza bir doğrulama kodu göndereceğiz. Onayladıktan sonra yeni numarayla giriş yapacaksınız.';
	@override String get sendCode => 'Kod Gönder';
	@override String codeSentTo({required Object phone}) => '${phone} numarasına gönderdiğimiz 6 haneli kodu girin';
	@override String get confirmNewPhone => 'Yeni Numarayı Onayla';
	@override String get changePhoneSuccess => 'Telefon numaranız değiştirildi. Yeni numaranızla tekrar giriş yapın.';
	@override String get dangerZone => 'Tehlikeli Bölge';
	@override String get deactivateAccount => 'Hesabı Devre Dışı Bırak';
	@override String get deactivateAccountSubtitle => 'Verilerinizi silmeden hesabınızı devre dışı bırakın';
	@override String get deactivateConfirmTitle => 'Hesap devre dışı bırakılsın mı?';
	@override String get deactivateConfirmMessage => 'Hesabınız devre dışı bırakılacak ve tüm cihazlarda oturumunuz kapatılacak. Verileriniz silinmez. Yeniden etkinleştirmek için destek ekibiyle iletişime geçin.';
	@override String get deactivate => 'Devre Dışı Bırak';
	@override String get deactivateSuccess => 'Hesabınız devre dışı bırakıldı.';
	@override String get deleteAccount => 'Hesabı Kalıcı Olarak Sil';
	@override String get deleteAccountSubtitle => 'Verilerinizi silin. Bu işlem geri alınamaz.';
	@override String get deleteConfirmTitle => 'Hesabınız kalıcı olarak silinsin mi?';
	@override String get deleteConfirmWarning => 'Bu işlem kalıcıdır ve geri alınamaz.';
	@override String get deleteConfirmMessage => 'Profiliniz, tıbbi kayıtlarınız, reçeteleriniz ve mesajlarınız kalıcı olarak silinecek. Yaklaşan randevularınız iptal edilecek ve uygun olduğunda ücret iadesi yapılacaktır. Ödeme kayıtları, kanunen gerekli muhasebe amaçları için anonimleştirilmiş biçimde saklanır.';
	@override String get deleteAccountSuccess => 'Hesabınız kalıcı olarak silindi.';
}

// Path: status
class _Translations$status$tr extends Translations$status$en {
	_Translations$status$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'Onaylandı';
	@override String get pending => 'Beklemede';
	@override String get cancelled => 'İptal edildi';
	@override String get declined => 'Reddedildi';
	@override String get requiresRescheduling => 'Yeniden planlanmalı';
	@override String get completed => 'Tamamlandı';
	@override String get noShow => 'Gelmedi';
}

// Path: home
class _Translations$home$tr extends Translations$home$en {
	_Translations$home$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String helloDoctor({required Object name}) => 'Merhaba, Dr. ${name}!';
	@override String helloPatient({required Object name}) => 'Merhaba, ${name}!';
	@override String get doctorSubtitle => 'Programınızı ve\nrandevularınızı yönetin.';
	@override String get patientSubtitle => 'Bir doktor bulun ve\nrandevu alın.';
	@override String get pendingRequests => 'Bekleyen İstekler';
	@override String get upcoming => 'Yaklaşan';
	@override String get findDoctor => 'Doktor Bul';
	@override String get aiAssistant => 'AI Asistan';
	@override String get myAppointments => 'Randevularım';
	@override String get appointments => 'Randevular';
	@override String get workplaces => 'İş Yerleri';
	@override String get blockTime => 'Zamanı Engelle';
	@override String get profile => 'Profil';
	@override String get allCaughtUp => 'Her şey güncel';
	@override String get noPendingRequests => 'Bekleyen randevu isteği yok';
	@override String get couldNotLoadAppointments => 'Randevular yüklenemedi';
	@override String get noUpcoming => 'Yaklaşan randevu yok';
	@override String get bookFirst => 'Bir doktorla ilk randevunuzu alın';
	@override String get findADoctor => 'Doktor Bul';
	@override String get myWaitlist => 'Bekleme Listem';
	@override String get leaveWaitlist => 'Ayrıl';
	@override String get statsThisMonth => 'Bu ay';
	@override String get statsPatients => 'Hastalar';
	@override String get statsAcceptRate => 'Kabul oranı';
	@override String get statsPending => 'Bekleyenler';
	@override String get schedule => 'Takvim';
}

// Path: appointments
class _Translations$appointments$tr extends Translations$appointments$en {
	_Translations$appointments$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Randevular';
	@override String get myTitle => 'Randevularım';
	@override String get tabPending => 'Bekleyen';
	@override String get tabAll => 'Tümü';
	@override String get tabUpcoming => 'Yaklaşan';
	@override String get tabPast => 'Geçmiş';
	@override String get noPendingRequests => 'Bekleyen istek yok';
	@override String get newRequestsAppear => 'Yeni randevu istekleri burada görünecek';
	@override String get noAppointments => 'Randevu yok';
	@override String get appointmentsAppear => 'Randevularınız burada görünecek';
	@override String get noUpcoming => 'Yaklaşan randevu yok';
	@override String get bookFirst => 'Bir doktorla ilk randevunuzu alın';
	@override String get noPast => 'Geçmiş randevu yok';
	@override String get pastAppear => 'Tamamlanan ve iptal edilen randevular burada görünür';
	@override String get couldNotLoad => 'Randevular yüklenemedi';
	@override String get detailTitle => 'Randevu';
	@override String get patient => 'Hasta';
	@override String get doctor => 'Doktor';
	@override String get workplace => 'İş Yeri';
	@override String get dateTime => 'Tarih ve Saat';
	@override String get reason => 'Sebep';
	@override String get doctorNotes => 'Doktor Notları';
	@override String get cancelTitle => 'Randevuyu İptal Et';
	@override String get cancelConfirm => 'Bu randevuyu iptal etmek istediğinizden emin misiniz?';
	@override String get cancelAction => 'Randevuyu İptal Et';
	@override String get cancelledSuccess => 'Randevu iptal edildi.';
	@override String get cancelledRefunded => 'Randevu iptal edildi. Ödemeniz iade edildi.';
	@override String get cancelledNoRefund => 'Randevu iptal edildi. Randevu saatine çok yakın olduğu için iade yapılmadı.';
	@override String get bookedTitle => 'Randevu alındı!';
	@override String get bookedMessage => 'Randevu isteğiniz gönderildi.';
	@override String get reschedule => 'Yeniden planla';
	@override String get rescheduleTitle => 'Randevuyu yeniden planla';
	@override String get reviewTitle => 'Yorum yaz';
	@override String get reviewRating => 'Puan';
	@override String get reviewComment => 'Yorum (isteğe bağlı)';
	@override String get reviewSubmit => 'Gönder';
	@override String get markCompleted => 'Tamamlandı olarak işaretle';
	@override String get rescheduledSuccess => 'Randevu başarıyla yeniden planlandı.';
	@override String get reviewSubmitted => 'Değerlendirme gönderildi. Teşekkürler!';
	@override String get yourReview => 'Değerlendirmeniz';
	@override String get editReviewTitle => 'Değerlendirmeyi Düzenle';
	@override String get reviewUpdated => 'Değerlendirme güncellendi.';
	@override String get deleteReviewTitle => 'Değerlendirmeyi Sil';
	@override String get deleteReviewConfirm => 'Değerlendirmenizi silmek istediğinizden emin misiniz?';
	@override String get reviewDeleted => 'Değerlendirme silindi.';
	@override String get requestReschedule => 'Yeniden Planlama İste';
	@override String get requestRescheduleTitle => 'Yeniden Planlama';
	@override String get requestRescheduleConfirm => 'Hastadan yeni bir saat seçmesini isteyin mi? Randevu yeniden planlama gerektiriyor olarak işaretlenecek.';
	@override String get requestRescheduleSuccess => 'Yeniden planlama istendi. Hasta bilgilendirilecek.';
	@override String get rescheduleNeededHint => 'Doktor yeni bir saat seçmenizi istedi.';
	@override String get markNoShow => 'Gelmedi İşaretle';
	@override String get markNoShowTitle => 'Gelmedi Olarak İşaretle';
	@override String get markNoShowConfirm => 'Bu randevuyu gelmedi olarak işaretleyelim mi? Hastanın gelmediği kaydedilir.';
	@override String get disputeNoShow => 'İtiraz et';
	@override String get disputeNoShowTitle => 'Gelmedi kaydına itiraz';
	@override String get disputeNoShowHint => 'Bunun neden hatalı işaretlendiğini düşündüğünüzü bize bildirin — destek ekibimiz inceleyecek.';
	@override String get disputeNoShowSubmit => 'Gönder';
	@override String get disputeNoShowSubmitted => 'İtirazınız gönderildi. İnceleyip sizinle iletişime geçeceğiz.';
	@override String get disputeNoShowOpen => 'İtiraz gönderildi — inceleniyor';
}

// Path: booking
class _Translations$booking$tr extends Translations$booking$en {
	_Translations$booking$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String bookWith({required Object name}) => 'Randevu — ${name}';
	@override String get selectWorkplace => 'İş Yeri Seçin';
	@override String get pickDate => 'Tarih seçin';
	@override String get slotsAppear => 'Uygun zaman aralıkları burada görünecek';
	@override String get couldNotLoadSlots => 'Zaman aralıkları yüklenemedi';
	@override String get noAvailableSlots => 'Uygun zaman aralığı yok';
	@override String get noOpenSlots => 'Bu tarih için boş zaman yok. Başka bir gün deneyin.';
	@override String get confirmTitle => 'Randevuyu Onayla';
	@override String get reasonForVisit => 'Ziyaret sebebi (isteğe bağlı)';
	@override String get confirmButton => 'Randevuyu Onayla';
	@override String get doctorLabel => 'Doktor';
	@override String get workplaceLabel => 'İş Yeri';
	@override String get addressLabel => 'Adres';
	@override String get startLabel => 'Başlangıç';
	@override String get endLabel => 'Bitiş';
	@override String get tryDifferentDate => 'Farklı bir tarih deneyin';
	@override String get earliestPreselected => 'En yakın uygun zaman önceden seçildi';
	@override String continueAt({required Object time}) => 'Devam et — ${time}';
}

// Path: doctorSearch
class _Translations$doctorSearch$tr extends Translations$doctorSearch$en {
	_Translations$doctorSearch$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Doktor Bul';
	@override String get searchByName => 'İsme göre ara...';
	@override String get city => 'Şehir';
	@override String get search => 'Ara';
	@override String get noDoctorsFound => 'Doktor bulunamadı';
	@override String get adjustSearch => 'Aramanızı veya filtrelerinizi değiştirmeyi deneyin';
	@override String get couldNotLoadDoctors => 'Doktorlar yüklenemedi';
	@override String get loadMore => 'Daha fazla göster';
	@override late final _Translations$doctorSearch$spec$tr spec = _Translations$doctorSearch$spec$tr._(_root);
	@override String get noAvailability => 'Uygunluk yok';
	@override String get availableToday => 'Bugün müsait';
	@override String get availableTomorrow => 'Yarın müsait';
	@override String availableOn({required Object date}) => '${date} müsait';
	@override String get sortBy => 'Sırala';
	@override String get sortDefault => 'İlgi';
	@override String get sortRating => 'En yüksek puan';
	@override String get sortPriceLow => 'En düşük fiyat';
	@override String get sortName => 'İsim (A–Z)';
	@override String get sortNearestSlot => 'En erken müsaitlik';
	@override String get sortDistance => 'Bana en yakın';
	@override String get locationDenied => 'Mesafeye göre sıralamak için konum izni gerekiyor. Ayarlardan izin verin veya şehir filtresini kullanın.';
	@override String get locationUnavailable => 'Konumunuz alınamadı. Konum hizmetlerinin açık olduğundan emin olun veya şehir filtresini kullanın.';
	@override String distanceKm({required Object km}) => '${km} km';
}

// Path: doctorDetail
class _Translations$doctorDetail$tr extends Translations$doctorDetail$en {
	_Translations$doctorDetail$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get profileTitle => 'Doktor Profili';
	@override String get couldNotLoadProfile => 'Profil yüklenemedi';
	@override String get about => 'Hakkında';
	@override String get workplaces => 'İş Yerleri';
	@override String minPerSlot({required Object min}) => 'aralık başına ${min} dk';
	@override String get bookAppointment => 'Randevu Al';
	@override String get consultationFee => 'Muayene ücreti';
	@override String get reviews => 'Yorumlar';
	@override String reviewsCount({required Object count}) => '${count} değerlendirme';
	@override String get joinWaitlist => 'Bekleme listesine katıl';
	@override String get leaveWaitlist => 'Bekleme listesinden çık';
}

// Path: profile
class _Translations$profile$tr extends Translations$profile$en {
	_Translations$profile$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profil';
	@override String get changePassword => 'Şifreyi Değiştir';
	@override String get currentPassword => 'Mevcut Şifre';
	@override String get newPassword => 'Yeni Şifre';
	@override String get confirmNewPassword => 'Yeni Şifreyi Onayla';
	@override String get firstName => 'Ad';
	@override String get lastName => 'Soyad';
	@override String get phone => 'Telefon';
	@override String get failedToSave => 'Profil kaydedilemedi.';
	@override String get professionalInfo => 'Mesleki Bilgiler';
	@override String get bio => 'Biyografi';
	@override String get bioHint => 'Deneyiminizin kısa açıklaması';
	@override String get consultationFee => 'Muayene ücreti';
	@override String get medicalInfo => 'Tıbbi Bilgiler';
	@override String get allergies => 'Alerjiler';
	@override String get allergiesHint => 'ör. Penisilin, fıstık';
	@override String get chronicConditions => 'Kronik hastalıklar';
	@override String get chronicConditionsHint => 'ör. Diyabet, hipertansiyon';
	@override String get medications => 'Mevcut ilaçlar';
	@override String get medicationsHint => 'ör. Metformin 500mg';
	@override String get appointmentLength => 'Randevu süresi';
	@override String get cancellationWindow => 'İptal süresi';
	@override String get cancellationWindowHint => 'Hastaların randevudan ne kadar önce iptal/erteleme yapabileceği.';
	@override String hoursValue({required Object h}) => '${h} sa';
}

// Path: notifications
class _Translations$notifications$tr extends Translations$notifications$en {
	_Translations$notifications$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bildirimler';
	@override String get noNotifications => 'Bildirim yok';
	@override String get allCaughtUp => 'Her şeyi gördünüz';
	@override String get couldNotLoad => 'Bildirimler yüklenemedi';
	@override String get markAllRead => 'Tümünü okundu işaretle';
	@override String get settingsTitle => 'Bildirim ayarları';
	@override String get pushEnabled => 'Push bildirimleri';
	@override String get pushEnabledSubtitle => 'Randevular ve güncellemeler için bu cihazda uyarılar';
	@override String get emailEnabled => 'E-posta bildirimleri';
	@override String get emailEnabledSubtitle => 'Güncellemeler e-posta adresinize gönderilir';
	@override String get categoriesTitle => 'Push kategorileri';
	@override String get careCategory => 'Randevular ve bakım';
	@override String get careCategorySubtitle => 'Rezervasyonlar, hatırlatmalar, reçeteler';
	@override String get messagesCategory => 'Mesajlar';
	@override String get messagesCategorySubtitle => 'Yeni sohbet mesajları';
	@override String get accountCategory => 'Hesap ve ödemeler';
	@override String get accountCategorySubtitle => 'Doğrulama, ödemeler, abonelik';
	@override String get quietHoursTitle => 'Sessiz saatler';
	@override String get quietHoursEnabled => 'Sessiz saatleri etkinleştir';
	@override String get quietHoursSubtitle => 'Bu saatler arasında push bildirimleri durdurulur';
	@override String get quietHoursStart => 'Başlangıç';
	@override String get quietHoursEnd => 'Bitiş';
}

// Path: workplaces
class _Translations$workplaces$tr extends Translations$workplaces$en {
	_Translations$workplaces$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'İş Yerlerim';
	@override String get noWorkplacesYet => 'Henüz iş yeri yok';
	@override String get tapToAdd => 'İlk iş yerinizi eklemek için + simgesine dokunun';
	@override String get couldNotLoad => 'İş yerleri yüklenemedi';
	@override String get deleteTitle => 'İş Yerini Sil';
	@override String deleteConfirm({required Object name}) => '"${name}" silinsin mi?';
	@override String get cannotDelete => 'İş yeri silinemiyor';
	@override String get workingHours => 'Çalışma Saatleri';
	@override String get setAsPrimary => 'Birincil Yap';
}

// Path: addWorkplace
class _Translations$addWorkplace$tr extends Translations$addWorkplace$en {
	_Translations$addWorkplace$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'İş Yeri Ekle';
	@override String get editTitle => 'İş Yerini Düzenle';
	@override String get name => 'Ad';
	@override String get address => 'Sokak Adresi';
	@override String get city => 'Şehir';
	@override String get type => 'Tür';
	@override String get clinic => 'Klinik';
	@override String get hospital => 'Hastane';
	@override String get privatePractice => 'Özel Muayenehane';
	@override String get failedToSave => 'İş yeri kaydedilemedi.';
	@override String get addButton => 'İş Yeri Ekle';
	@override String get saveChanges => 'Değişiklikleri Kaydet';
	@override String get pickOnMap => 'Haritadan Seç';
	@override String get mapPickerTitle => 'Konum Seçin';
	@override String get useMyLocation => 'Konumumu kullan';
	@override String get confirmLocation => 'Konumu Onayla';
	@override String get locationSet => 'Konum haritadan ayarlandı ✓';
	@override String get locationPermissionDenied => 'Mevcut konumunuzu kullanmak için izin gerekiyor. Haritayı elle de hareket ettirebilirsiniz.';
	@override String get locationUnavailable => 'Konumunuz alınamadı. Haritayı elle de hareket ettirebilirsiniz.';
}

// Path: workingHours
class _Translations$workingHours$tr extends Translations$workingHours$en {
	_Translations$workingHours$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Çalışma Saatleri';
	@override String get sectionHint => 'Hastaların bu adreste sizden randevu alabileceği gün ve saatleri belirleyin.';
	@override String get invalidRange => 'Etkin her gün için bitiş saati başlangıç saatinden sonra olmalıdır.';
	@override String get saved => 'Çalışma saatleri kaydedildi';
	@override String get failedToSave => 'Çalışma saatleri kaydedilemedi';
	@override late final _Translations$workingHours$days$tr days = _Translations$workingHours$days$tr._(_root);
}

// Path: blockTime
class _Translations$blockTime$tr extends Translations$blockTime$en {
	_Translations$blockTime$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zamanı Engelle';
	@override String get dateRange => 'Tarih Aralığı';
	@override String get tapToSelect => 'Tarihleri seçmek için dokunun';
	@override String get reason => 'Sebep (isteğe bağlı)';
	@override String get notifyPatients => 'Etkilenen hastaları bilgilendir';
	@override String get notifyDesc => 'Bu dönemde randevusu olan hastalara bildirim gönder';
	@override String get selectDateRange => 'Lütfen bir tarih aralığı seçin.';
	@override String get failedToBlock => 'Zaman engellenemedi. Lütfen tekrar deneyin.';
	@override String get blockButton => 'Dönemi Engelle';
}

// Path: onboarding
class _Translations$onboarding$tr extends Translations$onboarding$en {
	_Translations$onboarding$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profilinizi Tamamlayın';
	@override String get professionalInfo => 'Mesleki bilgiler';
	@override String get tellPatients => 'Hastalara muayenehaneniz hakkında bilgi verin.';
	@override String get specialization => 'Uzmanlık';
	@override String get selectSpecialization => 'Uzmanlığınızı seçin';
	@override String get couldNotLoadSpecs => 'Uzmanlıklar yüklenemedi. Geri çekip tekrar deneyin.';
	@override String get licenseNumber => 'Lisans numarası';
	@override String get licenseHint => 'örn. AZ-123456';
	@override String get bio => 'Biyografi (isteğe bağlı)';
	@override String get bioHint => 'Hastaların profilinizde göreceği kısa bir tanıtım.';
	@override String get appointmentLength => 'Randevu süresi';
	@override String get slotQuestion => 'Tek bir randevu aralığı ne kadar?';
	@override String get changeLater => 'Bunu daha sonra profilinizden değiştirebilirsiniz.';
	@override String minutes({required Object min}) => '${min} dk';
	@override String get verificationDoc => 'Doğrulama belgesi';
	@override String get uploadDiploma => 'Tıp diplomanızı veya lisansınızı yükleyin. Hesabınız doğrulanmadan önce bir yönetici inceler.';
	@override String get tapToChoose => 'Dosya seçmek için dokunun';
	@override String get tapToReplace => 'Değiştirmek için dokunun';
	@override String get anyFileType => 'Her tür dosya, 10 MB\'a kadar';
	@override String get selectSpecError => 'Lütfen uzmanlığınızı seçin.';
	@override String get licenseError => 'Lütfen lisans numaranızı girin.';
	@override String get diplomaError => 'Lütfen diplomanızı ekleyin.';
	@override String get checkDetails => 'Lütfen bilgilerinizi kontrol edip tekrar deneyin.';
	@override String get continueButton => 'Devam Et';
	@override String get finish => 'Bitir';
}

// Path: pendingVerification
class _Translations$pendingVerification$tr extends Translations$pendingVerification$en {
	_Translations$pendingVerification$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Doğrulama Bekleniyor';
	@override String get message => 'Hesabınız inceleniyor. Doğrulandığında sizi bilgilendireceğiz.';
	@override String get checkStatus => 'Durumu kontrol et';
	@override String get stillPending => 'Hâlâ inceleniyor. Doğrulandığında sizi bilgilendireceğiz.';
}

// Path: phoneField
class _Translations$phoneField$tr extends Translations$phoneField$en {
	_Translations$phoneField$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Telefon Numarası';
	@override String get selectCountry => 'Ülke Seçin';
	@override String get searchCountry => 'Ülke veya kod ara…';
	@override String get noCountriesFound => 'Ülke bulunamadı';
}

// Path: locations
class _Translations$locations$tr extends Translations$locations$en {
	_Translations$locations$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get pickCity => 'Şehir Seçin';
	@override String get searchHint => 'Şehir veya bölge ara…';
	@override String get noResultsFound => 'Şehir bulunamadı';
	@override String get couldNotLoad => 'Şehirler yüklenemedi. Tekrar denemek için dokunun.';
	@override String get allCities => 'Tüm şehirler';
}

// Path: splash
class _Translations$splash$tr extends Translations$splash$en {
	_Translations$splash$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Sağlığınız, basitleştirildi';
}

// Path: appIntro
class _Translations$appIntro$tr extends Translations$appIntro$en {
	_Translations$appIntro$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get page1Title => 'Doğru doktoru bulun';
	@override String get page1Subtitle => 'Uzmanlığa, şehre ve puana göre arayın — size uygun bir randevu alın.';
	@override String get page2Title => 'Yapay zekâ asistanına sorun';
	@override String get page2Subtitle => 'Belirtilerinizi anlatın, hangi uzmana başvurmanız gerektiğini öğrenin.';
	@override String get page3Title => 'Her şey tek bir uygulamada';
	@override String get page3Subtitle => 'Randevularınızı yönetin, tedavinizi takip edin ve uygulamayı kendi dilinizde güvenle kullanın.';
	@override String get skip => 'Geç';
	@override String get next => 'İleri';
	@override String get getStarted => 'Başla';
}

// Path: agenda
class _Translations$agenda$tr extends Translations$agenda$en {
	_Translations$agenda$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Takvim';
	@override String get today => 'Bugün';
	@override String get empty => 'Randevu yok';
	@override String get emptySubtitle => 'Bu gün için planlanmış bir şey yok';
}

// Path: favorites
class _Translations$favorites$tr extends Translations$favorites$en {
	_Translations$favorites$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Favoriler';
	@override String get empty => 'Henüz favori yok';
	@override String get emptySubtitle => 'Bir doktoru kaydetmek için kalbe dokunun';
	@override String get add => 'Favorilere ekle';
	@override String get remove => 'Favorilerden çıkar';
}

// Path: assistant
class _Translations$assistant$tr extends Translations$assistant$en {
	_Translations$assistant$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'AI Asistan';
	@override String get newChat => 'Yeni Sohbet';
	@override String get empty => 'Henüz sohbet yok';
	@override String get emptySubtitle => 'Belirtilerinizi anlatın, asistan hangi doktora gitmeniz gerektiğini önersin';
	@override String get couldNotLoad => 'Sohbetler yüklenemedi';
	@override String get couldNotLoadChat => 'Sohbet yüklenemedi';
	@override String get newConversation => 'Yeni sohbet';
	@override String get deleteTitle => 'Sohbet silinsin mi?';
	@override String get deleteConfirm => 'Sohbet ve tüm mesajları silinecek.';
	@override String get inputHint => 'Belirtilerinizi anlatın…';
	@override String get send => 'Gönder';
	@override String get sendFailed => 'Mesaj gönderilemedi. Lütfen tekrar deneyin.';
	@override String get typing => 'Asistan yazıyor…';
	@override String get startTitle => 'Nasıl yardımcı olabilirim?';
	@override String get startSubtitle => 'Başlamak için sizi rahatsız eden şeyi anlatın';
	@override String get book => 'Randevu al';
	@override String get reportTooltip => 'Yanıtı bildir';
	@override String get reportTitle => 'Yanıtı bildir';
	@override String get reportHint => 'Neden (isteğe bağlı)';
	@override String get reportSubmit => 'Bildir';
	@override String get reportSuccess => 'Teşekkürler, yanıt bildirildi.';
	@override String get reportFailed => 'Yanıt bildirilemedi. Lütfen tekrar deneyin.';
	@override String get topicsTooltip => 'Konular';
	@override String get topicsSheetTitle => 'Bir konu seçin';
}

// Path: messaging
class _Translations$messaging$tr extends Translations$messaging$en {
	_Translations$messaging$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mesajlar';
	@override String get sendMessage => 'Mesaj Gönder';
	@override String get typeMessage => 'Bir mesaj yazın…';
	@override String get send => 'Gönder';
	@override String get empty => 'Henüz yazışma yok';
	@override String get emptySubtitle => 'Yazışmalarınız burada görünecek.';
	@override String get disclaimer => 'Bu bir acil durum hattı değildir. Acil durumlarda acil servisleri arayın.';
	@override String get noSharedHistory => 'Bir doktora yalnızca onunla ortak bir randevu geçmişiniz olduğunda mesaj gönderebilirsiniz.';
	@override String get newMessage => 'Yeni bir mesajınız var';
}

// Path: legal
class _Translations$legal$tr extends Translations$legal$en {
	_Translations$legal$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gizlilik ve Koşullar';
	@override String get controllerNotice => 'DocLine, AuxioDev (auxiodev.com) tarafından Azerbaycan\'da oluşturulmuş ve işletilmektedir ("biz"). Son güncelleme: Temmuz 2026.';
	@override String get privacyTitle => 'Gizlilik Politikası';
	@override String get privacyIntro => 'Bu politika, DocLine\'nun hangi kişisel verileri, neden topladığını ve nasıl koruduğunu açıklar. Tıbbi randevu alma ve yönetme, sağlık bilgilerinizi doğal olarak içerir — bu aşağıda ayrıntılı olarak açıklanmıştır.';
	@override late final _Translations$legal$sections$tr sections = _Translations$legal$sections$tr._(_root);
	@override String get termsTitle => 'Kullanım Koşulları';
	@override String get termsIntro => 'Bir hesap oluşturarak aşağıdakileri kabul etmiş olursunuz.';
	@override String get termsBody => 'Kendiniz hakkında doğru bilgi verin. DocLine\'yu yalnızca tıbbi randevu bulma, alma ve yönetme amacıyla kullanın. Giriş bilgilerinizi gizli tutun. DocLine sizi bağımsız, lisanslı tıp uzmanlarıyla buluşturur — kendimiz bir sağlık kuruluşu değiliz ve semptom kontrol yapay zeka asistanı profesyonel tıbbi teşhis veya tavsiyenin yerini tutmaz. Tıbbi bir acil durumda, bu uygulamayı değil doğrudan acil servisleri arayın. Bu koşulları ihlal eden veya platformu kötüye kullanan hesapları askıya alabilir veya sonlandırabiliriz.';
	@override String get contact => 'Verileriniz hakkında sorularınız mı var? support@auxiodev.com adresine yazın';
	@override String get consentPrefix => '';
	@override String get consentPrivacyLink => 'Gizlilik Politikası';
	@override String get consentMiddle => ' ve ';
	@override String get consentTermsLink => 'Kullanım Koşulları';
	@override String get consentSuffix => '\'nı okudum, kabul ediyorum ve orada açıklandığı şekilde sağlık verilerimin işlenmesine açıkça rıza gösteriyorum.';
	@override String get viewAsPdf => 'PDF olarak görüntüle';
	@override String get pdfDocumentTitle => 'DocLine — Gizlilik Politikası ve Kullanım Koşulları';
	@override String get pdfLoadError => 'Belge yüklenemedi. Lütfen internet bağlantınızı kontrol edip tekrar deneyin.';
}

// Path: medications
class _Translations$medications$tr extends Translations$medications$en {
	_Translations$medications$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'İlaçlar';
	@override String get editMedication => 'İlacı Düzenle';
	@override String get name => 'Ad';
	@override String get dosage => 'Doz';
	@override String get notes => 'Notlar';
	@override String get form => 'Form';
	@override String get formPill => 'Hap';
	@override String get formCapsule => 'Kapsül';
	@override String get formLiquid => 'Sıvı';
	@override String get formInjection => 'Enjeksiyon';
	@override String get formOther => 'Diğer';
	@override String get schedule => 'Program';
	@override String get times => 'Alım Saatleri';
	@override String get addTime => 'Saat Ekle';
	@override String get daysOfWeek => 'Haftanın Günleri';
	@override String get everyDay => 'Her gün';
	@override String get startDate => 'Başlangıç Tarihi';
	@override String get endDate => 'Bitiş Tarihi';
	@override String get save => 'Kaydet';
	@override String get delete => 'Sil';
	@override String get deleteConfirmTitle => 'İlacı Sil';
	@override String get deleteConfirmBody => 'Bu ilacı silmek istediğinizden emin misiniz? Alım geçmişi saklanacak.';
	@override String get emptyTitle => 'Henüz ilaç yok';
	@override String get emptySubtitle => 'Doktorunuzun yazdığı ilaçlar randevunuzdan sonra burada görünecek.';
	@override String get todaysDoses => 'Bugünkü Alımlar';
	@override String get markTaken => 'Alındı';
	@override String get markSkipped => 'Atla';
	@override String get statusTaken => 'Alındı';
	@override String get statusSkipped => 'Atlandı';
	@override String get statusPending => 'Bekliyor';
	@override String reminderTitle({required Object name}) => '${name} alma vakti';
	@override String reminderBody({required Object dosage}) => 'Doz: ${dosage}';
	@override String get tabActive => 'Aktif';
	@override String get tabArchive => 'Arşiv';
	@override String get fromPrescription => 'Reçeteden';
	@override String get noSchedule => 'Program ayarlanmadı — hatırlatma saati eklemek için dokunun';
	@override String get dayMon => 'Pzt';
	@override String get dayTue => 'Sal';
	@override String get dayWed => 'Çar';
	@override String get dayThu => 'Per';
	@override String get dayFri => 'Cum';
	@override String get daySat => 'Cmt';
	@override String get daySun => 'Paz';
	@override String get updatedSuccess => 'İlaç güncellendi.';
	@override String get deletedSuccess => 'İlaç silindi.';
	@override String get atLeastOneTime => 'En az bir hatırlatma saati ekleyin';
}

// Path: prescriptions
class _Translations$prescriptions$tr extends Translations$prescriptions$en {
	_Translations$prescriptions$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Reçeteler';
	@override String get writeTitle => 'Reçete Yaz';
	@override String get addDrug => 'İlaç Ekle';
	@override String get drugName => 'İlaç Adı';
	@override String get dosage => 'Doz';
	@override String get frequency => 'Kullanım Sıklığı';
	@override String get duration => 'Süre';
	@override String get instructions => 'Talimatlar';
	@override String get notes => 'Notlar';
	@override String get save => 'Kaydet';
	@override String get empty => 'Henüz reçete yok';
	@override String get emptySubtitle => 'Doktorunuzun yazdığı reçeteler burada görünecek.';
	@override String get viewDetails => 'Detayları Gör';
	@override String issuedBy({required Object name}) => 'Dr. ${name} tarafından yazıldı';
	@override String issuedOn({required Object date}) => 'Yazılma tarihi: ${date}';
	@override String get applyToMedications => 'İlaçlarıma Ekle';
	@override String get applySuccess => 'İlaçlarınıza eklendi. Hatırlatma saatlerini ayarlayın.';
	@override String get alreadyApplied => 'Zaten ilaçlarınıza eklendi';
	@override String get noPrescriptionYet => 'Bu randevu için henüz reçete yazılmadı';
	@override String get writePrescription => 'Reçete Yaz';
	@override String get prescriptionIssued => 'Reçete yazıldı.';
	@override String get removeDrug => 'Kaldır';
	@override String get atLeastOneDrug => 'En az bir ilaç ekleyin';
	@override String get drugNameRequired => 'İlaç adı gereklidir';
	@override String get summaryTitle => 'Reçete';
	@override String itemsCount({required Object count}) => '${count} ilaç';
	@override String get newPrescription => 'Yeni Reçete';
	@override String get youHavePrescription => 'Bu randevu için bir reçete var';
}

// Path: records
class _Translations$records$tr extends Translations$records$en {
	_Translations$records$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sağlık Kayıtları';
	@override String get upload => 'Belge Yükle';
	@override String get recordType => 'Belge Türü';
	@override String get typeLabResult => 'Tahlil Sonucu';
	@override String get typeImaging => 'Görüntüleme';
	@override String get typeDocument => 'Belge';
	@override String get typeOther => 'Diğer';
	@override String get recordTitle => 'Başlık';
	@override String get recordDate => 'Tarih';
	@override String get notes => 'Notlar';
	@override String get chooseFile => 'Dosya Seç';
	@override String get changeFile => 'Dosyayı Değiştir';
	@override String get noFileChosen => 'Dosya seçilmedi';
	@override String get save => 'Kaydet';
	@override String get delete => 'Sil';
	@override String get deleteConfirmTitle => 'Belgeyi Sil';
	@override String get deleteConfirmBody => 'Bu belgeyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';
	@override String get empty => 'Henüz sağlık kaydı yok';
	@override String get emptySubtitle => 'Tahlil sonuçlarını, görüntüleri ve diğer belgeleri tek bir yerde saklayın.';
	@override String get view => 'Görüntüle';
	@override String get fileRequired => 'Yüklemek için bir dosya seçin';
	@override String get fileTooLarge => 'Dosya çok büyük (maks. 15 MB)';
	@override String get titleRequired => 'Başlık gereklidir';
	@override String get uploadSuccess => 'Belge yüklendi.';
	@override String get deletedSuccess => 'Belge silindi.';
	@override String get couldNotOpen => 'Dosya açılamadı';
}

// Path: payments
class _Translations$payments$tr extends Translations$payments$en {
	_Translations$payments$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ödeme';
	@override String get amount => 'Tutar';
	@override String get payNow => 'Şimdi Öde';
	@override String get payLater => 'Sonra Öde';
	@override String get statusPending => 'Ödeme Bekleniyor';
	@override String get statusPaid => 'Ödendi';
	@override String get statusFailed => 'Ödeme Başarısız';
	@override String get statusCancelled => 'İptal Edildi';
	@override String get statusRefunded => 'İade Edildi';
	@override String get statusRefundFailed => 'İade Başarısız';
	@override String get paymentConfirmed => 'Ödeme onaylandı. Teşekkürler!';
	@override String get openingBrowser => 'Tarayıcı açılıyor…';
	@override String get checkStatus => 'Durumu Kontrol Et';
}

// Path: family
class _Translations$family$tr extends Translations$family$en {
	_Translations$family$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aile';
	@override String get myself => 'Kendim';
	@override String get addFamilyMember => 'Aile Üyesi Ekle';
	@override String get editFamilyMember => 'Aile Üyesini Düzenle';
	@override String get firstName => 'Ad';
	@override String get lastName => 'Soyad';
	@override String get relationship => 'Yakınlık';
	@override String get relationshipChild => 'Çocuk';
	@override String get relationshipSpouse => 'Eş';
	@override String get relationshipParent => 'Ebeveyn';
	@override String get relationshipSibling => 'Kardeş';
	@override String get relationshipOther => 'Diğer';
	@override String get dateOfBirth => 'Doğum Tarihi';
	@override String get bloodType => 'Kan Grubu';
	@override String get allergies => 'Alerjiler';
	@override String get chronicConditions => 'Kronik hastalıklar';
	@override String get medications => 'Mevcut ilaçlar';
	@override String get save => 'Kaydet';
	@override String get delete => 'Sil';
	@override String get deleteConfirmTitle => 'Aile Üyesini Kaldır';
	@override String get deleteConfirmBody => 'Bu aile üyesini kaldırmak istediğinizden emin misiniz? Randevu, ilaç ve belge geçmişi saklanacak.';
	@override String get empty => 'Henüz aile üyesi yok';
	@override String get emptySubtitle => 'Randevularını, ilaçlarını ve belgelerini yönetmek için çocuğunuzu, eşinizi veya başka bir aile üyenizi ekleyin.';
	@override String get bookingForQuestion => 'Bu randevu kimin için?';
	@override String bookingForLabel({required Object name}) => 'Randevu kimin için: ${name}';
	@override String forLabel({required Object name}) => '${name} için';
	@override String ageYears({required Object age}) => '${age} yaşında';
	@override String bookedByLabel({required Object name}) => 'Randevuyu alan: ${name}';
	@override String get contactEmail => 'İletişim E-postası';
	@override String get contactEmailHelp => 'Eklendiklerini onlara bildireceğiz ve reddetmeleri için kolay bir yol sunacağız.';
	@override String get contactPhoneOptional => 'İletişim Telefonu (isteğe bağlı)';
	@override String get contactEmailRequiredForAdult => 'Bu aile üyesini bilgilendirebilmemiz için bir e-posta adresi gereklidir';
	@override String get adultConsentNotice => '18 yaşından büyük oldukları için onlara sizin tarafınızdan eklendiklerini bildiren bir e-posta göndereceğiz — uygulamaya ihtiyaçları yok ve bu bağlantıyı istedikleri zaman kaldırabilirler.';
	@override String get noticeAlreadySent => 'Eklendikleri konusunda onları bilgilendirdik. Bu bağlantıyı istedikleri zaman kaldırabilirler.';
	@override String get noticePendingBadge => 'Bildirim gönderildi';
}

// Path: subscription
class _Translations$subscription$tr extends Translations$subscription$en {
	_Translations$subscription$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Abonelik';
	@override String get planNameBasic => 'Başlangıç';
	@override String get planNamePro => 'Profesyonel';
	@override String get couldNotLoad => 'Abonelik bilgileri yüklenemedi.';
	@override String get nowActive => 'Aboneliğiniz artık aktif!';
	@override String get unavailable => 'Abonelik şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.';
	@override String trialDaysLeft({required Object days}) => 'Ücretsiz deneme — ${days} gün kaldı';
	@override String graceDaysLeft({required Object days}) => 'Ek süre — yenilemek için ${days} gün kaldı';
	@override String get expiredNotice => 'Aboneliğinizin süresi doldu. Hastalar tarafından tekrar görünür olmak için abone olun.';
	@override String get activeNotice => 'Aboneliğiniz aktif.';
	@override String get choosePlan => 'Başlamak için bir plan seçin.';
	@override String get currentPlan => 'Mevcut Plan';
	@override String get mostPopular => 'En Popüler';
	@override String get perMonth => 'aylık';
	@override String get manageOnWeb => 'Aboneliğinizi auxiodev.com üzerinden yönetin';
	@override String get featureUnlimitedWorkplaces => 'Sınırsız klinik';
	@override String featureWorkplaces({required Object count}) => '${count} kliniğe kadar';
	@override String get featureUnlimitedBookings => 'Sınırsız aylık randevu';
	@override String featureBookingsPerMonth({required Object count}) => 'Ayda ${count} randevuya kadar';
	@override String get featureChat => 'Hasta sohbeti';
	@override String get featurePromoted => 'Öncelikli sıralama + "Peşəkar" rozeti';
	@override String get renew => 'Yenile';
	@override String get subscribe => 'Abone Ol';
	@override String get planNameHospitalBasic => 'Klinik';
	@override String get planNameHospitalPro => 'Klinik Plus';
	@override String featureDoctors({required Object count}) => '${count} doktora kadar';
	@override String get featureUnlimitedDoctors => 'Sınırsız doktor';
	@override String get featureAdvancedStats => 'Gelişmiş istatistikler';
}

// Path: hospitalPicker
class _Translations$hospitalPicker$tr extends Translations$hospitalPicker$en {
	_Translations$hospitalPicker$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hastane Seçin';
	@override String get searchHint => 'Hastane adını arayın…';
	@override String get noResultsFound => 'Hastane bulunamadı';
	@override String get selectCityFirst => 'Önce şehir seçin';
	@override String addVariant({required Object name}) => '"${name}" ekle';
	@override String get pendingReview => 'İncelemede';
}

// Path: hospitalRegistration
class _Translations$hospitalRegistration$tr extends Translations$hospitalRegistration$en {
	_Translations$hospitalRegistration$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hastane Bilgileri';
	@override String get subtitle => 'Şehrinizi seçin, ardından hastanenizi listede bulun veya ekleyin.';
	@override String get cityStep => '1. Şehir';
	@override String get hospitalStep => '2. Hastane';
	@override String get searchHint => 'Hastane adını arayın…';
	@override String get noResultsFound => 'Hastane bulunamadı';
	@override String get notFoundPrompt => 'Hastanenizi bulamıyor musunuz?';
	@override String get addManually => 'Manuel olarak ekle';
	@override String get useSearchInstead => 'Tekrar ara';
	@override String get newHospitalName => 'Hastane adı';
	@override String get selectedPrefix => 'Seçildi:';
	@override String get pendingReviewNotice => 'Yeni hastaneler başkalarına görünmeden önce ekibimiz tarafından incelenir.';
	@override String get submit => 'Hesap Oluştur';
	@override String get hospitalRequired => 'Devam etmek için hastanenizi seçin veya ekleyin';
}

// Path: hospitalHome
class _Translations$hospitalHome$tr extends Translations$hospitalHome$en {
	_Translations$hospitalHome$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Merhaba, ${name}';
	@override String get subtitle => 'Doktorlarınızı ve randevularınızı yönetin';
	@override String get doctors => 'Doktorlar';
	@override String get inviteDoctor => 'Doktor Davet Et';
	@override String get appointments => 'Randevular';
	@override String get profile => 'Profil';
	@override String pendingRequests({required Object count}) => '${count} bekleyen talep';
}

// Path: hospitalDoctors
class _Translations$hospitalDoctors$tr extends Translations$hospitalDoctors$en {
	_Translations$hospitalDoctors$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Doktorlar';
	@override String get tabConfirmed => 'Onaylı';
	@override String get tabRequests => 'Talepler';
	@override String get tabInvited => 'Davet Edilen';
	@override String get noConfirmedDoctors => 'Henüz onaylı doktor yok';
	@override String get noRequests => 'Bekleyen talep yok';
	@override String get noInvited => 'Bekleyen davet yok';
	@override String get approve => 'Onayla';
	@override String get reject => 'Reddet';
	@override String get remove => 'Kaldır';
	@override String get removeConfirmTitle => 'Doktor kaldırılsın mı?';
	@override String removeConfirmMessage({required Object name}) => '${name} artık hastanenizle ilişkili olmayacak. Bu, iş yerini ve randevularını etkilemez.';
	@override String get requestedToJoin => 'Katılma talebinde bulundu';
	@override String get invitedAwaiting => 'Davet edildi — yanıt bekleniyor';
	@override String get editHours => 'Saatleri düzenle';
}

// Path: hospitalInvite
class _Translations$hospitalInvite$tr extends Translations$hospitalInvite$en {
	_Translations$hospitalInvite$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Doktor Davet Et';
	@override String get searchHint => 'İsme veya uzmanlığa göre arayın…';
	@override String get noResultsFound => 'Doktor bulunamadı';
	@override String get invite => 'Davet Et';
	@override String get invited => 'Davet Edildi';
}

// Path: hospitalAppointments
class _Translations$hospitalAppointments$tr extends Translations$hospitalAppointments$en {
	_Translations$hospitalAppointments$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Randevular';
	@override String get empty => 'Henüz randevu yok';
}

// Path: hospitalProfile
class _Translations$hospitalProfile$tr extends Translations$hospitalProfile$en {
	_Translations$hospitalProfile$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hastane Profili';
	@override String usageDoctors({required Object limit, required Object count}) => '${limit} doktordan ${count}';
	@override String usageDoctorsUnlimited({required Object count}) => '${count} doktor (sınırsız)';
	@override String get manageSubscription => 'Aboneliği Yönet';
}

// Path: hospitalDoctorHours
class _Translations$hospitalDoctorHours$tr extends Translations$hospitalDoctorHours$en {
	_Translations$hospitalDoctorHours$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Çalışma Saatleri';
	@override String get selectWorkplace => 'Bir iş yeri seçin';
	@override String get saved => 'Saatler kaydedildi';
}

// Path: doctorHospitals
class _Translations$doctorHospitals$tr extends Translations$doctorHospitals$en {
	_Translations$doctorHospitals$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hastanelerim';
	@override String get tabInvitations => 'Davetler';
	@override String get tabRequests => 'Talepler';
	@override String get tabConfirmed => 'Hastaneler';
	@override String get noInvitations => 'Bekleyen davet yok';
	@override String get noRequests => 'Bekleyen talep yok';
	@override String get noConfirmed => 'Henüz herhangi bir hastaneyle ilişkiniz yok';
	@override String get accept => 'Kabul et';
	@override String get decline => 'Reddet';
	@override String get cancelRequest => 'Talebi iptal et';
	@override String get invitedYouToJoin => 'Sizi katılmaya davet etti';
	@override String get awaitingApproval => 'Hastane onayı bekleniyor';
}

// Path: share
class _Translations$share$tr extends Translations$share$en {
	_Translations$share$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profili paylaş';
	@override String get shareLink => 'Bağlantıyı paylaş';
	@override String get copyLink => 'Bağlantıyı kopyala';
	@override String get linkCopied => 'Bağlantı kopyalandı';
}

// Path: hospitalDetail
class _Translations$hospitalDetail$tr extends Translations$hospitalDetail$en {
	_Translations$hospitalDetail$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hastane';
	@override String get couldNotLoad => 'Profil yüklenemedi';
	@override String get location => 'Adres';
	@override String get doctorsHeading => 'Buradaki doktorlar';
}

// Path: doctorSearch.spec
class _Translations$doctorSearch$spec$tr extends Translations$doctorSearch$spec$en {
	_Translations$doctorSearch$spec$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get general => 'Genel';
	@override String get cardiology => 'Kardiyoloji';
	@override String get dermatology => 'Dermatoloji';
	@override String get neurology => 'Nöroloji';
	@override String get orthopedics => 'Ortopedi';
	@override String get pediatrics => 'Pediatri';
	@override String get psychiatry => 'Psikiyatri';
	@override String get gynecology => 'Jinekoloji';
	@override String get urology => 'Üroloji';
	@override String get ophthalmology => 'Oftalmoloji';
	@override String get ent => 'KBB';
}

// Path: workingHours.days
class _Translations$workingHours$days$tr extends Translations$workingHours$days$en {
	_Translations$workingHours$days$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get monday => 'Pazartesi';
	@override String get tuesday => 'Salı';
	@override String get wednesday => 'Çarşamba';
	@override String get thursday => 'Perşembe';
	@override String get friday => 'Cuma';
	@override String get saturday => 'Cumartesi';
	@override String get sunday => 'Pazar';
}

// Path: legal.sections
class _Translations$legal$sections$tr extends Translations$legal$sections$en {
	_Translations$legal$sections$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$legal$sections$identity$tr identity = _Translations$legal$sections$identity$tr._(_root);
	@override late final _Translations$legal$sections$health$tr health = _Translations$legal$sections$health$tr._(_root);
	@override late final _Translations$legal$sections$professional$tr professional = _Translations$legal$sections$professional$tr._(_root);
	@override late final _Translations$legal$sections$location$tr location = _Translations$legal$sections$location$tr._(_root);
	@override late final _Translations$legal$sections$device$tr device = _Translations$legal$sections$device$tr._(_root);
	@override late final _Translations$legal$sections$payment$tr payment = _Translations$legal$sections$payment$tr._(_root);
	@override late final _Translations$legal$sections$family$tr family = _Translations$legal$sections$family$tr._(_root);
	@override late final _Translations$legal$sections$purposes$tr purposes = _Translations$legal$sections$purposes$tr._(_root);
	@override late final _Translations$legal$sections$legalBasis$tr legalBasis = _Translations$legal$sections$legalBasis$tr._(_root);
	@override late final _Translations$legal$sections$thirdParties$tr thirdParties = _Translations$legal$sections$thirdParties$tr._(_root);
	@override late final _Translations$legal$sections$retention$tr retention = _Translations$legal$sections$retention$tr._(_root);
	@override late final _Translations$legal$sections$rights$tr rights = _Translations$legal$sections$rights$tr._(_root);
	@override late final _Translations$legal$sections$security$tr security = _Translations$legal$sections$security$tr._(_root);
	@override late final _Translations$legal$sections$permissions$tr permissions = _Translations$legal$sections$permissions$tr._(_root);
	@override late final _Translations$legal$sections$children$tr children = _Translations$legal$sections$children$tr._(_root);
}

// Path: legal.sections.identity
class _Translations$legal$sections$identity$tr extends Translations$legal$sections$identity$en {
	_Translations$legal$sections$identity$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kimlik verileri';
	@override String get body => 'Ad ve soyad, e-posta adresi, telefon numarası (isteğe bağlı), şifreniz (geri döndürülemez bir hash olarak saklanır, asla düz metin olarak değil) ve tercih ettiğiniz uygulama dili.';
}

// Path: legal.sections.health
class _Translations$legal$sections$health$tr extends Translations$legal$sections$health$en {
	_Translations$legal$sections$health$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sağlık verileri';
	@override String get body => 'Hasta olarak: kan grubu, alerjiler, kronik hastalıklar, kullandığınız ilaçlar, randevu alırken belirttiğiniz sebep, yüklediğiniz tıbbi belgeler (tahlil sonuçları, görüntüleme, diğer kayıtlar), size yazılan reçeteler ve doktorunuzla mesajlaşma içeriğiniz. Semptom kontrol yapay zeka asistanını kullanırsanız, sorularınız ve yanıtları da aynı şekilde işlenir. Sağlık verileri Azerbaycan mevzuatına göre en yüksek koruma seviyesine sahiptir ve bunları yalnızca ayrı, açık rızanızla topluyoruz (aşağıda "Hukuki dayanak" bölümüne bakın).';
}

// Path: legal.sections.professional
class _Translations$legal$sections$professional$tr extends Translations$legal$sections$professional$en {
	_Translations$legal$sections$professional$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mesleki veriler (doktorlar)';
	@override String get body => 'Uzmanlık alanı, lisans numarası, diploma veya diğer doğrulama belgesi, işyeri bilgileri ve muayene ücreti. Bu bilgiler, profiliniz hastalara görünür olmadan önce ekibimiz tarafından incelenir.';
}

// Path: legal.sections.location
class _Translations$legal$sections$location$tr extends Translations$legal$sections$location$en {
	_Translations$legal$sections$location$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konum';
	@override String get body => 'İzninizle, doktorları size olan uzaklığa göre sıralamak için yaklaşık veya kesin konum. Yalnızca uygulama açıkken kullanılır — sunucularımızda asla saklanmaz.';
}

// Path: legal.sections.device
class _Translations$legal$sections$device$tr extends Translations$legal$sections$device$en {
	_Translations$legal$sections$device$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cihaz ve teknik veriler';
	@override String get body => 'Ayarlar bölümünden aktif oturumlarınızı görüp iptal edebilmeniz için cihaz kimlikleri ve oturum bilgileri, ayrıca randevu hatırlatmaları ve mesajları cihazınıza iletmek için bir push bildirim jetonu.';
}

// Path: legal.sections.payment
class _Translations$legal$sections$payment$tr extends Translations$legal$sections$payment$en {
	_Translations$legal$sections$payment$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ödeme verileri';
	@override String get body => 'Uygulama içinden bir konsültasyon için ödeme yaparsanız, ödeme tamamen ödeme ortağımız Payriff tarafından işlenir — kart numaranızı asla görmez veya saklamayız. Randevu geçmişiniz için ödeme tutarını, durumunu ve bir referans kimliğini saklarız.';
}

// Path: legal.sections.family
class _Translations$legal$sections$family$tr extends Translations$legal$sections$family$en {
	_Translations$legal$sections$family$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aile üyesi profilleri';
	@override String get body => 'Kendi girişi olmayan bir aile üyesinin (çocuk veya bakmakla yükümlü olduğunuz biri) profilini yönetiyorsanız, yukarıdaki aynı sağlık verisi kategorileri onun için hesabınız altında kaydedilebilir. Bir aile üyesi eklediğinizde, onun ebeveyni, vasisi veya sağlık bilgilerini onun adına yönetmeye yetkili olduğunuzu onaylamış olursunuz.';
}

// Path: legal.sections.purposes
class _Translations$legal$sections$purposes$tr extends Translations$legal$sections$purposes$en {
	_Translations$legal$sections$purposes$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verilerinizi neden kullanıyoruz';
	@override String get body => 'Doktor bulup randevu alabilmeniz için; doktorların programlarını ve hastalarını yönetebilmesi için; randevu hatırlatmaları ve güncellemeler göndermek için; konsültasyon ödemelerini işlemek için; isteğe bağlı semptom kontrol yapay zeka özelliğini sunmak için; hesabınızı güvende tutmak için.';
}

// Path: legal.sections.legalBasis
class _Translations$legal$sections$legalBasis$tr extends Translations$legal$sections$legalBasis$en {
	_Translations$legal$sections$legalBasis$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hukuki dayanak ve rızanız';
	@override String get body => 'Verilerinizi, kayıt olurken verdiğiniz rıza temelinde işliyoruz. Sağlık verileri, Azerbaycan Cumhuriyeti "Kişisel Veriler Hakkında" Kanunu (No. 998-IIIQ) uyarınca özel kategori kişisel veridir ve toplanmadan önce açık, yazılı rızanızı gerektirir — kayıt ekranındaki onay kutusu tam olarak bunu kaydeder. Hesabınızı silerek rızanızı istediğiniz zaman geri çekebilirsiniz, ancak yasanın gerektirdiği durumlarda (örneğin vergi amaçlı mali kayıtlar) sınırlı kayıtları saklayabiliriz.';
}

// Path: legal.sections.thirdParties
class _Translations$legal$sections$thirdParties$tr extends Translations$legal$sections$thirdParties$en {
	_Translations$legal$sections$thirdParties$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verilerinizi başka kim işler';
	@override String get body => 'Yalnızca bizim talimatımızla ve burada açıklanan amaçlar için hareket eden güvenilir hizmet sağlayıcılar: Cloudinary (güvenli dosya depolama — belgeler ve fotoğraflar asla herkese açık değildir, yalnızca imzalı, süreli bağlantılarla erişilebilir); Firebase/Google (push bildirimleri ve tercih ederseniz Google ile giriş); Apple (tercih ederseniz Apple ile Oturum Açma); Payriff (uygulama içi ödemeler). Kişisel verilerinizi satmayız.';
}

// Path: legal.sections.retention
class _Translations$legal$sections$retention$tr extends Translations$legal$sections$retention$en {
	_Translations$legal$sections$retention$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verilerinizi ne kadar süre saklıyoruz';
	@override String get body => 'Hesabınız aktif olduğu sürece. Hesabınızı silerseniz, yasal olarak saklamamız gereken kayıtlar (örneğin vergi amaçlı ödeme kayıtları) dışında, kişisel verilerinizi makul bir süre içinde kaldırırız.';
}

// Path: legal.sections.rights
class _Translations$legal$sections$rights$tr extends Translations$legal$sections$rights$en {
	_Translations$legal$sections$rights$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Haklarınız';
	@override String get body => 'Hakkınızda tuttuğumuz verilere erişebilir, hatalı verilerin düzeltilmesini, hesabınızın ve verilerinizin silinmesini talep edebilir ve rızanızı istediğiniz zaman geri çekebilirsiniz. Bunların çoğu doğrudan Profil > Ayarlar altında mevcuttur; diğer her şey için aşağıdan bizimle iletişime geçin.';
}

// Path: legal.sections.security
class _Translations$legal$sections$security$tr extends Translations$legal$sections$security$en {
	_Translations$legal$sections$security$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verilerinizi nasıl koruyoruz';
	@override String get body => 'Doktorunuzla mesajlaşmalarınız ve yapay zeka asistanı konuşmaları şifrelenir. Yüklenen belgeler ve fotoğraflar özel olarak saklanır, yalnızca güvenli imzalı bağlantılarla erişilebilir, asla herkese açık dosyalar olarak değil. Şifreler asla okunabilir biçimde saklanmaz.';
}

// Path: legal.sections.permissions
class _Translations$legal$sections$permissions$tr extends Translations$legal$sections$permissions$en {
	_Translations$legal$sections$permissions$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'İstediğimiz izinler';
	@override String get body => 'Kamera ve fotoğraf galerisi — profil fotoğrafı ayarlamak ve tıbbi belgeler yüklemek için. Konum — doktorları size olan uzaklığa göre sıralamak için. Bildirimler — randevu hatırlatmaları ve mesajlar iletmek için. Biyometri (Face ID / parmak izi) — uygulamanın kilidini açmanın isteğe bağlı, daha hızlı bir yolu; biyometrik verileriniz asla cihazınızdan çıkmaz, yalnızca işletim sisteminden bir evet/hayır onayı alırız.';
}

// Path: legal.sections.children
class _Translations$legal$sections$children$tr extends Translations$legal$sections$children$en {
	_Translations$legal$sections$children$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Yaş şartı';
	@override String get body => 'DocLine hesapları yetişkinler içindir. 18 yaşından küçükseniz, lütfen bir ebeveyn veya vasinin aile/bakmakla yükümlü olunan profil özelliğini kullanarak sizin adınıza bir hesap oluşturmasını ve yönetmesini sağlayın.';
}

/// The flat map containing all translations for locale <tr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsTr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'DocLine',
			'common.cancel' => 'İptal',
			'common.logout' => 'Çıkış Yap',
			'common.doctor' => 'Doktor',
			'common.patient' => 'Hasta',
			'common.save' => 'Kaydet',
			'common.edit' => 'Düzenle',
			'common.retry' => 'Tekrar dene',
			'common.back' => 'Geri',
			'common.ok' => 'Tamam',
			'common.delete' => 'Sil',
			'common.keep' => 'Vazgeç',
			'common.confirm' => 'Onayla',
			'common.decline' => 'Reddet',
			'common.primary' => 'Birincil',
			'common.somethingWrong' => 'Bir şeyler ters gitti',
			'common.seeAll' => 'Tümünü gör',
			'common.signOut' => 'Çıkış Yap',
			'common.search' => 'Ara',
			'common.tryAgain' => 'Lütfen tekrar deneyin',
			'common.required' => 'Gerekli',
			'common.noRatings' => 'Henüz değerlendirme yok',
			'common.hospital' => 'Hastane',
			'auth.login' => 'Giriş Yap',
			'auth.register' => 'Hesap Oluştur',
			'auth.signIn' => 'Giriş Yap',
			'auth.signUp' => 'Kayıt Ol',
			'auth.password' => 'Şifre',
			'auth.confirmPassword' => 'Şifreyi Onayla',
			'auth.firstName' => 'Ad',
			'auth.lastName' => 'Soyad',
			'auth.rememberMe' => 'Beni hatırla',
			'auth.forgotPassword' => 'Şifrenizi mi unuttunuz?',
			'auth.sendResetLink' => 'Sıfırlama Kodu Gönder',
			'auth.noAccount' => 'Hesabınız yok mu?',
			'auth.haveAccount' => 'Zaten hesabınız var mı?',
			'auth.welcomeBack' => 'Tekrar hoş geldiniz',
			'auth.signInToContinue' => 'Devam etmek için hesabınıza giriş yapın',
			'auth.createYourAccount' => 'Hesabınızı oluşturun',
			'auth.joinMedalize' => 'Bugün DocLine\'ya katılın',
			'auth.iAmA' => 'Ben bir',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => 'Girişe dön',
			'auth.verificationCode' => 'Doğrulama kodu',
			'auth.continueWithGoogle' => 'Google ile devam et',
			'auth.continueWithApple' => 'Apple ile devam et',
			'auth.orDivider' => 'veya',
			'forgotPassword.title' => 'Şifrenizi mi unuttunuz?',
			'forgotPassword.subtitle' => 'Telefon numaranızı girin, size 6 haneli bir sıfırlama kodu gönderelim',
			'resetPassword.title' => 'Şifreyi Sıfırla',
			'resetPassword.subtitle' => 'Telefonunuza gönderilen kodu girin ve yeni bir şifre seçin',
			'resetPassword.button' => 'Şifreyi Sıfırla',
			'resetPassword.success' => 'Şifre başarıyla sıfırlandı. Lütfen giriş yapın.',
			'verifyPhone.title' => 'Telefon Numaranızı Doğrulayın',
			'verifyPhone.subtitle' => ({required Object phone}) => '${phone} numarasına 6 haneli bir kod gönderdik',
			'verifyPhone.button' => 'Doğrula',
			'verifyPhone.resend' => 'Kodu tekrar gönder',
			'verifyPhone.resendSent' => 'Yeni bir kod gönderildi.',
			'socialComplete.title' => 'Neredeyse tamam',
			'socialComplete.subtitle' => 'Hesabınızı oluşturmayı tamamlamak için bir telefon numarası girin ve doğrulayın.',
			'socialComplete.button' => 'Devam et',
			'validation.emailRequired' => 'E-posta gerekli',
			'validation.emailInvalid' => 'Geçerli bir e-posta adresi girin',
			'validation.passwordRequired' => 'Şifre gerekli',
			'validation.passwordTooShort' => 'En az 8 karakter gerekli',
			'validation.passwordNeedsLetter' => 'En az bir harf ekleyin',
			'validation.passwordNeedsDigit' => 'En az bir rakam ekleyin',
			'validation.passwordMismatch' => 'Şifreler eşleşmiyor',
			'validation.passwordConfirmRequired' => 'Lütfen şifrenizi onaylayın',
			'validation.nameMinLength' => 'En az 2 karakter olmalı',
			'validation.roleRequired' => 'Lütfen bir rol seçin',
			'validation.phoneRequired' => 'Telefon numarası gerekli',
			'validation.phoneTooShort' => 'Numara çok kısa',
			'validation.phoneTooLong' => 'Numara çok uzun',
			'validation.fieldRequired' => ({required Object field}) => '${field} gerekli',
			'validation.fieldInvalid' => ({required Object field}) => '${field} geçersiz karakterler içeriyor',
			'errors.network' => 'Ağ hatası. Bağlantınızı kontrol edin.',
			'errors.rateLimit' => 'Çok fazla deneme. Lütfen bekleyip tekrar deneyin.',
			'errors.rateLimitWithSeconds' => ({required Object seconds}) => 'Çok fazla deneme. ${seconds} saniye sonra tekrar deneyin.',
			'errors.invalidCredentials' => 'Geçersiz telefon numarası veya şifre',
			'errors.sessionExpired' => 'Oturum süresi doldu. Lütfen tekrar giriş yapın.',
			'errors.authError' => 'Kimlik doğrulama hatası. Lütfen tekrar giriş yapın.',
			'errors.sessionRevoked' => 'Oturum iptal edildi. Lütfen tekrar giriş yapın.',
			'errors.permissionDenied' => 'Bunu yapma izniniz yok.',
			'errors.validationError' => 'Doğrulama hatası',
			'errors.serverError' => ({required Object code}) => 'Sunucu hatası (${code}). Lütfen tekrar deneyin.',
			'errors.socialLoginFailed' => 'Giriş başarısız oldu. Tekrar deneyin veya telefon numaranızı ve şifrenizi kullanın.',
			'errors.conflict' => 'Bu işlem şu anda tamamlanamıyor.',
			'errors.onboardingIncomplete' => 'Kaydı tamamlamak için lütfen tüm zorunlu alanları doldurun.',
			'errors.planLimitReached' => 'Plan limitinize ulaştınız. Daha fazlası için planınızı yükseltin.',
			'errors.chatUnavailable' => 'Bu hekim mevcut planında sohbet sunmuyor.',
			'errors.phoneNotVerified' => 'Giriş yapmadan önce lütfen telefon numaranızı doğrulayın.',
			'settings.title' => 'Ayarlar',
			'settings.account' => 'Hesap',
			'settings.profile' => 'Profil',
			'settings.notifications' => 'Bildirimler',
			'settings.appearance' => 'Görünüm',
			'settings.themeSystem' => 'Sistem',
			'settings.themeLight' => 'Açık',
			'settings.themeDark' => 'Koyu',
			'settings.language' => 'Dil',
			'settings.languageSystem' => 'Sistem varsayılanı',
			'settings.logoutTitle' => 'Çıkış',
			'settings.logoutConfirm' => 'Çıkış yapmak istediğinizden emin misiniz?',
			'settings.version' => 'DocLine v1.0.0',
			'settings.legal' => 'Gizlilik ve Koşullar',
			'security.title' => 'Güvenlik',
			'security.biometricLogin' => 'Biyometrik Giriş',
			'security.biometricLoginSubtitle' => 'Uygulamanın kilidini açmak için Face ID / Touch ID kullanın',
			'security.biometricPrompt' => 'DocLine\'ya erişmek için doğrulayın',
			'security.biometricUnavailable' => 'Bu cihazda biyometrik kimlik doğrulama kullanılamıyor',
			'security.biometricEnableFailed' => 'Biyometrik bilgileriniz doğrulanamadı. Tekrar deneyin.',
			'security.activeSessions' => 'Aktif Oturumlar',
			'security.activeSessionsSubtitle' => 'Hesabınıza şu anda giriş yapmış cihazlar',
			'security.thisDevice' => 'Bu cihaz',
			'security.lastActive' => ({required Object date}) => 'Son aktif: ${date}',
			'security.revoke' => 'İptal Et',
			'security.revokeConfirmTitle' => 'Cihaz iptal edilsin mi?',
			'security.revokeConfirmMessage' => ({required Object name}) => '${name} oturumu kapatılacak. Hesap bilgileriyle tekrar giriş yapabilir.',
			'security.revokeCurrentConfirmMessage' => 'Bu sizin mevcut cihazınız — iptal ederseniz hemen çıkış yaparsınız.',
			'security.revokeFailed' => 'Bu cihaz iptal edilemedi. Tekrar deneyin.',
			'security.signOutAllDevices' => 'Tüm cihazlardan çıkış yap',
			'security.signOutAllConfirmTitle' => 'Her yerden çıkış yapılsın mı?',
			'security.signOutAllConfirmMessage' => 'Bu cihaz dahil tüm cihazlarda oturumunuz kapatılacak.',
			'security.signOutAllFailed' => 'Tüm cihazlardan çıkış yapılamadı. Tekrar deneyin.',
			'security.noDevices' => 'Aktif oturum bulunamadı',
			'security.loadFailed' => 'Aktif oturumlarınız yüklenemedi',
			'security.changePhone' => 'Telefon Numarasını Değiştir',
			'security.changePhoneSubtitle' => 'Yeni telefon numaranıza bir doğrulama kodu göndereceğiz. Onayladıktan sonra yeni numarayla giriş yapacaksınız.',
			'security.sendCode' => 'Kod Gönder',
			'security.codeSentTo' => ({required Object phone}) => '${phone} numarasına gönderdiğimiz 6 haneli kodu girin',
			'security.confirmNewPhone' => 'Yeni Numarayı Onayla',
			'security.changePhoneSuccess' => 'Telefon numaranız değiştirildi. Yeni numaranızla tekrar giriş yapın.',
			'security.dangerZone' => 'Tehlikeli Bölge',
			'security.deactivateAccount' => 'Hesabı Devre Dışı Bırak',
			'security.deactivateAccountSubtitle' => 'Verilerinizi silmeden hesabınızı devre dışı bırakın',
			'security.deactivateConfirmTitle' => 'Hesap devre dışı bırakılsın mı?',
			'security.deactivateConfirmMessage' => 'Hesabınız devre dışı bırakılacak ve tüm cihazlarda oturumunuz kapatılacak. Verileriniz silinmez. Yeniden etkinleştirmek için destek ekibiyle iletişime geçin.',
			'security.deactivate' => 'Devre Dışı Bırak',
			'security.deactivateSuccess' => 'Hesabınız devre dışı bırakıldı.',
			'security.deleteAccount' => 'Hesabı Kalıcı Olarak Sil',
			'security.deleteAccountSubtitle' => 'Verilerinizi silin. Bu işlem geri alınamaz.',
			'security.deleteConfirmTitle' => 'Hesabınız kalıcı olarak silinsin mi?',
			'security.deleteConfirmWarning' => 'Bu işlem kalıcıdır ve geri alınamaz.',
			'security.deleteConfirmMessage' => 'Profiliniz, tıbbi kayıtlarınız, reçeteleriniz ve mesajlarınız kalıcı olarak silinecek. Yaklaşan randevularınız iptal edilecek ve uygun olduğunda ücret iadesi yapılacaktır. Ödeme kayıtları, kanunen gerekli muhasebe amaçları için anonimleştirilmiş biçimde saklanır.',
			'security.deleteAccountSuccess' => 'Hesabınız kalıcı olarak silindi.',
			'status.confirmed' => 'Onaylandı',
			'status.pending' => 'Beklemede',
			'status.cancelled' => 'İptal edildi',
			'status.declined' => 'Reddedildi',
			'status.requiresRescheduling' => 'Yeniden planlanmalı',
			'status.completed' => 'Tamamlandı',
			'status.noShow' => 'Gelmedi',
			'home.helloDoctor' => ({required Object name}) => 'Merhaba, Dr. ${name}!',
			'home.helloPatient' => ({required Object name}) => 'Merhaba, ${name}!',
			'home.doctorSubtitle' => 'Programınızı ve\nrandevularınızı yönetin.',
			'home.patientSubtitle' => 'Bir doktor bulun ve\nrandevu alın.',
			'home.pendingRequests' => 'Bekleyen İstekler',
			'home.upcoming' => 'Yaklaşan',
			'home.findDoctor' => 'Doktor Bul',
			'home.aiAssistant' => 'AI Asistan',
			'home.myAppointments' => 'Randevularım',
			'home.appointments' => 'Randevular',
			'home.workplaces' => 'İş Yerleri',
			'home.blockTime' => 'Zamanı Engelle',
			'home.profile' => 'Profil',
			'home.allCaughtUp' => 'Her şey güncel',
			'home.noPendingRequests' => 'Bekleyen randevu isteği yok',
			'home.couldNotLoadAppointments' => 'Randevular yüklenemedi',
			'home.noUpcoming' => 'Yaklaşan randevu yok',
			'home.bookFirst' => 'Bir doktorla ilk randevunuzu alın',
			'home.findADoctor' => 'Doktor Bul',
			'home.myWaitlist' => 'Bekleme Listem',
			'home.leaveWaitlist' => 'Ayrıl',
			'home.statsThisMonth' => 'Bu ay',
			'home.statsPatients' => 'Hastalar',
			'home.statsAcceptRate' => 'Kabul oranı',
			'home.statsPending' => 'Bekleyenler',
			'home.schedule' => 'Takvim',
			'appointments.title' => 'Randevular',
			'appointments.myTitle' => 'Randevularım',
			'appointments.tabPending' => 'Bekleyen',
			'appointments.tabAll' => 'Tümü',
			'appointments.tabUpcoming' => 'Yaklaşan',
			'appointments.tabPast' => 'Geçmiş',
			'appointments.noPendingRequests' => 'Bekleyen istek yok',
			'appointments.newRequestsAppear' => 'Yeni randevu istekleri burada görünecek',
			'appointments.noAppointments' => 'Randevu yok',
			'appointments.appointmentsAppear' => 'Randevularınız burada görünecek',
			'appointments.noUpcoming' => 'Yaklaşan randevu yok',
			'appointments.bookFirst' => 'Bir doktorla ilk randevunuzu alın',
			'appointments.noPast' => 'Geçmiş randevu yok',
			'appointments.pastAppear' => 'Tamamlanan ve iptal edilen randevular burada görünür',
			'appointments.couldNotLoad' => 'Randevular yüklenemedi',
			'appointments.detailTitle' => 'Randevu',
			'appointments.patient' => 'Hasta',
			'appointments.doctor' => 'Doktor',
			'appointments.workplace' => 'İş Yeri',
			'appointments.dateTime' => 'Tarih ve Saat',
			'appointments.reason' => 'Sebep',
			'appointments.doctorNotes' => 'Doktor Notları',
			'appointments.cancelTitle' => 'Randevuyu İptal Et',
			'appointments.cancelConfirm' => 'Bu randevuyu iptal etmek istediğinizden emin misiniz?',
			'appointments.cancelAction' => 'Randevuyu İptal Et',
			'appointments.cancelledSuccess' => 'Randevu iptal edildi.',
			'appointments.cancelledRefunded' => 'Randevu iptal edildi. Ödemeniz iade edildi.',
			'appointments.cancelledNoRefund' => 'Randevu iptal edildi. Randevu saatine çok yakın olduğu için iade yapılmadı.',
			'appointments.bookedTitle' => 'Randevu alındı!',
			'appointments.bookedMessage' => 'Randevu isteğiniz gönderildi.',
			'appointments.reschedule' => 'Yeniden planla',
			'appointments.rescheduleTitle' => 'Randevuyu yeniden planla',
			'appointments.reviewTitle' => 'Yorum yaz',
			'appointments.reviewRating' => 'Puan',
			'appointments.reviewComment' => 'Yorum (isteğe bağlı)',
			'appointments.reviewSubmit' => 'Gönder',
			'appointments.markCompleted' => 'Tamamlandı olarak işaretle',
			'appointments.rescheduledSuccess' => 'Randevu başarıyla yeniden planlandı.',
			'appointments.reviewSubmitted' => 'Değerlendirme gönderildi. Teşekkürler!',
			'appointments.yourReview' => 'Değerlendirmeniz',
			'appointments.editReviewTitle' => 'Değerlendirmeyi Düzenle',
			'appointments.reviewUpdated' => 'Değerlendirme güncellendi.',
			'appointments.deleteReviewTitle' => 'Değerlendirmeyi Sil',
			'appointments.deleteReviewConfirm' => 'Değerlendirmenizi silmek istediğinizden emin misiniz?',
			'appointments.reviewDeleted' => 'Değerlendirme silindi.',
			'appointments.requestReschedule' => 'Yeniden Planlama İste',
			'appointments.requestRescheduleTitle' => 'Yeniden Planlama',
			'appointments.requestRescheduleConfirm' => 'Hastadan yeni bir saat seçmesini isteyin mi? Randevu yeniden planlama gerektiriyor olarak işaretlenecek.',
			'appointments.requestRescheduleSuccess' => 'Yeniden planlama istendi. Hasta bilgilendirilecek.',
			'appointments.rescheduleNeededHint' => 'Doktor yeni bir saat seçmenizi istedi.',
			'appointments.markNoShow' => 'Gelmedi İşaretle',
			'appointments.markNoShowTitle' => 'Gelmedi Olarak İşaretle',
			'appointments.markNoShowConfirm' => 'Bu randevuyu gelmedi olarak işaretleyelim mi? Hastanın gelmediği kaydedilir.',
			'appointments.disputeNoShow' => 'İtiraz et',
			'appointments.disputeNoShowTitle' => 'Gelmedi kaydına itiraz',
			'appointments.disputeNoShowHint' => 'Bunun neden hatalı işaretlendiğini düşündüğünüzü bize bildirin — destek ekibimiz inceleyecek.',
			'appointments.disputeNoShowSubmit' => 'Gönder',
			'appointments.disputeNoShowSubmitted' => 'İtirazınız gönderildi. İnceleyip sizinle iletişime geçeceğiz.',
			'appointments.disputeNoShowOpen' => 'İtiraz gönderildi — inceleniyor',
			'booking.bookWith' => ({required Object name}) => 'Randevu — ${name}',
			'booking.selectWorkplace' => 'İş Yeri Seçin',
			'booking.pickDate' => 'Tarih seçin',
			'booking.slotsAppear' => 'Uygun zaman aralıkları burada görünecek',
			'booking.couldNotLoadSlots' => 'Zaman aralıkları yüklenemedi',
			'booking.noAvailableSlots' => 'Uygun zaman aralığı yok',
			'booking.noOpenSlots' => 'Bu tarih için boş zaman yok. Başka bir gün deneyin.',
			'booking.confirmTitle' => 'Randevuyu Onayla',
			'booking.reasonForVisit' => 'Ziyaret sebebi (isteğe bağlı)',
			'booking.confirmButton' => 'Randevuyu Onayla',
			'booking.doctorLabel' => 'Doktor',
			'booking.workplaceLabel' => 'İş Yeri',
			'booking.addressLabel' => 'Adres',
			'booking.startLabel' => 'Başlangıç',
			'booking.endLabel' => 'Bitiş',
			'booking.tryDifferentDate' => 'Farklı bir tarih deneyin',
			'booking.earliestPreselected' => 'En yakın uygun zaman önceden seçildi',
			'booking.continueAt' => ({required Object time}) => 'Devam et — ${time}',
			'doctorSearch.title' => 'Doktor Bul',
			'doctorSearch.searchByName' => 'İsme göre ara...',
			'doctorSearch.city' => 'Şehir',
			'doctorSearch.search' => 'Ara',
			'doctorSearch.noDoctorsFound' => 'Doktor bulunamadı',
			'doctorSearch.adjustSearch' => 'Aramanızı veya filtrelerinizi değiştirmeyi deneyin',
			'doctorSearch.couldNotLoadDoctors' => 'Doktorlar yüklenemedi',
			'doctorSearch.loadMore' => 'Daha fazla göster',
			'doctorSearch.spec.general' => 'Genel',
			'doctorSearch.spec.cardiology' => 'Kardiyoloji',
			'doctorSearch.spec.dermatology' => 'Dermatoloji',
			'doctorSearch.spec.neurology' => 'Nöroloji',
			'doctorSearch.spec.orthopedics' => 'Ortopedi',
			'doctorSearch.spec.pediatrics' => 'Pediatri',
			'doctorSearch.spec.psychiatry' => 'Psikiyatri',
			'doctorSearch.spec.gynecology' => 'Jinekoloji',
			'doctorSearch.spec.urology' => 'Üroloji',
			'doctorSearch.spec.ophthalmology' => 'Oftalmoloji',
			'doctorSearch.spec.ent' => 'KBB',
			'doctorSearch.noAvailability' => 'Uygunluk yok',
			'doctorSearch.availableToday' => 'Bugün müsait',
			'doctorSearch.availableTomorrow' => 'Yarın müsait',
			'doctorSearch.availableOn' => ({required Object date}) => '${date} müsait',
			'doctorSearch.sortBy' => 'Sırala',
			'doctorSearch.sortDefault' => 'İlgi',
			'doctorSearch.sortRating' => 'En yüksek puan',
			'doctorSearch.sortPriceLow' => 'En düşük fiyat',
			'doctorSearch.sortName' => 'İsim (A–Z)',
			'doctorSearch.sortNearestSlot' => 'En erken müsaitlik',
			'doctorSearch.sortDistance' => 'Bana en yakın',
			'doctorSearch.locationDenied' => 'Mesafeye göre sıralamak için konum izni gerekiyor. Ayarlardan izin verin veya şehir filtresini kullanın.',
			'doctorSearch.locationUnavailable' => 'Konumunuz alınamadı. Konum hizmetlerinin açık olduğundan emin olun veya şehir filtresini kullanın.',
			'doctorSearch.distanceKm' => ({required Object km}) => '${km} km',
			'doctorDetail.profileTitle' => 'Doktor Profili',
			'doctorDetail.couldNotLoadProfile' => 'Profil yüklenemedi',
			'doctorDetail.about' => 'Hakkında',
			'doctorDetail.workplaces' => 'İş Yerleri',
			'doctorDetail.minPerSlot' => ({required Object min}) => 'aralık başına ${min} dk',
			'doctorDetail.bookAppointment' => 'Randevu Al',
			'doctorDetail.consultationFee' => 'Muayene ücreti',
			'doctorDetail.reviews' => 'Yorumlar',
			'doctorDetail.reviewsCount' => ({required Object count}) => '${count} değerlendirme',
			'doctorDetail.joinWaitlist' => 'Bekleme listesine katıl',
			'doctorDetail.leaveWaitlist' => 'Bekleme listesinden çık',
			'profile.title' => 'Profil',
			'profile.changePassword' => 'Şifreyi Değiştir',
			'profile.currentPassword' => 'Mevcut Şifre',
			'profile.newPassword' => 'Yeni Şifre',
			'profile.confirmNewPassword' => 'Yeni Şifreyi Onayla',
			'profile.firstName' => 'Ad',
			'profile.lastName' => 'Soyad',
			'profile.phone' => 'Telefon',
			'profile.failedToSave' => 'Profil kaydedilemedi.',
			'profile.professionalInfo' => 'Mesleki Bilgiler',
			'profile.bio' => 'Biyografi',
			'profile.bioHint' => 'Deneyiminizin kısa açıklaması',
			'profile.consultationFee' => 'Muayene ücreti',
			'profile.medicalInfo' => 'Tıbbi Bilgiler',
			'profile.allergies' => 'Alerjiler',
			'profile.allergiesHint' => 'ör. Penisilin, fıstık',
			'profile.chronicConditions' => 'Kronik hastalıklar',
			'profile.chronicConditionsHint' => 'ör. Diyabet, hipertansiyon',
			'profile.medications' => 'Mevcut ilaçlar',
			'profile.medicationsHint' => 'ör. Metformin 500mg',
			'profile.appointmentLength' => 'Randevu süresi',
			'profile.cancellationWindow' => 'İptal süresi',
			'profile.cancellationWindowHint' => 'Hastaların randevudan ne kadar önce iptal/erteleme yapabileceği.',
			'profile.hoursValue' => ({required Object h}) => '${h} sa',
			'notifications.title' => 'Bildirimler',
			'notifications.noNotifications' => 'Bildirim yok',
			'notifications.allCaughtUp' => 'Her şeyi gördünüz',
			'notifications.couldNotLoad' => 'Bildirimler yüklenemedi',
			'notifications.markAllRead' => 'Tümünü okundu işaretle',
			'notifications.settingsTitle' => 'Bildirim ayarları',
			'notifications.pushEnabled' => 'Push bildirimleri',
			'notifications.pushEnabledSubtitle' => 'Randevular ve güncellemeler için bu cihazda uyarılar',
			'notifications.emailEnabled' => 'E-posta bildirimleri',
			'notifications.emailEnabledSubtitle' => 'Güncellemeler e-posta adresinize gönderilir',
			'notifications.categoriesTitle' => 'Push kategorileri',
			'notifications.careCategory' => 'Randevular ve bakım',
			'notifications.careCategorySubtitle' => 'Rezervasyonlar, hatırlatmalar, reçeteler',
			'notifications.messagesCategory' => 'Mesajlar',
			'notifications.messagesCategorySubtitle' => 'Yeni sohbet mesajları',
			'notifications.accountCategory' => 'Hesap ve ödemeler',
			'notifications.accountCategorySubtitle' => 'Doğrulama, ödemeler, abonelik',
			'notifications.quietHoursTitle' => 'Sessiz saatler',
			'notifications.quietHoursEnabled' => 'Sessiz saatleri etkinleştir',
			'notifications.quietHoursSubtitle' => 'Bu saatler arasında push bildirimleri durdurulur',
			'notifications.quietHoursStart' => 'Başlangıç',
			'notifications.quietHoursEnd' => 'Bitiş',
			'workplaces.title' => 'İş Yerlerim',
			'workplaces.noWorkplacesYet' => 'Henüz iş yeri yok',
			'workplaces.tapToAdd' => 'İlk iş yerinizi eklemek için + simgesine dokunun',
			'workplaces.couldNotLoad' => 'İş yerleri yüklenemedi',
			'workplaces.deleteTitle' => 'İş Yerini Sil',
			'workplaces.deleteConfirm' => ({required Object name}) => '"${name}" silinsin mi?',
			'workplaces.cannotDelete' => 'İş yeri silinemiyor',
			'workplaces.workingHours' => 'Çalışma Saatleri',
			'workplaces.setAsPrimary' => 'Birincil Yap',
			'addWorkplace.addTitle' => 'İş Yeri Ekle',
			'addWorkplace.editTitle' => 'İş Yerini Düzenle',
			'addWorkplace.name' => 'Ad',
			'addWorkplace.address' => 'Sokak Adresi',
			'addWorkplace.city' => 'Şehir',
			'addWorkplace.type' => 'Tür',
			'addWorkplace.clinic' => 'Klinik',
			'addWorkplace.hospital' => 'Hastane',
			'addWorkplace.privatePractice' => 'Özel Muayenehane',
			'addWorkplace.failedToSave' => 'İş yeri kaydedilemedi.',
			'addWorkplace.addButton' => 'İş Yeri Ekle',
			'addWorkplace.saveChanges' => 'Değişiklikleri Kaydet',
			'addWorkplace.pickOnMap' => 'Haritadan Seç',
			'addWorkplace.mapPickerTitle' => 'Konum Seçin',
			'addWorkplace.useMyLocation' => 'Konumumu kullan',
			'addWorkplace.confirmLocation' => 'Konumu Onayla',
			'addWorkplace.locationSet' => 'Konum haritadan ayarlandı ✓',
			'addWorkplace.locationPermissionDenied' => 'Mevcut konumunuzu kullanmak için izin gerekiyor. Haritayı elle de hareket ettirebilirsiniz.',
			'addWorkplace.locationUnavailable' => 'Konumunuz alınamadı. Haritayı elle de hareket ettirebilirsiniz.',
			'workingHours.title' => 'Çalışma Saatleri',
			'workingHours.sectionHint' => 'Hastaların bu adreste sizden randevu alabileceği gün ve saatleri belirleyin.',
			'workingHours.invalidRange' => 'Etkin her gün için bitiş saati başlangıç saatinden sonra olmalıdır.',
			'workingHours.saved' => 'Çalışma saatleri kaydedildi',
			'workingHours.failedToSave' => 'Çalışma saatleri kaydedilemedi',
			'workingHours.days.monday' => 'Pazartesi',
			'workingHours.days.tuesday' => 'Salı',
			'workingHours.days.wednesday' => 'Çarşamba',
			'workingHours.days.thursday' => 'Perşembe',
			'workingHours.days.friday' => 'Cuma',
			'workingHours.days.saturday' => 'Cumartesi',
			'workingHours.days.sunday' => 'Pazar',
			'blockTime.title' => 'Zamanı Engelle',
			'blockTime.dateRange' => 'Tarih Aralığı',
			'blockTime.tapToSelect' => 'Tarihleri seçmek için dokunun',
			'blockTime.reason' => 'Sebep (isteğe bağlı)',
			'blockTime.notifyPatients' => 'Etkilenen hastaları bilgilendir',
			'blockTime.notifyDesc' => 'Bu dönemde randevusu olan hastalara bildirim gönder',
			'blockTime.selectDateRange' => 'Lütfen bir tarih aralığı seçin.',
			'blockTime.failedToBlock' => 'Zaman engellenemedi. Lütfen tekrar deneyin.',
			'blockTime.blockButton' => 'Dönemi Engelle',
			'onboarding.title' => 'Profilinizi Tamamlayın',
			'onboarding.professionalInfo' => 'Mesleki bilgiler',
			'onboarding.tellPatients' => 'Hastalara muayenehaneniz hakkında bilgi verin.',
			'onboarding.specialization' => 'Uzmanlık',
			'onboarding.selectSpecialization' => 'Uzmanlığınızı seçin',
			'onboarding.couldNotLoadSpecs' => 'Uzmanlıklar yüklenemedi. Geri çekip tekrar deneyin.',
			'onboarding.licenseNumber' => 'Lisans numarası',
			'onboarding.licenseHint' => 'örn. AZ-123456',
			'onboarding.bio' => 'Biyografi (isteğe bağlı)',
			'onboarding.bioHint' => 'Hastaların profilinizde göreceği kısa bir tanıtım.',
			'onboarding.appointmentLength' => 'Randevu süresi',
			'onboarding.slotQuestion' => 'Tek bir randevu aralığı ne kadar?',
			'onboarding.changeLater' => 'Bunu daha sonra profilinizden değiştirebilirsiniz.',
			'onboarding.minutes' => ({required Object min}) => '${min} dk',
			'onboarding.verificationDoc' => 'Doğrulama belgesi',
			'onboarding.uploadDiploma' => 'Tıp diplomanızı veya lisansınızı yükleyin. Hesabınız doğrulanmadan önce bir yönetici inceler.',
			'onboarding.tapToChoose' => 'Dosya seçmek için dokunun',
			'onboarding.tapToReplace' => 'Değiştirmek için dokunun',
			'onboarding.anyFileType' => 'Her tür dosya, 10 MB\'a kadar',
			'onboarding.selectSpecError' => 'Lütfen uzmanlığınızı seçin.',
			'onboarding.licenseError' => 'Lütfen lisans numaranızı girin.',
			'onboarding.diplomaError' => 'Lütfen diplomanızı ekleyin.',
			'onboarding.checkDetails' => 'Lütfen bilgilerinizi kontrol edip tekrar deneyin.',
			'onboarding.continueButton' => 'Devam Et',
			'onboarding.finish' => 'Bitir',
			'pendingVerification.title' => 'Doğrulama Bekleniyor',
			'pendingVerification.message' => 'Hesabınız inceleniyor. Doğrulandığında sizi bilgilendireceğiz.',
			'pendingVerification.checkStatus' => 'Durumu kontrol et',
			'pendingVerification.stillPending' => 'Hâlâ inceleniyor. Doğrulandığında sizi bilgilendireceğiz.',
			'phoneField.label' => 'Telefon Numarası',
			'phoneField.selectCountry' => 'Ülke Seçin',
			'phoneField.searchCountry' => 'Ülke veya kod ara…',
			'phoneField.noCountriesFound' => 'Ülke bulunamadı',
			'locations.pickCity' => 'Şehir Seçin',
			'locations.searchHint' => 'Şehir veya bölge ara…',
			'locations.noResultsFound' => 'Şehir bulunamadı',
			'locations.couldNotLoad' => 'Şehirler yüklenemedi. Tekrar denemek için dokunun.',
			'locations.allCities' => 'Tüm şehirler',
			'splash.tagline' => 'Sağlığınız, basitleştirildi',
			'appIntro.page1Title' => 'Doğru doktoru bulun',
			'appIntro.page1Subtitle' => 'Uzmanlığa, şehre ve puana göre arayın — size uygun bir randevu alın.',
			'appIntro.page2Title' => 'Yapay zekâ asistanına sorun',
			'appIntro.page2Subtitle' => 'Belirtilerinizi anlatın, hangi uzmana başvurmanız gerektiğini öğrenin.',
			'appIntro.page3Title' => 'Her şey tek bir uygulamada',
			'appIntro.page3Subtitle' => 'Randevularınızı yönetin, tedavinizi takip edin ve uygulamayı kendi dilinizde güvenle kullanın.',
			'appIntro.skip' => 'Geç',
			'appIntro.next' => 'İleri',
			'appIntro.getStarted' => 'Başla',
			'agenda.title' => 'Takvim',
			'agenda.today' => 'Bugün',
			'agenda.empty' => 'Randevu yok',
			'agenda.emptySubtitle' => 'Bu gün için planlanmış bir şey yok',
			'favorites.title' => 'Favoriler',
			'favorites.empty' => 'Henüz favori yok',
			'favorites.emptySubtitle' => 'Bir doktoru kaydetmek için kalbe dokunun',
			'favorites.add' => 'Favorilere ekle',
			'favorites.remove' => 'Favorilerden çıkar',
			'assistant.title' => 'AI Asistan',
			'assistant.newChat' => 'Yeni Sohbet',
			'assistant.empty' => 'Henüz sohbet yok',
			'assistant.emptySubtitle' => 'Belirtilerinizi anlatın, asistan hangi doktora gitmeniz gerektiğini önersin',
			'assistant.couldNotLoad' => 'Sohbetler yüklenemedi',
			'assistant.couldNotLoadChat' => 'Sohbet yüklenemedi',
			'assistant.newConversation' => 'Yeni sohbet',
			'assistant.deleteTitle' => 'Sohbet silinsin mi?',
			'assistant.deleteConfirm' => 'Sohbet ve tüm mesajları silinecek.',
			'assistant.inputHint' => 'Belirtilerinizi anlatın…',
			'assistant.send' => 'Gönder',
			'assistant.sendFailed' => 'Mesaj gönderilemedi. Lütfen tekrar deneyin.',
			'assistant.typing' => 'Asistan yazıyor…',
			'assistant.startTitle' => 'Nasıl yardımcı olabilirim?',
			'assistant.startSubtitle' => 'Başlamak için sizi rahatsız eden şeyi anlatın',
			'assistant.book' => 'Randevu al',
			'assistant.reportTooltip' => 'Yanıtı bildir',
			'assistant.reportTitle' => 'Yanıtı bildir',
			'assistant.reportHint' => 'Neden (isteğe bağlı)',
			'assistant.reportSubmit' => 'Bildir',
			'assistant.reportSuccess' => 'Teşekkürler, yanıt bildirildi.',
			'assistant.reportFailed' => 'Yanıt bildirilemedi. Lütfen tekrar deneyin.',
			'assistant.topicsTooltip' => 'Konular',
			'assistant.topicsSheetTitle' => 'Bir konu seçin',
			'messaging.title' => 'Mesajlar',
			'messaging.sendMessage' => 'Mesaj Gönder',
			'messaging.typeMessage' => 'Bir mesaj yazın…',
			'messaging.send' => 'Gönder',
			'messaging.empty' => 'Henüz yazışma yok',
			'messaging.emptySubtitle' => 'Yazışmalarınız burada görünecek.',
			'messaging.disclaimer' => 'Bu bir acil durum hattı değildir. Acil durumlarda acil servisleri arayın.',
			'messaging.noSharedHistory' => 'Bir doktora yalnızca onunla ortak bir randevu geçmişiniz olduğunda mesaj gönderebilirsiniz.',
			'messaging.newMessage' => 'Yeni bir mesajınız var',
			'legal.title' => 'Gizlilik ve Koşullar',
			'legal.controllerNotice' => 'DocLine, AuxioDev (auxiodev.com) tarafından Azerbaycan\'da oluşturulmuş ve işletilmektedir ("biz"). Son güncelleme: Temmuz 2026.',
			'legal.privacyTitle' => 'Gizlilik Politikası',
			'legal.privacyIntro' => 'Bu politika, DocLine\'nun hangi kişisel verileri, neden topladığını ve nasıl koruduğunu açıklar. Tıbbi randevu alma ve yönetme, sağlık bilgilerinizi doğal olarak içerir — bu aşağıda ayrıntılı olarak açıklanmıştır.',
			'legal.sections.identity.title' => 'Kimlik verileri',
			'legal.sections.identity.body' => 'Ad ve soyad, e-posta adresi, telefon numarası (isteğe bağlı), şifreniz (geri döndürülemez bir hash olarak saklanır, asla düz metin olarak değil) ve tercih ettiğiniz uygulama dili.',
			'legal.sections.health.title' => 'Sağlık verileri',
			'legal.sections.health.body' => 'Hasta olarak: kan grubu, alerjiler, kronik hastalıklar, kullandığınız ilaçlar, randevu alırken belirttiğiniz sebep, yüklediğiniz tıbbi belgeler (tahlil sonuçları, görüntüleme, diğer kayıtlar), size yazılan reçeteler ve doktorunuzla mesajlaşma içeriğiniz. Semptom kontrol yapay zeka asistanını kullanırsanız, sorularınız ve yanıtları da aynı şekilde işlenir. Sağlık verileri Azerbaycan mevzuatına göre en yüksek koruma seviyesine sahiptir ve bunları yalnızca ayrı, açık rızanızla topluyoruz (aşağıda "Hukuki dayanak" bölümüne bakın).',
			'legal.sections.professional.title' => 'Mesleki veriler (doktorlar)',
			'legal.sections.professional.body' => 'Uzmanlık alanı, lisans numarası, diploma veya diğer doğrulama belgesi, işyeri bilgileri ve muayene ücreti. Bu bilgiler, profiliniz hastalara görünür olmadan önce ekibimiz tarafından incelenir.',
			'legal.sections.location.title' => 'Konum',
			'legal.sections.location.body' => 'İzninizle, doktorları size olan uzaklığa göre sıralamak için yaklaşık veya kesin konum. Yalnızca uygulama açıkken kullanılır — sunucularımızda asla saklanmaz.',
			'legal.sections.device.title' => 'Cihaz ve teknik veriler',
			'legal.sections.device.body' => 'Ayarlar bölümünden aktif oturumlarınızı görüp iptal edebilmeniz için cihaz kimlikleri ve oturum bilgileri, ayrıca randevu hatırlatmaları ve mesajları cihazınıza iletmek için bir push bildirim jetonu.',
			'legal.sections.payment.title' => 'Ödeme verileri',
			'legal.sections.payment.body' => 'Uygulama içinden bir konsültasyon için ödeme yaparsanız, ödeme tamamen ödeme ortağımız Payriff tarafından işlenir — kart numaranızı asla görmez veya saklamayız. Randevu geçmişiniz için ödeme tutarını, durumunu ve bir referans kimliğini saklarız.',
			'legal.sections.family.title' => 'Aile üyesi profilleri',
			'legal.sections.family.body' => 'Kendi girişi olmayan bir aile üyesinin (çocuk veya bakmakla yükümlü olduğunuz biri) profilini yönetiyorsanız, yukarıdaki aynı sağlık verisi kategorileri onun için hesabınız altında kaydedilebilir. Bir aile üyesi eklediğinizde, onun ebeveyni, vasisi veya sağlık bilgilerini onun adına yönetmeye yetkili olduğunuzu onaylamış olursunuz.',
			'legal.sections.purposes.title' => 'Verilerinizi neden kullanıyoruz',
			'legal.sections.purposes.body' => 'Doktor bulup randevu alabilmeniz için; doktorların programlarını ve hastalarını yönetebilmesi için; randevu hatırlatmaları ve güncellemeler göndermek için; konsültasyon ödemelerini işlemek için; isteğe bağlı semptom kontrol yapay zeka özelliğini sunmak için; hesabınızı güvende tutmak için.',
			'legal.sections.legalBasis.title' => 'Hukuki dayanak ve rızanız',
			'legal.sections.legalBasis.body' => 'Verilerinizi, kayıt olurken verdiğiniz rıza temelinde işliyoruz. Sağlık verileri, Azerbaycan Cumhuriyeti "Kişisel Veriler Hakkında" Kanunu (No. 998-IIIQ) uyarınca özel kategori kişisel veridir ve toplanmadan önce açık, yazılı rızanızı gerektirir — kayıt ekranındaki onay kutusu tam olarak bunu kaydeder. Hesabınızı silerek rızanızı istediğiniz zaman geri çekebilirsiniz, ancak yasanın gerektirdiği durumlarda (örneğin vergi amaçlı mali kayıtlar) sınırlı kayıtları saklayabiliriz.',
			'legal.sections.thirdParties.title' => 'Verilerinizi başka kim işler',
			'legal.sections.thirdParties.body' => 'Yalnızca bizim talimatımızla ve burada açıklanan amaçlar için hareket eden güvenilir hizmet sağlayıcılar: Cloudinary (güvenli dosya depolama — belgeler ve fotoğraflar asla herkese açık değildir, yalnızca imzalı, süreli bağlantılarla erişilebilir); Firebase/Google (push bildirimleri ve tercih ederseniz Google ile giriş); Apple (tercih ederseniz Apple ile Oturum Açma); Payriff (uygulama içi ödemeler). Kişisel verilerinizi satmayız.',
			'legal.sections.retention.title' => 'Verilerinizi ne kadar süre saklıyoruz',
			'legal.sections.retention.body' => 'Hesabınız aktif olduğu sürece. Hesabınızı silerseniz, yasal olarak saklamamız gereken kayıtlar (örneğin vergi amaçlı ödeme kayıtları) dışında, kişisel verilerinizi makul bir süre içinde kaldırırız.',
			'legal.sections.rights.title' => 'Haklarınız',
			_ => null,
		} ?? switch (path) {
			'legal.sections.rights.body' => 'Hakkınızda tuttuğumuz verilere erişebilir, hatalı verilerin düzeltilmesini, hesabınızın ve verilerinizin silinmesini talep edebilir ve rızanızı istediğiniz zaman geri çekebilirsiniz. Bunların çoğu doğrudan Profil > Ayarlar altında mevcuttur; diğer her şey için aşağıdan bizimle iletişime geçin.',
			'legal.sections.security.title' => 'Verilerinizi nasıl koruyoruz',
			'legal.sections.security.body' => 'Doktorunuzla mesajlaşmalarınız ve yapay zeka asistanı konuşmaları şifrelenir. Yüklenen belgeler ve fotoğraflar özel olarak saklanır, yalnızca güvenli imzalı bağlantılarla erişilebilir, asla herkese açık dosyalar olarak değil. Şifreler asla okunabilir biçimde saklanmaz.',
			'legal.sections.permissions.title' => 'İstediğimiz izinler',
			'legal.sections.permissions.body' => 'Kamera ve fotoğraf galerisi — profil fotoğrafı ayarlamak ve tıbbi belgeler yüklemek için. Konum — doktorları size olan uzaklığa göre sıralamak için. Bildirimler — randevu hatırlatmaları ve mesajlar iletmek için. Biyometri (Face ID / parmak izi) — uygulamanın kilidini açmanın isteğe bağlı, daha hızlı bir yolu; biyometrik verileriniz asla cihazınızdan çıkmaz, yalnızca işletim sisteminden bir evet/hayır onayı alırız.',
			'legal.sections.children.title' => 'Yaş şartı',
			'legal.sections.children.body' => 'DocLine hesapları yetişkinler içindir. 18 yaşından küçükseniz, lütfen bir ebeveyn veya vasinin aile/bakmakla yükümlü olunan profil özelliğini kullanarak sizin adınıza bir hesap oluşturmasını ve yönetmesini sağlayın.',
			'legal.termsTitle' => 'Kullanım Koşulları',
			'legal.termsIntro' => 'Bir hesap oluşturarak aşağıdakileri kabul etmiş olursunuz.',
			'legal.termsBody' => 'Kendiniz hakkında doğru bilgi verin. DocLine\'yu yalnızca tıbbi randevu bulma, alma ve yönetme amacıyla kullanın. Giriş bilgilerinizi gizli tutun. DocLine sizi bağımsız, lisanslı tıp uzmanlarıyla buluşturur — kendimiz bir sağlık kuruluşu değiliz ve semptom kontrol yapay zeka asistanı profesyonel tıbbi teşhis veya tavsiyenin yerini tutmaz. Tıbbi bir acil durumda, bu uygulamayı değil doğrudan acil servisleri arayın. Bu koşulları ihlal eden veya platformu kötüye kullanan hesapları askıya alabilir veya sonlandırabiliriz.',
			'legal.contact' => 'Verileriniz hakkında sorularınız mı var? support@auxiodev.com adresine yazın',
			'legal.consentPrefix' => '',
			'legal.consentPrivacyLink' => 'Gizlilik Politikası',
			'legal.consentMiddle' => ' ve ',
			'legal.consentTermsLink' => 'Kullanım Koşulları',
			'legal.consentSuffix' => '\'nı okudum, kabul ediyorum ve orada açıklandığı şekilde sağlık verilerimin işlenmesine açıkça rıza gösteriyorum.',
			'legal.viewAsPdf' => 'PDF olarak görüntüle',
			'legal.pdfDocumentTitle' => 'DocLine — Gizlilik Politikası ve Kullanım Koşulları',
			'legal.pdfLoadError' => 'Belge yüklenemedi. Lütfen internet bağlantınızı kontrol edip tekrar deneyin.',
			'medications.title' => 'İlaçlar',
			'medications.editMedication' => 'İlacı Düzenle',
			'medications.name' => 'Ad',
			'medications.dosage' => 'Doz',
			'medications.notes' => 'Notlar',
			'medications.form' => 'Form',
			'medications.formPill' => 'Hap',
			'medications.formCapsule' => 'Kapsül',
			'medications.formLiquid' => 'Sıvı',
			'medications.formInjection' => 'Enjeksiyon',
			'medications.formOther' => 'Diğer',
			'medications.schedule' => 'Program',
			'medications.times' => 'Alım Saatleri',
			'medications.addTime' => 'Saat Ekle',
			'medications.daysOfWeek' => 'Haftanın Günleri',
			'medications.everyDay' => 'Her gün',
			'medications.startDate' => 'Başlangıç Tarihi',
			'medications.endDate' => 'Bitiş Tarihi',
			'medications.save' => 'Kaydet',
			'medications.delete' => 'Sil',
			'medications.deleteConfirmTitle' => 'İlacı Sil',
			'medications.deleteConfirmBody' => 'Bu ilacı silmek istediğinizden emin misiniz? Alım geçmişi saklanacak.',
			'medications.emptyTitle' => 'Henüz ilaç yok',
			'medications.emptySubtitle' => 'Doktorunuzun yazdığı ilaçlar randevunuzdan sonra burada görünecek.',
			'medications.todaysDoses' => 'Bugünkü Alımlar',
			'medications.markTaken' => 'Alındı',
			'medications.markSkipped' => 'Atla',
			'medications.statusTaken' => 'Alındı',
			'medications.statusSkipped' => 'Atlandı',
			'medications.statusPending' => 'Bekliyor',
			'medications.reminderTitle' => ({required Object name}) => '${name} alma vakti',
			'medications.reminderBody' => ({required Object dosage}) => 'Doz: ${dosage}',
			'medications.tabActive' => 'Aktif',
			'medications.tabArchive' => 'Arşiv',
			'medications.fromPrescription' => 'Reçeteden',
			'medications.noSchedule' => 'Program ayarlanmadı — hatırlatma saati eklemek için dokunun',
			'medications.dayMon' => 'Pzt',
			'medications.dayTue' => 'Sal',
			'medications.dayWed' => 'Çar',
			'medications.dayThu' => 'Per',
			'medications.dayFri' => 'Cum',
			'medications.daySat' => 'Cmt',
			'medications.daySun' => 'Paz',
			'medications.updatedSuccess' => 'İlaç güncellendi.',
			'medications.deletedSuccess' => 'İlaç silindi.',
			'medications.atLeastOneTime' => 'En az bir hatırlatma saati ekleyin',
			'prescriptions.title' => 'Reçeteler',
			'prescriptions.writeTitle' => 'Reçete Yaz',
			'prescriptions.addDrug' => 'İlaç Ekle',
			'prescriptions.drugName' => 'İlaç Adı',
			'prescriptions.dosage' => 'Doz',
			'prescriptions.frequency' => 'Kullanım Sıklığı',
			'prescriptions.duration' => 'Süre',
			'prescriptions.instructions' => 'Talimatlar',
			'prescriptions.notes' => 'Notlar',
			'prescriptions.save' => 'Kaydet',
			'prescriptions.empty' => 'Henüz reçete yok',
			'prescriptions.emptySubtitle' => 'Doktorunuzun yazdığı reçeteler burada görünecek.',
			'prescriptions.viewDetails' => 'Detayları Gör',
			'prescriptions.issuedBy' => ({required Object name}) => 'Dr. ${name} tarafından yazıldı',
			'prescriptions.issuedOn' => ({required Object date}) => 'Yazılma tarihi: ${date}',
			'prescriptions.applyToMedications' => 'İlaçlarıma Ekle',
			'prescriptions.applySuccess' => 'İlaçlarınıza eklendi. Hatırlatma saatlerini ayarlayın.',
			'prescriptions.alreadyApplied' => 'Zaten ilaçlarınıza eklendi',
			'prescriptions.noPrescriptionYet' => 'Bu randevu için henüz reçete yazılmadı',
			'prescriptions.writePrescription' => 'Reçete Yaz',
			'prescriptions.prescriptionIssued' => 'Reçete yazıldı.',
			'prescriptions.removeDrug' => 'Kaldır',
			'prescriptions.atLeastOneDrug' => 'En az bir ilaç ekleyin',
			'prescriptions.drugNameRequired' => 'İlaç adı gereklidir',
			'prescriptions.summaryTitle' => 'Reçete',
			'prescriptions.itemsCount' => ({required Object count}) => '${count} ilaç',
			'prescriptions.newPrescription' => 'Yeni Reçete',
			'prescriptions.youHavePrescription' => 'Bu randevu için bir reçete var',
			'records.title' => 'Sağlık Kayıtları',
			'records.upload' => 'Belge Yükle',
			'records.recordType' => 'Belge Türü',
			'records.typeLabResult' => 'Tahlil Sonucu',
			'records.typeImaging' => 'Görüntüleme',
			'records.typeDocument' => 'Belge',
			'records.typeOther' => 'Diğer',
			'records.recordTitle' => 'Başlık',
			'records.recordDate' => 'Tarih',
			'records.notes' => 'Notlar',
			'records.chooseFile' => 'Dosya Seç',
			'records.changeFile' => 'Dosyayı Değiştir',
			'records.noFileChosen' => 'Dosya seçilmedi',
			'records.save' => 'Kaydet',
			'records.delete' => 'Sil',
			'records.deleteConfirmTitle' => 'Belgeyi Sil',
			'records.deleteConfirmBody' => 'Bu belgeyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.',
			'records.empty' => 'Henüz sağlık kaydı yok',
			'records.emptySubtitle' => 'Tahlil sonuçlarını, görüntüleri ve diğer belgeleri tek bir yerde saklayın.',
			'records.view' => 'Görüntüle',
			'records.fileRequired' => 'Yüklemek için bir dosya seçin',
			'records.fileTooLarge' => 'Dosya çok büyük (maks. 15 MB)',
			'records.titleRequired' => 'Başlık gereklidir',
			'records.uploadSuccess' => 'Belge yüklendi.',
			'records.deletedSuccess' => 'Belge silindi.',
			'records.couldNotOpen' => 'Dosya açılamadı',
			'payments.title' => 'Ödeme',
			'payments.amount' => 'Tutar',
			'payments.payNow' => 'Şimdi Öde',
			'payments.payLater' => 'Sonra Öde',
			'payments.statusPending' => 'Ödeme Bekleniyor',
			'payments.statusPaid' => 'Ödendi',
			'payments.statusFailed' => 'Ödeme Başarısız',
			'payments.statusCancelled' => 'İptal Edildi',
			'payments.statusRefunded' => 'İade Edildi',
			'payments.statusRefundFailed' => 'İade Başarısız',
			'payments.paymentConfirmed' => 'Ödeme onaylandı. Teşekkürler!',
			'payments.openingBrowser' => 'Tarayıcı açılıyor…',
			'payments.checkStatus' => 'Durumu Kontrol Et',
			'family.title' => 'Aile',
			'family.myself' => 'Kendim',
			'family.addFamilyMember' => 'Aile Üyesi Ekle',
			'family.editFamilyMember' => 'Aile Üyesini Düzenle',
			'family.firstName' => 'Ad',
			'family.lastName' => 'Soyad',
			'family.relationship' => 'Yakınlık',
			'family.relationshipChild' => 'Çocuk',
			'family.relationshipSpouse' => 'Eş',
			'family.relationshipParent' => 'Ebeveyn',
			'family.relationshipSibling' => 'Kardeş',
			'family.relationshipOther' => 'Diğer',
			'family.dateOfBirth' => 'Doğum Tarihi',
			'family.bloodType' => 'Kan Grubu',
			'family.allergies' => 'Alerjiler',
			'family.chronicConditions' => 'Kronik hastalıklar',
			'family.medications' => 'Mevcut ilaçlar',
			'family.save' => 'Kaydet',
			'family.delete' => 'Sil',
			'family.deleteConfirmTitle' => 'Aile Üyesini Kaldır',
			'family.deleteConfirmBody' => 'Bu aile üyesini kaldırmak istediğinizden emin misiniz? Randevu, ilaç ve belge geçmişi saklanacak.',
			'family.empty' => 'Henüz aile üyesi yok',
			'family.emptySubtitle' => 'Randevularını, ilaçlarını ve belgelerini yönetmek için çocuğunuzu, eşinizi veya başka bir aile üyenizi ekleyin.',
			'family.bookingForQuestion' => 'Bu randevu kimin için?',
			'family.bookingForLabel' => ({required Object name}) => 'Randevu kimin için: ${name}',
			'family.forLabel' => ({required Object name}) => '${name} için',
			'family.ageYears' => ({required Object age}) => '${age} yaşında',
			'family.bookedByLabel' => ({required Object name}) => 'Randevuyu alan: ${name}',
			'family.contactEmail' => 'İletişim E-postası',
			'family.contactEmailHelp' => 'Eklendiklerini onlara bildireceğiz ve reddetmeleri için kolay bir yol sunacağız.',
			'family.contactPhoneOptional' => 'İletişim Telefonu (isteğe bağlı)',
			'family.contactEmailRequiredForAdult' => 'Bu aile üyesini bilgilendirebilmemiz için bir e-posta adresi gereklidir',
			'family.adultConsentNotice' => '18 yaşından büyük oldukları için onlara sizin tarafınızdan eklendiklerini bildiren bir e-posta göndereceğiz — uygulamaya ihtiyaçları yok ve bu bağlantıyı istedikleri zaman kaldırabilirler.',
			'family.noticeAlreadySent' => 'Eklendikleri konusunda onları bilgilendirdik. Bu bağlantıyı istedikleri zaman kaldırabilirler.',
			'family.noticePendingBadge' => 'Bildirim gönderildi',
			'subscription.title' => 'Abonelik',
			'subscription.planNameBasic' => 'Başlangıç',
			'subscription.planNamePro' => 'Profesyonel',
			'subscription.couldNotLoad' => 'Abonelik bilgileri yüklenemedi.',
			'subscription.nowActive' => 'Aboneliğiniz artık aktif!',
			'subscription.unavailable' => 'Abonelik şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.',
			'subscription.trialDaysLeft' => ({required Object days}) => 'Ücretsiz deneme — ${days} gün kaldı',
			'subscription.graceDaysLeft' => ({required Object days}) => 'Ek süre — yenilemek için ${days} gün kaldı',
			'subscription.expiredNotice' => 'Aboneliğinizin süresi doldu. Hastalar tarafından tekrar görünür olmak için abone olun.',
			'subscription.activeNotice' => 'Aboneliğiniz aktif.',
			'subscription.choosePlan' => 'Başlamak için bir plan seçin.',
			'subscription.currentPlan' => 'Mevcut Plan',
			'subscription.mostPopular' => 'En Popüler',
			'subscription.perMonth' => 'aylık',
			'subscription.manageOnWeb' => 'Aboneliğinizi auxiodev.com üzerinden yönetin',
			'subscription.featureUnlimitedWorkplaces' => 'Sınırsız klinik',
			'subscription.featureWorkplaces' => ({required Object count}) => '${count} kliniğe kadar',
			'subscription.featureUnlimitedBookings' => 'Sınırsız aylık randevu',
			'subscription.featureBookingsPerMonth' => ({required Object count}) => 'Ayda ${count} randevuya kadar',
			'subscription.featureChat' => 'Hasta sohbeti',
			'subscription.featurePromoted' => 'Öncelikli sıralama + "Peşəkar" rozeti',
			'subscription.renew' => 'Yenile',
			'subscription.subscribe' => 'Abone Ol',
			'subscription.planNameHospitalBasic' => 'Klinik',
			'subscription.planNameHospitalPro' => 'Klinik Plus',
			'subscription.featureDoctors' => ({required Object count}) => '${count} doktora kadar',
			'subscription.featureUnlimitedDoctors' => 'Sınırsız doktor',
			'subscription.featureAdvancedStats' => 'Gelişmiş istatistikler',
			'hospitalPicker.title' => 'Hastane Seçin',
			'hospitalPicker.searchHint' => 'Hastane adını arayın…',
			'hospitalPicker.noResultsFound' => 'Hastane bulunamadı',
			'hospitalPicker.selectCityFirst' => 'Önce şehir seçin',
			'hospitalPicker.addVariant' => ({required Object name}) => '"${name}" ekle',
			'hospitalPicker.pendingReview' => 'İncelemede',
			'hospitalRegistration.title' => 'Hastane Bilgileri',
			'hospitalRegistration.subtitle' => 'Şehrinizi seçin, ardından hastanenizi listede bulun veya ekleyin.',
			'hospitalRegistration.cityStep' => '1. Şehir',
			'hospitalRegistration.hospitalStep' => '2. Hastane',
			'hospitalRegistration.searchHint' => 'Hastane adını arayın…',
			'hospitalRegistration.noResultsFound' => 'Hastane bulunamadı',
			'hospitalRegistration.notFoundPrompt' => 'Hastanenizi bulamıyor musunuz?',
			'hospitalRegistration.addManually' => 'Manuel olarak ekle',
			'hospitalRegistration.useSearchInstead' => 'Tekrar ara',
			'hospitalRegistration.newHospitalName' => 'Hastane adı',
			'hospitalRegistration.selectedPrefix' => 'Seçildi:',
			'hospitalRegistration.pendingReviewNotice' => 'Yeni hastaneler başkalarına görünmeden önce ekibimiz tarafından incelenir.',
			'hospitalRegistration.submit' => 'Hesap Oluştur',
			'hospitalRegistration.hospitalRequired' => 'Devam etmek için hastanenizi seçin veya ekleyin',
			'hospitalHome.greeting' => ({required Object name}) => 'Merhaba, ${name}',
			'hospitalHome.subtitle' => 'Doktorlarınızı ve randevularınızı yönetin',
			'hospitalHome.doctors' => 'Doktorlar',
			'hospitalHome.inviteDoctor' => 'Doktor Davet Et',
			'hospitalHome.appointments' => 'Randevular',
			'hospitalHome.profile' => 'Profil',
			'hospitalHome.pendingRequests' => ({required Object count}) => '${count} bekleyen talep',
			'hospitalDoctors.title' => 'Doktorlar',
			'hospitalDoctors.tabConfirmed' => 'Onaylı',
			'hospitalDoctors.tabRequests' => 'Talepler',
			'hospitalDoctors.tabInvited' => 'Davet Edilen',
			'hospitalDoctors.noConfirmedDoctors' => 'Henüz onaylı doktor yok',
			'hospitalDoctors.noRequests' => 'Bekleyen talep yok',
			'hospitalDoctors.noInvited' => 'Bekleyen davet yok',
			'hospitalDoctors.approve' => 'Onayla',
			'hospitalDoctors.reject' => 'Reddet',
			'hospitalDoctors.remove' => 'Kaldır',
			'hospitalDoctors.removeConfirmTitle' => 'Doktor kaldırılsın mı?',
			'hospitalDoctors.removeConfirmMessage' => ({required Object name}) => '${name} artık hastanenizle ilişkili olmayacak. Bu, iş yerini ve randevularını etkilemez.',
			'hospitalDoctors.requestedToJoin' => 'Katılma talebinde bulundu',
			'hospitalDoctors.invitedAwaiting' => 'Davet edildi — yanıt bekleniyor',
			'hospitalDoctors.editHours' => 'Saatleri düzenle',
			'hospitalInvite.title' => 'Doktor Davet Et',
			'hospitalInvite.searchHint' => 'İsme veya uzmanlığa göre arayın…',
			'hospitalInvite.noResultsFound' => 'Doktor bulunamadı',
			'hospitalInvite.invite' => 'Davet Et',
			'hospitalInvite.invited' => 'Davet Edildi',
			'hospitalAppointments.title' => 'Randevular',
			'hospitalAppointments.empty' => 'Henüz randevu yok',
			'hospitalProfile.title' => 'Hastane Profili',
			'hospitalProfile.usageDoctors' => ({required Object limit, required Object count}) => '${limit} doktordan ${count}',
			'hospitalProfile.usageDoctorsUnlimited' => ({required Object count}) => '${count} doktor (sınırsız)',
			'hospitalProfile.manageSubscription' => 'Aboneliği Yönet',
			'hospitalDoctorHours.title' => 'Çalışma Saatleri',
			'hospitalDoctorHours.selectWorkplace' => 'Bir iş yeri seçin',
			'hospitalDoctorHours.saved' => 'Saatler kaydedildi',
			'doctorHospitals.title' => 'Hastanelerim',
			'doctorHospitals.tabInvitations' => 'Davetler',
			'doctorHospitals.tabRequests' => 'Talepler',
			'doctorHospitals.tabConfirmed' => 'Hastaneler',
			'doctorHospitals.noInvitations' => 'Bekleyen davet yok',
			'doctorHospitals.noRequests' => 'Bekleyen talep yok',
			'doctorHospitals.noConfirmed' => 'Henüz herhangi bir hastaneyle ilişkiniz yok',
			'doctorHospitals.accept' => 'Kabul et',
			'doctorHospitals.decline' => 'Reddet',
			'doctorHospitals.cancelRequest' => 'Talebi iptal et',
			'doctorHospitals.invitedYouToJoin' => 'Sizi katılmaya davet etti',
			'doctorHospitals.awaitingApproval' => 'Hastane onayı bekleniyor',
			'share.title' => 'Profili paylaş',
			'share.shareLink' => 'Bağlantıyı paylaş',
			'share.copyLink' => 'Bağlantıyı kopyala',
			'share.linkCopied' => 'Bağlantı kopyalandı',
			'hospitalDetail.title' => 'Hastane',
			'hospitalDetail.couldNotLoad' => 'Profil yüklenemedi',
			'hospitalDetail.location' => 'Adres',
			'hospitalDetail.doctorsHeading' => 'Buradaki doktorlar',
			_ => null,
		};
	}
}
