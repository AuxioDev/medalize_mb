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
class TranslationsZh extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsZh _root = this; // ignore: unused_field

	@override 
	TranslationsZh $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZh(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'Medalize';
	@override late final _Translations$common$zh common = _Translations$common$zh._(_root);
	@override late final _Translations$auth$zh auth = _Translations$auth$zh._(_root);
	@override late final _Translations$forgotPassword$zh forgotPassword = _Translations$forgotPassword$zh._(_root);
	@override late final _Translations$resetPassword$zh resetPassword = _Translations$resetPassword$zh._(_root);
	@override late final _Translations$validation$zh validation = _Translations$validation$zh._(_root);
	@override late final _Translations$errors$zh errors = _Translations$errors$zh._(_root);
	@override late final _Translations$settings$zh settings = _Translations$settings$zh._(_root);
	@override late final _Translations$security$zh security = _Translations$security$zh._(_root);
	@override late final _Translations$status$zh status = _Translations$status$zh._(_root);
	@override late final _Translations$home$zh home = _Translations$home$zh._(_root);
	@override late final _Translations$appointments$zh appointments = _Translations$appointments$zh._(_root);
	@override late final _Translations$booking$zh booking = _Translations$booking$zh._(_root);
	@override late final _Translations$doctorSearch$zh doctorSearch = _Translations$doctorSearch$zh._(_root);
	@override late final _Translations$doctorDetail$zh doctorDetail = _Translations$doctorDetail$zh._(_root);
	@override late final _Translations$profile$zh profile = _Translations$profile$zh._(_root);
	@override late final _Translations$notifications$zh notifications = _Translations$notifications$zh._(_root);
	@override late final _Translations$workplaces$zh workplaces = _Translations$workplaces$zh._(_root);
	@override late final _Translations$addWorkplace$zh addWorkplace = _Translations$addWorkplace$zh._(_root);
	@override late final _Translations$workingHours$zh workingHours = _Translations$workingHours$zh._(_root);
	@override late final _Translations$blockTime$zh blockTime = _Translations$blockTime$zh._(_root);
	@override late final _Translations$onboarding$zh onboarding = _Translations$onboarding$zh._(_root);
	@override late final _Translations$pendingVerification$zh pendingVerification = _Translations$pendingVerification$zh._(_root);
	@override late final _Translations$phoneField$zh phoneField = _Translations$phoneField$zh._(_root);
	@override late final _Translations$locations$zh locations = _Translations$locations$zh._(_root);
	@override late final _Translations$splash$zh splash = _Translations$splash$zh._(_root);
	@override late final _Translations$appIntro$zh appIntro = _Translations$appIntro$zh._(_root);
	@override late final _Translations$agenda$zh agenda = _Translations$agenda$zh._(_root);
	@override late final _Translations$favorites$zh favorites = _Translations$favorites$zh._(_root);
	@override late final _Translations$assistant$zh assistant = _Translations$assistant$zh._(_root);
	@override late final _Translations$messaging$zh messaging = _Translations$messaging$zh._(_root);
	@override late final _Translations$legal$zh legal = _Translations$legal$zh._(_root);
	@override late final _Translations$medications$zh medications = _Translations$medications$zh._(_root);
	@override late final _Translations$prescriptions$zh prescriptions = _Translations$prescriptions$zh._(_root);
	@override late final _Translations$records$zh records = _Translations$records$zh._(_root);
	@override late final _Translations$payments$zh payments = _Translations$payments$zh._(_root);
	@override late final _Translations$family$zh family = _Translations$family$zh._(_root);
}

// Path: common
class _Translations$common$zh extends Translations$common$en {
	_Translations$common$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get cancel => '取消';
	@override String get logout => '退出登录';
	@override String get doctor => '医生';
	@override String get patient => '患者';
	@override String get save => '保存';
	@override String get edit => '编辑';
	@override String get retry => '重试';
	@override String get back => '返回';
	@override String get ok => '确定';
	@override String get delete => '删除';
	@override String get keep => '保留';
	@override String get confirm => '确认';
	@override String get decline => '拒绝';
	@override String get primary => '主要';
	@override String get somethingWrong => '出了点问题';
	@override String get seeAll => '查看全部';
	@override String get signOut => '退出登录';
	@override String get search => '搜索';
	@override String get tryAgain => '请重试';
	@override String get required => '必填';
	@override String get noRatings => '暂无评分';
}

// Path: auth
class _Translations$auth$zh extends Translations$auth$en {
	_Translations$auth$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get login => '登录';
	@override String get register => '创建账户';
	@override String get signIn => '登录';
	@override String get signUp => '注册';
	@override String get email => '电子邮箱';
	@override String get password => '密码';
	@override String get confirmPassword => '确认密码';
	@override String get firstName => '名字';
	@override String get lastName => '姓氏';
	@override String get rememberMe => '记住我';
	@override String get forgotPassword => '忘记密码？';
	@override String get sendResetLink => '发送重置码';
	@override String get noAccount => '还没有账户？';
	@override String get haveAccount => '已有账户？';
	@override String get welcomeBack => '欢迎回来';
	@override String get signInToContinue => '登录您的账户以继续';
	@override String get createYourAccount => '创建您的账户';
	@override String get joinMedalize => '立即加入 Medalize';
	@override String get iAmA => '我是';
	@override String get emailHint => 'you@example.com';
	@override String get passwordHint => '••••••••';
	@override String get backToSignIn => '返回登录';
	@override String get verificationCode => '验证码';
	@override String get continueWithGoogle => '使用 Google 继续';
	@override String get continueWithApple => '使用 Apple 继续';
	@override String get orDivider => '或';
}

// Path: forgotPassword
class _Translations$forgotPassword$zh extends Translations$forgotPassword$en {
	_Translations$forgotPassword$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '忘记密码？';
	@override String get subtitle => '输入您的电子邮箱，我们将发送 6 位重置码';
}

// Path: resetPassword
class _Translations$resetPassword$zh extends Translations$resetPassword$en {
	_Translations$resetPassword$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '重置密码';
	@override String get subtitle => '输入发送到您邮箱的验证码并设置新密码';
	@override String get button => '重置密码';
	@override String get success => '密码重置成功，请登录。';
}

// Path: validation
class _Translations$validation$zh extends Translations$validation$en {
	_Translations$validation$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => '请输入电子邮箱';
	@override String get emailInvalid => '请输入有效的电子邮箱地址';
	@override String get passwordRequired => '请输入密码';
	@override String get passwordTooShort => '至少需要 8 个字符';
	@override String get passwordNeedsLetter => '至少包含一个字母';
	@override String get passwordNeedsDigit => '至少包含一个数字';
	@override String get passwordMismatch => '密码不一致';
	@override String get passwordConfirmRequired => '请确认您的密码';
	@override String get nameMinLength => '至少需要 2 个字符';
	@override String get roleRequired => '请选择角色';
	@override String get phoneRequired => '请输入电话号码';
	@override String get phoneTooShort => '号码太短';
	@override String get phoneTooLong => '号码太长';
	@override String fieldRequired({required Object field}) => '${field} 为必填项';
	@override String fieldInvalid({required Object field}) => '${field} 包含无效字符';
}

// Path: errors
class _Translations$errors$zh extends Translations$errors$en {
	_Translations$errors$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get network => '网络错误，请检查您的连接。';
	@override String get rateLimit => '尝试次数过多，请稍后再试。';
	@override String rateLimitWithSeconds({required Object seconds}) => '尝试次数过多，请 ${seconds} 秒后再试。';
	@override String get invalidCredentials => '邮箱或密码错误';
	@override String get sessionExpired => '会话已过期，请重新登录。';
	@override String get authError => '身份验证错误，请重新登录。';
	@override String get sessionRevoked => '会话已被撤销，请重新登录。';
	@override String get permissionDenied => '您没有执行此操作的权限。';
	@override String get validationError => '验证错误';
	@override String serverError({required Object code}) => '服务器错误（${code}），请重试。';
	@override String get socialLoginFailed => '登录失败，请重试或使用邮箱和密码登录。';
	@override String get conflict => '当前无法完成此操作。';
	@override String get onboardingIncomplete => '请填写所有必填项以完成入驻。';
}

// Path: settings
class _Translations$settings$zh extends Translations$settings$en {
	_Translations$settings$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '设置';
	@override String get account => '账户';
	@override String get profile => '个人资料';
	@override String get notifications => '通知';
	@override String get appearance => '外观';
	@override String get themeSystem => '跟随系统';
	@override String get themeLight => '浅色';
	@override String get themeDark => '深色';
	@override String get language => '语言';
	@override String get languageSystem => '系统默认';
	@override String get logoutTitle => '退出登录';
	@override String get logoutConfirm => '您确定要退出登录吗？';
	@override String get version => 'Medalize v1.0.0';
	@override String get legal => '隐私与条款';
}

// Path: security
class _Translations$security$zh extends Translations$security$en {
	_Translations$security$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '安全';
	@override String get biometricLogin => '生物识别登录';
	@override String get biometricLoginSubtitle => '使用面容 ID / 触控 ID 解锁应用';
	@override String get biometricPrompt => '请验证身份以访问 Medalize';
	@override String get biometricUnavailable => '此设备不支持生物识别认证';
	@override String get biometricEnableFailed => '无法验证您的生物识别信息，请重试。';
	@override String get activeSessions => '活跃会话';
	@override String get activeSessionsSubtitle => '当前已登录您账户的设备';
	@override String get thisDevice => '此设备';
	@override String lastActive({required Object date}) => '最后活跃：${date}';
	@override String get revoke => '撤销';
	@override String get revokeConfirmTitle => '撤销此设备？';
	@override String revokeConfirmMessage({required Object name}) => '${name} 将被登出，可使用账户凭据重新登录。';
	@override String get revokeCurrentConfirmMessage => '这是您当前的设备 — 撤销后将立即登出。';
	@override String get revokeFailed => '无法撤销此设备，请重试。';
	@override String get signOutAllDevices => '退出所有设备';
	@override String get signOutAllConfirmTitle => '退出所有设备？';
	@override String get signOutAllConfirmMessage => '您将在包括此设备在内的所有设备上登出。';
	@override String get signOutAllFailed => '无法退出所有设备，请重试。';
	@override String get noDevices => '未找到活跃会话';
	@override String get loadFailed => '无法加载您的活跃会话';
	@override String get changeEmail => '更改邮箱';
	@override String get changeEmailSubtitle => '我们将向您的新邮箱发送验证码。确认后您将使用新邮箱登录。';
	@override String get newEmailLabel => '新邮箱';
	@override String get sendCode => '发送验证码';
	@override String codeSentTo({required Object email}) => '请输入我们发送到 ${email} 的6位验证码';
	@override String get confirmNewEmail => '确认新邮箱';
	@override String get changeEmailSuccess => '邮箱已更改，请使用新邮箱重新登录。';
	@override String get dangerZone => '危险区域';
	@override String get deactivateAccount => '停用账户';
	@override String get deactivateAccountSubtitle => '停用账户但不删除数据';
	@override String get deactivateConfirmTitle => '停用账户？';
	@override String get deactivateConfirmMessage => '您的账户将被停用，并在所有设备上退出登录。数据不会被删除。如需恢复，请联系客服。';
	@override String get deactivate => '停用';
	@override String get deactivateSuccess => '您的账户已停用。';
}

