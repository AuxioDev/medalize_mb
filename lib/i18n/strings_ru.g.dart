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
class TranslationsRu extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'DocGet';
	@override late final _Translations$common$ru common = _Translations$common$ru._(_root);
	@override late final _Translations$auth$ru auth = _Translations$auth$ru._(_root);
	@override late final _Translations$forgotPassword$ru forgotPassword = _Translations$forgotPassword$ru._(_root);
	@override late final _Translations$resetPassword$ru resetPassword = _Translations$resetPassword$ru._(_root);
	@override late final _Translations$verifyPhone$ru verifyPhone = _Translations$verifyPhone$ru._(_root);
	@override late final _Translations$socialComplete$ru socialComplete = _Translations$socialComplete$ru._(_root);
	@override late final _Translations$validation$ru validation = _Translations$validation$ru._(_root);
	@override late final _Translations$errors$ru errors = _Translations$errors$ru._(_root);
	@override late final _Translations$settings$ru settings = _Translations$settings$ru._(_root);
	@override late final _Translations$security$ru security = _Translations$security$ru._(_root);
	@override late final _Translations$status$ru status = _Translations$status$ru._(_root);
	@override late final _Translations$home$ru home = _Translations$home$ru._(_root);
	@override late final _Translations$appointments$ru appointments = _Translations$appointments$ru._(_root);
	@override late final _Translations$booking$ru booking = _Translations$booking$ru._(_root);
	@override late final _Translations$doctorSearch$ru doctorSearch = _Translations$doctorSearch$ru._(_root);
	@override late final _Translations$doctorDetail$ru doctorDetail = _Translations$doctorDetail$ru._(_root);
	@override late final _Translations$profile$ru profile = _Translations$profile$ru._(_root);
	@override late final _Translations$notifications$ru notifications = _Translations$notifications$ru._(_root);
	@override late final _Translations$workplaces$ru workplaces = _Translations$workplaces$ru._(_root);
	@override late final _Translations$addWorkplace$ru addWorkplace = _Translations$addWorkplace$ru._(_root);
	@override late final _Translations$workingHours$ru workingHours = _Translations$workingHours$ru._(_root);
	@override late final _Translations$blockTime$ru blockTime = _Translations$blockTime$ru._(_root);
	@override late final _Translations$onboarding$ru onboarding = _Translations$onboarding$ru._(_root);
	@override late final _Translations$pendingVerification$ru pendingVerification = _Translations$pendingVerification$ru._(_root);
	@override late final _Translations$phoneField$ru phoneField = _Translations$phoneField$ru._(_root);
	@override late final _Translations$locations$ru locations = _Translations$locations$ru._(_root);
	@override late final _Translations$splash$ru splash = _Translations$splash$ru._(_root);
	@override late final _Translations$appIntro$ru appIntro = _Translations$appIntro$ru._(_root);
	@override late final _Translations$agenda$ru agenda = _Translations$agenda$ru._(_root);
	@override late final _Translations$favorites$ru favorites = _Translations$favorites$ru._(_root);
	@override late final _Translations$assistant$ru assistant = _Translations$assistant$ru._(_root);
	@override late final _Translations$messaging$ru messaging = _Translations$messaging$ru._(_root);
	@override late final _Translations$legal$ru legal = _Translations$legal$ru._(_root);
	@override late final _Translations$medications$ru medications = _Translations$medications$ru._(_root);
	@override late final _Translations$prescriptions$ru prescriptions = _Translations$prescriptions$ru._(_root);
	@override late final _Translations$records$ru records = _Translations$records$ru._(_root);
	@override late final _Translations$payments$ru payments = _Translations$payments$ru._(_root);
	@override late final _Translations$family$ru family = _Translations$family$ru._(_root);
	@override late final _Translations$subscription$ru subscription = _Translations$subscription$ru._(_root);
	@override late final _Translations$hospitalPicker$ru hospitalPicker = _Translations$hospitalPicker$ru._(_root);
	@override late final _Translations$hospitalRegistration$ru hospitalRegistration = _Translations$hospitalRegistration$ru._(_root);
	@override late final _Translations$hospitalHome$ru hospitalHome = _Translations$hospitalHome$ru._(_root);
	@override late final _Translations$hospitalDoctors$ru hospitalDoctors = _Translations$hospitalDoctors$ru._(_root);
	@override late final _Translations$hospitalInvite$ru hospitalInvite = _Translations$hospitalInvite$ru._(_root);
	@override late final _Translations$hospitalAppointments$ru hospitalAppointments = _Translations$hospitalAppointments$ru._(_root);
	@override late final _Translations$hospitalProfile$ru hospitalProfile = _Translations$hospitalProfile$ru._(_root);
	@override late final _Translations$hospitalDoctorHours$ru hospitalDoctorHours = _Translations$hospitalDoctorHours$ru._(_root);
	@override late final _Translations$doctorHospitals$ru doctorHospitals = _Translations$doctorHospitals$ru._(_root);
	@override late final _Translations$share$ru share = _Translations$share$ru._(_root);
	@override late final _Translations$hospitalDetail$ru hospitalDetail = _Translations$hospitalDetail$ru._(_root);
}

// Path: common
class _Translations$common$ru extends Translations$common$en {
	_Translations$common$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Отмена';
	@override String get logout => 'Выйти';
	@override String get doctor => 'Врач';
	@override String get patient => 'Пациент';
	@override String get save => 'Сохранить';
	@override String get edit => 'Изменить';
	@override String get retry => 'Повторить';
	@override String get back => 'Назад';
	@override String get ok => 'OK';
	@override String get delete => 'Удалить';
	@override String get keep => 'Оставить';
	@override String get confirm => 'Подтвердить';
	@override String get decline => 'Отклонить';
	@override String get primary => 'Основной';
	@override String get somethingWrong => 'Что-то пошло не так';
	@override String get seeAll => 'Все';
	@override String get signOut => 'Выйти';
	@override String get search => 'Поиск';
	@override String get tryAgain => 'Повторите попытку';
	@override String get required => 'Обязательно';
	@override String get noRatings => 'Нет оценок';
	@override String get hospital => 'Больница';
}

// Path: auth
class _Translations$auth$ru extends Translations$auth$en {
	_Translations$auth$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get login => 'Войти';
	@override String get register => 'Создать аккаунт';
	@override String get signIn => 'Войти';
	@override String get signUp => 'Зарегистрироваться';
	@override String get password => 'Пароль';
	@override String get confirmPassword => 'Подтвердите пароль';
	@override String get firstName => 'Имя';
	@override String get lastName => 'Фамилия';
	@override String get rememberMe => 'Запомнить меня';
	@override String get forgotPassword => 'Забыли пароль?';
	@override String get sendResetLink => 'Отправить код';
	@override String get noAccount => 'Нет аккаунта?';
	@override String get haveAccount => 'Уже есть аккаунт?';
	@override String get welcomeBack => 'С возвращением';
	@override String get signInToContinue => 'Войдите в аккаунт, чтобы продолжить';
	@override String get createYourAccount => 'Создайте аккаунт';
	@override String get joinMedalize => 'Присоединяйтесь к DocGet';
	@override String get iAmA => 'Я —';
	@override String get passwordHint => '••••••••';
	@override String get backToSignIn => 'Назад ко входу';
	@override String get verificationCode => 'Код подтверждения';
	@override String get continueWithGoogle => 'Продолжить с Google';
	@override String get continueWithApple => 'Продолжить с Apple';
	@override String get orDivider => 'или';
}

// Path: forgotPassword
class _Translations$forgotPassword$ru extends Translations$forgotPassword$en {
	_Translations$forgotPassword$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Забыли пароль?';
	@override String get subtitle => 'Введите номер телефона, и мы отправим 6-значный код для сброса';
}

// Path: resetPassword
class _Translations$resetPassword$ru extends Translations$resetPassword$en {
	_Translations$resetPassword$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Сброс пароля';
	@override String get subtitle => 'Введите код, отправленный на ваш телефон, и выберите новый пароль';
	@override String get button => 'Сбросить пароль';
	@override String get success => 'Пароль успешно сброшен. Войдите в аккаунт.';
}

// Path: verifyPhone
class _Translations$verifyPhone$ru extends Translations$verifyPhone$en {
	_Translations$verifyPhone$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Подтвердите номер телефона';
	@override String subtitle({required Object phone}) => 'Мы отправили 6-значный код на ${phone}';
	@override String get button => 'Подтвердить';
	@override String get resend => 'Отправить код повторно';
	@override String get resendSent => 'Новый код отправлен.';
}

// Path: socialComplete
class _Translations$socialComplete$ru extends Translations$socialComplete$en {
	_Translations$socialComplete$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ещё один шаг';
	@override String get subtitle => 'Укажите и подтвердите номер телефона, чтобы завершить создание аккаунта.';
	@override String get button => 'Продолжить';
}

// Path: validation
class _Translations$validation$ru extends Translations$validation$en {
	_Translations$validation$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => 'Введите эл. почту';
	@override String get emailInvalid => 'Введите действительный адрес эл. почты';
	@override String get passwordRequired => 'Введите пароль';
	@override String get passwordTooShort => 'Не менее 8 символов';
	@override String get passwordNeedsLetter => 'Добавьте хотя бы одну букву';
	@override String get passwordNeedsDigit => 'Добавьте хотя бы одну цифру';
	@override String get passwordMismatch => 'Пароли не совпадают';
	@override String get passwordConfirmRequired => 'Подтвердите пароль';
	@override String get nameMinLength => 'Не менее 2 символов';
	@override String get roleRequired => 'Выберите роль';
	@override String get phoneRequired => 'Введите номер телефона';
	@override String get phoneTooShort => 'Номер слишком короткий';
	@override String get phoneTooLong => 'Номер слишком длинный';
	@override String fieldRequired({required Object field}) => '${field} — обязательное поле';
	@override String fieldInvalid({required Object field}) => '${field} содержит недопустимые символы';
}

// Path: errors
class _Translations$errors$ru extends Translations$errors$en {
	_Translations$errors$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get network => 'Ошибка сети. Проверьте подключение.';
	@override String get rateLimit => 'Слишком много попыток. Подождите и повторите.';
	@override String rateLimitWithSeconds({required Object seconds}) => 'Слишком много попыток. Повторите через ${seconds} с.';
	@override String get invalidCredentials => 'Неверный номер телефона или пароль';
	@override String get sessionExpired => 'Сессия истекла. Пожалуйста, войдите снова.';
	@override String get authError => 'Ошибка аутентификации. Пожалуйста, войдите снова.';
	@override String get sessionRevoked => 'Сессия отозвана. Пожалуйста, войдите снова.';
	@override String get permissionDenied => 'У вас нет прав для этого действия.';
	@override String get validationError => 'Ошибка проверки';
	@override String serverError({required Object code}) => 'Ошибка сервера (${code}). Повторите попытку.';
	@override String get socialLoginFailed => 'Не удалось войти. Попробуйте снова или используйте номер телефона и пароль.';
	@override String get conflict => 'Это действие сейчас невозможно выполнить.';
	@override String get onboardingIncomplete => 'Заполните все обязательные поля, чтобы завершить регистрацию.';
	@override String get planLimitReached => 'Вы достигли лимита вашего тарифа. Перейдите на более высокий тариф.';
	@override String get chatUnavailable => 'Этот врач не предлагает чат на своём текущем тарифе.';
	@override String get phoneNotVerified => 'Подтвердите номер телефона перед входом.';
}

// Path: settings
class _Translations$settings$ru extends Translations$settings$en {
	_Translations$settings$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Настройки';
	@override String get account => 'Аккаунт';
	@override String get profile => 'Профиль';
	@override String get notifications => 'Уведомления';
	@override String get appearance => 'Оформление';
	@override String get themeSystem => 'Системная';
	@override String get themeLight => 'Светлая';
	@override String get themeDark => 'Тёмная';
	@override String get language => 'Язык';
	@override String get languageSystem => 'Как в системе';
	@override String get logoutTitle => 'Выход';
	@override String get logoutConfirm => 'Вы уверены, что хотите выйти?';
	@override String get version => 'DocGet v1.0.0';
	@override String get legal => 'Конфиденциальность и условия';
}

// Path: security
class _Translations$security$ru extends Translations$security$en {
	_Translations$security$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Безопасность';
	@override String get biometricLogin => 'Вход по биометрии';
	@override String get biometricLoginSubtitle => 'Используйте Face ID / Touch ID для разблокировки приложения';
	@override String get biometricPrompt => 'Подтвердите личность для доступа к DocGet';
	@override String get biometricUnavailable => 'Биометрическая аутентификация недоступна на этом устройстве';
	@override String get biometricEnableFailed => 'Не удалось подтвердить биометрию. Попробуйте снова.';
	@override String get activeSessions => 'Активные сессии';
	@override String get activeSessionsSubtitle => 'Устройства, вошедшие в ваш аккаунт';
	@override String get thisDevice => 'Это устройство';
	@override String lastActive({required Object date}) => 'Последняя активность: ${date}';
	@override String get revoke => 'Отозвать';
	@override String get revokeConfirmTitle => 'Отозвать устройство?';
	@override String revokeConfirmMessage({required Object name}) => '${name} будет выведено из системы. Оно сможет войти снова с вашими учётными данными.';
	@override String get revokeCurrentConfirmMessage => 'Это ваше текущее устройство — его отзыв немедленно завершит вашу сессию.';
	@override String get revokeFailed => 'Не удалось отозвать это устройство. Попробуйте снова.';
	@override String get signOutAllDevices => 'Выйти со всех устройств';
	@override String get signOutAllConfirmTitle => 'Выйти везде?';
	@override String get signOutAllConfirmMessage => 'Вы выйдете из системы на всех устройствах, включая это.';
	@override String get signOutAllFailed => 'Не удалось выйти со всех устройств. Попробуйте снова.';
	@override String get noDevices => 'Активные сессии не найдены';
	@override String get loadFailed => 'Не удалось загрузить активные сессии';
	@override String get changePhone => 'Изменить номер телефона';
	@override String get changePhoneSubtitle => 'Мы отправим код подтверждения на новый номер. После подтверждения вы будете входить с новым номером.';
	@override String get sendCode => 'Отправить код';
	@override String codeSentTo({required Object phone}) => 'Введите 6-значный код, отправленный на ${phone}';
	@override String get confirmNewPhone => 'Подтвердить новый номер';
	@override String get changePhoneSuccess => 'Номер телефона изменён. Войдите заново с новым номером.';
	@override String get dangerZone => 'Опасная зона';
	@override String get deactivateAccount => 'Деактивировать аккаунт';
	@override String get deactivateAccountSubtitle => 'Отключить аккаунт без удаления данных';
	@override String get deactivateConfirmTitle => 'Деактивировать аккаунт?';
	@override String get deactivateConfirmMessage => 'Аккаунт будет деактивирован, и вы выйдете из системы на всех устройствах. Данные не удаляются. Для восстановления обратитесь в поддержку.';
	@override String get deactivate => 'Деактивировать';
	@override String get deactivateSuccess => 'Ваш аккаунт деактивирован.';
	@override String get deleteAccount => 'Удалить аккаунт навсегда';
	@override String get deleteAccountSubtitle => 'Удалить ваши данные без возможности восстановления.';
	@override String get deleteConfirmTitle => 'Удалить аккаунт навсегда?';
	@override String get deleteConfirmWarning => 'Это действие необратимо и не может быть отменено.';
	@override String get deleteConfirmMessage => 'Ваш профиль, медицинские записи, рецепты и сообщения будут безвозвратно удалены. Предстоящие приёмы будут отменены и возвращены при наличии права на возврат. Платёжные записи сохраняются в обезличенном виде для целей бухгалтерского учёта, как того требует закон.';
	@override String get deleteAccountSuccess => 'Ваш аккаунт был безвозвратно удалён.';
}

