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
	@override String get appName => 'Medalize';
	@override late final _Translations$common$ru common = _Translations$common$ru._(_root);
	@override late final _Translations$auth$ru auth = _Translations$auth$ru._(_root);
	@override late final _Translations$forgotPassword$ru forgotPassword = _Translations$forgotPassword$ru._(_root);
	@override late final _Translations$resetPassword$ru resetPassword = _Translations$resetPassword$ru._(_root);
	@override late final _Translations$validation$ru validation = _Translations$validation$ru._(_root);
	@override late final _Translations$errors$ru errors = _Translations$errors$ru._(_root);
	@override late final _Translations$settings$ru settings = _Translations$settings$ru._(_root);
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
	@override late final _Translations$splash$ru splash = _Translations$splash$ru._(_root);
	@override late final _Translations$agenda$ru agenda = _Translations$agenda$ru._(_root);
	@override late final _Translations$favorites$ru favorites = _Translations$favorites$ru._(_root);
	@override late final _Translations$legal$ru legal = _Translations$legal$ru._(_root);
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
	@override String get email => 'Эл. почта';
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
	@override String get joinMedalize => 'Присоединяйтесь к Medalize';
	@override String get iAmA => 'Я —';
	@override String get emailHint => 'you@example.com';
	@override String get passwordHint => '••••••••';
	@override String get backToSignIn => 'Назад ко входу';
	@override String get verificationCode => 'Код подтверждения';
}

// Path: forgotPassword
class _Translations$forgotPassword$ru extends Translations$forgotPassword$en {
	_Translations$forgotPassword$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Забыли пароль?';
	@override String get subtitle => 'Введите эл. почту, и мы отправим 6-значный код для сброса';
}

// Path: resetPassword
class _Translations$resetPassword$ru extends Translations$resetPassword$en {
	_Translations$resetPassword$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Сброс пароля';
	@override String get subtitle => 'Введите код из письма и выберите новый пароль';
	@override String get button => 'Сбросить пароль';
	@override String get success => 'Пароль успешно сброшен. Войдите в аккаунт.';
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
	@override String get invalidCredentials => 'Неверная эл. почта или пароль';
	@override String get sessionExpired => 'Сессия истекла. Пожалуйста, войдите снова.';
	@override String get authError => 'Ошибка аутентификации. Пожалуйста, войдите снова.';
	@override String get sessionRevoked => 'Сессия отозвана. Пожалуйста, войдите снова.';
	@override String get permissionDenied => 'У вас нет прав для этого действия.';
	@override String get validationError => 'Ошибка проверки';
	@override String serverError({required Object code}) => 'Ошибка сервера (${code}). Повторите попытку.';
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
	@override String get version => 'Medalize v1.0.0';
	@override String get legal => 'Конфиденциальность и условия';
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
	@override String get myWaitlist => 'Мой лист ожидания';
	@override String get leaveWaitlist => 'Выйти';
	@override String get statsThisMonth => 'Этот месяц';
	@override String get statsPatients => 'Пациенты';
	@override String get statsAcceptRate => '% принятых';
	@override String get statsPending => 'Ожидают';
	@override String get schedule => 'Расписание';
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
	@override String get requestReschedule => 'Запросить перенос';
	@override String get requestRescheduleTitle => 'Запрос переноса';
	@override String get requestRescheduleConfirm => 'Попросить пациента выбрать новое время? Запись будет помечена как требующая переноса.';
	@override String get requestRescheduleSuccess => 'Перенос запрошен. Пациент получит уведомление.';
	@override String get rescheduleNeededHint => 'Врач попросил вас выбрать новое время.';
	@override String get markNoShow => 'Отметить неявку';
	@override String get markNoShowTitle => 'Отметить как неявку';
	@override String get markNoShowConfirm => 'Отметить этот приём как неявку? Будет зафиксировано, что пациент не пришёл.';
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
	@override String get confirmTitle => 'Подтвердить запись';
	@override String get reasonForVisit => 'Причина визита (необязательно)';
	@override String get confirmButton => 'Подтвердить запись';
	@override String get doctorLabel => 'Врач';
	@override String get workplaceLabel => 'Место работы';
	@override String get addressLabel => 'Адрес';
	@override String get startLabel => 'Начало';
	@override String get endLabel => 'Конец';
	@override String get tryDifferentDate => 'Попробуйте другую дату';
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
	@override String get address => 'Адрес';
	@override String get city => 'Город';
	@override String get type => 'Тип';
	@override String get clinic => 'Клиника';
	@override String get hospital => 'Больница';
	@override String get privatePractice => 'Частная практика';
	@override String get failedToSave => 'Не удалось сохранить место работы.';
	@override String get addButton => 'Добавить место работы';
	@override String get saveChanges => 'Сохранить изменения';
}