// Path: status
class _Translations$status$zh extends Translations$status$en {
	_Translations$status$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get confirmed => '已确认';
	@override String get pending => '待处理';
	@override String get cancelled => '已取消';
	@override String get declined => '已拒绝';
	@override String get requiresRescheduling => '需要改期';
	@override String get completed => '已完成';
	@override String get noShow => '未到诊';
}

// Path: home
class _Translations$home$zh extends Translations$home$en {
	_Translations$home$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String helloDoctor({required Object name}) => '您好，${name} 医生！';
	@override String helloPatient({required Object name}) => '您好，${name}！';
	@override String get doctorSubtitle => '管理您的日程\n和预约。';
	@override String get patientSubtitle => '查找医生并\n预约就诊。';
	@override String get pendingRequests => '待处理请求';
	@override String get upcoming => '即将到来';
	@override String get findDoctor => '查找医生';
	@override String get aiAssistant => 'AI 助手';
	@override String get myAppointments => '我的预约';
	@override String get appointments => '预约';
	@override String get workplaces => '工作地点';
	@override String get blockTime => '屏蔽时间';
	@override String get profile => '个人资料';
	@override String get allCaughtUp => '全部处理完毕';
	@override String get noPendingRequests => '没有待处理的预约请求';
	@override String get couldNotLoadAppointments => '无法加载预约';
	@override String get noUpcoming => '没有即将到来的预约';
	@override String get bookFirst => '预约您的第一次就诊';
	@override String get findADoctor => '查找医生';
	@override String get myWaitlist => '我的候诊队列';
	@override String get leaveWaitlist => '退出';
	@override String get statsThisMonth => '本月';
	@override String get statsPatients => '患者';
	@override String get statsAcceptRate => '接受率';
	@override String get statsPending => '待处理';
	@override String get schedule => '日程';
}

// Path: appointments
class _Translations$appointments$zh extends Translations$appointments$en {
	_Translations$appointments$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '预约';
	@override String get myTitle => '我的预约';
	@override String get tabPending => '待处理';
	@override String get tabAll => '全部';
	@override String get tabUpcoming => '即将到来';
	@override String get tabPast => '已过去';
	@override String get noPendingRequests => '没有待处理的请求';
	@override String get newRequestsAppear => '新的预约请求将显示在此处';
	@override String get noAppointments => '没有预约';
	@override String get appointmentsAppear => '您的预约将显示在此处';
	@override String get noUpcoming => '没有即将到来的预约';
	@override String get bookFirst => '预约您的第一次就诊';
	@override String get noPast => '没有过去的预约';
	@override String get pastAppear => '已完成和已取消的预约显示在此处';
	@override String get couldNotLoad => '无法加载预约';
	@override String get detailTitle => '预约';
	@override String get patient => '患者';
	@override String get doctor => '医生';
	@override String get workplace => '工作地点';
	@override String get dateTime => '日期和时间';
	@override String get reason => '原因';
	@override String get doctorNotes => '医生备注';
	@override String get cancelTitle => '取消预约';
	@override String get cancelConfirm => '您确定要取消此预约吗？';
	@override String get cancelAction => '取消预约';
	@override String get bookedTitle => '已预约！';
	@override String get bookedMessage => '您的预约请求已发送。';
	@override String get reschedule => '改期';
	@override String get rescheduleTitle => '改期预约';
	@override String get reviewTitle => '发表评价';
	@override String get reviewRating => '评分';
	@override String get reviewComment => '留言（可选）';
	@override String get reviewSubmit => '提交';
	@override String get markCompleted => '标记为已完成';
	@override String get rescheduledSuccess => '预约已成功改期。';
	@override String get reviewSubmitted => '评价已提交，谢谢！';
	@override String get yourReview => '您的评价';
	@override String get editReviewTitle => '编辑评价';
	@override String get reviewUpdated => '评价已更新。';
	@override String get deleteReviewTitle => '删除评价';
	@override String get deleteReviewConfirm => '确定要删除您的评价吗？';
	@override String get reviewDeleted => '评价已删除。';
	@override String get requestReschedule => '请求改期';
	@override String get requestRescheduleTitle => '请求改期';
	@override String get requestRescheduleConfirm => '请患者选择新的时间？该预约将被标记为需要改期。';
	@override String get requestRescheduleSuccess => '已请求改期，将通知患者。';
	@override String get rescheduleNeededHint => '医生请您选择新的时间。';
	@override String get markNoShow => '标记未到诊';
	@override String get markNoShowTitle => '标记为未到诊';
	@override String get markNoShowConfirm => '将此预约标记为未到诊？这将记录患者未到。';
}

// Path: booking
class _Translations$booking$zh extends Translations$booking$en {
	_Translations$booking$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String bookWith({required Object name}) => '预约 — ${name}';
	@override String get selectWorkplace => '选择工作地点';
	@override String get pickDate => '选择日期';
	@override String get slotsAppear => '可用时间段将显示在此处';
	@override String get couldNotLoadSlots => '无法加载时间段';
	@override String get noAvailableSlots => '没有可用时间段';
	@override String get noOpenSlots => '该日期没有空闲时间段，请尝试其他日期。';
	@override String get confirmTitle => '确认预约';
	@override String get reasonForVisit => '就诊原因（可选）';
	@override String get confirmButton => '确认预约';
	@override String get doctorLabel => '医生';
	@override String get workplaceLabel => '工作地点';
	@override String get addressLabel => '地址';
	@override String get startLabel => '开始';
	@override String get endLabel => '结束';
	@override String get tryDifferentDate => '请换个日期试试';
}

// Path: doctorSearch
class _Translations$doctorSearch$zh extends Translations$doctorSearch$en {
	_Translations$doctorSearch$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '查找医生';
	@override String get searchByName => '按姓名搜索...';
	@override String get city => '城市';
	@override String get search => '搜索';
	@override String get noDoctorsFound => '未找到医生';
	@override String get adjustSearch => '请尝试调整搜索或筛选条件';
	@override String get couldNotLoadDoctors => '无法加载医生';
	@override String get loadMore => '加载更多';
	@override late final _Translations$doctorSearch$spec$zh spec = _Translations$doctorSearch$spec$zh._(_root);
	@override String get noAvailability => '暂无时间';
	@override String get availableToday => '今天可约';
	@override String get availableTomorrow => '明天可约';
	@override String availableOn({required Object date}) => '${date} 可约';
	@override String get sortBy => '排序';
	@override String get sortDefault => '默认';
	@override String get sortRating => '评分最高';
	@override String get sortPriceLow => '价格最低';
	@override String get sortName => '姓名 (A–Z)';
	@override String get sortNearestSlot => '最早可约';
	@override String get sortDistance => '距离最近';
	@override String get locationDenied => '按距离排序需要位置权限。请在设置中允许，或改用城市筛选。';
	@override String get locationUnavailable => '无法获取您的位置。请检查定位服务是否开启，或改用城市筛选。';
	@override String distanceKm({required Object km}) => '${km} 公里';
}

// Path: doctorDetail
class _Translations$doctorDetail$zh extends Translations$doctorDetail$en {
	_Translations$doctorDetail$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get profileTitle => '医生资料';
	@override String get couldNotLoadProfile => '无法加载资料';
	@override String get about => '简介';
	@override String get workplaces => '工作地点';
	@override String minPerSlot({required Object min}) => '每个时段 ${min} 分钟';
	@override String get bookAppointment => '预约就诊';
	@override String get consultationFee => '挂号费';
	@override String get reviews => '评价';
	@override String reviewsCount({required Object count}) => '${count} 条评价';
	@override String get joinWaitlist => '加入候补';
	@override String get leaveWaitlist => '退出候补';
}

// Path: profile
class _Translations$profile$zh extends Translations$profile$en {
	_Translations$profile$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '个人资料';
	@override String get changePassword => '更改密码';
	@override String get currentPassword => '当前密码';
	@override String get newPassword => '新密码';
	@override String get confirmNewPassword => '确认新密码';
	@override String get firstName => '名字';
	@override String get lastName => '姓氏';
	@override String get phone => '电话';
	@override String get failedToSave => '保存个人资料失败。';
	@override String get professionalInfo => '职业信息';
	@override String get bio => '简介';
	@override String get bioHint => '简短介绍您的经验';
	@override String get consultationFee => '挂号费';
	@override String get medicalInfo => '医疗信息';
	@override String get allergies => '过敏史';
	@override String get allergiesHint => '如：青霉素、花生';
	@override String get chronicConditions => '慢性病史';
	@override String get chronicConditionsHint => '如：糖尿病、高血压';
	@override String get medications => '当前用药';
	@override String get medicationsHint => '如：二甲双胍500mg';
	@override String get appointmentLength => '预约时长';
	@override String get cancellationWindow => '取消时限';
	@override String get cancellationWindowHint => '患者可在预约前多久取消或改期。';
	@override String hoursValue({required Object h}) => '${h} 小时';
}

// Path: notifications
class _Translations$notifications$zh extends Translations$notifications$en {
	_Translations$notifications$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '通知';
	@override String get noNotifications => '没有通知';
	@override String get allCaughtUp => '您已查看全部';
	@override String get couldNotLoad => '无法加载通知';
	@override String get markAllRead => '全部标为已读';
	@override String get settingsTitle => '通知设置';
	@override String get pushEnabled => '推送通知';
	@override String get pushEnabledSubtitle => '在此设备上接收预约和更新提醒';
	@override String get emailEnabled => '邮件通知';
	@override String get emailEnabledSubtitle => '更新将发送到您的邮箱';
}

// Path: workplaces
class _Translations$workplaces$zh extends Translations$workplaces$en {
	_Translations$workplaces$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的工作地点';
	@override String get noWorkplacesYet => '暂无工作地点';
	@override String get tapToAdd => '点击 + 添加您的第一个工作地点';
	@override String get couldNotLoad => '无法加载工作地点';
	@override String get deleteTitle => '删除工作地点';
	@override String deleteConfirm({required Object name}) => '删除“${name}”？';
	@override String get cannotDelete => '无法删除工作地点';
	@override String get workingHours => '工作时间';
	@override String get setAsPrimary => '设为主要';
}

// Path: addWorkplace
class _Translations$addWorkplace$zh extends Translations$addWorkplace$en {
	_Translations$addWorkplace$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get addTitle => '添加工作地点';
	@override String get editTitle => '编辑工作地点';
	@override String get name => '名称';
	@override String get address => '街道地址';
	@override String get city => '城市';
	@override String get type => '类型';
	@override String get clinic => '诊所';
	@override String get hospital => '医院';
	@override String get privatePractice => '私人诊所';
	@override String get failedToSave => '保存工作地点失败。';
	@override String get addButton => '添加工作地点';
	@override String get saveChanges => '保存更改';
	@override String get pickOnMap => '在地图上选择';
	@override String get mapPickerTitle => '选择位置';
	@override String get useMyLocation => '使用我的位置';
	@override String get confirmLocation => '确认位置';
	@override String get locationSet => '已从地图设置位置 ✓';
	@override String get locationPermissionDenied => '需要定位权限才能使用您的当前位置。您仍可以手动移动地图。';
	@override String get locationUnavailable => '无法获取您的位置。您仍可以手动移动地图。';
}