// Path: status
class _Translations$status$ru extends Translations$status$en {
	_Translations$status$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'Подтверждено';
	@override String get pending => 'В ожидании';
	@override String get cancelled => 'Отменено';
	@override String get declined => 'Отклонено';
	@override String get requiresRescheduling => 'Требует переноса';
	@override String get completed => 'Завершено';
	@override String get noShow => 'Неявка';
}

// Path: home
class _Translations$home$ru extends Translations$home$en {
	_Translations$home$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String helloDoctor({required Object name}) => 'Здравствуйте, д-р ${name}!';
	@override String helloPatient({required Object name}) => 'Здравствуйте, ${name}!';
	@override String get doctorSubtitle => 'Управляйте расписанием\nи приёмами.';
	@override String get patientSubtitle => 'Найдите врача и\nзапишитесь на приём.';
	@override String get pendingRequests => 'Ожидающие запросы';
	@override String get upcoming => 'Предстоящие';
	@override String get findDoctor => 'Найти врача';
	@override String get aiAssistant => 'ИИ-ассистент';
	@override String get myAppointments => 'Мои приёмы';
	@override String get appointments => 'Приёмы';
	@override String get workplaces => 'Места работы';
	@override String get blockTime => 'Заблокировать время';
	@override String get profile => 'Профиль';
	@override String get allCaughtUp => 'Всё в порядке';
	@override String get noPendingRequests => 'Нет ожидающих запросов на приём';
	@override String get couldNotLoadAppointments => 'Не удалось загрузить приёмы';
	@override String get noUpcoming => 'Нет предстоящих приёмов';
	@override String get bookFirst => 'Запишитесь на первый приём к врачу';
	@override String get findADoctor => 'Найти врача';
	@override String get myWaitlist => 'Лист ожидания';
	@override String get leaveWaitlist => 'Выйти';
	@override String get statsThisMonth => 'Этот месяц';
	@override String get statsPatients => 'Пациенты';
	@override String get statsAcceptRate => '% принятых';
	@override String get statsPending => 'Ожидают';
	@override String get schedule => 'Расписание';
	@override String quickBookWith({required Object name}) => 'Записаться к ${name}';
}

// Path: appointments
class _Translations$appointments$ru extends Translations$appointments$en {
	_Translations$appointments$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Приёмы';
	@override String get myTitle => 'Мои приёмы';
	@override String get tabPending => 'Ожидают';
	@override String get tabAll => 'Все';
	@override String get tabUpcoming => 'Предстоящие';
	@override String get tabPast => 'Прошедшие';
	@override String get noPendingRequests => 'Нет ожидающих запросов';
	@override String get newRequestsAppear => 'Новые запросы на приём появятся здесь';
	@override String get noAppointments => 'Нет приёмов';
	@override String get appointmentsAppear => 'Ваши приёмы появятся здесь';
	@override String get noUpcoming => 'Нет предстоящих приёмов';
	@override String get bookFirst => 'Запишитесь на первый приём к врачу';
	@override String get noPast => 'Нет прошедших приёмов';
	@override String get pastAppear => 'Завершённые и отменённые приёмы появятся здесь';
	@override String get couldNotLoad => 'Не удалось загрузить приёмы';
	@override String get detailTitle => 'Приём';
	@override String get patient => 'Пациент';
	@override String get doctor => 'Врач';
	@override String get workplace => 'Место работы';
	@override String get dateTime => 'Дата и время';
	@override String get reason => 'Причина';
	@override String get doctorNotes => 'Заметки врача';
	@override String get cancelTitle => 'Отменить приём';
	@override String get cancelConfirm => 'Вы уверены, что хотите отменить этот приём?';
	@override String get cancelAction => 'Отменить приём';
	@override String get cancelledSuccess => 'Приём отменён.';
	@override String get cancelledRefunded => 'Приём отменён. Оплата возвращена.';
	@override String get cancelledNoRefund => 'Приём отменён. Возврат не произведён — отмена произошла слишком близко к времени приёма.';
	@override String get bookedTitle => 'Записано!';
	@override String get bookedMessage => 'Ваш запрос на приём отправлен.';
	@override String get reschedule => 'Перенести';
	@override String get rescheduleTitle => 'Перенос приёма';
	@override String get reviewTitle => 'Оставить отзыв';
	@override String get reviewRating => 'Оценка';
	@override String get reviewComment => 'Комментарий (необязательно)';
	@override String get reviewSubmit => 'Отправить';
	@override String get markCompleted => 'Отметить завершённым';
	@override String get rescheduledSuccess => 'Запись успешно перенесена.';
	@override String get reviewSubmitted => 'Отзыв отправлен. Спасибо!';
	@override String get yourReview => 'Ваш отзыв';
	@override String get editReviewTitle => 'Изменить отзыв';
	@override String get reviewUpdated => 'Отзыв обновлён.';
	@override String get deleteReviewTitle => 'Удалить отзыв';
	@override String get deleteReviewConfirm => 'Вы уверены, что хотите удалить свой отзыв?';
	@override String get reviewDeleted => 'Отзыв удалён.';
	@override String get requestReschedule => 'Запросить перенос';
	@override String get requestRescheduleTitle => 'Запрос переноса';
	@override String get requestRescheduleConfirm => 'Попросить пациента выбрать новое время? Запись будет помечена как требующая переноса.';
	@override String get requestRescheduleSuccess => 'Перенос запрошен. Пациент получит уведомление.';
	@override String get rescheduleNeededHint => 'Врач попросил вас выбрать новое время.';
	@override String get markNoShow => 'Отметить неявку';
	@override String get markNoShowTitle => 'Отметить как неявку';
	@override String get markNoShowConfirm => 'Отметить этот приём как неявку? Будет зафиксировано, что пациент не пришёл.';
	@override String get disputeNoShow => 'Оспорить';
	@override String get disputeNoShowTitle => 'Оспорить неявку';
	@override String get disputeNoShowHint => 'Расскажите, почему вы считаете, что это отмечено ошибочно — наша служба поддержки рассмотрит обращение.';
	@override String get disputeNoShowSubmit => 'Отправить';
	@override String get disputeNoShowSubmitted => 'Ваше обращение отправлено. Мы рассмотрим его и свяжемся с вами.';
	@override String get disputeNoShowOpen => 'Обращение отправлено — на рассмотрении';
	@override String get bookedSnack => 'Запись отправлена';
	@override String get bookAgain => 'Записаться снова';
}

// Path: booking
class _Translations$booking$ru extends Translations$booking$en {
	_Translations$booking$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String bookWith({required Object name}) => 'Запись — ${name}';
	@override String get selectWorkplace => 'Выберите место работы';
	@override String get pickDate => 'Выберите дату';
	@override String get slotsAppear => 'Доступные слоты появятся здесь';
	@override String get couldNotLoadSlots => 'Не удалось загрузить слоты';
	@override String get noAvailableSlots => 'Нет доступных слотов';
	@override String get noOpenSlots => 'На эту дату нет свободных слотов. Попробуйте другой день.';
	@override String get reasonForVisit => 'Причина визита (необязательно)';
	@override String get tryDifferentDate => 'Попробуйте другую дату';
	@override String get earliestPreselected => 'Выбран ближайший свободный слот';
	@override String continueAt({required Object time}) => 'Продолжить — ${time}';
	@override String confirmAt({required Object time}) => 'Подтвердить — ${time}';
	@override String get reasonPresetCheckup => 'Плановый осмотр';
	@override String get reasonPresetFollowUp => 'Повторный визит';
	@override String get reasonPresetNewComplaint => 'Новая жалоба';
}

// Path: doctorSearch
class _Translations$doctorSearch$ru extends Translations$doctorSearch$en {
	_Translations$doctorSearch$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Найти врача';
	@override String get searchByName => 'Поиск по имени...';
	@override String get city => 'Город';
	@override String get search => 'Поиск';
	@override String get noDoctorsFound => 'Врачи не найдены';
	@override String get adjustSearch => 'Попробуйте изменить поиск или фильтры';
	@override String get couldNotLoadDoctors => 'Не удалось загрузить врачей';
	@override String get loadMore => 'Показать ещё';
	@override late final _Translations$doctorSearch$spec$ru spec = _Translations$doctorSearch$spec$ru._(_root);
	@override String get noAvailability => 'Нет свободного времени';
	@override String get availableToday => 'Доступен сегодня';
	@override String get availableTomorrow => 'Доступен завтра';
	@override String availableOn({required Object date}) => 'Доступен ${date}';
	@override String get sortBy => 'Сортировка';
	@override String get sortDefault => 'По умолчанию';
	@override String get sortRating => 'По рейтингу';
	@override String get sortPriceLow => 'Сначала дешевле';
	@override String get sortName => 'По имени (А–Я)';
	@override String get sortNearestSlot => 'Ближайшая запись';
	@override String get sortDistance => 'По расстоянию';
	@override String get locationDenied => 'Для сортировки по расстоянию нужен доступ к геолокации. Разрешите его в настройках или используйте фильтр по городу.';
	@override String get locationUnavailable => 'Не удалось определить местоположение. Проверьте, что геолокация включена, или используйте фильтр по городу.';
	@override String distanceKm({required Object km}) => '${km} км';
	@override String get book => 'Записаться';
}

// Path: doctorDetail
class _Translations$doctorDetail$ru extends Translations$doctorDetail$en {
	_Translations$doctorDetail$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get profileTitle => 'Профиль врача';
	@override String get couldNotLoadProfile => 'Не удалось загрузить профиль';
	@override String get about => 'О себе';
	@override String get workplaces => 'Места работы';
	@override String minPerSlot({required Object min}) => '${min} мин на приём';
	@override String get bookAppointment => 'Записаться на приём';
	@override String get consultationFee => 'Стоимость приёма';
	@override String get reviews => 'Отзывы';
	@override String reviewsCount({required Object count}) => '${count} отзывов';
	@override String get joinWaitlist => 'В лист ожидания';
	@override String get leaveWaitlist => 'Покинуть лист ожидания';
}

// Path: profile
class _Translations$profile$ru extends Translations$profile$en {
	_Translations$profile$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Профиль';
	@override String get changePassword => 'Изменить пароль';
	@override String get currentPassword => 'Текущий пароль';
	@override String get newPassword => 'Новый пароль';
	@override String get confirmNewPassword => 'Подтвердите новый пароль';
	@override String get firstName => 'Имя';
	@override String get lastName => 'Фамилия';
	@override String get phone => 'Телефон';
	@override String get failedToSave => 'Не удалось сохранить профиль.';
	@override String get professionalInfo => 'Профессиональная информация';
	@override String get bio => 'О себе';
	@override String get bioHint => 'Краткое описание вашего опыта';
	@override String get consultationFee => 'Стоимость приёма';
	@override String get medicalInfo => 'Медицинская информация';
	@override String get allergies => 'Аллергии';
	@override String get allergiesHint => 'напр. Пенициллин, орехи';
	@override String get chronicConditions => 'Хронические заболевания';
	@override String get chronicConditionsHint => 'напр. Диабет, гипертония';
	@override String get medications => 'Принимаемые препараты';
	@override String get medicationsHint => 'напр. Метформин 500 мг';
	@override String get appointmentLength => 'Длительность приёма';
	@override String get cancellationWindow => 'Срок отмены';
	@override String get cancellationWindowHint => 'За сколько часов до приёма пациент ещё может отменить или перенести.';
	@override String hoursValue({required Object h}) => '${h} ч';
}

// Path: notifications
class _Translations$notifications$ru extends Translations$notifications$en {
	_Translations$notifications$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Уведомления';
	@override String get noNotifications => 'Нет уведомлений';
	@override String get allCaughtUp => 'Вы всё просмотрели';
	@override String get couldNotLoad => 'Не удалось загрузить уведомления';
	@override String get markAllRead => 'Отметить всё прочитанным';
	@override String get settingsTitle => 'Настройки уведомлений';
	@override String get pushEnabled => 'Push-уведомления';
	@override String get pushEnabledSubtitle => 'Оповещения на этом устройстве о записях и изменениях';
	@override String get emailEnabled => 'Уведомления на email';
	@override String get emailEnabledSubtitle => 'Изменения будут приходить на вашу почту';
	@override String get categoriesTitle => 'Категории push-уведомлений';
	@override String get careCategory => 'Приёмы и здоровье';
	@override String get careCategorySubtitle => 'Брони, напоминания, рецепты';
	@override String get messagesCategory => 'Сообщения';
	@override String get messagesCategorySubtitle => 'Новые сообщения в чате';
	@override String get accountCategory => 'Аккаунт и оплата';
	@override String get accountCategorySubtitle => 'Верификация, платежи, подписка';
	@override String get quietHoursTitle => 'Тихие часы';
	@override String get quietHoursEnabled => 'Включить тихие часы';
	@override String get quietHoursSubtitle => 'В это время push-уведомления не приходят';
	@override String get quietHoursStart => 'Начало';
	@override String get quietHoursEnd => 'Конец';
}

// Path: workplaces
class _Translations$workplaces$ru extends Translations$workplaces$en {
	_Translations$workplaces$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Мои места работы';
	@override String get noWorkplacesYet => 'Пока нет мест работы';
	@override String get tapToAdd => 'Нажмите +, чтобы добавить первое место работы';
	@override String get couldNotLoad => 'Не удалось загрузить места работы';
	@override String get deleteTitle => 'Удалить место работы';
	@override String deleteConfirm({required Object name}) => 'Удалить «${name}»?';
	@override String get cannotDelete => 'Невозможно удалить место работы';
	@override String get workingHours => 'Часы работы';
	@override String get setAsPrimary => 'Сделать основным';
}

// Path: addWorkplace
class _Translations$addWorkplace$ru extends Translations$addWorkplace$en {
	_Translations$addWorkplace$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'Добавить место работы';
	@override String get editTitle => 'Изменить место работы';
	@override String get name => 'Название';
	@override String get address => 'Улица, дом';
	@override String get city => 'Город';
	@override String get type => 'Тип';
	@override String get clinic => 'Клиника';
	@override String get hospital => 'Больница';
	@override String get privatePractice => 'Частная практика';
	@override String get failedToSave => 'Не удалось сохранить место работы.';
	@override String get addButton => 'Добавить место работы';
	@override String get saveChanges => 'Сохранить изменения';
	@override String get pickOnMap => 'Выбрать на карте';
	@override String get mapPickerTitle => 'Выберите местоположение';
	@override String get useMyLocation => 'Использовать моё местоположение';
	@override String get confirmLocation => 'Подтвердить местоположение';
	@override String get locationSet => 'Местоположение задано с карты ✓';
	@override String get locationPermissionDenied => 'Нужно разрешение на геолокацию, чтобы использовать текущее положение. Карту можно передвинуть вручную.';
	@override String get locationUnavailable => 'Не удалось определить местоположение. Карту можно передвинуть вручную.';
}

// Path: workingHours
class _Translations$workingHours$ru extends Translations$workingHours$en {
	_Translations$workingHours$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Часы работы';
	@override String get sectionHint => 'Укажите дни и часы, когда пациенты смогут записаться к вам по этому адресу.';
	@override String get invalidRange => 'Для каждого активного дня время окончания должно быть позже времени начала.';
	@override String get saved => 'Часы работы сохранены';
	@override String get failedToSave => 'Не удалось сохранить часы работы';
	@override late final _Translations$workingHours$days$ru days = _Translations$workingHours$days$ru._(_root);
}

// Path: blockTime
class _Translations$blockTime$ru extends Translations$blockTime$en {
	_Translations$blockTime$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Заблокировать время';
	@override String get dateRange => 'Диапазон дат';
	@override String get tapToSelect => 'Нажмите, чтобы выбрать даты';
	@override String get reason => 'Причина (необязательно)';
	@override String get notifyPatients => 'Уведомить затронутых пациентов';
	@override String get notifyDesc => 'Отправить уведомления пациентам с приёмами в этот период';
	@override String get selectDateRange => 'Пожалуйста, выберите диапазон дат.';
	@override String get failedToBlock => 'Не удалось заблокировать время. Повторите попытку.';
	@override String get blockButton => 'Заблокировать период';
}

