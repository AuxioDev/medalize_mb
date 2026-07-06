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
	@override String get appName => 'Medalize';
	@override late final _Translations$common$tr common = _Translations$common$tr._(_root);
	@override late final _Translations$auth$tr auth = _Translations$auth$tr._(_root);
	@override late final _Translations$forgotPassword$tr forgotPassword = _Translations$forgotPassword$tr._(_root);
	@override late final _Translations$resetPassword$tr resetPassword = _Translations$resetPassword$tr._(_root);
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
	@override late final _Translations$splash$tr splash = _Translations$splash$tr._(_root);
	@override late final _Translations$appIntro$tr appIntro = _Translations$appIntro$tr._(_root);
	@override late final _Translations$agenda$tr agenda = _Translations$agenda$tr._(_root);
	@override late final _Translations$favorites$tr favorites = _Translations$favorites$tr._(_root);
	@override late final _Translations$assistant$tr assistant = _Translations$assistant$tr._(_root);
	@override late final _Translations$legal$tr legal = _Translations$legal$tr._(_root);
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
	@override String get email => 'E-posta';
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
	@override String get joinMedalize => 'Bugün Medalize\'ye katılın';
	@override String get iAmA => 'Ben bir';
	@override String get emailHint => 'you@example.com';
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
	@override String get subtitle => 'E-postanızı girin, size 6 haneli bir sıfırlama kodu gönderelim';
}

// Path: resetPassword
class _Translations$resetPassword$tr extends Translations$resetPassword$en {
	_Translations$resetPassword$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Şifreyi Sıfırla';
	@override String get subtitle => 'E-postanıza gönderilen kodu girin ve yeni bir şifre seçin';
	@override String get button => 'Şifreyi Sıfırla';
	@override String get success => 'Şifre başarıyla sıfırlandı. Lütfen giriş yapın.';
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
	@override String get invalidCredentials => 'Geçersiz e-posta veya şifre';
	@override String get sessionExpired => 'Oturum süresi doldu. Lütfen tekrar giriş yapın.';
	@override String get authError => 'Kimlik doğrulama hatası. Lütfen tekrar giriş yapın.';
	@override String get sessionRevoked => 'Oturum iptal edildi. Lütfen tekrar giriş yapın.';
	@override String get permissionDenied => 'Bunu yapma izniniz yok.';
	@override String get validationError => 'Doğrulama hatası';
	@override String serverError({required Object code}) => 'Sunucu hatası (${code}). Lütfen tekrar deneyin.';
	@override String get socialLoginFailed => 'Giriş başarısız oldu. Tekrar deneyin veya e-posta ve şifrenizi kullanın.';
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
	@override String get version => 'Medalize v1.0.0';
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
	@override String get biometricPrompt => 'Medalize\'a erişmek için doğrulayın';
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
	@override String get changeEmail => 'E-postayı Değiştir';
	@override String get changeEmailSubtitle => 'Yeni e-posta adresinize bir doğrulama kodu göndereceğiz. Onayladıktan sonra yeni e-postanızla giriş yapacaksınız.';
	@override String get newEmailLabel => 'Yeni e-posta';
	@override String get sendCode => 'Kod Gönder';
	@override String codeSentTo({required Object email}) => '${email} adresine gönderdiğimiz 6 haneli kodu girin';
	@override String get confirmNewEmail => 'Yeni E-postayı Onayla';
	@override String get changeEmailSuccess => 'E-postanız değiştirildi. Yeni e-postanızla tekrar giriş yapın.';
	@override String get dangerZone => 'Tehlikeli Bölge';
	@override String get deactivateAccount => 'Hesabı Devre Dışı Bırak';
	@override String get deactivateAccountSubtitle => 'Verilerinizi silmeden hesabınızı devre dışı bırakın';
	@override String get deactivateConfirmTitle => 'Hesap devre dışı bırakılsın mı?';
	@override String get deactivateConfirmMessage => 'Hesabınız devre dışı bırakılacak ve tüm cihazlarda oturumunuz kapatılacak. Verileriniz silinmez. Yeniden etkinleştirmek için destek ekibiyle iletişime geçin.';
	@override String get deactivate => 'Devre Dışı Bırak';
	@override String get deactivateSuccess => 'Hesabınız devre dışı bırakıldı.';
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
	@override String get address => 'Adres';
	@override String get city => 'Şehir';
	@override String get type => 'Tür';
	@override String get clinic => 'Klinik';
	@override String get hospital => 'Hastane';
	@override String get privatePractice => 'Özel Muayenehane';
	@override String get failedToSave => 'İş yeri kaydedilemedi.';
	@override String get addButton => 'İş Yeri Ekle';
	@override String get saveChanges => 'Değişiklikleri Kaydet';
}