// Path: workingHours
class _Translations$workingHours$zh extends Translations$workingHours$en {
	_Translations$workingHours$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '工作时间';
	@override String get sectionHint => '设置患者可以在此地点预约您的工作日和时间。';
	@override String get invalidRange => '每个启用的工作日，结束时间必须晚于开始时间。';
	@override String get saved => '工作时间已保存';
	@override String get failedToSave => '保存工作时间失败';
	@override late final _Translations$workingHours$days$zh days = _Translations$workingHours$days$zh._(_root);
}

// Path: blockTime
class _Translations$blockTime$zh extends Translations$blockTime$en {
	_Translations$blockTime$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '屏蔽时间';
	@override String get dateRange => '日期范围';
	@override String get tapToSelect => '点击选择日期';
	@override String get reason => '原因（可选）';
	@override String get notifyPatients => '通知受影响的患者';
	@override String get notifyDesc => '向此期间有预约的患者发送通知';
	@override String get selectDateRange => '请选择日期范围。';
	@override String get failedToBlock => '屏蔽时间失败，请重试。';
	@override String get blockButton => '屏蔽时段';
}

// Path: onboarding
class _Translations$onboarding$zh extends Translations$onboarding$en {
	_Translations$onboarding$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '完善您的资料';
	@override String get professionalInfo => '专业信息';
	@override String get tellPatients => '向患者介绍您的诊疗。';
	@override String get specialization => '专业';
	@override String get selectSpecialization => '选择您的专业';
	@override String get couldNotLoadSpecs => '无法加载专业，请返回重试。';
	@override String get licenseNumber => '执照编号';
	@override String get licenseHint => '例如 AZ-123456';
	@override String get bio => '简介（可选）';
	@override String get bioHint => '患者将在您的资料中看到的简短介绍。';
	@override String get appointmentLength => '预约时长';
	@override String get slotQuestion => '单个预约时段有多长？';
	@override String get changeLater => '稍后可在个人资料中更改。';
	@override String minutes({required Object min}) => '${min} 分钟';
	@override String get verificationDoc => '验证文件';
	@override String get uploadDiploma => '上传您的医学文凭或执照。管理员将在您的账户验证前进行审核。';
	@override String get tapToChoose => '点击选择文件';
	@override String get tapToReplace => '点击替换';
	@override String get anyFileType => '任何文件类型，最大 10 MB';
	@override String get selectSpecError => '请选择您的专业。';
	@override String get licenseError => '请输入您的执照编号。';
	@override String get diplomaError => '请附上您的文凭。';
	@override String get checkDetails => '请检查您的信息并重试。';
	@override String get continueButton => '继续';
	@override String get finish => '完成';
}

// Path: pendingVerification
class _Translations$pendingVerification$zh extends Translations$pendingVerification$en {
	_Translations$pendingVerification$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '等待验证';
	@override String get message => '您的账户正在审核中。验证通过后我们会通知您。';
	@override String get checkStatus => '检查状态';
	@override String get stillPending => '仍在审核中。验证通过后我们会通知您。';
}

// Path: phoneField
class _Translations$phoneField$zh extends Translations$phoneField$en {
	_Translations$phoneField$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get label => '电话号码';
	@override String get labelOptional => '电话号码（可选）';
	@override String get selectCountry => '选择国家';
	@override String get searchCountry => '搜索国家或区号…';
	@override String get noCountriesFound => '未找到国家';
}

// Path: locations
class _Translations$locations$zh extends Translations$locations$en {
	_Translations$locations$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get pickCity => '选择城市';
	@override String get searchHint => '搜索城市或地区…';
	@override String get noResultsFound => '未找到城市';
	@override String get couldNotLoad => '无法加载城市列表，点击重试。';
	@override String get allCities => '所有城市';
}

// Path: splash
class _Translations$splash$zh extends Translations$splash$en {
	_Translations$splash$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get tagline => '让健康更简单';
}

// Path: appIntro
class _Translations$appIntro$zh extends Translations$appIntro$en {
	_Translations$appIntro$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get page1Title => '找到合适的医生';
	@override String get page1Subtitle => '按专科、城市和评分搜索，预约适合您的时间。';
	@override String get page2Title => '咨询 AI 健康助手';
	@override String get page2Subtitle => '描述您的症状，随时了解应该看哪位专科医生。';
	@override String get page3Title => '一个应用，管理一切';
	@override String get page3Subtitle => '管理预约、跟踪就诊记录，并使用您熟悉的语言安全地使用本应用。';
	@override String get skip => '跳过';
	@override String get next => '下一步';
	@override String get getStarted => '开始使用';
}

// Path: agenda
class _Translations$agenda$zh extends Translations$agenda$en {
	_Translations$agenda$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '日程';
	@override String get today => '今天';
	@override String get empty => '没有预约';
	@override String get emptySubtitle => '这一天没有安排';
}

// Path: favorites
class _Translations$favorites$zh extends Translations$favorites$en {
	_Translations$favorites$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '收藏';
	@override String get empty => '还没有收藏';
	@override String get emptySubtitle => '点击医生上的爱心以收藏';
	@override String get add => '加入收藏';
	@override String get remove => '取消收藏';
}

// Path: assistant
class _Translations$assistant$zh extends Translations$assistant$en {
	_Translations$assistant$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => 'AI 助手';
	@override String get newChat => '新对话';
	@override String get empty => '暂无对话';
	@override String get emptySubtitle => '描述您的症状，助手会建议您应就诊哪科医生';
	@override String get couldNotLoad => '无法加载对话列表';
	@override String get couldNotLoadChat => '无法加载该对话';
	@override String get newConversation => '新对话';
	@override String get deleteTitle => '删除对话？';
	@override String get deleteConfirm => '该对话及其所有消息将被删除。';
	@override String get inputHint => '请描述您的症状…';
	@override String get send => '发送';
	@override String get sendFailed => '消息发送失败，请重试。';
	@override String get typing => '助手正在输入…';
	@override String get startTitle => '有什么可以帮您？';
	@override String get startSubtitle => '请先描述让您不适的症状';
	@override String get book => '预约';
	@override String get reportTooltip => '举报此回复';
	@override String get reportTitle => '举报回复';
	@override String get reportHint => '原因（可选）';
	@override String get reportSubmit => '举报';
	@override String get reportSuccess => '感谢反馈，该回复已被举报。';
	@override String get reportFailed => '无法举报该回复，请重试。';
	@override String get topicsTooltip => '主题';
	@override String get topicsSheetTitle => '选择一个主题';
}

// Path: messaging
class _Translations$messaging$zh extends Translations$messaging$en {
	_Translations$messaging$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '消息';
	@override String get sendMessage => '发消息';
	@override String get typeMessage => '输入消息…';
	@override String get send => '发送';
	@override String get empty => '暂无对话';
	@override String get emptySubtitle => '您的消息记录将显示在这里。';
	@override String get disclaimer => '这不是紧急联系渠道，如遇紧急情况请拨打急救电话。';
	@override String get noSharedHistory => '只有与该医生有共同的预约记录后，才能给对方发消息。';
	@override String get newMessage => '您有一条新消息';
}

// Path: legal
class _Translations$legal$zh extends Translations$legal$en {
	_Translations$legal$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '隐私与条款';
	@override String get controllerNotice => 'Medalize 由 [Fərdi Sahibkar adı — VÖEN: XXXXXXXXXXXX]（阿塞拜疆,"我们"）运营。最后更新：2026年7月。';
	@override String get privacyTitle => '隐私政策';
	@override String get privacyIntro => '本政策说明 Medalize 收集哪些个人数据、原因以及如何保护这些数据。预约和管理医疗就诊必然涉及您的健康信息，下面将详细说明。';
	@override late final _Translations$legal$sections$zh sections = _Translations$legal$sections$zh._(_root);
	@override String get termsTitle => '服务条款';
	@override String get termsIntro => '创建账号即表示您同意以下内容。';
	@override String get termsBody => '提供关于您自己的准确信息。仅将 Medalize 用于查找、预约和管理医疗就诊。对您的登录凭证保密。Medalize 将您与独立的、持证的医疗专业人员联系起来——我们自身并非医疗机构，AI 症状检查助手也不能替代专业医疗诊断或建议。如遇医疗紧急情况，请直接联系急救服务，而非使用本应用。对于违反本条款或滥用平台的账号，我们可能会暂停或终止其使用。';
	@override String get contact => '对您的数据有疑问？请联系 support@medalize.app';
	@override String get consentPrefix => '我已阅读并同意';
	@override String get consentPrivacyLink => '隐私政策';
	@override String get consentMiddle => '和';
	@override String get consentTermsLink => '服务条款';
	@override String get consentSuffix => '，并明确同意按其中所述处理我的健康数据。';
	@override String get viewAsPdf => '查看 PDF';
	@override String get pdfDocumentTitle => 'Medalize — 隐私政策与服务条款';
	@override String get pdfLoadError => '无法加载文档。请检查您的网络连接后重试。';
}

// Path: medications
class _Translations$medications$zh extends Translations$medications$en {
	_Translations$medications$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '用药';
	@override String get editMedication => '编辑药物';
	@override String get name => '名称';
	@override String get dosage => '剂量';
	@override String get notes => '备注';
	@override String get form => '剂型';
	@override String get formPill => '药片';
	@override String get formCapsule => '胶囊';
	@override String get formLiquid => '液体';
	@override String get formInjection => '注射剂';
	@override String get formOther => '其他';
	@override String get schedule => '服药安排';
	@override String get times => '服药时间';
	@override String get addTime => '添加时间';
	@override String get daysOfWeek => '星期';
	@override String get everyDay => '每天';
	@override String get startDate => '开始日期';
	@override String get endDate => '结束日期';
	@override String get save => '保存';
	@override String get delete => '删除';
	@override String get deleteConfirmTitle => '删除药物';
	@override String get deleteConfirmBody => '确定要删除这个药物吗?服药记录将被保留。';
	@override String get emptyTitle => '暂无药物';
	@override String get emptySubtitle => '医生开具的药物将在就诊后显示在这里。';
	@override String get todaysDoses => '今日服药';
	@override String get markTaken => '已服用';
	@override String get markSkipped => '跳过';
	@override String get statusTaken => '已服用';
	@override String get statusSkipped => '已跳过';
	@override String get statusPending => '待服用';
	@override String reminderTitle({required Object name}) => '该服用${name}了';
	@override String reminderBody({required Object dosage}) => '剂量:${dosage}';
	@override String get tabActive => '使用中';
	@override String get tabArchive => '已归档';
	@override String get fromPrescription => '来自处方';
	@override String get noSchedule => '尚未设置服药时间 — 点击添加提醒时间';
	@override String get dayMon => '周一';
	@override String get dayTue => '周二';
	@override String get dayWed => '周三';
	@override String get dayThu => '周四';
	@override String get dayFri => '周五';
	@override String get daySat => '周六';
	@override String get daySun => '周日';
	@override String get updatedSuccess => '药物已更新。';
	@override String get deletedSuccess => '药物已删除。';
	@override String get atLeastOneTime => '请至少添加一个提醒时间';
}