// Path: onboarding
class _Translations$onboarding$ru extends Translations$onboarding$en {
	_Translations$onboarding$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Заполните профиль';
	@override String get professionalInfo => 'Профессиональная информация';
	@override String get tellPatients => 'Расскажите пациентам о своей практике.';
	@override String get specialization => 'Специализация';
	@override String get selectSpecialization => 'Выберите специализацию';
	@override String get couldNotLoadSpecs => 'Не удалось загрузить специализации. Вернитесь и повторите.';
	@override String get licenseNumber => 'Номер лицензии';
	@override String get licenseHint => 'напр. AZ-123456';
	@override String get bio => 'О себе (необязательно)';
	@override String get bioHint => 'Краткое описание, которое пациенты увидят в вашем профиле.';
	@override String get appointmentLength => 'Длительность приёма';
	@override String get slotQuestion => 'Сколько длится один слот приёма?';
	@override String get changeLater => 'Это можно изменить позже в профиле.';
	@override String minutes({required Object min}) => '${min} мин';
	@override String get verificationDoc => 'Документ для подтверждения';
	@override String get uploadDiploma => 'Загрузите медицинский диплом или лицензию. Администратор проверит его перед подтверждением вашего аккаунта.';
	@override String get tapToChoose => 'Нажмите, чтобы выбрать файл';
	@override String get tapToReplace => 'Нажмите, чтобы заменить';
	@override String get anyFileType => 'Любой тип файла, до 10 МБ';
	@override String get selectSpecError => 'Пожалуйста, выберите специализацию.';
	@override String get licenseError => 'Пожалуйста, введите номер лицензии.';
	@override String get diplomaError => 'Пожалуйста, прикрепите диплом.';
	@override String get checkDetails => 'Проверьте данные и повторите попытку.';
	@override String get continueButton => 'Продолжить';
	@override String get finish => 'Завершить';
}

// Path: pendingVerification
class _Translations$pendingVerification$ru extends Translations$pendingVerification$en {
	_Translations$pendingVerification$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ожидает подтверждения';
	@override String get message => 'Ваш аккаунт на рассмотрении. Мы уведомим вас после подтверждения.';
	@override String get checkStatus => 'Проверить статус';
	@override String get stillPending => 'Всё ещё на рассмотрении. Мы уведомим вас, как только аккаунт будет подтверждён.';
}

// Path: phoneField
class _Translations$phoneField$ru extends Translations$phoneField$en {
	_Translations$phoneField$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get label => 'Номер телефона';
	@override String get selectCountry => 'Выберите страну';
	@override String get searchCountry => 'Поиск страны или кода…';
	@override String get noCountriesFound => 'Страны не найдены';
}

// Path: locations
class _Translations$locations$ru extends Translations$locations$en {
	_Translations$locations$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get pickCity => 'Выберите город';
	@override String get searchHint => 'Поиск города или региона…';
	@override String get noResultsFound => 'Города не найдены';
	@override String get couldNotLoad => 'Не удалось загрузить города. Нажмите, чтобы повторить.';
	@override String get allCities => 'Все города';
}

// Path: splash
class _Translations$splash$ru extends Translations$splash$en {
	_Translations$splash$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Ваше здоровье — это просто';
}

// Path: appIntro
class _Translations$appIntro$ru extends Translations$appIntro$en {
	_Translations$appIntro$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get page1Title => 'Найдите нужного врача';
	@override String get page1Subtitle => 'Ищите по специальности, городу и рейтингу — и запишитесь на удобное время.';
	@override String get page2Title => 'Спросите ИИ-помощника';
	@override String get page2Subtitle => 'Опишите симптомы и узнайте, к какому врачу лучше обратиться — в любое время.';
	@override String get page3Title => 'Всё в одном приложении';
	@override String get page3Subtitle => 'Управляйте записями, следите за визитами и пользуйтесь приложением на своём языке — безопасно.';
	@override String get skip => 'Пропустить';
	@override String get next => 'Далее';
	@override String get getStarted => 'Начать';
}

// Path: agenda
class _Translations$agenda$ru extends Translations$agenda$en {
	_Translations$agenda$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Расписание';
	@override String get today => 'Сегодня';
	@override String get empty => 'Нет приёмов';
	@override String get emptySubtitle => 'На этот день ничего не запланировано';
}

// Path: favorites
class _Translations$favorites$ru extends Translations$favorites$en {
	_Translations$favorites$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Избранное';
	@override String get empty => 'Пока нет избранного';
	@override String get emptySubtitle => 'Нажмите на сердечко у врача, чтобы сохранить его здесь';
	@override String get add => 'В избранное';
	@override String get remove => 'Убрать из избранного';
}

// Path: assistant
class _Translations$assistant$ru extends Translations$assistant$en {
	_Translations$assistant$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'ИИ-ассистент';
	@override String get newChat => 'Новый чат';
	@override String get empty => 'Пока нет разговоров';
	@override String get emptySubtitle => 'Опишите симптомы — ассистент подскажет, к какому врачу обратиться';
	@override String get couldNotLoad => 'Не удалось загрузить разговоры';
	@override String get couldNotLoadChat => 'Не удалось загрузить разговор';
	@override String get newConversation => 'Новый разговор';
	@override String get deleteTitle => 'Удалить разговор?';
	@override String get deleteConfirm => 'Разговор и все его сообщения будут удалены.';
	@override String get inputHint => 'Опишите ваши симптомы…';
	@override String get send => 'Отправить';
	@override String get sendFailed => 'Не удалось отправить сообщение. Попробуйте ещё раз.';
	@override String get typing => 'Ассистент печатает…';
	@override String get startTitle => 'Чем помочь?';
	@override String get startSubtitle => 'Для начала опишите, что вас беспокоит';
	@override String get book => 'Записаться';
	@override String get reportTooltip => 'Пожаловаться на ответ';
	@override String get reportTitle => 'Пожаловаться на ответ';
	@override String get reportHint => 'Причина (необязательно)';
	@override String get reportSubmit => 'Отправить';
	@override String get reportSuccess => 'Спасибо, жалоба отправлена.';
	@override String get reportFailed => 'Не удалось отправить жалобу. Попробуйте ещё раз.';
	@override String get topicsTooltip => 'Темы';
	@override String get topicsSheetTitle => 'Выберите тему';
}

// Path: messaging
class _Translations$messaging$ru extends Translations$messaging$en {
	_Translations$messaging$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Сообщения';
	@override String get sendMessage => 'Написать';
	@override String get typeMessage => 'Введите сообщение…';
	@override String get send => 'Отправить';
	@override String get empty => 'Пока нет переписок';
	@override String get emptySubtitle => 'Здесь появятся ваши переписки.';
	@override String get disclaimer => 'Это не экстренная связь. В неотложных случаях звоните в скорую помощь.';
	@override String get noSharedHistory => 'Написать врачу можно после того, как у вас появится общая история записей на приём.';
	@override String get newMessage => 'У вас новое сообщение';
}

// Path: legal
class _Translations$legal$ru extends Translations$legal$en {
	_Translations$legal$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Конфиденциальность и условия';
	@override String get controllerNotice => 'DocGet создан и управляется компанией AuxioDev (auxiodev.com), Азербайджан («мы»). Последнее обновление: июль 2026.';
	@override String get privacyTitle => 'Политика конфиденциальности';
	@override String get privacyIntro => 'Здесь объясняется, какие персональные данные собирает DocGet, зачем и как они защищены. Запись и ведение медицинских приёмов неизбежно связаны с данными о здоровье — ниже это подробно раскрыто.';
	@override late final _Translations$legal$sections$ru sections = _Translations$legal$sections$ru._(_root);
	@override String get termsTitle => 'Условия использования';
	@override String get termsIntro => 'Создавая аккаунт, вы соглашаетесь со следующим.';
	@override String get termsBody => 'Указывать о себе достоверную информацию. Использовать DocGet только для поиска, бронирования и ведения медицинских приёмов. Не разглашать данные для входа в аккаунт. DocGet соединяет вас с независимыми лицензированными медицинскими специалистами — мы сами не являемся медицинской организацией, а ИИ-ассистент для проверки симптомов не заменяет профессиональную медицинскую диагностику или консультацию. При неотложном состоянии обращайтесь напрямую в службу экстренной помощи, а не в это приложение. Мы можем приостановить или удалить аккаунт при нарушении этих условий или злоупотреблении сервисом.';
	@override String get contact => 'Вопросы о ваших данных? Напишите на support@auxiodev.com';
	@override String get consentPrefix => 'Я прочитал(а) и согласен(на) с ';
	@override String get consentPrivacyLink => 'Политикой конфиденциальности';
	@override String get consentMiddle => ' и ';
	@override String get consentTermsLink => 'Условиями использования';
	@override String get consentSuffix => ', а также прямо даю согласие на обработку данных о моём здоровье, как описано в них.';
	@override String get viewAsPdf => 'Открыть как PDF';
	@override String get pdfDocumentTitle => 'DocGet — Политика конфиденциальности и условия использования';
	@override String get pdfLoadError => 'Не удалось загрузить документ. Проверьте подключение к интернету и попробуйте снова.';
}

// Path: medications
class _Translations$medications$ru extends Translations$medications$en {
	_Translations$medications$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Лекарства';
	@override String get editMedication => 'Изменить лекарство';
	@override String get name => 'Название';
	@override String get dosage => 'Дозировка';
	@override String get notes => 'Заметки';
	@override String get form => 'Форма выпуска';
	@override String get formPill => 'Таблетка';
	@override String get formCapsule => 'Капсула';
	@override String get formLiquid => 'Жидкость';
	@override String get formInjection => 'Инъекция';
	@override String get formOther => 'Другое';
	@override String get schedule => 'Расписание';
	@override String get times => 'Время приёма';
	@override String get addTime => 'Добавить время';
	@override String get daysOfWeek => 'Дни недели';
	@override String get everyDay => 'Каждый день';
	@override String get startDate => 'Дата начала';
	@override String get endDate => 'Дата окончания';
	@override String get save => 'Сохранить';
	@override String get delete => 'Удалить';
	@override String get deleteConfirmTitle => 'Удалить лекарство';
	@override String get deleteConfirmBody => 'Удалить это лекарство? История приёма сохранится.';
	@override String get emptyTitle => 'Пока нет лекарств';
	@override String get emptySubtitle => 'Лекарства, назначенные врачом, появятся здесь после приёма.';
	@override String get todaysDoses => 'Приёмы сегодня';
	@override String get markTaken => 'Принято';
	@override String get markSkipped => 'Пропустить';
	@override String get statusTaken => 'Принято';
	@override String get statusSkipped => 'Пропущено';
	@override String get statusPending => 'Ожидает';
	@override String reminderTitle({required Object name}) => 'Пора принять ${name}';
	@override String reminderBody({required Object dosage}) => 'Доза: ${dosage}';
	@override String get tabActive => 'Активные';
	@override String get tabArchive => 'Архив';
	@override String get fromPrescription => 'По рецепту';
	@override String get noSchedule => 'Расписание не задано — нажмите, чтобы добавить время приёма';
	@override String get dayMon => 'Пн';
	@override String get dayTue => 'Вт';
	@override String get dayWed => 'Ср';
	@override String get dayThu => 'Чт';
	@override String get dayFri => 'Пт';
	@override String get daySat => 'Сб';
	@override String get daySun => 'Вс';
	@override String get updatedSuccess => 'Лекарство обновлено.';
	@override String get deletedSuccess => 'Лекарство удалено.';
	@override String get atLeastOneTime => 'Добавьте хотя бы одно время приёма';
}

// Path: prescriptions
class _Translations$prescriptions$ru extends Translations$prescriptions$en {
	_Translations$prescriptions$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Рецепты';
	@override String get writeTitle => 'Выписать рецепт';
	@override String get addDrug => 'Добавить препарат';
	@override String get drugName => 'Название препарата';
	@override String get dosage => 'Дозировка';
	@override String get frequency => 'Частота приёма';
	@override String get duration => 'Длительность';
	@override String get instructions => 'Инструкции';
	@override String get notes => 'Заметки';
	@override String get save => 'Сохранить';
	@override String get empty => 'Пока нет рецептов';
	@override String get emptySubtitle => 'Здесь появятся рецепты, выписанные вашим врачом.';
	@override String get viewDetails => 'Подробнее';
	@override String issuedBy({required Object name}) => 'Выписал(а) д-р ${name}';
	@override String issuedOn({required Object date}) => 'Дата выдачи: ${date}';
	@override String get applyToMedications => 'Добавить в мои лекарства';
	@override String get applySuccess => 'Добавлено в ваши лекарства. Настройте время приёма, чтобы получать напоминания.';
	@override String get alreadyApplied => 'Уже добавлено в ваши лекарства';
	@override String get noPrescriptionYet => 'Рецепт для этой записи ещё не выписан';
	@override String get writePrescription => 'Выписать рецепт';
	@override String get prescriptionIssued => 'Рецепт выписан.';
	@override String get removeDrug => 'Удалить';
	@override String get atLeastOneDrug => 'Добавьте хотя бы один препарат';
	@override String get drugNameRequired => 'Укажите название препарата';
	@override String get summaryTitle => 'Рецепт';
	@override String itemsCount({required Object count}) => 'Лекарств: ${count}';
	@override String get newPrescription => 'Новый рецепт';
	@override String get youHavePrescription => 'Для этой записи есть рецепт';
}

// Path: records
class _Translations$records$ru extends Translations$records$en {
	_Translations$records$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Медицинские документы';
	@override String get upload => 'Загрузить документ';
	@override String get recordType => 'Тип документа';
	@override String get typeLabResult => 'Анализ';
	@override String get typeImaging => 'Снимок';
	@override String get typeDocument => 'Документ';
	@override String get typeOther => 'Другое';
	@override String get recordTitle => 'Название';
	@override String get recordDate => 'Дата';
	@override String get notes => 'Заметки';
	@override String get chooseFile => 'Выбрать файл';
	@override String get changeFile => 'Изменить файл';
	@override String get noFileChosen => 'Файл не выбран';
	@override String get save => 'Сохранить';
	@override String get delete => 'Удалить';
	@override String get deleteConfirmTitle => 'Удалить документ';
	@override String get deleteConfirmBody => 'Удалить этот документ? Это действие необратимо.';
	@override String get empty => 'Пока нет документов';
	@override String get emptySubtitle => 'Загружайте результаты анализов, снимки и другие документы в одном месте.';
	@override String get view => 'Открыть';
	@override String get fileRequired => 'Выберите файл для загрузки';
	@override String get fileTooLarge => 'Файл слишком большой (макс. 15 МБ)';
	@override String get titleRequired => 'Укажите название';
	@override String get uploadSuccess => 'Документ загружен.';
	@override String get deletedSuccess => 'Документ удалён.';
	@override String get couldNotOpen => 'Не удалось открыть файл';
}

// Path: payments
class _Translations$payments$ru extends Translations$payments$en {
	_Translations$payments$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Оплата';
	@override String get amount => 'Сумма';
	@override String get payNow => 'Оплатить сейчас';
	@override String get payLater => 'Оплатить позже';
	@override String get statusPending => 'Ожидает оплаты';
	@override String get statusPaid => 'Оплачено';
	@override String get statusFailed => 'Оплата не прошла';
	@override String get statusCancelled => 'Отменено';
	@override String get statusRefunded => 'Возвращено';
	@override String get statusRefundFailed => 'Возврат не удался';
	@override String get paymentConfirmed => 'Оплата подтверждена. Спасибо!';
	@override String get openingBrowser => 'Открываем браузер…';
	@override String get checkStatus => 'Проверить статус';
}