// Path: workingHours
class _Translations$workingHours$tr extends Translations$workingHours$en {
	_Translations$workingHours$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Çalışma Saatleri';
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
	@override String get labelOptional => 'Telefon Numarası (İsteğe bağlı)';
	@override String get selectCountry => 'Ülke Seçin';
	@override String get searchCountry => 'Ülke veya kod ara…';
	@override String get noCountriesFound => 'Ülke bulunamadı';
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
}

// Path: legal
class _Translations$legal$tr extends Translations$legal$en {
	_Translations$legal$tr._(TranslationsTr root) : this._root = root, super.internal(root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gizlilik ve Koşullar';
	@override String get privacyTitle => 'Gizlilik Politikası';
	@override String get privacyBody => 'Medalize, randevu almanız ve yönetmeniz için kişisel ve sağlık bilgilerinizi işler. Verilerinizi satmıyoruz. Tam Gizlilik Politikası, herkese açık lansmandan önce burada yayınlanacaktır.';
	@override String get termsTitle => 'Kullanım Koşulları';
	@override String get termsBody => 'Medalize’ı kullanarak, hizmeti randevu alma ve yönetme için sorumlu bir şekilde kullanmayı kabul edersiniz. Tam Kullanım Koşulları, herkese açık lansmandan önce burada yayınlanacaktır.';
	@override String get draftNotice => 'Taslak — nihai hukuki inceleme bekleniyor.';
	@override String get contact => 'Verilerinizle ilgili sorular mı var? support@medalize.app ile iletişime geçin';
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

/// The flat map containing all translations for locale <tr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsTr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'Medalize',
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
			'auth.login' => 'Giriş Yap',
			'auth.register' => 'Hesap Oluştur',
			'auth.signIn' => 'Giriş Yap',
			'auth.signUp' => 'Kayıt Ol',
			'auth.email' => 'E-posta',
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
			'auth.joinMedalize' => 'Bugün Medalize\'ye katılın',
			'auth.iAmA' => 'Ben bir',
			'auth.emailHint' => 'you@example.com',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => 'Girişe dön',
			'auth.verificationCode' => 'Doğrulama kodu',
			'auth.continueWithGoogle' => 'Google ile devam et',
			'auth.continueWithApple' => 'Apple ile devam et',
			'auth.orDivider' => 'veya',
			'forgotPassword.title' => 'Şifrenizi mi unuttunuz?',
			'forgotPassword.subtitle' => 'E-postanızı girin, size 6 haneli bir sıfırlama kodu gönderelim',
			'resetPassword.title' => 'Şifreyi Sıfırla',
			'resetPassword.subtitle' => 'E-postanıza gönderilen kodu girin ve yeni bir şifre seçin',
			'resetPassword.button' => 'Şifreyi Sıfırla',
			'resetPassword.success' => 'Şifre başarıyla sıfırlandı. Lütfen giriş yapın.',
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
			'errors.invalidCredentials' => 'Geçersiz e-posta veya şifre',
			'errors.sessionExpired' => 'Oturum süresi doldu. Lütfen tekrar giriş yapın.',
			'errors.authError' => 'Kimlik doğrulama hatası. Lütfen tekrar giriş yapın.',
			'errors.sessionRevoked' => 'Oturum iptal edildi. Lütfen tekrar giriş yapın.',
			'errors.permissionDenied' => 'Bunu yapma izniniz yok.',
			'errors.validationError' => 'Doğrulama hatası',
			'errors.serverError' => ({required Object code}) => 'Sunucu hatası (${code}). Lütfen tekrar deneyin.',
			'errors.socialLoginFailed' => 'Giriş başarısız oldu. Tekrar deneyin veya e-posta ve şifrenizi kullanın.',
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
			'settings.version' => 'Medalize v1.0.0',
			'settings.legal' => 'Gizlilik ve Koşullar',
			'security.title' => 'Güvenlik',
			'security.biometricLogin' => 'Biyometrik Giriş',
			'security.biometricLoginSubtitle' => 'Uygulamanın kilidini açmak için Face ID / Touch ID kullanın',
			'security.biometricPrompt' => 'Medalize\'a erişmek için doğrulayın',
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
			'security.changeEmail' => 'E-postayı Değiştir',
			'security.changeEmailSubtitle' => 'Yeni e-posta adresinize bir doğrulama kodu göndereceğiz. Onayladıktan sonra yeni e-postanızla giriş yapacaksınız.',
			'security.newEmailLabel' => 'Yeni e-posta',
			'security.sendCode' => 'Kod Gönder',
			'security.codeSentTo' => ({required Object email}) => '${email} adresine gönderdiğimiz 6 haneli kodu girin',
			'security.confirmNewEmail' => 'Yeni E-postayı Onayla',
			'security.changeEmailSuccess' => 'E-postanız değiştirildi. Yeni e-postanızla tekrar giriş yapın.',
			'security.dangerZone' => 'Tehlikeli Bölge',
			'security.deactivateAccount' => 'Hesabı Devre Dışı Bırak',
			'security.deactivateAccountSubtitle' => 'Verilerinizi silmeden hesabınızı devre dışı bırakın',
			'security.deactivateConfirmTitle' => 'Hesap devre dışı bırakılsın mı?',
			'security.deactivateConfirmMessage' => 'Hesabınız devre dışı bırakılacak ve tüm cihazlarda oturumunuz kapatılacak. Verileriniz silinmez. Yeniden etkinleştirmek için destek ekibiyle iletişime geçin.',
			'security.deactivate' => 'Devre Dışı Bırak',
			'security.deactivateSuccess' => 'Hesabınız devre dışı bırakıldı.',
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
			'doctorSearch.title' => 'Doktor Bul',
			'doctorSearch.searchByName' => 'İsme göre ara...',
			'doctorSearch.city' => 'Şehir',
			'doctorSearch.search' => 'Ara',
			'doctorSearch.noDoctorsFound' => 'Doktor bulunamadı',
			'doctorSearch.adjustSearch' => 'Aramanızı veya filtrelerinizi değiştirmeyi deneyin',
			'doctorSearch.couldNotLoadDoctors' => 'Doktorlar yüklenemedi',
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
			'addWorkplace.address' => 'Adres',
			'addWorkplace.city' => 'Şehir',
			'addWorkplace.type' => 'Tür',
			'addWorkplace.clinic' => 'Klinik',
			'addWorkplace.hospital' => 'Hastane',
			'addWorkplace.privatePractice' => 'Özel Muayenehane',
			'addWorkplace.failedToSave' => 'İş yeri kaydedilemedi.',
			'addWorkplace.addButton' => 'İş Yeri Ekle',
			'addWorkplace.saveChanges' => 'Değişiklikleri Kaydet',
			'workingHours.title' => 'Çalışma Saatleri',
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
			'phoneField.labelOptional' => 'Telefon Numarası (İsteğe bağlı)',
			'phoneField.selectCountry' => 'Ülke Seçin',
			'phoneField.searchCountry' => 'Ülke veya kod ara…',
			'phoneField.noCountriesFound' => 'Ülke bulunamadı',
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
			'legal.title' => 'Gizlilik ve Koşullar',
			'legal.privacyTitle' => 'Gizlilik Politikası',
			'legal.privacyBody' => 'Medalize, randevu almanız ve yönetmeniz için kişisel ve sağlık bilgilerinizi işler. Verilerinizi satmıyoruz. Tam Gizlilik Politikası, herkese açık lansmandan önce burada yayınlanacaktır.',
			'legal.termsTitle' => 'Kullanım Koşulları',
			'legal.termsBody' => 'Medalize’ı kullanarak, hizmeti randevu alma ve yönetme için sorumlu bir şekilde kullanmayı kabul edersiniz. Tam Kullanım Koşulları, herkese açık lansmandan önce burada yayınlanacaktır.',
			'legal.draftNotice' => 'Taslak — nihai hukuki inceleme bekleniyor.',
			'legal.contact' => 'Verilerinizle ilgili sorular mı var? support@medalize.app ile iletişime geçin',
			_ => null,
		};
	}
}