// Path: prescriptions
class _Translations$prescriptions$zh extends Translations$prescriptions$en {
	_Translations$prescriptions$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '处方';
	@override String get writeTitle => '开具处方';
	@override String get addDrug => '添加药物';
	@override String get drugName => '药物名称';
	@override String get dosage => '剂量';
	@override String get frequency => '服用频率';
	@override String get duration => '疗程';
	@override String get instructions => '用药说明';
	@override String get notes => '备注';
	@override String get save => '保存';
	@override String get empty => '暂无处方';
	@override String get emptySubtitle => '医生开具的处方将显示在这里。';
	@override String get viewDetails => '查看详情';
	@override String issuedBy({required Object name}) => '由 ${name} 医生开具';
	@override String issuedOn({required Object date}) => '开具日期:${date}';
	@override String get applyToMedications => '添加到我的用药';
	@override String get applySuccess => '已添加到您的用药。请设置提醒时间以接收通知。';
	@override String get alreadyApplied => '已添加到您的用药';
	@override String get noPrescriptionYet => '此预约尚无处方';
	@override String get writePrescription => '开具处方';
	@override String get prescriptionIssued => '处方已开具。';
	@override String get removeDrug => '移除';
	@override String get atLeastOneDrug => '请至少添加一种药物';
	@override String get drugNameRequired => '请填写药物名称';
	@override String get summaryTitle => '处方';
	@override String itemsCount({required Object count}) => '${count} 种药物';
	@override String get newPrescription => '新处方';
	@override String get youHavePrescription => '此预约已有处方';
}

// Path: records
class _Translations$records$zh extends Translations$records$en {
	_Translations$records$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '健康档案';
	@override String get upload => '上传文件';
	@override String get recordType => '文件类型';
	@override String get typeLabResult => '化验结果';
	@override String get typeImaging => '影像检查';
	@override String get typeDocument => '文档';
	@override String get typeOther => '其他';
	@override String get recordTitle => '标题';
	@override String get recordDate => '日期';
	@override String get notes => '备注';
	@override String get chooseFile => '选择文件';
	@override String get changeFile => '更换文件';
	@override String get noFileChosen => '未选择文件';
	@override String get save => '保存';
	@override String get delete => '删除';
	@override String get deleteConfirmTitle => '删除档案';
	@override String get deleteConfirmBody => '确定要删除这份档案吗?此操作无法撤销。';
	@override String get empty => '暂无健康档案';
	@override String get emptySubtitle => '将化验结果、影像检查和其他文档集中保存在这里。';
	@override String get view => '查看';
	@override String get fileRequired => '请选择要上传的文件';
	@override String get fileTooLarge => '文件过大（最大 15 MB）';
	@override String get titleRequired => '请填写标题';
	@override String get uploadSuccess => '文件已上传。';
	@override String get deletedSuccess => '文件已删除。';
	@override String get couldNotOpen => '无法打开文件';
}

// Path: payments
class _Translations$payments$zh extends Translations$payments$en {
	_Translations$payments$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '支付';
	@override String get amount => '金额';
	@override String get payNow => '立即支付';
	@override String get payLater => '稍后支付';
	@override String get statusPending => '待支付';
	@override String get statusPaid => '已支付';
	@override String get statusFailed => '支付失败';
	@override String get statusCancelled => '已取消';
	@override String get paymentConfirmed => '支付已确认，谢谢！';
	@override String get openingBrowser => '正在打开浏览器…';
	@override String get checkStatus => '查看状态';
}

// Path: family
class _Translations$family$zh extends Translations$family$en {
	_Translations$family$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '家庭成员';
	@override String get myself => '本人';
	@override String get addFamilyMember => '添加家庭成员';
	@override String get editFamilyMember => '编辑家庭成员';
	@override String get firstName => '名';
	@override String get lastName => '姓';
	@override String get relationship => '关系';
	@override String get relationshipChild => '子女';
	@override String get relationshipSpouse => '配偶';
	@override String get relationshipParent => '父母';
	@override String get relationshipSibling => '兄弟姐妹';
	@override String get relationshipOther => '其他';
	@override String get dateOfBirth => '出生日期';
	@override String get bloodType => '血型';
	@override String get allergies => '过敏史';
	@override String get chronicConditions => '慢性病史';
	@override String get medications => '当前用药';
	@override String get save => '保存';
	@override String get delete => '删除';
	@override String get deleteConfirmTitle => '删除家庭成员';
	@override String get deleteConfirmBody => '确定要删除这位家庭成员吗?其预约、用药和档案记录将被保留。';
	@override String get empty => '暂无家庭成员';
	@override String get emptySubtitle => '添加子女、配偶或其他家庭成员，以管理他们的预约、用药和健康档案。';
	@override String get bookingForQuestion => '这次预约是为谁安排的？';
	@override String bookingForLabel({required Object name}) => '预约对象：${name}';
	@override String forLabel({required Object name}) => '${name} 的';
	@override String ageYears({required Object age}) => '${age} 岁';
	@override String bookedByLabel({required Object name}) => '预约人：${name}';
}

// Path: doctorSearch.spec
class _Translations$doctorSearch$spec$zh extends Translations$doctorSearch$spec$en {
	_Translations$doctorSearch$spec$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get general => '全科';
	@override String get cardiology => '心脏科';
	@override String get dermatology => '皮肤科';
	@override String get neurology => '神经科';
	@override String get orthopedics => '骨科';
	@override String get pediatrics => '儿科';
	@override String get psychiatry => '精神科';
	@override String get gynecology => '妇科';
	@override String get urology => '泌尿科';
	@override String get ophthalmology => '眼科';
	@override String get ent => '耳鼻喉科';
}

// Path: workingHours.days
class _Translations$workingHours$days$zh extends Translations$workingHours$days$en {
	_Translations$workingHours$days$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get monday => '星期一';
	@override String get tuesday => '星期二';
	@override String get wednesday => '星期三';
	@override String get thursday => '星期四';
	@override String get friday => '星期五';
	@override String get saturday => '星期六';
	@override String get sunday => '星期日';
}

// Path: legal.sections
class _Translations$legal$sections$zh extends Translations$legal$sections$en {
	_Translations$legal$sections$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _Translations$legal$sections$identity$zh identity = _Translations$legal$sections$identity$zh._(_root);
	@override late final _Translations$legal$sections$health$zh health = _Translations$legal$sections$health$zh._(_root);
	@override late final _Translations$legal$sections$professional$zh professional = _Translations$legal$sections$professional$zh._(_root);
	@override late final _Translations$legal$sections$location$zh location = _Translations$legal$sections$location$zh._(_root);
	@override late final _Translations$legal$sections$device$zh device = _Translations$legal$sections$device$zh._(_root);
	@override late final _Translations$legal$sections$payment$zh payment = _Translations$legal$sections$payment$zh._(_root);
	@override late final _Translations$legal$sections$family$zh family = _Translations$legal$sections$family$zh._(_root);
	@override late final _Translations$legal$sections$purposes$zh purposes = _Translations$legal$sections$purposes$zh._(_root);
	@override late final _Translations$legal$sections$legalBasis$zh legalBasis = _Translations$legal$sections$legalBasis$zh._(_root);
	@override late final _Translations$legal$sections$thirdParties$zh thirdParties = _Translations$legal$sections$thirdParties$zh._(_root);
	@override late final _Translations$legal$sections$retention$zh retention = _Translations$legal$sections$retention$zh._(_root);
	@override late final _Translations$legal$sections$rights$zh rights = _Translations$legal$sections$rights$zh._(_root);
	@override late final _Translations$legal$sections$security$zh security = _Translations$legal$sections$security$zh._(_root);
	@override late final _Translations$legal$sections$permissions$zh permissions = _Translations$legal$sections$permissions$zh._(_root);
	@override late final _Translations$legal$sections$children$zh children = _Translations$legal$sections$children$zh._(_root);
}

// Path: legal.sections.identity
class _Translations$legal$sections$identity$zh extends Translations$legal$sections$identity$en {
	_Translations$legal$sections$identity$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '身份数据';
	@override String get body => '姓名、电子邮箱、电话号码（可选）、您的密码（以不可逆的哈希形式存储，绝不以明文存储）以及您偏好的应用语言。';
}

// Path: legal.sections.health
class _Translations$legal$sections$health$zh extends Translations$legal$sections$health$en {
	_Translations$legal$sections$health$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '健康数据';
	@override String get body => '作为患者：血型、过敏史、慢性病、正在服用的药物、预约时填写的就诊原因、您上传的医疗文件（化验结果、影像资料、其他记录）、为您开具的处方，以及您与医生的聊天内容。如果您使用 AI 症状检查助手，您的问题和它的回复也会以同样方式处理。根据阿塞拜疆法律，健康数据受到最高级别的保护，我们仅在获得您单独、明确的同意后才会收集（见下方"法律依据"）。';
}

// Path: legal.sections.professional
class _Translations$legal$sections$professional$zh extends Translations$legal$sections$professional$en {
	_Translations$legal$sections$professional$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '专业数据（医生）';
	@override String get body => '医学专业方向、执照号码、文凭或其他验证文件、工作地点信息以及问诊费用。在您的资料对患者可见之前，这些信息会由我们的团队审核。';
}

// Path: legal.sections.location
class _Translations$legal$sections$location$zh extends Translations$legal$sections$location$en {
	_Translations$legal$sections$location$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '位置信息';
	@override String get body => '经您许可后获取大致或精确位置，以便按距离为您排序医生。仅在应用打开期间使用——绝不会存储在我们的服务器上。';
}

// Path: legal.sections.device
class _Translations$legal$sections$device$zh extends Translations$legal$sections$device$en {
	_Translations$legal$sections$device$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '设备与技术数据';
	@override String get body => '设备标识符和会话信息，以便您可以在"设置"中查看并撤销当前登录的设备，以及用于向您的设备推送预约提醒和消息的推送通知令牌。';
}

// Path: legal.sections.payment
class _Translations$legal$sections$payment$zh extends Translations$legal$sections$payment$en {
	_Translations$legal$sections$payment$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '支付数据';
	@override String get body => '如果您在应用内为问诊付款，付款将完全由我们的支付合作伙伴 Payriff 处理——我们绝不会看到或存储您的银行卡号。我们仅保留付款金额、状态以及用于您预约历史记录的参考编号。';
}