// Path: family
class _Translations$family$ru extends Translations$family$en {
	_Translations$family$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Семья';
	@override String get myself => 'Я сам(а)';
	@override String get addFamilyMember => 'Добавить члена семьи';
	@override String get editFamilyMember => 'Изменить члена семьи';
	@override String get firstName => 'Имя';
	@override String get lastName => 'Фамилия';
	@override String get relationship => 'Кем приходится';
	@override String get relationshipChild => 'Ребёнок';
	@override String get relationshipSpouse => 'Супруг(а)';
	@override String get relationshipParent => 'Родитель';
	@override String get relationshipSibling => 'Брат/сестра';
	@override String get relationshipOther => 'Другое';
	@override String get dateOfBirth => 'Дата рождения';
	@override String get bloodType => 'Группа крови';
	@override String get allergies => 'Аллергии';
	@override String get chronicConditions => 'Хронические заболевания';
	@override String get medications => 'Принимаемые препараты';
	@override String get save => 'Сохранить';
	@override String get delete => 'Удалить';
	@override String get deleteConfirmTitle => 'Удалить члена семьи';
	@override String get deleteConfirmBody => 'Удалить этого члена семьи? История записей, лекарств и документов сохранится.';
	@override String get empty => 'Пока нет членов семьи';
	@override String get emptySubtitle => 'Добавьте ребёнка, супруга или другого родственника, чтобы управлять их записями, лекарствами и документами.';
	@override String get bookingForQuestion => 'Для кого эта запись на приём?';
	@override String bookingForLabel({required Object name}) => 'Запись для: ${name}';
	@override String forLabel({required Object name}) => 'для ${name}';
	@override String ageYears({required Object age}) => '${age} лет';
	@override String bookedByLabel({required Object name}) => 'Записал(а) ${name}';
	@override String get contactPhone => 'Контактный телефон';
	@override String get contactPhoneHelp => 'Мы отправим им SMS о том, что их добавили, и дадим простой способ отказаться.';
	@override String get contactEmailOptional => 'Контактный email (необязательно)';
	@override String get contactPhoneRequiredForAdult => 'Телефон обязателен, чтобы мы могли уведомить этого члена семьи';
	@override String get adultConsentNotice => 'Поскольку им исполнилось 18 лет, мы отправим им SMS о том, что вы их добавили — приложение им не понадобится, и они смогут отключить эту связь в любой момент.';
	@override String get noticeAlreadySent => 'Мы сообщили им, что их добавили. Они могут отключить эту связь в любой момент.';
	@override String get noticePendingBadge => 'Уведомление отправлено';
}

// Path: subscription
class _Translations$subscription$ru extends Translations$subscription$en {
	_Translations$subscription$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Подписка';
	@override String get planNameBasic => 'Стартовый';
	@override String get planNamePro => 'Профессиональный';
	@override String get couldNotLoad => 'Не удалось загрузить данные подписки.';
	@override String get nowActive => 'Ваша подписка активирована!';
	@override String get unavailable => 'Подписки временно недоступны. Попробуйте позже.';
	@override String trialDaysLeft({required Object days}) => 'Пробный период — осталось ${days} дн.';
	@override String graceDaysLeft({required Object days}) => 'Льготный период — осталось ${days} дн. для продления';
	@override String get expiredNotice => 'Срок действия вашей подписки истёк. Оформите подписку, чтобы снова быть видимым для пациентов.';
	@override String get activeNotice => 'Ваша подписка активна.';
	@override String get choosePlan => 'Выберите тариф, чтобы начать.';
	@override String get currentPlan => 'Текущий тариф';
	@override String get mostPopular => 'Популярный выбор';
	@override String get perMonth => 'в месяц';
	@override String get manageOnWeb => 'Управляйте подпиской на auxiodev.com';
	@override String get featureUnlimitedWorkplaces => 'Неограниченное количество клиник';
	@override String featureWorkplaces({required Object count}) => 'До ${count} клиник(и)';
	@override String get featureUnlimitedBookings => 'Неограниченное количество записей в месяц';
	@override String featureBookingsPerMonth({required Object count}) => 'До ${count} записей в месяц';
	@override String get featureChat => 'Чат с пациентами';
	@override String get featurePromoted => 'Приоритет в поиске + бейдж «Peşəkar»';
	@override String get renew => 'Продлить';
	@override String get subscribe => 'Оформить подписку';
	@override String get planNameHospitalBasic => 'Клиника';
	@override String get planNameHospitalPro => 'Клиника Плюс';
	@override String featureDoctors({required Object count}) => 'До ${count} врачей';
	@override String get featureUnlimitedDoctors => 'Неограниченное количество врачей';
	@override String get featureAdvancedStats => 'Расширенная статистика';
}

// Path: hospitalPicker
class _Translations$hospitalPicker$ru extends Translations$hospitalPicker$en {
	_Translations$hospitalPicker$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Выбор больницы';
	@override String get searchHint => 'Поиск по названию…';
	@override String get noResultsFound => 'Больницы не найдены';
	@override String get selectCityFirst => 'Сначала выберите город';
	@override String addVariant({required Object name}) => 'Добавить «${name}»';
	@override String get pendingReview => 'На проверке';
}

// Path: hospitalRegistration
class _Translations$hospitalRegistration$ru extends Translations$hospitalRegistration$en {
	_Translations$hospitalRegistration$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Данные больницы';
	@override String get subtitle => 'Выберите город, затем найдите свою больницу в списке или добавьте её.';
	@override String get cityStep => '1. Город';
	@override String get hospitalStep => '2. Больница';
	@override String get searchHint => 'Поиск по названию…';
	@override String get noResultsFound => 'Больницы не найдены';
	@override String get notFoundPrompt => 'Не нашли свою больницу?';
	@override String get addManually => 'Добавить вручную';
	@override String get useSearchInstead => 'Искать снова';
	@override String get newHospitalName => 'Название больницы';
	@override String get selectedPrefix => 'Выбрано:';
	@override String get pendingReviewNotice => 'Новые больницы проверяются нашей командой, прежде чем появиться у других пользователей.';
	@override String get submit => 'Создать аккаунт';
	@override String get hospitalRequired => 'Выберите или добавьте больницу, чтобы продолжить';
}

// Path: hospitalHome
class _Translations$hospitalHome$ru extends Translations$hospitalHome$en {
	_Translations$hospitalHome$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Здравствуйте, ${name}';
	@override String get subtitle => 'Управляйте врачами и записями';
	@override String get doctors => 'Врачи';
	@override String get inviteDoctor => 'Пригласить врача';
	@override String get appointments => 'Записи';
	@override String get profile => 'Профиль';
	@override String pendingRequests({required Object count}) => '${count} заявок ожидают решения';
}

// Path: hospitalDoctors
class _Translations$hospitalDoctors$ru extends Translations$hospitalDoctors$en {
	_Translations$hospitalDoctors$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Врачи';
	@override String get tabConfirmed => 'Подтверждённые';
	@override String get tabRequests => 'Заявки';
	@override String get tabInvited => 'Приглашённые';
	@override String get noConfirmedDoctors => 'Пока нет подтверждённых врачей';
	@override String get noRequests => 'Нет ожидающих заявок';
	@override String get noInvited => 'Нет ожидающих приглашений';
	@override String get approve => 'Подтвердить';
	@override String get reject => 'Отклонить';
	@override String get remove => 'Удалить';
	@override String get removeConfirmTitle => 'Удалить врача?';
	@override String removeConfirmMessage({required Object name}) => '${name} больше не будет связан с вашей больницей. Это не повлияет на его место работы и записи.';
	@override String get requestedToJoin => 'Запросил присоединение';
	@override String get invitedAwaiting => 'Приглашён — ожидает ответа';
	@override String get editHours => 'Изменить часы';
}

// Path: hospitalInvite
class _Translations$hospitalInvite$ru extends Translations$hospitalInvite$en {
	_Translations$hospitalInvite$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Пригласить врача';
	@override String get searchHint => 'Поиск по имени или специализации…';
	@override String get noResultsFound => 'Врачи не найдены';
	@override String get invite => 'Пригласить';
	@override String get invited => 'Приглашён';
}

// Path: hospitalAppointments
class _Translations$hospitalAppointments$ru extends Translations$hospitalAppointments$en {
	_Translations$hospitalAppointments$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Записи';
	@override String get empty => 'Пока нет записей';
}

// Path: hospitalProfile
class _Translations$hospitalProfile$ru extends Translations$hospitalProfile$en {
	_Translations$hospitalProfile$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Профиль больницы';
	@override String usageDoctors({required Object count, required Object limit}) => '${count} из ${limit} врачей';
	@override String usageDoctorsUnlimited({required Object count}) => '${count} врачей (без ограничений)';
	@override String get manageSubscription => 'Управление подпиской';
}

// Path: hospitalDoctorHours
class _Translations$hospitalDoctorHours$ru extends Translations$hospitalDoctorHours$en {
	_Translations$hospitalDoctorHours$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Часы работы';
	@override String get selectWorkplace => 'Выберите место работы';
	@override String get saved => 'Часы сохранены';
}

// Path: doctorHospitals
class _Translations$doctorHospitals$ru extends Translations$doctorHospitals$en {
	_Translations$doctorHospitals$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Мои больницы';
	@override String get tabInvitations => 'Приглашения';
	@override String get tabRequests => 'Заявки';
	@override String get tabConfirmed => 'Больницы';
	@override String get noInvitations => 'Нет ожидающих приглашений';
	@override String get noRequests => 'Нет ожидающих заявок';
	@override String get noConfirmed => 'Вы пока не связаны ни с одной больницей';
	@override String get accept => 'Принять';
	@override String get decline => 'Отклонить';
	@override String get cancelRequest => 'Отменить заявку';
	@override String get invitedYouToJoin => 'Пригласила вас присоединиться';
	@override String get awaitingApproval => 'Ожидает подтверждения больницы';
}

// Path: share
class _Translations$share$ru extends Translations$share$en {
	_Translations$share$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Поделиться профилем';
	@override String get shareLink => 'Поделиться ссылкой';
	@override String get copyLink => 'Скопировать ссылку';
	@override String get linkCopied => 'Ссылка скопирована';
}

// Path: hospitalDetail
class _Translations$hospitalDetail$ru extends Translations$hospitalDetail$en {
	_Translations$hospitalDetail$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Больница';
	@override String get couldNotLoad => 'Не удалось загрузить профиль';
	@override String get location => 'Адрес';
	@override String get doctorsHeading => 'Врачи в клинике';
}

// Path: doctorSearch.spec
class _Translations$doctorSearch$spec$ru extends Translations$doctorSearch$spec$en {
	_Translations$doctorSearch$spec$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get general => 'Общий';
	@override String get cardiology => 'Кардиология';
	@override String get dermatology => 'Дерматология';
	@override String get neurology => 'Неврология';
	@override String get orthopedics => 'Ортопедия';
	@override String get pediatrics => 'Педиатрия';
	@override String get psychiatry => 'Психиатрия';
	@override String get gynecology => 'Гинекология';
	@override String get urology => 'Урология';
	@override String get ophthalmology => 'Офтальмология';
	@override String get ent => 'ЛОР';
}

// Path: workingHours.days
class _Translations$workingHours$days$ru extends Translations$workingHours$days$en {
	_Translations$workingHours$days$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get monday => 'Понедельник';
	@override String get tuesday => 'Вторник';
	@override String get wednesday => 'Среда';
	@override String get thursday => 'Четверг';
	@override String get friday => 'Пятница';
	@override String get saturday => 'Суббота';
	@override String get sunday => 'Воскресенье';
}

// Path: legal.sections
class _Translations$legal$sections$ru extends Translations$legal$sections$en {
	_Translations$legal$sections$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$legal$sections$identity$ru identity = _Translations$legal$sections$identity$ru._(_root);
	@override late final _Translations$legal$sections$health$ru health = _Translations$legal$sections$health$ru._(_root);
	@override late final _Translations$legal$sections$professional$ru professional = _Translations$legal$sections$professional$ru._(_root);
	@override late final _Translations$legal$sections$location$ru location = _Translations$legal$sections$location$ru._(_root);
	@override late final _Translations$legal$sections$device$ru device = _Translations$legal$sections$device$ru._(_root);
	@override late final _Translations$legal$sections$payment$ru payment = _Translations$legal$sections$payment$ru._(_root);
	@override late final _Translations$legal$sections$family$ru family = _Translations$legal$sections$family$ru._(_root);
	@override late final _Translations$legal$sections$purposes$ru purposes = _Translations$legal$sections$purposes$ru._(_root);
	@override late final _Translations$legal$sections$legalBasis$ru legalBasis = _Translations$legal$sections$legalBasis$ru._(_root);
	@override late final _Translations$legal$sections$thirdParties$ru thirdParties = _Translations$legal$sections$thirdParties$ru._(_root);
	@override late final _Translations$legal$sections$retention$ru retention = _Translations$legal$sections$retention$ru._(_root);
	@override late final _Translations$legal$sections$rights$ru rights = _Translations$legal$sections$rights$ru._(_root);
	@override late final _Translations$legal$sections$security$ru security = _Translations$legal$sections$security$ru._(_root);
	@override late final _Translations$legal$sections$permissions$ru permissions = _Translations$legal$sections$permissions$ru._(_root);
	@override late final _Translations$legal$sections$children$ru children = _Translations$legal$sections$children$ru._(_root);
}

// Path: legal.sections.identity
class _Translations$legal$sections$identity$ru extends Translations$legal$sections$identity$en {
	_Translations$legal$sections$identity$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Данные для идентификации';
	@override String get body => 'Имя и фамилия, email, номер телефона (необязательно), пароль (хранится в виде необратимого хэша, никогда в открытом виде), предпочитаемый язык приложения.';
}

// Path: legal.sections.health
class _Translations$legal$sections$health$ru extends Translations$legal$sections$health$en {
	_Translations$legal$sections$health$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Данные о здоровье';
	@override String get body => 'Для пациентов: группа крови, аллергии, хронические заболевания, принимаемые лекарства, причина обращения при бронировании, загруженные медицинские документы (анализы, снимки, прочие записи), выписанные вам рецепты, содержание переписки с врачом. При использовании ИИ-ассистента для проверки симптомов таким же образом обрабатываются ваши вопросы и его ответы. Данные о здоровье получают наивысший уровень защиты по законодательству Азербайджана — мы собираем их только при вашем отдельном явном согласии (см. «Правовое основание» ниже).';
}

// Path: legal.sections.professional
class _Translations$legal$sections$professional$ru extends Translations$legal$sections$professional$en {
	_Translations$legal$sections$professional$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Профессиональные данные (врачи)';
	@override String get body => 'Специализация, номер лицензии, диплом или иной подтверждающий документ, данные о месте работы, стоимость консультации. Эти данные проверяются нашей командой до того, как профиль станет виден пациентам.';
}

// Path: legal.sections.location
class _Translations$legal$sections$location$ru extends Translations$legal$sections$location$en {
	_Translations$legal$sections$location$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Геолокация';
	@override String get body => 'С вашего разрешения — приблизительное или точное местоположение, чтобы сортировать врачей по расстоянию до вас. Используется только пока приложение открыто и никогда не сохраняется на наших серверах.';
}

// Path: legal.sections.device
class _Translations$legal$sections$device$ru extends Translations$legal$sections$device$en {
	_Translations$legal$sections$device$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Данные устройства';
	@override String get body => 'Идентификаторы устройства и данные сессии — чтобы вы могли видеть и отзывать активные входы в разделе «Настройки», а также токен push-уведомлений для доставки напоминаний о приёмах и сообщений.';
}

// Path: legal.sections.payment
class _Translations$legal$sections$payment$ru extends Translations$legal$sections$payment$en {
	_Translations$legal$sections$payment$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Платёжные данные';
	@override String get body => 'Если вы оплачиваете консультацию в приложении, оплата полностью обрабатывается нашим платёжным партнёром Payriff — мы никогда не видим и не храним номер вашей карты. Мы сохраняем сумму платежа, статус и идентификатор для истории ваших записей.';
}

