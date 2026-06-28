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
	@override late final _Translations$splash$zh splash = _Translations$splash$zh._(_root);
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
	@override String get requestReschedule => '请求改期';
	@override String get requestRescheduleTitle => '请求改期';
	@override String get requestRescheduleConfirm => '请患者选择新的时间？该预约将被标记为需要改期。';
	@override String get requestRescheduleSuccess => '已请求改期，将通知患者。';
	@override String get rescheduleNeededHint => '医生请您选择新的时间。';
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
	@override String get address => '地址';
	@override String get city => '城市';
	@override String get type => '类型';
	@override String get clinic => '诊所';
	@override String get hospital => '医院';
	@override String get privatePractice => '私人诊所';
	@override String get failedToSave => '保存工作地点失败。';
	@override String get addButton => '添加工作地点';
	@override String get saveChanges => '保存更改';
}

// Path: workingHours
class _Translations$workingHours$zh extends Translations$workingHours$en {
	_Translations$workingHours$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '工作时间';
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

// Path: splash
class _Translations$splash$zh extends Translations$splash$en {
	_Translations$splash$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get tagline => '让健康更简单';
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
			'status.confirmed' => '已确认',
			'status.pending' => '待处理',
			'status.cancelled' => '已取消',
			'status.declined' => '已拒绝',
			'status.requiresRescheduling' => '需要改期',
			'status.completed' => '已完成',
			'home.helloDoctor' => ({required Object name}) => '您好，${name} 医生！',
			'home.helloPatient' => ({required Object name}) => '您好，${name}！',
			'home.doctorSubtitle' => '管理您的日程\n和预约。',
			'home.patientSubtitle' => '查找医生并\n预约就诊。',
			'home.pendingRequests' => '待处理请求',
			'home.upcoming' => '即将到来',
			'home.findDoctor' => '查找医生',
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
			'appointments.requestReschedule' => '请求改期',
			'appointments.requestRescheduleTitle' => '请求改期',
			'appointments.requestRescheduleConfirm' => '请患者选择新的时间？该预约将被标记为需要改期。',
			'appointments.requestRescheduleSuccess' => '已请求改期，将通知患者。',
			'appointments.rescheduleNeededHint' => '医生请您选择新的时间。',
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
			'doctorDetail.profileTitle' => '医生资料',
			'doctorDetail.couldNotLoadProfile' => '无法加载资料',
			'doctorDetail.about' => '简介',
			'doctorDetail.workplaces' => '工作地点',
			'doctorDetail.minPerSlot' => ({required Object min}) => '每个时段 ${min} 分钟',
			'doctorDetail.bookAppointment' => '预约就诊',
			'doctorDetail.consultationFee' => '挂号费',
			'doctorDetail.reviews' => '评价',
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
			'notifications.title' => '通知',
			'notifications.noNotifications' => '没有通知',
			'notifications.allCaughtUp' => '您已查看全部',
			'notifications.couldNotLoad' => '无法加载通知',
			'notifications.markAllRead' => '全部标为已读',
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
			'addWorkplace.address' => '地址',
			'addWorkplace.city' => '城市',
			'addWorkplace.type' => '类型',
			'addWorkplace.clinic' => '诊所',
			'addWorkplace.hospital' => '医院',
			'addWorkplace.privatePractice' => '私人诊所',
			'addWorkplace.failedToSave' => '保存工作地点失败。',
			'addWorkplace.addButton' => '添加工作地点',
			'addWorkplace.saveChanges' => '保存更改',
			'workingHours.title' => '工作时间',
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
			'phoneField.label' => '电话号码',
			'phoneField.labelOptional' => '电话号码（可选）',
			'phoneField.selectCountry' => '选择国家',
			'phoneField.searchCountry' => '搜索国家或区号…',
			'phoneField.noCountriesFound' => '未找到国家',
			'splash.tagline' => '让健康更简单',
			_ => null,
		};
	}
}