// Path: legal.sections.family
class _Translations$legal$sections$family$zh extends Translations$legal$sections$family$en {
	_Translations$legal$sections$family$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '家庭成员档案';
	@override String get body => '如果您管理某位没有自己账号的家庭成员（子女或受抚养人）的档案，上述相同类别的健康数据可能会在您的账号下为其记录。添加家庭成员即表示您确认自己是其父母、监护人，或以其他方式获得授权代其管理健康信息。';
}

// Path: legal.sections.purposes
class _Translations$legal$sections$purposes$zh extends Translations$legal$sections$purposes$en {
	_Translations$legal$sections$purposes$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我们为何使用您的数据';
	@override String get body => '使您能够找到医生并预约；使医生能够管理日程和患者；发送预约提醒和更新；处理问诊付款；提供可选的 AI 症状检查功能；以及保障您账号的安全。';
}

// Path: legal.sections.legalBasis
class _Translations$legal$sections$legalBasis$zh extends Translations$legal$sections$legalBasis$en {
	_Translations$legal$sections$legalBasis$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '法律依据与您的同意';
	@override String get body => '我们基于您注册时给予的同意处理您的数据。根据阿塞拜疆共和国《个人数据法》（第998-IIIQ号），健康数据属于特殊类别的个人数据，在收集前需要您明确的书面同意——注册界面上的复选框正是记录这一同意。您可以随时通过删除账号撤回同意，但在法律要求的情况下（例如出于税务目的的财务记录），我们可能会保留有限的记录。';
}

// Path: legal.sections.thirdParties
class _Translations$legal$sections$thirdParties$zh extends Translations$legal$sections$thirdParties$en {
	_Translations$legal$sections$thirdParties$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '还有谁会处理您的数据';
	@override String get body => '仅按照我们的指示、为此处所述目的行事的可信服务提供商：Cloudinary（安全文件存储——文档和照片绝不公开可访问，仅通过有时效的签名链接访问）；Firebase/Google（推送通知，以及您选择使用的 Google 登录）；Apple（您选择使用的 Apple 登录）；Payriff（应用内支付）。我们不会出售您的个人数据。';
}

// Path: legal.sections.retention
class _Translations$legal$sections$retention$zh extends Translations$legal$sections$retention$en {
	_Translations$legal$sections$retention$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我们保留数据多长时间';
	@override String get body => '只要您的账号处于活跃状态。如果您删除账号，我们会在合理期限内删除您的个人数据，但法律要求保留的记录除外（例如出于税务目的的付款记录）。';
}

// Path: legal.sections.rights
class _Translations$legal$sections$rights$zh extends Translations$legal$sections$rights$en {
	_Translations$legal$sections$rights$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '您的权利';
	@override String get body => '您可以访问我们持有的关于您的数据，要求更正不准确的数据，要求删除您的账号和数据，并可随时撤回同意。其中大部分可直接在"个人资料">"设置"中完成；其他事项请通过下方联系方式与我们联系。';
}

// Path: legal.sections.security
class _Translations$legal$sections$security$zh extends Translations$legal$sections$security$en {
	_Translations$legal$sections$security$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我们如何保护您的数据';
	@override String get body => '您与医生之间的消息以及与 AI 助手的对话均经过加密。上传的文档和照片以私密方式存储，仅可通过安全的签名链接访问，绝不会作为公开文件存在。密码绝不会以可读形式存储。';
}

// Path: legal.sections.permissions
class _Translations$legal$sections$permissions$zh extends Translations$legal$sections$permissions$en {
	_Translations$legal$sections$permissions$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我们请求的权限';
	@override String get body => '相机和照片图库——用于设置头像和上传医疗文件。位置——用于按距离为您排序医生。通知——用于推送预约提醒和消息。生物识别（面容 ID / 指纹）——一种可选的、更快捷的应用解锁方式；您的生物识别数据绝不会离开您的设备，我们仅会收到设备操作系统返回的"是/否"确认。';
}

// Path: legal.sections.children
class _Translations$legal$sections$children$zh extends Translations$legal$sections$children$en {
	_Translations$legal$sections$children$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '年龄要求';
	@override String get body => 'Medalize 账号面向成年人。如果您未满18岁，请让父母或监护人使用家庭成员档案功能代您创建和管理账号。';
}