// Path: workingHours
class _Translations$workingHours$ru extends Translations$workingHours$en {
	_Translations$workingHours$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Часы работы';
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
	@override String get labelOptional => 'Номер телефона (необязательно)';
	@override String get selectCountry => 'Выберите страну';
	@override String get searchCountry => 'Поиск страны или кода…';
	@override String get noCountriesFound => 'Страны не найдены';
}

// Path: splash
class _Translations$splash$ru extends Translations$splash$en {
	_Translations$splash$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Ваше здоровье — это просто';
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

// Path: legal
class _Translations$legal$ru extends Translations$legal$en {
	_Translations$legal$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Конфиденциальность и условия';
	@override String get privacyTitle => 'Политика конфиденциальности';
	@override String get privacyBody => 'Medalize обрабатывает ваши персональные и медицинские данные, чтобы вы могли записываться на приёмы и управлять ими. Мы не продаём ваши данные. Полная политика конфиденциальности будет опубликована здесь до публичного запуска.';
	@override String get termsTitle => 'Условия использования';
	@override String get termsBody => 'Используя Medalize, вы соглашаетесь ответственно пользоваться сервисом для записи и управления приёмами. Полные условия использования будут опубликованы здесь до публичного запуска.';
	@override String get draftNotice => 'Черновик — ожидается финальная юридическая проверка.';
	@override String get contact => 'Вопросы о ваших данных? Напишите на support@medalize.app';
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

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'Medalize',
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
			'auth.login' => 'Войти',
			'auth.register' => 'Создать аккаунт',
			'auth.signIn' => 'Войти',
			'auth.signUp' => 'Зарегистрироваться',
			'auth.email' => 'Эл. почта',
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
			'auth.joinMedalize' => 'Присоединяйтесь к Medalize',
			'auth.iAmA' => 'Я —',
			'auth.emailHint' => 'you@example.com',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => 'Назад ко входу',
			'auth.verificationCode' => 'Код подтверждения',
			'forgotPassword.title' => 'Забыли пароль?',
			'forgotPassword.subtitle' => 'Введите эл. почту, и мы отправим 6-значный код для сброса',
			'resetPassword.title' => 'Сброс пароля',
			'resetPassword.subtitle' => 'Введите код из письма и выберите новый пароль',
			'resetPassword.button' => 'Сбросить пароль',
			'resetPassword.success' => 'Пароль успешно сброшен. Войдите в аккаунт.',
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
			'errors.invalidCredentials' => 'Неверная эл. почта или пароль',
			'errors.sessionExpired' => 'Сессия истекла. Пожалуйста, войдите снова.',
			'errors.authError' => 'Ошибка аутентификации. Пожалуйста, войдите снова.',
			'errors.sessionRevoked' => 'Сессия отозвана. Пожалуйста, войдите снова.',
			'errors.permissionDenied' => 'У вас нет прав для этого действия.',
			'errors.validationError' => 'Ошибка проверки',
			'errors.serverError' => ({required Object code}) => 'Ошибка сервера (${code}). Повторите попытку.',
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
			'settings.version' => 'Medalize v1.0.0',
			'settings.legal' => 'Конфиденциальность и условия',
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
			'home.myWaitlist' => 'Мой лист ожидания',
			'home.leaveWaitlist' => 'Выйти',
			'home.statsThisMonth' => 'Этот месяц',
			'home.statsPatients' => 'Пациенты',
			'home.statsAcceptRate' => '% принятых',
			'home.statsPending' => 'Ожидают',
			'home.schedule' => 'Расписание',
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
			'appointments.requestReschedule' => 'Запросить перенос',
			'appointments.requestRescheduleTitle' => 'Запрос переноса',
			'appointments.requestRescheduleConfirm' => 'Попросить пациента выбрать новое время? Запись будет помечена как требующая переноса.',
			'appointments.requestRescheduleSuccess' => 'Перенос запрошен. Пациент получит уведомление.',
			'appointments.rescheduleNeededHint' => 'Врач попросил вас выбрать новое время.',
			'appointments.markNoShow' => 'Отметить неявку',
			'appointments.markNoShowTitle' => 'Отметить как неявку',
			'appointments.markNoShowConfirm' => 'Отметить этот приём как неявку? Будет зафиксировано, что пациент не пришёл.',
			'booking.bookWith' => ({required Object name}) => 'Запись — ${name}',
			'booking.selectWorkplace' => 'Выберите место работы',
			'booking.pickDate' => 'Выберите дату',
			'booking.slotsAppear' => 'Доступные слоты появятся здесь',
			'booking.couldNotLoadSlots' => 'Не удалось загрузить слоты',
			'booking.noAvailableSlots' => 'Нет доступных слотов',
			'booking.noOpenSlots' => 'На эту дату нет свободных слотов. Попробуйте другой день.',
			'booking.confirmTitle' => 'Подтвердить запись',
			'booking.reasonForVisit' => 'Причина визита (необязательно)',
			'booking.confirmButton' => 'Подтвердить запись',
			'booking.doctorLabel' => 'Врач',
			'booking.workplaceLabel' => 'Место работы',
			'booking.addressLabel' => 'Адрес',
			'booking.startLabel' => 'Начало',
			'booking.endLabel' => 'Конец',
			'booking.tryDifferentDate' => 'Попробуйте другую дату',
			'doctorSearch.title' => 'Найти врача',
			'doctorSearch.searchByName' => 'Поиск по имени...',
			'doctorSearch.city' => 'Город',
			'doctorSearch.search' => 'Поиск',
			'doctorSearch.noDoctorsFound' => 'Врачи не найдены',
			'doctorSearch.adjustSearch' => 'Попробуйте изменить поиск или фильтры',
			'doctorSearch.couldNotLoadDoctors' => 'Не удалось загрузить врачей',
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
			'addWorkplace.address' => 'Адрес',
			'addWorkplace.city' => 'Город',
			'addWorkplace.type' => 'Тип',
			'addWorkplace.clinic' => 'Клиника',
			'addWorkplace.hospital' => 'Больница',
			'addWorkplace.privatePractice' => 'Частная практика',
			'addWorkplace.failedToSave' => 'Не удалось сохранить место работы.',
			'addWorkplace.addButton' => 'Добавить место работы',
			'addWorkplace.saveChanges' => 'Сохранить изменения',
			'workingHours.title' => 'Часы работы',
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
			'phoneField.labelOptional' => 'Номер телефона (необязательно)',
			'phoneField.selectCountry' => 'Выберите страну',
			'phoneField.searchCountry' => 'Поиск страны или кода…',
			'phoneField.noCountriesFound' => 'Страны не найдены',
			'splash.tagline' => 'Ваше здоровье — это просто',
			'agenda.title' => 'Расписание',
			'agenda.today' => 'Сегодня',
			'agenda.empty' => 'Нет приёмов',
			'agenda.emptySubtitle' => 'На этот день ничего не запланировано',
			'favorites.title' => 'Избранное',
			'favorites.empty' => 'Пока нет избранного',
			'favorites.emptySubtitle' => 'Нажмите на сердечко у врача, чтобы сохранить его здесь',
			'favorites.add' => 'В избранное',
			'favorites.remove' => 'Убрать из избранного',
			'legal.title' => 'Конфиденциальность и условия',
			'legal.privacyTitle' => 'Политика конфиденциальности',
			'legal.privacyBody' => 'Medalize обрабатывает ваши персональные и медицинские данные, чтобы вы могли записываться на приёмы и управлять ими. Мы не продаём ваши данные. Полная политика конфиденциальности будет опубликована здесь до публичного запуска.',
			'legal.termsTitle' => 'Условия использования',
			'legal.termsBody' => 'Используя Medalize, вы соглашаетесь ответственно пользоваться сервисом для записи и управления приёмами. Полные условия использования будут опубликованы здесь до публичного запуска.',
			'legal.draftNotice' => 'Черновик — ожидается финальная юридическая проверка.',
			'legal.contact' => 'Вопросы о ваших данных? Напишите на support@medalize.app',
			_ => null,
		};
	}
}