// Path: legal.sections.family
class _Translations$legal$sections$family$ru extends Translations$legal$sections$family$en {
	_Translations$legal$sections$family$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Профили членов семьи';
	@override String get body => 'Если вы управляете профилем члена семьи (ребёнка или иждивенца без собственного входа в аккаунт), те же категории данных о здоровье выше могут фиксироваться для него в рамках вашего аккаунта. Добавляя члена семьи, вы подтверждаете, что являетесь его родителем, опекуном или иным образом уполномочены управлять его медицинскими данными.';
}

// Path: legal.sections.purposes
class _Translations$legal$sections$purposes$ru extends Translations$legal$sections$purposes$en {
	_Translations$legal$sections$purposes$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Зачем нам ваши данные';
	@override String get body => 'Чтобы вы могли находить врачей и записываться к ним на приём; чтобы врачи могли управлять расписанием и пациентами; для отправки напоминаний о приёмах и обновлений; для обработки платежей за консультации; для работы опциональной функции ИИ-проверки симптомов; для обеспечения безопасности вашего аккаунта.';
}

// Path: legal.sections.legalBasis
class _Translations$legal$sections$legalBasis$ru extends Translations$legal$sections$legalBasis$en {
	_Translations$legal$sections$legalBasis$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Правовое основание и ваше согласие';
	@override String get body => 'Мы обрабатываем ваши данные на основании согласия, данного при регистрации. Данные о здоровье относятся к специальной категории персональных данных по Закону Азербайджанской Республики «О персональных данных» (№998-IIIQ), который требует явного письменного согласия до их сбора — именно это фиксирует чекбокс на экране регистрации. Вы можете отозвать согласие в любой момент, удалив аккаунт, хотя мы можем сохранить ограниченные записи, если это требуется законом (например, финансовые записи для налоговой отчётности).';
}

// Path: legal.sections.thirdParties
class _Translations$legal$sections$thirdParties$ru extends Translations$legal$sections$thirdParties$en {
	_Translations$legal$sections$thirdParties$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Кто ещё обрабатывает ваши данные';
	@override String get body => 'Доверенные поставщики услуг, действующие только по нашему поручению и исключительно для описанных здесь целей: Cloudinary (безопасное хранение файлов — документы и фото никогда не доступны публично, только по подписанным ссылкам с ограниченным сроком действия); Firebase/Google (push-уведомления и вход через Google, если вы его выберете); Apple (вход через Apple, если вы его выберете); Payriff (платежи в приложении). Мы не продаём ваши персональные данные.';
}

// Path: legal.sections.retention
class _Translations$legal$sections$retention$ru extends Translations$legal$sections$retention$en {
	_Translations$legal$sections$retention$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Сколько мы храним данные';
	@override String get body => 'Пока ваш аккаунт активен. При удалении аккаунта мы удаляем ваши персональные данные в разумный срок, за исключением записей, которые обязаны хранить по закону (например, платёжные записи для налогового учёта).';
}

// Path: legal.sections.rights
class _Translations$legal$sections$rights$ru extends Translations$legal$sections$rights$en {
	_Translations$legal$sections$rights$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ваши права';
	@override String get body => 'Вы можете запросить доступ к данным, которые мы о вас храним, потребовать исправления неточных данных, потребовать удаления аккаунта и данных, а также отозвать согласие в любой момент. Большая часть этого доступна прямо в разделе «Профиль» → «Настройки»; по остальным вопросам — свяжитесь с нами ниже.';
}

// Path: legal.sections.security
class _Translations$legal$sections$security$ru extends Translations$legal$sections$security$en {
	_Translations$legal$sections$security$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Как мы защищаем ваши данные';
	@override String get body => 'Переписка с врачом и разговоры с ИИ-ассистентом шифруются. Загруженные документы и фото хранятся приватно и доступны только по защищённым подписанным ссылкам, никогда как публичные файлы. Пароли никогда не хранятся в читаемом виде.';
}

// Path: legal.sections.permissions
class _Translations$legal$sections$permissions$ru extends Translations$legal$sections$permissions$en {
	_Translations$legal$sections$permissions$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Какие разрешения мы запрашиваем';
	@override String get body => 'Камера и фотогалерея — чтобы установить фото профиля и загрузить медицинские документы. Геолокация — чтобы сортировать врачей по расстоянию до вас. Уведомления — чтобы доставлять напоминания о приёмах и сообщения. Биометрия (Face ID / отпечаток пальца) — необязательный, более быстрый способ разблокировки приложения; ваши биометрические данные никогда не покидают устройство, мы получаем только подтверждение «да/нет» от его операционной системы.';
}