/// The flat map containing all translations for locale <zh>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'Medalize',
			'common.cancel' => '取消',
			'common.logout' => '退出登录',
			'common.doctor' => '医生',
			'common.patient' => '患者',
			'common.save' => '保存',
			'common.edit' => '编辑',
			'common.retry' => '重试',
			'common.back' => '返回',
			'common.ok' => '确定',
			'common.delete' => '删除',
			'common.keep' => '保留',
			'common.confirm' => '确认',
			'common.decline' => '拒绝',
			'common.primary' => '主要',
			'common.somethingWrong' => '出了点问题',
			'common.seeAll' => '查看全部',
			'common.signOut' => '退出登录',
			'common.search' => '搜索',
			'common.tryAgain' => '请重试',
			'common.required' => '必填',
			'common.noRatings' => '暂无评分',
			'auth.login' => '登录',
			'auth.register' => '创建账户',
			'auth.signIn' => '登录',
			'auth.signUp' => '注册',
			'auth.email' => '电子邮箱',
			'auth.password' => '密码',
			'auth.confirmPassword' => '确认密码',
			'auth.firstName' => '名字',
			'auth.lastName' => '姓氏',
			'auth.rememberMe' => '记住我',
			'auth.forgotPassword' => '忘记密码？',
			'auth.sendResetLink' => '发送重置码',
			'auth.noAccount' => '还没有账户？',
			'auth.haveAccount' => '已有账户？',
			'auth.welcomeBack' => '欢迎回来',
			'auth.signInToContinue' => '登录您的账户以继续',
			'auth.createYourAccount' => '创建您的账户',
			'auth.joinMedalize' => '立即加入 Medalize',
			'auth.iAmA' => '我是',
			'auth.emailHint' => 'you@example.com',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => '返回登录',
			'auth.verificationCode' => '验证码',
			'auth.continueWithGoogle' => '使用 Google 继续',
			'auth.continueWithApple' => '使用 Apple 继续',
			'auth.orDivider' => '或',
			'forgotPassword.title' => '忘记密码？',
			'forgotPassword.subtitle' => '输入您的电子邮箱，我们将发送 6 位重置码',
			'resetPassword.title' => '重置密码',
			'resetPassword.subtitle' => '输入发送到您邮箱的验证码并设置新密码',
			'resetPassword.button' => '重置密码',
			'resetPassword.success' => '密码重置成功，请登录。',
			'validation.emailRequired' => '请输入电子邮箱',
			'validation.emailInvalid' => '请输入有效的电子邮箱地址',
			'validation.passwordRequired' => '请输入密码',
			'validation.passwordTooShort' => '至少需要 8 个字符',
			'validation.passwordNeedsLetter' => '至少包含一个字母',
			'validation.passwordNeedsDigit' => '至少包含一个数字',
			'validation.passwordMismatch' => '密码不一致',
			'validation.passwordConfirmRequired' => '请确认您的密码',
			'validation.nameMinLength' => '至少需要 2 个字符',
			'validation.roleRequired' => '请选择角色',
			'validation.phoneRequired' => '请输入电话号码',
			'validation.phoneTooShort' => '号码太短',
			'validation.phoneTooLong' => '号码太长',
			'validation.fieldRequired' => ({required Object field}) => '${field} 为必填项',
			'validation.fieldInvalid' => ({required Object field}) => '${field} 包含无效字符',
			'errors.network' => '网络错误，请检查您的连接。',
			'errors.rateLimit' => '尝试次数过多，请稍后再试。',
			'errors.rateLimitWithSeconds' => ({required Object seconds}) => '尝试次数过多，请 ${seconds} 秒后再试。',
			'errors.invalidCredentials' => '邮箱或密码错误',
			'errors.sessionExpired' => '会话已过期，请重新登录。',
			'errors.authError' => '身份验证错误，请重新登录。',
			'errors.sessionRevoked' => '会话已被撤销，请重新登录。',
			'errors.permissionDenied' => '您没有执行此操作的权限。',
			'errors.validationError' => '验证错误',
			'errors.serverError' => ({required Object code}) => '服务器错误（${code}），请重试。',
			'errors.socialLoginFailed' => '登录失败，请重试或使用邮箱和密码登录。',
			'errors.conflict' => '当前无法完成此操作。',
			'errors.onboardingIncomplete' => '请填写所有必填项以完成入驻。',
			'settings.title' => '设置',
			'settings.account' => '账户',
			'settings.profile' => '个人资料',
			'settings.notifications' => '通知',
			'settings.appearance' => '外观',
			'settings.themeSystem' => '跟随系统',
			'settings.themeLight' => '浅色',
			'settings.themeDark' => '深色',
			'settings.language' => '语言',
			'settings.languageSystem' => '系统默认',
			'settings.logoutTitle' => '退出登录',
			'settings.logoutConfirm' => '您确定要退出登录吗？',
			'settings.version' => 'Medalize v1.0.0',
			'settings.legal' => '隐私与条款',
			'security.title' => '安全',
			'security.biometricLogin' => '生物识别登录',
			'security.biometricLoginSubtitle' => '使用面容 ID / 触控 ID 解锁应用',
			'security.biometricPrompt' => '请验证身份以访问 Medalize',
			'security.biometricUnavailable' => '此设备不支持生物识别认证',
			'security.biometricEnableFailed' => '无法验证您的生物识别信息，请重试。',
			'security.activeSessions' => '活跃会话',
			'security.activeSessionsSubtitle' => '当前已登录您账户的设备',
			'security.thisDevice' => '此设备',
			'security.lastActive' => ({required Object date}) => '最后活跃：${date}',
			'security.revoke' => '撤销',
			'security.revokeConfirmTitle' => '撤销此设备？',
			'security.revokeConfirmMessage' => ({required Object name}) => '${name} 将被登出，可使用账户凭据重新登录。',
			'security.revokeCurrentConfirmMessage' => '这是您当前的设备 — 撤销后将立即登出。',
			'security.revokeFailed' => '无法撤销此设备，请重试。',
			'security.signOutAllDevices' => '退出所有设备',
			'security.signOutAllConfirmTitle' => '退出所有设备？',
			'security.signOutAllConfirmMessage' => '您将在包括此设备在内的所有设备上登出。',
			'security.signOutAllFailed' => '无法退出所有设备，请重试。',
			'security.noDevices' => '未找到活跃会话',
			'security.loadFailed' => '无法加载您的活跃会话',
			'security.changeEmail' => '更改邮箱',
			'security.changeEmailSubtitle' => '我们将向您的新邮箱发送验证码。确认后您将使用新邮箱登录。',
			'security.newEmailLabel' => '新邮箱',
			'security.sendCode' => '发送验证码',
			'security.codeSentTo' => ({required Object email}) => '请输入我们发送到 ${email} 的6位验证码',
			'security.confirmNewEmail' => '确认新邮箱',
			'security.changeEmailSuccess' => '邮箱已更改，请使用新邮箱重新登录。',
			'security.dangerZone' => '危险区域',
			'security.deactivateAccount' => '停用账户',
			'security.deactivateAccountSubtitle' => '停用账户但不删除数据',
			'security.deactivateConfirmTitle' => '停用账户？',
			'security.deactivateConfirmMessage' => '您的账户将被停用，并在所有设备上退出登录。数据不会被删除。如需恢复，请联系客服。',
			'security.deactivate' => '停用',
			'security.deactivateSuccess' => '您的账户已停用。',
			'status.confirmed' => '已确认',
			'status.pending' => '待处理',
			'status.cancelled' => '已取消',
			'status.declined' => '已拒绝',
			'status.requiresRescheduling' => '需要改期',
			'status.completed' => '已完成',
			'status.noShow' => '未到诊',
			'home.helloDoctor' => ({required Object name}) => '您好，${name} 医生！',
			'home.helloPatient' => ({required Object name}) => '您好，${name}！',
			'home.doctorSubtitle' => '管理您的日程\n和预约。',
			'home.patientSubtitle' => '查找医生并\n预约就诊。',
			'home.pendingRequests' => '待处理请求',
			'home.upcoming' => '即将到来',
			'home.findDoctor' => '查找医生',
			'home.aiAssistant' => 'AI 助手',
			'home.myAppointments' => '我的预约',
			'home.appointments' => '预约',
			'home.workplaces' => '工作地点',
			'home.blockTime' => '屏蔽时间',
			'home.profile' => '个人资料',
			'home.allCaughtUp' => '全部处理完毕',
			'home.noPendingRequests' => '没有待处理的预约请求',
			'home.couldNotLoadAppointments' => '无法加载预约',
			'home.noUpcoming' => '没有即将到来的预约',
			'home.bookFirst' => '预约您的第一次就诊',
			'home.findADoctor' => '查找医生',
			'home.myWaitlist' => '我的候诊队列',
			'home.leaveWaitlist' => '退出',
			'home.statsThisMonth' => '本月',
			'home.statsPatients' => '患者',
			'home.statsAcceptRate' => '接受率',
			'home.statsPending' => '待处理',
			'home.schedule' => '日程',
			'appointments.title' => '预约',
			'appointments.myTitle' => '我的预约',
			'appointments.tabPending' => '待处理',
			'appointments.tabAll' => '全部',
			'appointments.tabUpcoming' => '即将到来',
			'appointments.tabPast' => '已过去',
			'appointments.noPendingRequests' => '没有待处理的请求',
			'appointments.newRequestsAppear' => '新的预约请求将显示在此处',
			'appointments.noAppointments' => '没有预约',
			'appointments.appointmentsAppear' => '您的预约将显示在此处',
			'appointments.noUpcoming' => '没有即将到来的预约',
			'appointments.bookFirst' => '预约您的第一次就诊',
			'appointments.noPast' => '没有过去的预约',
			'appointments.pastAppear' => '已完成和已取消的预约显示在此处',
			'appointments.couldNotLoad' => '无法加载预约',
			'appointments.detailTitle' => '预约',
			'appointments.patient' => '患者',
			'appointments.doctor' => '医生',
			'appointments.workplace' => '工作地点',
			'appointments.dateTime' => '日期和时间',
			'appointments.reason' => '原因',
			'appointments.doctorNotes' => '医生备注',
			'appointments.cancelTitle' => '取消预约',
			'appointments.cancelConfirm' => '您确定要取消此预约吗？',
			'appointments.cancelAction' => '取消预约',
			'appointments.bookedTitle' => '已预约！',
			'appointments.bookedMessage' => '您的预约请求已发送。',
			'appointments.reschedule' => '改期',
			'appointments.rescheduleTitle' => '改期预约',
			'appointments.reviewTitle' => '发表评价',
			'appointments.reviewRating' => '评分',
			'appointments.reviewComment' => '留言（可选）',
			'appointments.reviewSubmit' => '提交',
			'appointments.markCompleted' => '标记为已完成',
			'appointments.rescheduledSuccess' => '预约已成功改期。',
			'appointments.reviewSubmitted' => '评价已提交，谢谢！',
			'appointments.yourReview' => '您的评价',
			'appointments.editReviewTitle' => '编辑评价',
			'appointments.reviewUpdated' => '评价已更新。',
			'appointments.deleteReviewTitle' => '删除评价',
			'appointments.deleteReviewConfirm' => '确定要删除您的评价吗？',
			'appointments.reviewDeleted' => '评价已删除。',
			'appointments.requestReschedule' => '请求改期',
			'appointments.requestRescheduleTitle' => '请求改期',
			'appointments.requestRescheduleConfirm' => '请患者选择新的时间？该预约将被标记为需要改期。',
			'appointments.requestRescheduleSuccess' => '已请求改期，将通知患者。',
			'appointments.rescheduleNeededHint' => '医生请您选择新的时间。',
			'appointments.markNoShow' => '标记未到诊',
			'appointments.markNoShowTitle' => '标记为未到诊',
			'appointments.markNoShowConfirm' => '将此预约标记为未到诊？这将记录患者未到。',
			'booking.bookWith' => ({required Object name}) => '预约 — ${name}',
			'booking.selectWorkplace' => '选择工作地点',
			'booking.pickDate' => '选择日期',
			'booking.slotsAppear' => '可用时间段将显示在此处',
			'booking.couldNotLoadSlots' => '无法加载时间段',
			'booking.noAvailableSlots' => '没有可用时间段',
			'booking.noOpenSlots' => '该日期没有空闲时间段，请尝试其他日期。',
			'booking.confirmTitle' => '确认预约',
			'booking.reasonForVisit' => '就诊原因（可选）',
			'booking.confirmButton' => '确认预约',
			'booking.doctorLabel' => '医生',
			'booking.workplaceLabel' => '工作地点',
			'booking.addressLabel' => '地址',
			'booking.startLabel' => '开始',
			'booking.endLabel' => '结束',
			'booking.tryDifferentDate' => '请换个日期试试',
			'doctorSearch.title' => '查找医生',
			'doctorSearch.searchByName' => '按姓名搜索...',
			'doctorSearch.city' => '城市',
			'doctorSearch.search' => '搜索',
			'doctorSearch.noDoctorsFound' => '未找到医生',
			'doctorSearch.adjustSearch' => '请尝试调整搜索或筛选条件',
			'doctorSearch.couldNotLoadDoctors' => '无法加载医生',
			'doctorSearch.loadMore' => '加载更多',
			'doctorSearch.spec.general' => '全科',
			'doctorSearch.spec.cardiology' => '心脏科',
			'doctorSearch.spec.dermatology' => '皮肤科',
			'doctorSearch.spec.neurology' => '神经科',
			'doctorSearch.spec.orthopedics' => '骨科',
			'doctorSearch.spec.pediatrics' => '儿科',
			'doctorSearch.spec.psychiatry' => '精神科',
			'doctorSearch.spec.gynecology' => '妇科',
			'doctorSearch.spec.urology' => '泌尿科',
			'doctorSearch.spec.ophthalmology' => '眼科',
			'doctorSearch.spec.ent' => '耳鼻喉科',
			'doctorSearch.noAvailability' => '暂无时间',
			'doctorSearch.availableToday' => '今天可约',
			'doctorSearch.availableTomorrow' => '明天可约',
			'doctorSearch.availableOn' => ({required Object date}) => '${date} 可约',
			'doctorSearch.sortBy' => '排序',
			'doctorSearch.sortDefault' => '默认',
			'doctorSearch.sortRating' => '评分最高',
			'doctorSearch.sortPriceLow' => '价格最低',
			'doctorSearch.sortName' => '姓名 (A–Z)',
			'doctorSearch.sortNearestSlot' => '最早可约',
			'doctorSearch.sortDistance' => '距离最近',
			'doctorSearch.locationDenied' => '按距离排序需要位置权限。请在设置中允许，或改用城市筛选。',
			'doctorSearch.locationUnavailable' => '无法获取您的位置。请检查定位服务是否开启，或改用城市筛选。',
			'doctorSearch.distanceKm' => ({required Object km}) => '${km} 公里',
			'doctorDetail.profileTitle' => '医生资料',
			'doctorDetail.couldNotLoadProfile' => '无法加载资料',
			'doctorDetail.about' => '简介',
			'doctorDetail.workplaces' => '工作地点',
			'doctorDetail.minPerSlot' => ({required Object min}) => '每个时段 ${min} 分钟',
			'doctorDetail.bookAppointment' => '预约就诊',
			'doctorDetail.consultationFee' => '挂号费',
			'doctorDetail.reviews' => '评价',
			'doctorDetail.reviewsCount' => ({required Object count}) => '${count} 条评价',
			'doctorDetail.joinWaitlist' => '加入候补',
			'doctorDetail.leaveWaitlist' => '退出候补',
			'profile.title' => '个人资料',
			'profile.changePassword' => '更改密码',
			'profile.currentPassword' => '当前密码',
			'profile.newPassword' => '新密码',
			'profile.confirmNewPassword' => '确认新密码',
			'profile.firstName' => '名字',
			'profile.lastName' => '姓氏',
			'profile.phone' => '电话',
			'profile.failedToSave' => '保存个人资料失败。',
			'profile.professionalInfo' => '职业信息',
			'profile.bio' => '简介',
			'profile.bioHint' => '简短介绍您的经验',
			'profile.consultationFee' => '挂号费',
			'profile.medicalInfo' => '医疗信息',
			'profile.allergies' => '过敏史',
			'profile.allergiesHint' => '如：青霉素、花生',
			'profile.chronicConditions' => '慢性病史',
			'profile.chronicConditionsHint' => '如：糖尿病、高血压',
			'profile.medications' => '当前用药',
			'profile.medicationsHint' => '如：二甲双胍500mg',
			'profile.appointmentLength' => '预约时长',
			'profile.cancellationWindow' => '取消时限',
			'profile.cancellationWindowHint' => '患者可在预约前多久取消或改期。',
			'profile.hoursValue' => ({required Object h}) => '${h} 小时',
			'notifications.title' => '通知',
			'notifications.noNotifications' => '没有通知',
			'notifications.allCaughtUp' => '您已查看全部',
			'notifications.couldNotLoad' => '无法加载通知',
			'notifications.markAllRead' => '全部标为已读',
			'notifications.settingsTitle' => '通知设置',
			'notifications.pushEnabled' => '推送通知',
			'notifications.pushEnabledSubtitle' => '在此设备上接收预约和更新提醒',
			'notifications.emailEnabled' => '邮件通知',
			'notifications.emailEnabledSubtitle' => '更新将发送到您的邮箱',
			'workplaces.title' => '我的工作地点',
			'workplaces.noWorkplacesYet' => '暂无工作地点',
			'workplaces.tapToAdd' => '点击 + 添加您的第一个工作地点',
			'workplaces.couldNotLoad' => '无法加载工作地点',
			'workplaces.deleteTitle' => '删除工作地点',
			'workplaces.deleteConfirm' => ({required Object name}) => '删除“${name}”？',
			'workplaces.cannotDelete' => '无法删除工作地点',
			'workplaces.workingHours' => '工作时间',
			'workplaces.setAsPrimary' => '设为主要',
			'addWorkplace.addTitle' => '添加工作地点',
			'addWorkplace.editTitle' => '编辑工作地点',
			'addWorkplace.name' => '名称',
			'addWorkplace.address' => '街道地址',
			'addWorkplace.city' => '城市',
			'addWorkplace.type' => '类型',
			'addWorkplace.clinic' => '诊所',
			'addWorkplace.hospital' => '医院',
			'addWorkplace.privatePractice' => '私人诊所',
			'addWorkplace.failedToSave' => '保存工作地点失败。',
			'addWorkplace.addButton' => '添加工作地点',
			'addWorkplace.saveChanges' => '保存更改',
			'addWorkplace.pickOnMap' => '在地图上选择',
			'addWorkplace.mapPickerTitle' => '选择位置',
			'addWorkplace.useMyLocation' => '使用我的位置',
			'addWorkplace.confirmLocation' => '确认位置',
			'addWorkplace.locationSet' => '已从地图设置位置 ✓',
			'addWorkplace.locationPermissionDenied' => '需要定位权限才能使用您的当前位置。您仍可以手动移动地图。',
			'addWorkplace.locationUnavailable' => '无法获取您的位置。您仍可以手动移动地图。',
			'workingHours.title' => '工作时间',
			'workingHours.sectionHint' => '设置患者可以在此地点预约您的工作日和时间。',
			'workingHours.invalidRange' => '每个启用的工作日，结束时间必须晚于开始时间。',
			'workingHours.saved' => '工作时间已保存',
			'workingHours.failedToSave' => '保存工作时间失败',
			'workingHours.days.monday' => '星期一',
			'workingHours.days.tuesday' => '星期二',
			'workingHours.days.wednesday' => '星期三',
			'workingHours.days.thursday' => '星期四',
			'workingHours.days.friday' => '星期五',
			'workingHours.days.saturday' => '星期六',
			'workingHours.days.sunday' => '星期日',
			'blockTime.title' => '屏蔽时间',
			'blockTime.dateRange' => '日期范围',
			'blockTime.tapToSelect' => '点击选择日期',
			'blockTime.reason' => '原因（可选）',
			'blockTime.notifyPatients' => '通知受影响的患者',
			'blockTime.notifyDesc' => '向此期间有预约的患者发送通知',
			'blockTime.selectDateRange' => '请选择日期范围。',
			'blockTime.failedToBlock' => '屏蔽时间失败，请重试。',
			'blockTime.blockButton' => '屏蔽时段',
			'onboarding.title' => '完善您的资料',
			'onboarding.professionalInfo' => '专业信息',
			'onboarding.tellPatients' => '向患者介绍您的诊疗。',
			'onboarding.specialization' => '专业',
			'onboarding.selectSpecialization' => '选择您的专业',
			'onboarding.couldNotLoadSpecs' => '无法加载专业，请返回重试。',
			'onboarding.licenseNumber' => '执照编号',
			'onboarding.licenseHint' => '例如 AZ-123456',
			'onboarding.bio' => '简介（可选）',
			'onboarding.bioHint' => '患者将在您的资料中看到的简短介绍。',
			'onboarding.appointmentLength' => '预约时长',
			'onboarding.slotQuestion' => '单个预约时段有多长？',
			'onboarding.changeLater' => '稍后可在个人资料中更改。',
			'onboarding.minutes' => ({required Object min}) => '${min} 分钟',
			'onboarding.verificationDoc' => '验证文件',
			'onboarding.uploadDiploma' => '上传您的医学文凭或执照。管理员将在您的账户验证前进行审核。',
			'onboarding.tapToChoose' => '点击选择文件',
			'onboarding.tapToReplace' => '点击替换',
			'onboarding.anyFileType' => '任何文件类型，最大 10 MB',
			'onboarding.selectSpecError' => '请选择您的专业。',
			'onboarding.licenseError' => '请输入您的执照编号。',
			'onboarding.diplomaError' => '请附上您的文凭。',
			'onboarding.checkDetails' => '请检查您的信息并重试。',
			'onboarding.continueButton' => '继续',
			'onboarding.finish' => '完成',
			'pendingVerification.title' => '等待验证',
			'pendingVerification.message' => '您的账户正在审核中。验证通过后我们会通知您。',
			'pendingVerification.checkStatus' => '检查状态',
			'pendingVerification.stillPending' => '仍在审核中。验证通过后我们会通知您。',
			'phoneField.label' => '电话号码',
			'phoneField.labelOptional' => '电话号码（可选）',
			'phoneField.selectCountry' => '选择国家',
			'phoneField.searchCountry' => '搜索国家或区号…',
			'phoneField.noCountriesFound' => '未找到国家',
			'locations.pickCity' => '选择城市',
			'locations.searchHint' => '搜索城市或地区…',
			'locations.noResultsFound' => '未找到城市',
			'locations.couldNotLoad' => '无法加载城市列表，点击重试。',
			'locations.allCities' => '所有城市',
			'splash.tagline' => '让健康更简单',
			'appIntro.page1Title' => '找到合适的医生',
			'appIntro.page1Subtitle' => '按专科、城市和评分搜索，预约适合您的时间。',
			'appIntro.page2Title' => '咨询 AI 健康助手',
			'appIntro.page2Subtitle' => '描述您的症状，随时了解应该看哪位专科医生。',
			'appIntro.page3Title' => '一个应用，管理一切',
			'appIntro.page3Subtitle' => '管理预约、跟踪就诊记录，并使用您熟悉的语言安全地使用本应用。',
			'appIntro.skip' => '跳过',
			'appIntro.next' => '下一步',
			'appIntro.getStarted' => '开始使用',
			'agenda.title' => '日程',
			'agenda.today' => '今天',
			'agenda.empty' => '没有预约',
			'agenda.emptySubtitle' => '这一天没有安排',
			'favorites.title' => '收藏',
			'favorites.empty' => '还没有收藏',
			'favorites.emptySubtitle' => '点击医生上的爱心以收藏',
			'favorites.add' => '加入收藏',
			'favorites.remove' => '取消收藏',
			'assistant.title' => 'AI 助手',
			'assistant.newChat' => '新对话',
			'assistant.empty' => '暂无对话',
			'assistant.emptySubtitle' => '描述您的症状，助手会建议您应就诊哪科医生',
			'assistant.couldNotLoad' => '无法加载对话列表',
			'assistant.couldNotLoadChat' => '无法加载该对话',
			'assistant.newConversation' => '新对话',
			'assistant.deleteTitle' => '删除对话？',
			'assistant.deleteConfirm' => '该对话及其所有消息将被删除。',
			'assistant.inputHint' => '请描述您的症状…',
			'assistant.send' => '发送',
			'assistant.sendFailed' => '消息发送失败，请重试。',
			'assistant.typing' => '助手正在输入…',
			'assistant.startTitle' => '有什么可以帮您？',
			'assistant.startSubtitle' => '请先描述让您不适的症状',
			'assistant.book' => '预约',
			'assistant.reportTooltip' => '举报此回复',
			'assistant.reportTitle' => '举报回复',
			'assistant.reportHint' => '原因（可选）',
			'assistant.reportSubmit' => '举报',
			'assistant.reportSuccess' => '感谢反馈，该回复已被举报。',
			'assistant.reportFailed' => '无法举报该回复，请重试。',
			'assistant.topicsTooltip' => '主题',
			'assistant.topicsSheetTitle' => '选择一个主题',
			'messaging.title' => '消息',
			'messaging.sendMessage' => '发消息',
			'messaging.typeMessage' => '输入消息…',
			'messaging.send' => '发送',
			'messaging.empty' => '暂无对话',
			'messaging.emptySubtitle' => '您的消息记录将显示在这里。',
			'messaging.disclaimer' => '这不是紧急联系渠道，如遇紧急情况请拨打急救电话。',
			'messaging.noSharedHistory' => '只有与该医生有共同的预约记录后，才能给对方发消息。',
			'messaging.newMessage' => '您有一条新消息',
			'legal.title' => '隐私与条款',
			'legal.controllerNotice' => 'Medalize 由 [Fərdi Sahibkar adı — VÖEN: XXXXXXXXXXXX]（阿塞拜疆,"我们"）运营。最后更新：2026年7月。',
			'legal.privacyTitle' => '隐私政策',
			'legal.privacyIntro' => '本政策说明 Medalize 收集哪些个人数据、原因以及如何保护这些数据。预约和管理医疗就诊必然涉及您的健康信息，下面将详细说明。',
			'legal.sections.identity.title' => '身份数据',
			'legal.sections.identity.body' => '姓名、电子邮箱、电话号码（可选）、您的密码（以不可逆的哈希形式存储，绝不以明文存储）以及您偏好的应用语言。',
			'legal.sections.health.title' => '健康数据',
			'legal.sections.health.body' => '作为患者：血型、过敏史、慢性病、正在服用的药物、预约时填写的就诊原因、您上传的医疗文件（化验结果、影像资料、其他记录）、为您开具的处方，以及您与医生的聊天内容。如果您使用 AI 症状检查助手，您的问题和它的回复也会以同样方式处理。根据阿塞拜疆法律，健康数据受到最高级别的保护，我们仅在获得您单独、明确的同意后才会收集（见下方"法律依据"）。',
			'legal.sections.professional.title' => '专业数据（医生）',
			'legal.sections.professional.body' => '医学专业方向、执照号码、文凭或其他验证文件、工作地点信息以及问诊费用。在您的资料对患者可见之前，这些信息会由我们的团队审核。',
			'legal.sections.location.title' => '位置信息',
			'legal.sections.location.body' => '经您许可后获取大致或精确位置，以便按距离为您排序医生。仅在应用打开期间使用——绝不会存储在我们的服务器上。',
			'legal.sections.device.title' => '设备与技术数据',
			'legal.sections.device.body' => '设备标识符和会话信息，以便您可以在"设置"中查看并撤销当前登录的设备，以及用于向您的设备推送预约提醒和消息的推送通知令牌。',
			'legal.sections.payment.title' => '支付数据',
			'legal.sections.payment.body' => '如果您在应用内为问诊付款，付款将完全由我们的支付合作伙伴 Payriff 处理——我们绝不会看到或存储您的银行卡号。我们仅保留付款金额、状态以及用于您预约历史记录的参考编号。',
			'legal.sections.family.title' => '家庭成员档案',
			'legal.sections.family.body' => '如果您管理某位没有自己账号的家庭成员（子女或受抚养人）的档案，上述相同类别的健康数据可能会在您的账号下为其记录。添加家庭成员即表示您确认自己是其父母、监护人，或以其他方式获得授权代其管理健康信息。',
			'legal.sections.purposes.title' => '我们为何使用您的数据',
			'legal.sections.purposes.body' => '使您能够找到医生并预约；使医生能够管理日程和患者；发送预约提醒和更新；处理问诊付款；提供可选的 AI 症状检查功能；以及保障您账号的安全。',
			'legal.sections.legalBasis.title' => '法律依据与您的同意',
			'legal.sections.legalBasis.body' => '我们基于您注册时给予的同意处理您的数据。根据阿塞拜疆共和国《个人数据法》（第998-IIIQ号），健康数据属于特殊类别的个人数据，在收集前需要您明确的书面同意——注册界面上的复选框正是记录这一同意。您可以随时通过删除账号撤回同意，但在法律要求的情况下（例如出于税务目的的财务记录），我们可能会保留有限的记录。',
			'legal.sections.thirdParties.title' => '还有谁会处理您的数据',
			'legal.sections.thirdParties.body' => '仅按照我们的指示、为此处所述目的行事的可信服务提供商：Cloudinary（安全文件存储——文档和照片绝不公开可访问，仅通过有时效的签名链接访问）；Firebase/Google（推送通知，以及您选择使用的 Google 登录）；Apple（您选择使用的 Apple 登录）；Payriff（应用内支付）。我们不会出售您的个人数据。',
			'legal.sections.retention.title' => '我们保留数据多长时间',
			'legal.sections.retention.body' => '只要您的账号处于活跃状态。如果您删除账号，我们会在合理期限内删除您的个人数据，但法律要求保留的记录除外（例如出于税务目的的付款记录）。',
			'legal.sections.rights.title' => '您的权利',
			'legal.sections.rights.body' => '您可以访问我们持有的关于您的数据，要求更正不准确的数据，要求删除您的账号和数据，并可随时撤回同意。其中大部分可直接在"个人资料">"设置"中完成；其他事项请通过下方联系方式与我们联系。',
			'legal.sections.security.title' => '我们如何保护您的数据',
			'legal.sections.security.body' => '您与医生之间的消息以及与 AI 助手的对话均经过加密。上传的文档和照片以私密方式存储，仅可通过安全的签名链接访问，绝不会作为公开文件存在。密码绝不会以可读形式存储。',
			'legal.sections.permissions.title' => '我们请求的权限',
			'legal.sections.permissions.body' => '相机和照片图库——用于设置头像和上传医疗文件。位置——用于按距离为您排序医生。通知——用于推送预约提醒和消息。生物识别（面容 ID / 指纹）——一种可选的、更快捷的应用解锁方式；您的生物识别数据绝不会离开您的设备，我们仅会收到设备操作系统返回的"是/否"确认。',
			'legal.sections.children.title' => '年龄要求',
			'legal.sections.children.body' => 'Medalize 账号面向成年人。如果您未满18岁，请让父母或监护人使用家庭成员档案功能代您创建和管理账号。',
			'legal.termsTitle' => '服务条款',
			'legal.termsIntro' => '创建账号即表示您同意以下内容。',
			'legal.termsBody' => '提供关于您自己的准确信息。仅将 Medalize 用于查找、预约和管理医疗就诊。对您的登录凭证保密。Medalize 将您与独立的、持证的医疗专业人员联系起来——我们自身并非医疗机构，AI 症状检查助手也不能替代专业医疗诊断或建议。如遇医疗紧急情况，请直接联系急救服务，而非使用本应用。对于违反本条款或滥用平台的账号，我们可能会暂停或终止其使用。',
			'legal.contact' => '对您的数据有疑问？请联系 support@medalize.app',
			'legal.consentPrefix' => '我已阅读并同意',
			'legal.consentPrivacyLink' => '隐私政策',
			'legal.consentMiddle' => '和',
			'legal.consentTermsLink' => '服务条款',
			'legal.consentSuffix' => '，并明确同意按其中所述处理我的健康数据。',
			'legal.viewAsPdf' => '查看 PDF',
			'legal.pdfDocumentTitle' => 'Medalize — 隐私政策与服务条款',
			'legal.pdfLoadError' => '无法加载文档。请检查您的网络连接后重试。',
			'medications.title' => '用药',
			'medications.editMedication' => '编辑药物',
			'medications.name' => '名称',
			'medications.dosage' => '剂量',
			'medications.notes' => '备注',
			'medications.form' => '剂型',
			'medications.formPill' => '药片',
			'medications.formCapsule' => '胶囊',
			'medications.formLiquid' => '液体',
			'medications.formInjection' => '注射剂',
			'medications.formOther' => '其他',
			'medications.schedule' => '服药安排',
			'medications.times' => '服药时间',
			'medications.addTime' => '添加时间',
			'medications.daysOfWeek' => '星期',
			'medications.everyDay' => '每天',
			'medications.startDate' => '开始日期',
			'medications.endDate' => '结束日期',
			_ => null,
		} ?? switch (path) {
			'medications.save' => '保存',
			'medications.delete' => '删除',
			'medications.deleteConfirmTitle' => '删除药物',
			'medications.deleteConfirmBody' => '确定要删除这个药物吗?服药记录将被保留。',
			'medications.emptyTitle' => '暂无药物',
			'medications.emptySubtitle' => '医生开具的药物将在就诊后显示在这里。',
			'medications.todaysDoses' => '今日服药',
			'medications.markTaken' => '已服用',
			'medications.markSkipped' => '跳过',
			'medications.statusTaken' => '已服用',
			'medications.statusSkipped' => '已跳过',
			'medications.statusPending' => '待服用',
			'medications.reminderTitle' => ({required Object name}) => '该服用${name}了',
			'medications.reminderBody' => ({required Object dosage}) => '剂量:${dosage}',
			'medications.tabActive' => '使用中',
			'medications.tabArchive' => '已归档',
			'medications.fromPrescription' => '来自处方',
			'medications.noSchedule' => '尚未设置服药时间 — 点击添加提醒时间',
			'medications.dayMon' => '周一',
			'medications.dayTue' => '周二',
			'medications.dayWed' => '周三',
			'medications.dayThu' => '周四',
			'medications.dayFri' => '周五',
			'medications.daySat' => '周六',
			'medications.daySun' => '周日',
			'medications.updatedSuccess' => '药物已更新。',
			'medications.deletedSuccess' => '药物已删除。',
			'medications.atLeastOneTime' => '请至少添加一个提醒时间',
			'prescriptions.title' => '处方',
			'prescriptions.writeTitle' => '开具处方',
			'prescriptions.addDrug' => '添加药物',
			'prescriptions.drugName' => '药物名称',
			'prescriptions.dosage' => '剂量',
			'prescriptions.frequency' => '服用频率',
			'prescriptions.duration' => '疗程',
			'prescriptions.instructions' => '用药说明',
			'prescriptions.notes' => '备注',
			'prescriptions.save' => '保存',
			'prescriptions.empty' => '暂无处方',
			'prescriptions.emptySubtitle' => '医生开具的处方将显示在这里。',
			'prescriptions.viewDetails' => '查看详情',
			'prescriptions.issuedBy' => ({required Object name}) => '由 ${name} 医生开具',
			'prescriptions.issuedOn' => ({required Object date}) => '开具日期:${date}',
			'prescriptions.applyToMedications' => '添加到我的用药',
			'prescriptions.applySuccess' => '已添加到您的用药。请设置提醒时间以接收通知。',
			'prescriptions.alreadyApplied' => '已添加到您的用药',
			'prescriptions.noPrescriptionYet' => '此预约尚无处方',
			'prescriptions.writePrescription' => '开具处方',
			'prescriptions.prescriptionIssued' => '处方已开具。',
			'prescriptions.removeDrug' => '移除',
			'prescriptions.atLeastOneDrug' => '请至少添加一种药物',
			'prescriptions.drugNameRequired' => '请填写药物名称',
			'prescriptions.summaryTitle' => '处方',
			'prescriptions.itemsCount' => ({required Object count}) => '${count} 种药物',
			'prescriptions.newPrescription' => '新处方',
			'prescriptions.youHavePrescription' => '此预约已有处方',
			'records.title' => '健康档案',
			'records.upload' => '上传文件',
			'records.recordType' => '文件类型',
			'records.typeLabResult' => '化验结果',
			'records.typeImaging' => '影像检查',
			'records.typeDocument' => '文档',
			'records.typeOther' => '其他',
			'records.recordTitle' => '标题',
			'records.recordDate' => '日期',
			'records.notes' => '备注',
			'records.chooseFile' => '选择文件',
			'records.changeFile' => '更换文件',
			'records.noFileChosen' => '未选择文件',
			'records.save' => '保存',
			'records.delete' => '删除',
			'records.deleteConfirmTitle' => '删除档案',
			'records.deleteConfirmBody' => '确定要删除这份档案吗?此操作无法撤销。',
			'records.empty' => '暂无健康档案',
			'records.emptySubtitle' => '将化验结果、影像检查和其他文档集中保存在这里。',
			'records.view' => '查看',
			'records.fileRequired' => '请选择要上传的文件',
			'records.fileTooLarge' => '文件过大（最大 15 MB）',
			'records.titleRequired' => '请填写标题',
			'records.uploadSuccess' => '文件已上传。',
			'records.deletedSuccess' => '文件已删除。',
			'records.couldNotOpen' => '无法打开文件',
			'payments.title' => '支付',
			'payments.amount' => '金额',
			'payments.payNow' => '立即支付',
			'payments.payLater' => '稍后支付',
			'payments.statusPending' => '待支付',
			'payments.statusPaid' => '已支付',
			'payments.statusFailed' => '支付失败',
			'payments.statusCancelled' => '已取消',
			'payments.paymentConfirmed' => '支付已确认，谢谢！',
			'payments.openingBrowser' => '正在打开浏览器…',
			'payments.checkStatus' => '查看状态',
			'family.title' => '家庭成员',
			'family.myself' => '本人',
			'family.addFamilyMember' => '添加家庭成员',
			'family.editFamilyMember' => '编辑家庭成员',
			'family.firstName' => '名',
			'family.lastName' => '姓',
			'family.relationship' => '关系',
			'family.relationshipChild' => '子女',
			'family.relationshipSpouse' => '配偶',
			'family.relationshipParent' => '父母',
			'family.relationshipSibling' => '兄弟姐妹',
			'family.relationshipOther' => '其他',
			'family.dateOfBirth' => '出生日期',
			'family.bloodType' => '血型',
			'family.allergies' => '过敏史',
			'family.chronicConditions' => '慢性病史',
			'family.medications' => '当前用药',
			'family.save' => '保存',
			'family.delete' => '删除',
			'family.deleteConfirmTitle' => '删除家庭成员',
			'family.deleteConfirmBody' => '确定要删除这位家庭成员吗?其预约、用药和档案记录将被保留。',
			'family.empty' => '暂无家庭成员',
			'family.emptySubtitle' => '添加子女、配偶或其他家庭成员，以管理他们的预约、用药和健康档案。',
			'family.bookingForQuestion' => '这次预约是为谁安排的？',
			'family.bookingForLabel' => ({required Object name}) => '预约对象：${name}',
			'family.forLabel' => ({required Object name}) => '${name} 的',
			'family.ageYears' => ({required Object age}) => '${age} 岁',
			'family.bookedByLabel' => ({required Object name}) => '预约人：${name}',
			_ => null,
		};
	}
}