// Path: legal.sections.children
class _Translations$legal$sections$children$ru extends Translations$legal$sections$children$en {
	_Translations$legal$sections$children$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Возрастное ограничение';
	@override String get body => 'Аккаунты DocGet предназначены для совершеннолетних. Если вам меньше 18 лет, попросите родителя или опекуна создать и вести аккаунт от вашего имени через функцию профилей членов семьи.';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'DocGet',
			'common.cancel' => 'Отмена',
			'common.logout' => 'Выйти',
			'common.doctor' => 'Врач',
			'common.patient' => 'Пациент',
			'common.save' => 'Сохранить',
			'common.edit' => 'Изменить',
			'common.retry' => 'Повторить',
			'common.back' => 'Назад',
			'common.ok' => 'OK',
			'common.delete' => 'Удалить',
			'common.keep' => 'Оставить',
			'common.confirm' => 'Подтвердить',
			'common.decline' => 'Отклонить',
			'common.primary' => 'Основной',
			'common.somethingWrong' => 'Что-то пошло не так',
			'common.seeAll' => 'Все',
			'common.signOut' => 'Выйти',
			'common.search' => 'Поиск',
			'common.tryAgain' => 'Повторите попытку',
			'common.required' => 'Обязательно',
			'common.noRatings' => 'Нет оценок',
			'common.hospital' => 'Больница',
			'auth.login' => 'Войти',
			'auth.register' => 'Создать аккаунт',
			'auth.signIn' => 'Войти',
			'auth.signUp' => 'Зарегистрироваться',
			'auth.password' => 'Пароль',
			'auth.confirmPassword' => 'Подтвердите пароль',
			'auth.firstName' => 'Имя',
			'auth.lastName' => 'Фамилия',
			'auth.rememberMe' => 'Запомнить меня',
			'auth.forgotPassword' => 'Забыли пароль?',
			'auth.sendResetLink' => 'Отправить код',
			'auth.noAccount' => 'Нет аккаунта?',
			'auth.haveAccount' => 'Уже есть аккаунт?',
			'auth.welcomeBack' => 'С возвращением',
			'auth.signInToContinue' => 'Войдите в аккаунт, чтобы продолжить',
			'auth.createYourAccount' => 'Создайте аккаунт',
			'auth.joinMedalize' => 'Присоединяйтесь к DocGet',
			'auth.iAmA' => 'Я —',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => 'Назад ко входу',
			'auth.verificationCode' => 'Код подтверждения',
			'auth.continueWithGoogle' => 'Продолжить с Google',
			'auth.continueWithApple' => 'Продолжить с Apple',
			'auth.orDivider' => 'или',
			'forgotPassword.title' => 'Забыли пароль?',
			'forgotPassword.subtitle' => 'Введите номер телефона, и мы отправим 6-значный код для сброса',
			'resetPassword.title' => 'Сброс пароля',
			'resetPassword.subtitle' => 'Введите код, отправленный на ваш телефон, и выберите новый пароль',
			'resetPassword.button' => 'Сбросить пароль',
			'resetPassword.success' => 'Пароль успешно сброшен. Войдите в аккаунт.',
			'verifyPhone.title' => 'Подтвердите номер телефона',
			'verifyPhone.subtitle' => ({required Object phone}) => 'Мы отправили 6-значный код на ${phone}',
			'verifyPhone.button' => 'Подтвердить',
			'verifyPhone.resend' => 'Отправить код повторно',
			'verifyPhone.resendSent' => 'Новый код отправлен.',
			'socialComplete.title' => 'Ещё один шаг',
			'socialComplete.subtitle' => 'Укажите и подтвердите номер телефона, чтобы завершить создание аккаунта.',
			'socialComplete.button' => 'Продолжить',
			'validation.emailRequired' => 'Введите эл. почту',
			'validation.emailInvalid' => 'Введите действительный адрес эл. почты',
			'validation.passwordRequired' => 'Введите пароль',
			'validation.passwordTooShort' => 'Не менее 8 символов',
			'validation.passwordNeedsLetter' => 'Добавьте хотя бы одну букву',
			'validation.passwordNeedsDigit' => 'Добавьте хотя бы одну цифру',
			'validation.passwordMismatch' => 'Пароли не совпадают',
			'validation.passwordConfirmRequired' => 'Подтвердите пароль',
			'validation.nameMinLength' => 'Не менее 2 символов',
			'validation.roleRequired' => 'Выберите роль',
			'validation.phoneRequired' => 'Введите номер телефона',
			'validation.phoneTooShort' => 'Номер слишком короткий',
			'validation.phoneTooLong' => 'Номер слишком длинный',
			'validation.fieldRequired' => ({required Object field}) => '${field} — обязательное поле',
			'validation.fieldInvalid' => ({required Object field}) => '${field} содержит недопустимые символы',
			'errors.network' => 'Ошибка сети. Проверьте подключение.',
			'errors.rateLimit' => 'Слишком много попыток. Подождите и повторите.',
			'errors.rateLimitWithSeconds' => ({required Object seconds}) => 'Слишком много попыток. Повторите через ${seconds} с.',
			'errors.invalidCredentials' => 'Неверный номер телефона или пароль',
			'errors.sessionExpired' => 'Сессия истекла. Пожалуйста, войдите снова.',
			'errors.authError' => 'Ошибка аутентификации. Пожалуйста, войдите снова.',
			'errors.sessionRevoked' => 'Сессия отозвана. Пожалуйста, войдите снова.',
			'errors.permissionDenied' => 'У вас нет прав для этого действия.',
			'errors.validationError' => 'Ошибка проверки',
			'errors.serverError' => ({required Object code}) => 'Ошибка сервера (${code}). Повторите попытку.',
			'errors.socialLoginFailed' => 'Не удалось войти. Попробуйте снова или используйте номер телефона и пароль.',
			'errors.conflict' => 'Это действие сейчас невозможно выполнить.',
			'errors.onboardingIncomplete' => 'Заполните все обязательные поля, чтобы завершить регистрацию.',
			'errors.planLimitReached' => 'Вы достигли лимита вашего тарифа. Перейдите на более высокий тариф.',
			'errors.chatUnavailable' => 'Этот врач не предлагает чат на своём текущем тарифе.',
			'errors.phoneNotVerified' => 'Подтвердите номер телефона перед входом.',
			'settings.title' => 'Настройки',
			'settings.account' => 'Аккаунт',
			'settings.profile' => 'Профиль',
			'settings.notifications' => 'Уведомления',
			'settings.appearance' => 'Оформление',
			'settings.themeSystem' => 'Системная',
			'settings.themeLight' => 'Светлая',
			'settings.themeDark' => 'Тёмная',
			'settings.language' => 'Язык',
			'settings.languageSystem' => 'Как в системе',
			'settings.logoutTitle' => 'Выход',
			'settings.logoutConfirm' => 'Вы уверены, что хотите выйти?',
			'settings.version' => 'DocGet v1.0.0',
			'settings.legal' => 'Конфиденциальность и условия',
			'security.title' => 'Безопасность',
			'security.biometricLogin' => 'Вход по биометрии',
			'security.biometricLoginSubtitle' => 'Используйте Face ID / Touch ID для разблокировки приложения',
			'security.biometricPrompt' => 'Подтвердите личность для доступа к DocGet',
			'security.biometricUnavailable' => 'Биометрическая аутентификация недоступна на этом устройстве',
			'security.biometricEnableFailed' => 'Не удалось подтвердить биометрию. Попробуйте снова.',
			'security.activeSessions' => 'Активные сессии',
			'security.activeSessionsSubtitle' => 'Устройства, вошедшие в ваш аккаунт',
			'security.thisDevice' => 'Это устройство',
			'security.lastActive' => ({required Object date}) => 'Последняя активность: ${date}',
			'security.revoke' => 'Отозвать',
			'security.revokeConfirmTitle' => 'Отозвать устройство?',
			'security.revokeConfirmMessage' => ({required Object name}) => '${name} будет выведено из системы. Оно сможет войти снова с вашими учётными данными.',
			'security.revokeCurrentConfirmMessage' => 'Это ваше текущее устройство — его отзыв немедленно завершит вашу сессию.',
			'security.revokeFailed' => 'Не удалось отозвать это устройство. Попробуйте снова.',
			'security.signOutAllDevices' => 'Выйти со всех устройств',
			'security.signOutAllConfirmTitle' => 'Выйти везде?',
			'security.signOutAllConfirmMessage' => 'Вы выйдете из системы на всех устройствах, включая это.',
			'security.signOutAllFailed' => 'Не удалось выйти со всех устройств. Попробуйте снова.',
			'security.noDevices' => 'Активные сессии не найдены',
			'security.loadFailed' => 'Не удалось загрузить активные сессии',
			'security.changePhone' => 'Изменить номер телефона',
			'security.changePhoneSubtitle' => 'Мы отправим код подтверждения на новый номер. После подтверждения вы будете входить с новым номером.',
			'security.sendCode' => 'Отправить код',
			'security.codeSentTo' => ({required Object phone}) => 'Введите 6-значный код, отправленный на ${phone}',
			'security.confirmNewPhone' => 'Подтвердить новый номер',
			'security.changePhoneSuccess' => 'Номер телефона изменён. Войдите заново с новым номером.',
			'security.dangerZone' => 'Опасная зона',
			'security.deactivateAccount' => 'Деактивировать аккаунт',
			'security.deactivateAccountSubtitle' => 'Отключить аккаунт без удаления данных',
			'security.deactivateConfirmTitle' => 'Деактивировать аккаунт?',
			'security.deactivateConfirmMessage' => 'Аккаунт будет деактивирован, и вы выйдете из системы на всех устройствах. Данные не удаляются. Для восстановления обратитесь в поддержку.',
			'security.deactivate' => 'Деактивировать',
			'security.deactivateSuccess' => 'Ваш аккаунт деактивирован.',
			'security.deleteAccount' => 'Удалить аккаунт навсегда',
			'security.deleteAccountSubtitle' => 'Удалить ваши данные без возможности восстановления.',
			'security.deleteConfirmTitle' => 'Удалить аккаунт навсегда?',
			'security.deleteConfirmWarning' => 'Это действие необратимо и не может быть отменено.',
			'security.deleteConfirmMessage' => 'Ваш профиль, медицинские записи, рецепты и сообщения будут безвозвратно удалены. Предстоящие приёмы будут отменены и возвращены при наличии права на возврат. Платёжные записи сохраняются в обезличенном виде для целей бухгалтерского учёта, как того требует закон.',
			'security.deleteAccountSuccess' => 'Ваш аккаунт был безвозвратно удалён.',
			'status.confirmed' => 'Подтверждено',
			'status.pending' => 'В ожидании',
			'status.cancelled' => 'Отменено',
			'status.declined' => 'Отклонено',
			'status.requiresRescheduling' => 'Требует переноса',
			'status.completed' => 'Завершено',
			'status.noShow' => 'Неявка',
			'home.helloDoctor' => ({required Object name}) => 'Здравствуйте, д-р ${name}!',
			'home.helloPatient' => ({required Object name}) => 'Здравствуйте, ${name}!',
			'home.doctorSubtitle' => 'Управляйте расписанием\nи приёмами.',
			'home.patientSubtitle' => 'Найдите врача и\nзапишитесь на приём.',
			'home.pendingRequests' => 'Ожидающие запросы',
			'home.upcoming' => 'Предстоящие',
			'home.findDoctor' => 'Найти врача',
			'home.aiAssistant' => 'ИИ-ассистент',
			'home.myAppointments' => 'Мои приёмы',
			'home.appointments' => 'Приёмы',
			'home.workplaces' => 'Места работы',
			'home.blockTime' => 'Заблокировать время',
			'home.profile' => 'Профиль',
			'home.allCaughtUp' => 'Всё в порядке',
			'home.noPendingRequests' => 'Нет ожидающих запросов на приём',
			'home.couldNotLoadAppointments' => 'Не удалось загрузить приёмы',
			'home.noUpcoming' => 'Нет предстоящих приёмов',
			'home.bookFirst' => 'Запишитесь на первый приём к врачу',
			'home.findADoctor' => 'Найти врача',
			'home.myWaitlist' => 'Лист ожидания',
			'home.leaveWaitlist' => 'Выйти',
			'home.statsThisMonth' => 'Этот месяц',
			'home.statsPatients' => 'Пациенты',
			'home.statsAcceptRate' => '% принятых',
			'home.statsPending' => 'Ожидают',
			'home.schedule' => 'Расписание',
			'home.quickBookWith' => ({required Object name}) => 'Записаться к ${name}',
			'appointments.title' => 'Приёмы',
			'appointments.myTitle' => 'Мои приёмы',
			'appointments.tabPending' => 'Ожидают',
			'appointments.tabAll' => 'Все',
			'appointments.tabUpcoming' => 'Предстоящие',
			'appointments.tabPast' => 'Прошедшие',
			'appointments.noPendingRequests' => 'Нет ожидающих запросов',
			'appointments.newRequestsAppear' => 'Новые запросы на приём появятся здесь',
			'appointments.noAppointments' => 'Нет приёмов',
			'appointments.appointmentsAppear' => 'Ваши приёмы появятся здесь',
			'appointments.noUpcoming' => 'Нет предстоящих приёмов',
			'appointments.bookFirst' => 'Запишитесь на первый приём к врачу',
			'appointments.noPast' => 'Нет прошедших приёмов',
			'appointments.pastAppear' => 'Завершённые и отменённые приёмы появятся здесь',
			'appointments.couldNotLoad' => 'Не удалось загрузить приёмы',
			'appointments.detailTitle' => 'Приём',
			'appointments.patient' => 'Пациент',
			'appointments.doctor' => 'Врач',
			'appointments.workplace' => 'Место работы',
			'appointments.dateTime' => 'Дата и время',
			'appointments.reason' => 'Причина',
			'appointments.doctorNotes' => 'Заметки врача',
			'appointments.cancelTitle' => 'Отменить приём',
			'appointments.cancelConfirm' => 'Вы уверены, что хотите отменить этот приём?',
			'appointments.cancelAction' => 'Отменить приём',
			'appointments.cancelledSuccess' => 'Приём отменён.',
			'appointments.cancelledRefunded' => 'Приём отменён. Оплата возвращена.',
			'appointments.cancelledNoRefund' => 'Приём отменён. Возврат не произведён — отмена произошла слишком близко к времени приёма.',
			'appointments.bookedTitle' => 'Записано!',
			'appointments.bookedMessage' => 'Ваш запрос на приём отправлен.',
			'appointments.reschedule' => 'Перенести',
			'appointments.rescheduleTitle' => 'Перенос приёма',
			'appointments.reviewTitle' => 'Оставить отзыв',
			'appointments.reviewRating' => 'Оценка',
			'appointments.reviewComment' => 'Комментарий (необязательно)',
			'appointments.reviewSubmit' => 'Отправить',
			'appointments.markCompleted' => 'Отметить завершённым',
			'appointments.rescheduledSuccess' => 'Запись успешно перенесена.',
			'appointments.reviewSubmitted' => 'Отзыв отправлен. Спасибо!',
			'appointments.yourReview' => 'Ваш отзыв',
			'appointments.editReviewTitle' => 'Изменить отзыв',
			'appointments.reviewUpdated' => 'Отзыв обновлён.',
			'appointments.deleteReviewTitle' => 'Удалить отзыв',
			'appointments.deleteReviewConfirm' => 'Вы уверены, что хотите удалить свой отзыв?',
			'appointments.reviewDeleted' => 'Отзыв удалён.',
			'appointments.requestReschedule' => 'Запросить перенос',
			'appointments.requestRescheduleTitle' => 'Запрос переноса',
			'appointments.requestRescheduleConfirm' => 'Попросить пациента выбрать новое время? Запись будет помечена как требующая переноса.',
			'appointments.requestRescheduleSuccess' => 'Перенос запрошен. Пациент получит уведомление.',
			'appointments.rescheduleNeededHint' => 'Врач попросил вас выбрать новое время.',
			'appointments.markNoShow' => 'Отметить неявку',
			'appointments.markNoShowTitle' => 'Отметить как неявку',
			'appointments.markNoShowConfirm' => 'Отметить этот приём как неявку? Будет зафиксировано, что пациент не пришёл.',
			'appointments.disputeNoShow' => 'Оспорить',
			'appointments.disputeNoShowTitle' => 'Оспорить неявку',
			'appointments.disputeNoShowHint' => 'Расскажите, почему вы считаете, что это отмечено ошибочно — наша служба поддержки рассмотрит обращение.',
			'appointments.disputeNoShowSubmit' => 'Отправить',
			'appointments.disputeNoShowSubmitted' => 'Ваше обращение отправлено. Мы рассмотрим его и свяжемся с вами.',
			'appointments.disputeNoShowOpen' => 'Обращение отправлено — на рассмотрении',
			'appointments.bookedSnack' => 'Запись отправлена',
			'appointments.bookAgain' => 'Записаться снова',
			'booking.bookWith' => ({required Object name}) => 'Запись — ${name}',
			'booking.selectWorkplace' => 'Выберите место работы',
			'booking.pickDate' => 'Выберите дату',
			'booking.slotsAppear' => 'Доступные слоты появятся здесь',
			'booking.couldNotLoadSlots' => 'Не удалось загрузить слоты',
			'booking.noAvailableSlots' => 'Нет доступных слотов',
			'booking.noOpenSlots' => 'На эту дату нет свободных слотов. Попробуйте другой день.',
			'booking.reasonForVisit' => 'Причина визита (необязательно)',
			'booking.tryDifferentDate' => 'Попробуйте другую дату',
			'booking.earliestPreselected' => 'Выбран ближайший свободный слот',
			'booking.continueAt' => ({required Object time}) => 'Продолжить — ${time}',
			'booking.confirmAt' => ({required Object time}) => 'Подтвердить — ${time}',
			'booking.reasonPresetCheckup' => 'Плановый осмотр',
			'booking.reasonPresetFollowUp' => 'Повторный визит',
			'booking.reasonPresetNewComplaint' => 'Новая жалоба',
			'doctorSearch.title' => 'Найти врача',
			'doctorSearch.searchByName' => 'Поиск по имени...',
			'doctorSearch.city' => 'Город',
			'doctorSearch.search' => 'Поиск',
			'doctorSearch.noDoctorsFound' => 'Врачи не найдены',
			'doctorSearch.adjustSearch' => 'Попробуйте изменить поиск или фильтры',
			'doctorSearch.couldNotLoadDoctors' => 'Не удалось загрузить врачей',
			'doctorSearch.loadMore' => 'Показать ещё',
			'doctorSearch.spec.general' => 'Общий',
			'doctorSearch.spec.cardiology' => 'Кардиология',
			'doctorSearch.spec.dermatology' => 'Дерматология',
			'doctorSearch.spec.neurology' => 'Неврология',
			'doctorSearch.spec.orthopedics' => 'Ортопедия',
			'doctorSearch.spec.pediatrics' => 'Педиатрия',
			'doctorSearch.spec.psychiatry' => 'Психиатрия',
			'doctorSearch.spec.gynecology' => 'Гинекология',
			'doctorSearch.spec.urology' => 'Урология',
			'doctorSearch.spec.ophthalmology' => 'Офтальмология',
			'doctorSearch.spec.ent' => 'ЛОР',
			'doctorSearch.noAvailability' => 'Нет свободного времени',
			'doctorSearch.availableToday' => 'Доступен сегодня',
			'doctorSearch.availableTomorrow' => 'Доступен завтра',
			'doctorSearch.availableOn' => ({required Object date}) => 'Доступен ${date}',
			'doctorSearch.sortBy' => 'Сортировка',
			'doctorSearch.sortDefault' => 'По умолчанию',
			'doctorSearch.sortRating' => 'По рейтингу',
			'doctorSearch.sortPriceLow' => 'Сначала дешевле',
			'doctorSearch.sortName' => 'По имени (А–Я)',
			'doctorSearch.sortNearestSlot' => 'Ближайшая запись',
			'doctorSearch.sortDistance' => 'По расстоянию',
			'doctorSearch.locationDenied' => 'Для сортировки по расстоянию нужен доступ к геолокации. Разрешите его в настройках или используйте фильтр по городу.',
			'doctorSearch.locationUnavailable' => 'Не удалось определить местоположение. Проверьте, что геолокация включена, или используйте фильтр по городу.',
			'doctorSearch.distanceKm' => ({required Object km}) => '${km} км',
			'doctorSearch.book' => 'Записаться',
			'doctorDetail.profileTitle' => 'Профиль врача',
			'doctorDetail.couldNotLoadProfile' => 'Не удалось загрузить профиль',
			'doctorDetail.about' => 'О себе',
			'doctorDetail.workplaces' => 'Места работы',
			'doctorDetail.minPerSlot' => ({required Object min}) => '${min} мин на приём',
			'doctorDetail.bookAppointment' => 'Записаться на приём',
			'doctorDetail.consultationFee' => 'Стоимость приёма',
			'doctorDetail.reviews' => 'Отзывы',
			'doctorDetail.reviewsCount' => ({required Object count}) => '${count} отзывов',
			'doctorDetail.joinWaitlist' => 'В лист ожидания',
			'doctorDetail.leaveWaitlist' => 'Покинуть лист ожидания',
			'profile.title' => 'Профиль',
			'profile.changePassword' => 'Изменить пароль',
			'profile.currentPassword' => 'Текущий пароль',
			'profile.newPassword' => 'Новый пароль',
			'profile.confirmNewPassword' => 'Подтвердите новый пароль',
			'profile.firstName' => 'Имя',
			'profile.lastName' => 'Фамилия',
			'profile.phone' => 'Телефон',
			'profile.failedToSave' => 'Не удалось сохранить профиль.',
			'profile.professionalInfo' => 'Профессиональная информация',
			'profile.bio' => 'О себе',
			'profile.bioHint' => 'Краткое описание вашего опыта',
			'profile.consultationFee' => 'Стоимость приёма',
			'profile.medicalInfo' => 'Медицинская информация',
			'profile.allergies' => 'Аллергии',
			'profile.allergiesHint' => 'напр. Пенициллин, орехи',
			'profile.chronicConditions' => 'Хронические заболевания',
			'profile.chronicConditionsHint' => 'напр. Диабет, гипертония',
			'profile.medications' => 'Принимаемые препараты',
			'profile.medicationsHint' => 'напр. Метформин 500 мг',
			'profile.appointmentLength' => 'Длительность приёма',
			'profile.cancellationWindow' => 'Срок отмены',
			'profile.cancellationWindowHint' => 'За сколько часов до приёма пациент ещё может отменить или перенести.',
			'profile.hoursValue' => ({required Object h}) => '${h} ч',
			'notifications.title' => 'Уведомления',
			'notifications.noNotifications' => 'Нет уведомлений',
			'notifications.allCaughtUp' => 'Вы всё просмотрели',
			'notifications.couldNotLoad' => 'Не удалось загрузить уведомления',
			'notifications.markAllRead' => 'Отметить всё прочитанным',
			'notifications.settingsTitle' => 'Настройки уведомлений',
			'notifications.pushEnabled' => 'Push-уведомления',
			'notifications.pushEnabledSubtitle' => 'Оповещения на этом устройстве о записях и изменениях',
			'notifications.emailEnabled' => 'Уведомления на email',
			'notifications.emailEnabledSubtitle' => 'Изменения будут приходить на вашу почту',
			'notifications.categoriesTitle' => 'Категории push-уведомлений',
			'notifications.careCategory' => 'Приёмы и здоровье',
			'notifications.careCategorySubtitle' => 'Брони, напоминания, рецепты',
			'notifications.messagesCategory' => 'Сообщения',
			'notifications.messagesCategorySubtitle' => 'Новые сообщения в чате',
			'notifications.accountCategory' => 'Аккаунт и оплата',
			'notifications.accountCategorySubtitle' => 'Верификация, платежи, подписка',
			'notifications.quietHoursTitle' => 'Тихие часы',
			'notifications.quietHoursEnabled' => 'Включить тихие часы',
			'notifications.quietHoursSubtitle' => 'В это время push-уведомления не приходят',
			'notifications.quietHoursStart' => 'Начало',
			'notifications.quietHoursEnd' => 'Конец',
			'workplaces.title' => 'Мои места работы',
			'workplaces.noWorkplacesYet' => 'Пока нет мест работы',
			'workplaces.tapToAdd' => 'Нажмите +, чтобы добавить первое место работы',
			'workplaces.couldNotLoad' => 'Не удалось загрузить места работы',
			'workplaces.deleteTitle' => 'Удалить место работы',
			'workplaces.deleteConfirm' => ({required Object name}) => 'Удалить «${name}»?',
			'workplaces.cannotDelete' => 'Невозможно удалить место работы',
			'workplaces.workingHours' => 'Часы работы',
			'workplaces.setAsPrimary' => 'Сделать основным',
			'addWorkplace.addTitle' => 'Добавить место работы',
			'addWorkplace.editTitle' => 'Изменить место работы',
			'addWorkplace.name' => 'Название',
			'addWorkplace.address' => 'Улица, дом',
			'addWorkplace.city' => 'Город',
			'addWorkplace.type' => 'Тип',
			'addWorkplace.clinic' => 'Клиника',
			'addWorkplace.hospital' => 'Больница',
			'addWorkplace.privatePractice' => 'Частная практика',
			'addWorkplace.failedToSave' => 'Не удалось сохранить место работы.',
			'addWorkplace.addButton' => 'Добавить место работы',
			'addWorkplace.saveChanges' => 'Сохранить изменения',
			'addWorkplace.pickOnMap' => 'Выбрать на карте',
			'addWorkplace.mapPickerTitle' => 'Выберите местоположение',
			'addWorkplace.useMyLocation' => 'Использовать моё местоположение',
			'addWorkplace.confirmLocation' => 'Подтвердить местоположение',
			'addWorkplace.locationSet' => 'Местоположение задано с карты ✓',
			'addWorkplace.locationPermissionDenied' => 'Нужно разрешение на геолокацию, чтобы использовать текущее положение. Карту можно передвинуть вручную.',
			'addWorkplace.locationUnavailable' => 'Не удалось определить местоположение. Карту можно передвинуть вручную.',
			'workingHours.title' => 'Часы работы',
			'workingHours.sectionHint' => 'Укажите дни и часы, когда пациенты смогут записаться к вам по этому адресу.',
			'workingHours.invalidRange' => 'Для каждого активного дня время окончания должно быть позже времени начала.',
			'workingHours.saved' => 'Часы работы сохранены',
			'workingHours.failedToSave' => 'Не удалось сохранить часы работы',
			'workingHours.days.monday' => 'Понедельник',
			'workingHours.days.tuesday' => 'Вторник',
			'workingHours.days.wednesday' => 'Среда',
			'workingHours.days.thursday' => 'Четверг',
			'workingHours.days.friday' => 'Пятница',
			'workingHours.days.saturday' => 'Суббота',
			'workingHours.days.sunday' => 'Воскресенье',
			'blockTime.title' => 'Заблокировать время',
			'blockTime.dateRange' => 'Диапазон дат',
			'blockTime.tapToSelect' => 'Нажмите, чтобы выбрать даты',
			'blockTime.reason' => 'Причина (необязательно)',
			'blockTime.notifyPatients' => 'Уведомить затронутых пациентов',
			'blockTime.notifyDesc' => 'Отправить уведомления пациентам с приёмами в этот период',
			'blockTime.selectDateRange' => 'Пожалуйста, выберите диапазон дат.',
			'blockTime.failedToBlock' => 'Не удалось заблокировать время. Повторите попытку.',
			'blockTime.blockButton' => 'Заблокировать период',
			'onboarding.title' => 'Заполните профиль',
			'onboarding.professionalInfo' => 'Профессиональная информация',
			'onboarding.tellPatients' => 'Расскажите пациентам о своей практике.',
			'onboarding.specialization' => 'Специализация',
			'onboarding.selectSpecialization' => 'Выберите специализацию',
			'onboarding.couldNotLoadSpecs' => 'Не удалось загрузить специализации. Вернитесь и повторите.',
			'onboarding.licenseNumber' => 'Номер лицензии',
			'onboarding.licenseHint' => 'напр. AZ-123456',
			'onboarding.bio' => 'О себе (необязательно)',
			'onboarding.bioHint' => 'Краткое описание, которое пациенты увидят в вашем профиле.',
			'onboarding.appointmentLength' => 'Длительность приёма',
			'onboarding.slotQuestion' => 'Сколько длится один слот приёма?',
			'onboarding.changeLater' => 'Это можно изменить позже в профиле.',
			'onboarding.minutes' => ({required Object min}) => '${min} мин',
			'onboarding.verificationDoc' => 'Документ для подтверждения',
			'onboarding.uploadDiploma' => 'Загрузите медицинский диплом или лицензию. Администратор проверит его перед подтверждением вашего аккаунта.',
			'onboarding.tapToChoose' => 'Нажмите, чтобы выбрать файл',
			'onboarding.tapToReplace' => 'Нажмите, чтобы заменить',
			'onboarding.anyFileType' => 'Любой тип файла, до 10 МБ',
			'onboarding.selectSpecError' => 'Пожалуйста, выберите специализацию.',
			'onboarding.licenseError' => 'Пожалуйста, введите номер лицензии.',
			'onboarding.diplomaError' => 'Пожалуйста, прикрепите диплом.',
			'onboarding.checkDetails' => 'Проверьте данные и повторите попытку.',
			'onboarding.continueButton' => 'Продолжить',
			'onboarding.finish' => 'Завершить',
			'pendingVerification.title' => 'Ожидает подтверждения',
			'pendingVerification.message' => 'Ваш аккаунт на рассмотрении. Мы уведомим вас после подтверждения.',
			'pendingVerification.checkStatus' => 'Проверить статус',
			'pendingVerification.stillPending' => 'Всё ещё на рассмотрении. Мы уведомим вас, как только аккаунт будет подтверждён.',
			'phoneField.label' => 'Номер телефона',
			'phoneField.selectCountry' => 'Выберите страну',
			'phoneField.searchCountry' => 'Поиск страны или кода…',
			'phoneField.noCountriesFound' => 'Страны не найдены',
			'locations.pickCity' => 'Выберите город',
			'locations.searchHint' => 'Поиск города или региона…',
			'locations.noResultsFound' => 'Города не найдены',
			'locations.couldNotLoad' => 'Не удалось загрузить города. Нажмите, чтобы повторить.',
			'locations.allCities' => 'Все города',
			'splash.tagline' => 'Ваше здоровье — это просто',
			'appIntro.page1Title' => 'Найдите нужного врача',
			'appIntro.page1Subtitle' => 'Ищите по специальности, городу и рейтингу — и запишитесь на удобное время.',
			'appIntro.page2Title' => 'Спросите ИИ-помощника',
			'appIntro.page2Subtitle' => 'Опишите симптомы и узнайте, к какому врачу лучше обратиться — в любое время.',
			'appIntro.page3Title' => 'Всё в одном приложении',
			'appIntro.page3Subtitle' => 'Управляйте записями, следите за визитами и пользуйтесь приложением на своём языке — безопасно.',
			'appIntro.skip' => 'Пропустить',
			'appIntro.next' => 'Далее',
			'appIntro.getStarted' => 'Начать',
			'agenda.title' => 'Расписание',
			'agenda.today' => 'Сегодня',
			'agenda.empty' => 'Нет приёмов',
			'agenda.emptySubtitle' => 'На этот день ничего не запланировано',
			'favorites.title' => 'Избранное',
			'favorites.empty' => 'Пока нет избранного',
			'favorites.emptySubtitle' => 'Нажмите на сердечко у врача, чтобы сохранить его здесь',
			'favorites.add' => 'В избранное',
			'favorites.remove' => 'Убрать из избранного',
			'assistant.title' => 'ИИ-ассистент',
			'assistant.newChat' => 'Новый чат',
			'assistant.empty' => 'Пока нет разговоров',
			'assistant.emptySubtitle' => 'Опишите симптомы — ассистент подскажет, к какому врачу обратиться',
			'assistant.couldNotLoad' => 'Не удалось загрузить разговоры',
			'assistant.couldNotLoadChat' => 'Не удалось загрузить разговор',
			'assistant.newConversation' => 'Новый разговор',
			'assistant.deleteTitle' => 'Удалить разговор?',
			'assistant.deleteConfirm' => 'Разговор и все его сообщения будут удалены.',
			'assistant.inputHint' => 'Опишите ваши симптомы…',
			'assistant.send' => 'Отправить',
			'assistant.sendFailed' => 'Не удалось отправить сообщение. Попробуйте ещё раз.',
			'assistant.typing' => 'Ассистент печатает…',
			'assistant.startTitle' => 'Чем помочь?',
			'assistant.startSubtitle' => 'Для начала опишите, что вас беспокоит',
			'assistant.book' => 'Записаться',
			'assistant.reportTooltip' => 'Пожаловаться на ответ',
			'assistant.reportTitle' => 'Пожаловаться на ответ',
			'assistant.reportHint' => 'Причина (необязательно)',
			'assistant.reportSubmit' => 'Отправить',
			'assistant.reportSuccess' => 'Спасибо, жалоба отправлена.',
			'assistant.reportFailed' => 'Не удалось отправить жалобу. Попробуйте ещё раз.',
			'assistant.topicsTooltip' => 'Темы',
			'assistant.topicsSheetTitle' => 'Выберите тему',
			'messaging.title' => 'Сообщения',
			'messaging.sendMessage' => 'Написать',
			'messaging.typeMessage' => 'Введите сообщение…',
			'messaging.send' => 'Отправить',
			'messaging.empty' => 'Пока нет переписок',
			'messaging.emptySubtitle' => 'Здесь появятся ваши переписки.',
			'messaging.disclaimer' => 'Это не экстренная связь. В неотложных случаях звоните в скорую помощь.',
			'messaging.noSharedHistory' => 'Написать врачу можно после того, как у вас появится общая история записей на приём.',
			'messaging.newMessage' => 'У вас новое сообщение',
			'legal.title' => 'Конфиденциальность и условия',
			'legal.controllerNotice' => 'DocGet создан и управляется компанией AuxioDev (auxiodev.com), Азербайджан («мы»). Последнее обновление: июль 2026.',
			'legal.privacyTitle' => 'Политика конфиденциальности',
			'legal.privacyIntro' => 'Здесь объясняется, какие персональные данные собирает DocGet, зачем и как они защищены. Запись и ведение медицинских приёмов неизбежно связаны с данными о здоровье — ниже это подробно раскрыто.',
			'legal.sections.identity.title' => 'Данные для идентификации',
			'legal.sections.identity.body' => 'Имя и фамилия, email, номер телефона (необязательно), пароль (хранится в виде необратимого хэша, никогда в открытом виде), предпочитаемый язык приложения.',
			'legal.sections.health.title' => 'Данные о здоровье',
			'legal.sections.health.body' => 'Для пациентов: группа крови, аллергии, хронические заболевания, принимаемые лекарства, причина обращения при бронировании, загруженные медицинские документы (анализы, снимки, прочие записи), выписанные вам рецепты, содержание переписки с врачом. При использовании ИИ-ассистента для проверки симптомов таким же образом обрабатываются ваши вопросы и его ответы. Данные о здоровье получают наивысший уровень защиты по законодательству Азербайджана — мы собираем их только при вашем отдельном явном согласии (см. «Правовое основание» ниже).',
			'legal.sections.professional.title' => 'Профессиональные данные (врачи)',
			'legal.sections.professional.body' => 'Специализация, номер лицензии, диплом или иной подтверждающий документ, данные о месте работы, стоимость консультации. Эти данные проверяются нашей командой до того, как профиль станет виден пациентам.',
			'legal.sections.location.title' => 'Геолокация',
			'legal.sections.location.body' => 'С вашего разрешения — приблизительное или точное местоположение, чтобы сортировать врачей по расстоянию до вас. Используется только пока приложение открыто и никогда не сохраняется на наших серверах.',
			'legal.sections.device.title' => 'Данные устройства',
			'legal.sections.device.body' => 'Идентификаторы устройства и данные сессии — чтобы вы могли видеть и отзывать активные входы в разделе «Настройки», а также токен push-уведомлений для доставки напоминаний о приёмах и сообщений.',
			'legal.sections.payment.title' => 'Платёжные данные',
			'legal.sections.payment.body' => 'Если вы оплачиваете консультацию в приложении, оплата полностью обрабатывается нашим платёжным партнёром Payriff — мы никогда не видим и не храним номер вашей карты. Мы сохраняем сумму платежа, статус и идентификатор для истории ваших записей.',
			'legal.sections.family.title' => 'Профили членов семьи',
			'legal.sections.family.body' => 'Если вы управляете профилем члена семьи (ребёнка или иждивенца без собственного входа в аккаунт), те же категории данных о здоровье выше могут фиксироваться для него в рамках вашего аккаунта. Добавляя члена семьи, вы подтверждаете, что являетесь его родителем, опекуном или иным образом уполномочены управлять его медицинскими данными.',
			'legal.sections.purposes.title' => 'Зачем нам ваши данные',
			'legal.sections.purposes.body' => 'Чтобы вы могли находить врачей и записываться к ним на приём; чтобы врачи могли управлять расписанием и пациентами; для отправки напоминаний о приёмах и обновлений; для обработки платежей за консультации; для работы опциональной функции ИИ-проверки симптомов; для обеспечения безопасности вашего аккаунта.',
			'legal.sections.legalBasis.title' => 'Правовое основание и ваше согласие',
			'legal.sections.legalBasis.body' => 'Мы обрабатываем ваши данные на основании согласия, данного при регистрации. Данные о здоровье относятся к специальной категории персональных данных по Закону Азербайджанской Республики «О персональных данных» (№998-IIIQ), который требует явного письменного согласия до их сбора — именно это фиксирует чекбокс на экране регистрации. Вы можете отозвать согласие в любой момент, удалив аккаунт, хотя мы можем сохранить ограниченные записи, если это требуется законом (например, финансовые записи для налоговой отчётности).',
			'legal.sections.thirdParties.title' => 'Кто ещё обрабатывает ваши данные',
			'legal.sections.thirdParties.body' => 'Доверенные поставщики услуг, действующие только по нашему поручению и исключительно для описанных здесь целей: Cloudinary (безопасное хранение файлов — документы и фото никогда не доступны публично, только по подписанным ссылкам с ограниченным сроком действия); Firebase/Google (push-уведомления и вход через Google, если вы его выберете); Apple (вход через Apple, если вы его выберете); Payriff (платежи в приложении). Мы не продаём ваши персональные данные.',
			'legal.sections.retention.title' => 'Сколько мы храним данные',
			'legal.sections.retention.body' => 'Пока ваш аккаунт активен. При удалении аккаунта мы удаляем ваши персональные данные в разумный срок, за исключением записей, которые обязаны хранить по закону (например, платёжные записи для налогового учёта).',
			_ => null,
		} ?? switch (path) {
			'legal.sections.rights.title' => 'Ваши права',
			'legal.sections.rights.body' => 'Вы можете запросить доступ к данным, которые мы о вас храним, потребовать исправления неточных данных, потребовать удаления аккаунта и данных, а также отозвать согласие в любой момент. Большая часть этого доступна прямо в разделе «Профиль» → «Настройки»; по остальным вопросам — свяжитесь с нами ниже.',
			'legal.sections.security.title' => 'Как мы защищаем ваши данные',
			'legal.sections.security.body' => 'Переписка с врачом и разговоры с ИИ-ассистентом шифруются. Загруженные документы и фото хранятся приватно и доступны только по защищённым подписанным ссылкам, никогда как публичные файлы. Пароли никогда не хранятся в читаемом виде.',
			'legal.sections.permissions.title' => 'Какие разрешения мы запрашиваем',
			'legal.sections.permissions.body' => 'Камера и фотогалерея — чтобы установить фото профиля и загрузить медицинские документы. Геолокация — чтобы сортировать врачей по расстоянию до вас. Уведомления — чтобы доставлять напоминания о приёмах и сообщения. Биометрия (Face ID / отпечаток пальца) — необязательный, более быстрый способ разблокировки приложения; ваши биометрические данные никогда не покидают устройство, мы получаем только подтверждение «да/нет» от его операционной системы.',
			'legal.sections.children.title' => 'Возрастное ограничение',
			'legal.sections.children.body' => 'Аккаунты DocGet предназначены для совершеннолетних. Если вам меньше 18 лет, попросите родителя или опекуна создать и вести аккаунт от вашего имени через функцию профилей членов семьи.',
			'legal.termsTitle' => 'Условия использования',
			'legal.termsIntro' => 'Создавая аккаунт, вы соглашаетесь со следующим.',
			'legal.termsBody' => 'Указывать о себе достоверную информацию. Использовать DocGet только для поиска, бронирования и ведения медицинских приёмов. Не разглашать данные для входа в аккаунт. DocGet соединяет вас с независимыми лицензированными медицинскими специалистами — мы сами не являемся медицинской организацией, а ИИ-ассистент для проверки симптомов не заменяет профессиональную медицинскую диагностику или консультацию. При неотложном состоянии обращайтесь напрямую в службу экстренной помощи, а не в это приложение. Мы можем приостановить или удалить аккаунт при нарушении этих условий или злоупотреблении сервисом.',
			'legal.contact' => 'Вопросы о ваших данных? Напишите на support@auxiodev.com',
			'legal.consentPrefix' => 'Я прочитал(а) и согласен(на) с ',
			'legal.consentPrivacyLink' => 'Политикой конфиденциальности',
			'legal.consentMiddle' => ' и ',
			'legal.consentTermsLink' => 'Условиями использования',
			'legal.consentSuffix' => ', а также прямо даю согласие на обработку данных о моём здоровье, как описано в них.',
			'legal.viewAsPdf' => 'Открыть как PDF',
			'legal.pdfDocumentTitle' => 'DocGet — Политика конфиденциальности и условия использования',
			'legal.pdfLoadError' => 'Не удалось загрузить документ. Проверьте подключение к интернету и попробуйте снова.',
			'medications.title' => 'Лекарства',
			'medications.editMedication' => 'Изменить лекарство',
			'medications.name' => 'Название',
			'medications.dosage' => 'Дозировка',
			'medications.notes' => 'Заметки',
			'medications.form' => 'Форма выпуска',
			'medications.formPill' => 'Таблетка',
			'medications.formCapsule' => 'Капсула',
			'medications.formLiquid' => 'Жидкость',
			'medications.formInjection' => 'Инъекция',
			'medications.formOther' => 'Другое',
			'medications.schedule' => 'Расписание',
			'medications.times' => 'Время приёма',
			'medications.addTime' => 'Добавить время',
			'medications.daysOfWeek' => 'Дни недели',
			'medications.everyDay' => 'Каждый день',
			'medications.startDate' => 'Дата начала',
			'medications.endDate' => 'Дата окончания',
			'medications.save' => 'Сохранить',
			'medications.delete' => 'Удалить',
			'medications.deleteConfirmTitle' => 'Удалить лекарство',
			'medications.deleteConfirmBody' => 'Удалить это лекарство? История приёма сохранится.',
			'medications.emptyTitle' => 'Пока нет лекарств',
			'medications.emptySubtitle' => 'Лекарства, назначенные врачом, появятся здесь после приёма.',
			'medications.todaysDoses' => 'Приёмы сегодня',
			'medications.markTaken' => 'Принято',
			'medications.markSkipped' => 'Пропустить',
			'medications.statusTaken' => 'Принято',
			'medications.statusSkipped' => 'Пропущено',
			'medications.statusPending' => 'Ожидает',
			'medications.reminderTitle' => ({required Object name}) => 'Пора принять ${name}',
			'medications.reminderBody' => ({required Object dosage}) => 'Доза: ${dosage}',
			'medications.tabActive' => 'Активные',
			'medications.tabArchive' => 'Архив',
			'medications.fromPrescription' => 'По рецепту',
			'medications.noSchedule' => 'Расписание не задано — нажмите, чтобы добавить время приёма',
			'medications.dayMon' => 'Пн',
			'medications.dayTue' => 'Вт',
			'medications.dayWed' => 'Ср',
			'medications.dayThu' => 'Чт',
			'medications.dayFri' => 'Пт',
			'medications.daySat' => 'Сб',
			'medications.daySun' => 'Вс',
			'medications.updatedSuccess' => 'Лекарство обновлено.',
			'medications.deletedSuccess' => 'Лекарство удалено.',
			'medications.atLeastOneTime' => 'Добавьте хотя бы одно время приёма',
			'prescriptions.title' => 'Рецепты',
			'prescriptions.writeTitle' => 'Выписать рецепт',
			'prescriptions.addDrug' => 'Добавить препарат',
			'prescriptions.drugName' => 'Название препарата',
			'prescriptions.dosage' => 'Дозировка',
			'prescriptions.frequency' => 'Частота приёма',
			'prescriptions.duration' => 'Длительность',
			'prescriptions.instructions' => 'Инструкции',
			'prescriptions.notes' => 'Заметки',
			'prescriptions.save' => 'Сохранить',
			'prescriptions.empty' => 'Пока нет рецептов',
			'prescriptions.emptySubtitle' => 'Здесь появятся рецепты, выписанные вашим врачом.',
			'prescriptions.viewDetails' => 'Подробнее',
			'prescriptions.issuedBy' => ({required Object name}) => 'Выписал(а) д-р ${name}',
			'prescriptions.issuedOn' => ({required Object date}) => 'Дата выдачи: ${date}',
			'prescriptions.applyToMedications' => 'Добавить в мои лекарства',
			'prescriptions.applySuccess' => 'Добавлено в ваши лекарства. Настройте время приёма, чтобы получать напоминания.',
			'prescriptions.alreadyApplied' => 'Уже добавлено в ваши лекарства',
			'prescriptions.noPrescriptionYet' => 'Рецепт для этой записи ещё не выписан',
			'prescriptions.writePrescription' => 'Выписать рецепт',
			'prescriptions.prescriptionIssued' => 'Рецепт выписан.',
			'prescriptions.removeDrug' => 'Удалить',
			'prescriptions.atLeastOneDrug' => 'Добавьте хотя бы один препарат',
			'prescriptions.drugNameRequired' => 'Укажите название препарата',
			'prescriptions.summaryTitle' => 'Рецепт',
			'prescriptions.itemsCount' => ({required Object count}) => 'Лекарств: ${count}',
			'prescriptions.newPrescription' => 'Новый рецепт',
			'prescriptions.youHavePrescription' => 'Для этой записи есть рецепт',
			'records.title' => 'Медицинские документы',
			'records.upload' => 'Загрузить документ',
			'records.recordType' => 'Тип документа',
			'records.typeLabResult' => 'Анализ',
			'records.typeImaging' => 'Снимок',
			'records.typeDocument' => 'Документ',
			'records.typeOther' => 'Другое',
			'records.recordTitle' => 'Название',
			'records.recordDate' => 'Дата',
			'records.notes' => 'Заметки',
			'records.chooseFile' => 'Выбрать файл',
			'records.changeFile' => 'Изменить файл',
			'records.noFileChosen' => 'Файл не выбран',
			'records.save' => 'Сохранить',
			'records.delete' => 'Удалить',
			'records.deleteConfirmTitle' => 'Удалить документ',
			'records.deleteConfirmBody' => 'Удалить этот документ? Это действие необратимо.',
			'records.empty' => 'Пока нет документов',
			'records.emptySubtitle' => 'Загружайте результаты анализов, снимки и другие документы в одном месте.',
			'records.view' => 'Открыть',
			'records.fileRequired' => 'Выберите файл для загрузки',
			'records.fileTooLarge' => 'Файл слишком большой (макс. 15 МБ)',
			'records.titleRequired' => 'Укажите название',
			'records.uploadSuccess' => 'Документ загружен.',
			'records.deletedSuccess' => 'Документ удалён.',
			'records.couldNotOpen' => 'Не удалось открыть файл',
			'payments.title' => 'Оплата',
			'payments.amount' => 'Сумма',
			'payments.payNow' => 'Оплатить сейчас',
			'payments.payLater' => 'Оплатить позже',
			'payments.statusPending' => 'Ожидает оплаты',
			'payments.statusPaid' => 'Оплачено',
			'payments.statusFailed' => 'Оплата не прошла',
			'payments.statusCancelled' => 'Отменено',
			'payments.statusRefunded' => 'Возвращено',
			'payments.statusRefundFailed' => 'Возврат не удался',
			'payments.paymentConfirmed' => 'Оплата подтверждена. Спасибо!',
			'payments.openingBrowser' => 'Открываем браузер…',
			'payments.checkStatus' => 'Проверить статус',
			'family.title' => 'Семья',
			'family.myself' => 'Я сам(а)',
			'family.addFamilyMember' => 'Добавить члена семьи',
			'family.editFamilyMember' => 'Изменить члена семьи',
			'family.firstName' => 'Имя',
			'family.lastName' => 'Фамилия',
			'family.relationship' => 'Кем приходится',
			'family.relationshipChild' => 'Ребёнок',
			'family.relationshipSpouse' => 'Супруг(а)',
			'family.relationshipParent' => 'Родитель',
			'family.relationshipSibling' => 'Брат/сестра',
			'family.relationshipOther' => 'Другое',
			'family.dateOfBirth' => 'Дата рождения',
			'family.bloodType' => 'Группа крови',
			'family.allergies' => 'Аллергии',
			'family.chronicConditions' => 'Хронические заболевания',
			'family.medications' => 'Принимаемые препараты',
			'family.save' => 'Сохранить',
			'family.delete' => 'Удалить',
			'family.deleteConfirmTitle' => 'Удалить члена семьи',
			'family.deleteConfirmBody' => 'Удалить этого члена семьи? История записей, лекарств и документов сохранится.',
			'family.empty' => 'Пока нет членов семьи',
			'family.emptySubtitle' => 'Добавьте ребёнка, супруга или другого родственника, чтобы управлять их записями, лекарствами и документами.',
			'family.bookingForQuestion' => 'Для кого эта запись на приём?',
			'family.bookingForLabel' => ({required Object name}) => 'Запись для: ${name}',
			'family.forLabel' => ({required Object name}) => 'для ${name}',
			'family.ageYears' => ({required Object age}) => '${age} лет',
			'family.bookedByLabel' => ({required Object name}) => 'Записал(а) ${name}',
			'family.contactPhone' => 'Контактный телефон',
			'family.contactPhoneHelp' => 'Мы отправим им SMS о том, что их добавили, и дадим простой способ отказаться.',
			'family.contactEmailOptional' => 'Контактный email (необязательно)',
			'family.contactPhoneRequiredForAdult' => 'Телефон обязателен, чтобы мы могли уведомить этого члена семьи',
			'family.adultConsentNotice' => 'Поскольку им исполнилось 18 лет, мы отправим им SMS о том, что вы их добавили — приложение им не понадобится, и они смогут отключить эту связь в любой момент.',
			'family.noticeAlreadySent' => 'Мы сообщили им, что их добавили. Они могут отключить эту связь в любой момент.',
			'family.noticePendingBadge' => 'Уведомление отправлено',
			'subscription.title' => 'Подписка',
			'subscription.planNameBasic' => 'Стартовый',
			'subscription.planNamePro' => 'Профессиональный',
			'subscription.couldNotLoad' => 'Не удалось загрузить данные подписки.',
			'subscription.nowActive' => 'Ваша подписка активирована!',
			'subscription.unavailable' => 'Подписки временно недоступны. Попробуйте позже.',
			'subscription.trialDaysLeft' => ({required Object days}) => 'Пробный период — осталось ${days} дн.',
			'subscription.graceDaysLeft' => ({required Object days}) => 'Льготный период — осталось ${days} дн. для продления',
			'subscription.expiredNotice' => 'Срок действия вашей подписки истёк. Оформите подписку, чтобы снова быть видимым для пациентов.',
			'subscription.activeNotice' => 'Ваша подписка активна.',
			'subscription.choosePlan' => 'Выберите тариф, чтобы начать.',
			'subscription.currentPlan' => 'Текущий тариф',
			'subscription.mostPopular' => 'Популярный выбор',
			'subscription.perMonth' => 'в месяц',
			'subscription.manageOnWeb' => 'Управляйте подпиской на auxiodev.com',
			'subscription.featureUnlimitedWorkplaces' => 'Неограниченное количество клиник',
			'subscription.featureWorkplaces' => ({required Object count}) => 'До ${count} клиник(и)',
			'subscription.featureUnlimitedBookings' => 'Неограниченное количество записей в месяц',
			'subscription.featureBookingsPerMonth' => ({required Object count}) => 'До ${count} записей в месяц',
			'subscription.featureChat' => 'Чат с пациентами',
			'subscription.featurePromoted' => 'Приоритет в поиске + бейдж «Peşəkar»',
			'subscription.renew' => 'Продлить',
			'subscription.subscribe' => 'Оформить подписку',
			'subscription.planNameHospitalBasic' => 'Клиника',
			'subscription.planNameHospitalPro' => 'Клиника Плюс',
			'subscription.featureDoctors' => ({required Object count}) => 'До ${count} врачей',
			'subscription.featureUnlimitedDoctors' => 'Неограниченное количество врачей',
			'subscription.featureAdvancedStats' => 'Расширенная статистика',
			'hospitalPicker.title' => 'Выбор больницы',
			'hospitalPicker.searchHint' => 'Поиск по названию…',
			'hospitalPicker.noResultsFound' => 'Больницы не найдены',
			'hospitalPicker.selectCityFirst' => 'Сначала выберите город',
			'hospitalPicker.addVariant' => ({required Object name}) => 'Добавить «${name}»',
			'hospitalPicker.pendingReview' => 'На проверке',
			'hospitalRegistration.title' => 'Данные больницы',
			'hospitalRegistration.subtitle' => 'Выберите город, затем найдите свою больницу в списке или добавьте её.',
			'hospitalRegistration.cityStep' => '1. Город',
			'hospitalRegistration.hospitalStep' => '2. Больница',
			'hospitalRegistration.searchHint' => 'Поиск по названию…',
			'hospitalRegistration.noResultsFound' => 'Больницы не найдены',
			'hospitalRegistration.notFoundPrompt' => 'Не нашли свою больницу?',
			'hospitalRegistration.addManually' => 'Добавить вручную',
			'hospitalRegistration.useSearchInstead' => 'Искать снова',
			'hospitalRegistration.newHospitalName' => 'Название больницы',
			'hospitalRegistration.selectedPrefix' => 'Выбрано:',
			'hospitalRegistration.pendingReviewNotice' => 'Новые больницы проверяются нашей командой, прежде чем появиться у других пользователей.',
			'hospitalRegistration.submit' => 'Создать аккаунт',
			'hospitalRegistration.hospitalRequired' => 'Выберите или добавьте больницу, чтобы продолжить',
			'hospitalHome.greeting' => ({required Object name}) => 'Здравствуйте, ${name}',
			'hospitalHome.subtitle' => 'Управляйте врачами и записями',
			'hospitalHome.doctors' => 'Врачи',
			'hospitalHome.inviteDoctor' => 'Пригласить врача',
			'hospitalHome.appointments' => 'Записи',
			'hospitalHome.profile' => 'Профиль',
			'hospitalHome.pendingRequests' => ({required Object count}) => '${count} заявок ожидают решения',
			'hospitalDoctors.title' => 'Врачи',
			'hospitalDoctors.tabConfirmed' => 'Подтверждённые',
			'hospitalDoctors.tabRequests' => 'Заявки',
			'hospitalDoctors.tabInvited' => 'Приглашённые',
			'hospitalDoctors.noConfirmedDoctors' => 'Пока нет подтверждённых врачей',
			'hospitalDoctors.noRequests' => 'Нет ожидающих заявок',
			'hospitalDoctors.noInvited' => 'Нет ожидающих приглашений',
			'hospitalDoctors.approve' => 'Подтвердить',
			'hospitalDoctors.reject' => 'Отклонить',
			'hospitalDoctors.remove' => 'Удалить',
			'hospitalDoctors.removeConfirmTitle' => 'Удалить врача?',
			'hospitalDoctors.removeConfirmMessage' => ({required Object name}) => '${name} больше не будет связан с вашей больницей. Это не повлияет на его место работы и записи.',
			'hospitalDoctors.requestedToJoin' => 'Запросил присоединение',
			'hospitalDoctors.invitedAwaiting' => 'Приглашён — ожидает ответа',
			'hospitalDoctors.editHours' => 'Изменить часы',
			'hospitalInvite.title' => 'Пригласить врача',
			'hospitalInvite.searchHint' => 'Поиск по имени или специализации…',
			'hospitalInvite.noResultsFound' => 'Врачи не найдены',
			'hospitalInvite.invite' => 'Пригласить',
			'hospitalInvite.invited' => 'Приглашён',
			'hospitalAppointments.title' => 'Записи',
			'hospitalAppointments.empty' => 'Пока нет записей',
			'hospitalProfile.title' => 'Профиль больницы',
			'hospitalProfile.usageDoctors' => ({required Object count, required Object limit}) => '${count} из ${limit} врачей',
			'hospitalProfile.usageDoctorsUnlimited' => ({required Object count}) => '${count} врачей (без ограничений)',
			'hospitalProfile.manageSubscription' => 'Управление подпиской',
			'hospitalDoctorHours.title' => 'Часы работы',
			'hospitalDoctorHours.selectWorkplace' => 'Выберите место работы',
			'hospitalDoctorHours.saved' => 'Часы сохранены',
			'doctorHospitals.title' => 'Мои больницы',
			'doctorHospitals.tabInvitations' => 'Приглашения',
			'doctorHospitals.tabRequests' => 'Заявки',
			'doctorHospitals.tabConfirmed' => 'Больницы',
			'doctorHospitals.noInvitations' => 'Нет ожидающих приглашений',
			'doctorHospitals.noRequests' => 'Нет ожидающих заявок',
			'doctorHospitals.noConfirmed' => 'Вы пока не связаны ни с одной больницей',
			'doctorHospitals.accept' => 'Принять',
			'doctorHospitals.decline' => 'Отклонить',
			'doctorHospitals.cancelRequest' => 'Отменить заявку',
			'doctorHospitals.invitedYouToJoin' => 'Пригласила вас присоединиться',
			'doctorHospitals.awaitingApproval' => 'Ожидает подтверждения больницы',
			'share.title' => 'Поделиться профилем',
			'share.shareLink' => 'Поделиться ссылкой',
			'share.copyLink' => 'Скопировать ссылку',
			'share.linkCopied' => 'Ссылка скопирована',
			'hospitalDetail.title' => 'Больница',
			'hospitalDetail.couldNotLoad' => 'Не удалось загрузить профиль',
			'hospitalDetail.location' => 'Адрес',
			'hospitalDetail.doctorsHeading' => 'Врачи в клинике',
			_ => null,
		};
	}
}
