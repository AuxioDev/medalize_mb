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
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'Medalize';
	@override late final _Translations$common$fr common = _Translations$common$fr._(_root);
	@override late final _Translations$auth$fr auth = _Translations$auth$fr._(_root);
	@override late final _Translations$forgotPassword$fr forgotPassword = _Translations$forgotPassword$fr._(_root);
	@override late final _Translations$resetPassword$fr resetPassword = _Translations$resetPassword$fr._(_root);
	@override late final _Translations$validation$fr validation = _Translations$validation$fr._(_root);
	@override late final _Translations$errors$fr errors = _Translations$errors$fr._(_root);
	@override late final _Translations$settings$fr settings = _Translations$settings$fr._(_root);
	@override late final _Translations$security$fr security = _Translations$security$fr._(_root);
	@override late final _Translations$status$fr status = _Translations$status$fr._(_root);
	@override late final _Translations$home$fr home = _Translations$home$fr._(_root);
	@override late final _Translations$appointments$fr appointments = _Translations$appointments$fr._(_root);
	@override late final _Translations$booking$fr booking = _Translations$booking$fr._(_root);
	@override late final _Translations$doctorSearch$fr doctorSearch = _Translations$doctorSearch$fr._(_root);
	@override late final _Translations$doctorDetail$fr doctorDetail = _Translations$doctorDetail$fr._(_root);
	@override late final _Translations$profile$fr profile = _Translations$profile$fr._(_root);
	@override late final _Translations$notifications$fr notifications = _Translations$notifications$fr._(_root);
	@override late final _Translations$workplaces$fr workplaces = _Translations$workplaces$fr._(_root);
	@override late final _Translations$addWorkplace$fr addWorkplace = _Translations$addWorkplace$fr._(_root);
	@override late final _Translations$workingHours$fr workingHours = _Translations$workingHours$fr._(_root);
	@override late final _Translations$blockTime$fr blockTime = _Translations$blockTime$fr._(_root);
	@override late final _Translations$onboarding$fr onboarding = _Translations$onboarding$fr._(_root);
	@override late final _Translations$pendingVerification$fr pendingVerification = _Translations$pendingVerification$fr._(_root);
	@override late final _Translations$phoneField$fr phoneField = _Translations$phoneField$fr._(_root);
	@override late final _Translations$locations$fr locations = _Translations$locations$fr._(_root);
	@override late final _Translations$splash$fr splash = _Translations$splash$fr._(_root);
	@override late final _Translations$appIntro$fr appIntro = _Translations$appIntro$fr._(_root);
	@override late final _Translations$agenda$fr agenda = _Translations$agenda$fr._(_root);
	@override late final _Translations$favorites$fr favorites = _Translations$favorites$fr._(_root);
	@override late final _Translations$assistant$fr assistant = _Translations$assistant$fr._(_root);
	@override late final _Translations$messaging$fr messaging = _Translations$messaging$fr._(_root);
	@override late final _Translations$legal$fr legal = _Translations$legal$fr._(_root);
	@override late final _Translations$medications$fr medications = _Translations$medications$fr._(_root);
	@override late final _Translations$prescriptions$fr prescriptions = _Translations$prescriptions$fr._(_root);
	@override late final _Translations$records$fr records = _Translations$records$fr._(_root);
	@override late final _Translations$payments$fr payments = _Translations$payments$fr._(_root);
	@override late final _Translations$family$fr family = _Translations$family$fr._(_root);
	@override late final _Translations$subscription$fr subscription = _Translations$subscription$fr._(_root);
	@override late final _Translations$hospitalPicker$fr hospitalPicker = _Translations$hospitalPicker$fr._(_root);
	@override late final _Translations$hospitalRegistration$fr hospitalRegistration = _Translations$hospitalRegistration$fr._(_root);
	@override late final _Translations$hospitalHome$fr hospitalHome = _Translations$hospitalHome$fr._(_root);
	@override late final _Translations$hospitalDoctors$fr hospitalDoctors = _Translations$hospitalDoctors$fr._(_root);
	@override late final _Translations$hospitalInvite$fr hospitalInvite = _Translations$hospitalInvite$fr._(_root);
	@override late final _Translations$hospitalAppointments$fr hospitalAppointments = _Translations$hospitalAppointments$fr._(_root);
	@override late final _Translations$hospitalProfile$fr hospitalProfile = _Translations$hospitalProfile$fr._(_root);
	@override late final _Translations$hospitalDoctorHours$fr hospitalDoctorHours = _Translations$hospitalDoctorHours$fr._(_root);
	@override late final _Translations$doctorHospitals$fr doctorHospitals = _Translations$doctorHospitals$fr._(_root);
}

// Path: common
class _Translations$common$fr extends Translations$common$en {
	_Translations$common$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annuler';
	@override String get logout => 'Se déconnecter';
	@override String get doctor => 'Médecin';
	@override String get patient => 'Patient';
	@override String get save => 'Enregistrer';
	@override String get edit => 'Modifier';
	@override String get retry => 'Réessayer';
	@override String get back => 'Retour';
	@override String get ok => 'OK';
	@override String get delete => 'Supprimer';
	@override String get keep => 'Conserver';
	@override String get confirm => 'Confirmer';
	@override String get decline => 'Refuser';
	@override String get primary => 'Principal';
	@override String get somethingWrong => 'Une erreur s\'est produite';
	@override String get seeAll => 'Tout voir';
	@override String get signOut => 'Se déconnecter';
	@override String get search => 'Rechercher';
	@override String get tryAgain => 'Veuillez réessayer';
	@override String get required => 'Requis';
	@override String get noRatings => 'Pas encore de note';
	@override String get hospital => 'Hôpital';
}

// Path: auth
class _Translations$auth$fr extends Translations$auth$en {
	_Translations$auth$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get login => 'Se connecter';
	@override String get register => 'Créer un compte';
	@override String get signIn => 'Se connecter';
	@override String get signUp => 'S\'inscrire';
	@override String get email => 'E-mail';
	@override String get password => 'Mot de passe';
	@override String get confirmPassword => 'Confirmer le mot de passe';
	@override String get firstName => 'Prénom';
	@override String get lastName => 'Nom';
	@override String get rememberMe => 'Se souvenir de moi';
	@override String get forgotPassword => 'Mot de passe oublié ?';
	@override String get sendResetLink => 'Envoyer le code';
	@override String get noAccount => 'Vous n\'avez pas de compte ?';
	@override String get haveAccount => 'Vous avez déjà un compte ?';
	@override String get welcomeBack => 'Bon retour';
	@override String get signInToContinue => 'Connectez-vous à votre compte pour continuer';
	@override String get createYourAccount => 'Créez votre compte';
	@override String get joinMedalize => 'Rejoignez Medalize dès aujourd\'hui';
	@override String get iAmA => 'Je suis';
	@override String get emailHint => 'you@example.com';
	@override String get passwordHint => '••••••••';
	@override String get backToSignIn => 'Retour à la connexion';
	@override String get verificationCode => 'Code de vérification';
	@override String get continueWithGoogle => 'Continuer avec Google';
	@override String get continueWithApple => 'Continuer avec Apple';
	@override String get orDivider => 'ou';
}

// Path: forgotPassword
class _Translations$forgotPassword$fr extends Translations$forgotPassword$en {
	_Translations$forgotPassword$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mot de passe oublié ?';
	@override String get subtitle => 'Saisissez votre e-mail et nous vous enverrons un code de réinitialisation à 6 chiffres';
}

// Path: resetPassword
class _Translations$resetPassword$fr extends Translations$resetPassword$en {
	_Translations$resetPassword$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Réinitialiser le mot de passe';
	@override String get subtitle => 'Saisissez le code envoyé par e-mail et choisissez un nouveau mot de passe';
	@override String get button => 'Réinitialiser le mot de passe';
	@override String get success => 'Mot de passe réinitialisé. Veuillez vous connecter.';
}

// Path: validation
class _Translations$validation$fr extends Translations$validation$en {
	_Translations$validation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => 'L\'e-mail est requis';
	@override String get emailInvalid => 'Saisissez une adresse e-mail valide';
	@override String get passwordRequired => 'Le mot de passe est requis';
	@override String get passwordTooShort => '8 caractères minimum requis';
	@override String get passwordNeedsLetter => 'Incluez au moins une lettre';
	@override String get passwordNeedsDigit => 'Incluez au moins un chiffre';
	@override String get passwordMismatch => 'Les mots de passe ne correspondent pas';
	@override String get passwordConfirmRequired => 'Veuillez confirmer votre mot de passe';
	@override String get nameMinLength => '2 caractères minimum';
	@override String get roleRequired => 'Veuillez sélectionner un rôle';
	@override String get phoneRequired => 'Le numéro de téléphone est requis';
	@override String get phoneTooShort => 'Le numéro est trop court';
	@override String get phoneTooLong => 'Le numéro est trop long';
	@override String fieldRequired({required Object field}) => '${field} est requis';
	@override String fieldInvalid({required Object field}) => '${field} contient des caractères invalides';
}

// Path: errors
class _Translations$errors$fr extends Translations$errors$en {
	_Translations$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get network => 'Erreur réseau. Vérifiez votre connexion.';
	@override String get rateLimit => 'Trop de tentatives. Veuillez patienter et réessayer.';
	@override String rateLimitWithSeconds({required Object seconds}) => 'Trop de tentatives. Réessayez dans ${seconds} s.';
	@override String get invalidCredentials => 'E-mail ou mot de passe invalide';
	@override String get sessionExpired => 'Session expirée. Veuillez vous reconnecter.';
	@override String get authError => 'Erreur d\'authentification. Veuillez vous reconnecter.';
	@override String get sessionRevoked => 'Session révoquée. Veuillez vous reconnecter.';
	@override String get permissionDenied => 'Vous n\'avez pas la permission de faire cela.';
	@override String get validationError => 'Erreur de validation';
	@override String serverError({required Object code}) => 'Erreur serveur (${code}). Veuillez réessayer.';
	@override String get socialLoginFailed => 'Échec de la connexion. Réessayez ou utilisez votre e-mail et mot de passe.';
	@override String get conflict => 'Cette action ne peut pas être effectuée pour le moment.';
	@override String get onboardingIncomplete => 'Veuillez remplir tous les champs requis pour terminer l\'inscription.';
	@override String get planLimitReached => 'Vous avez atteint la limite de votre forfait. Passez à un forfait supérieur pour en ajouter davantage.';
	@override String get chatUnavailable => 'Ce médecin ne propose pas le chat avec son forfait actuel.';
}

// Path: settings
class _Translations$settings$fr extends Translations$settings$en {
	_Translations$settings$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paramètres';
	@override String get account => 'Compte';
	@override String get profile => 'Profil';
	@override String get notifications => 'Notifications';
	@override String get appearance => 'Apparence';
	@override String get themeSystem => 'Système';
	@override String get themeLight => 'Clair';
	@override String get themeDark => 'Sombre';
	@override String get language => 'Langue';
	@override String get languageSystem => 'Par défaut du système';
	@override String get logoutTitle => 'Déconnexion';
	@override String get logoutConfirm => 'Voulez-vous vraiment vous déconnecter ?';
	@override String get version => 'Medalize v1.0.0';
	@override String get legal => 'Confidentialité et conditions';
}

// Path: security
class _Translations$security$fr extends Translations$security$en {
	_Translations$security$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sécurité';
	@override String get biometricLogin => 'Connexion biométrique';
	@override String get biometricLoginSubtitle => 'Utilisez Face ID / Touch ID pour déverrouiller l\'application';
	@override String get biometricPrompt => 'Authentifiez-vous pour accéder à Medalize';
	@override String get biometricUnavailable => 'L\'authentification biométrique n\'est pas disponible sur cet appareil';
	@override String get biometricEnableFailed => 'Impossible de vérifier votre biométrie. Réessayez.';
	@override String get activeSessions => 'Sessions actives';
	@override String get activeSessionsSubtitle => 'Appareils actuellement connectés à votre compte';
	@override String get thisDevice => 'Cet appareil';
	@override String lastActive({required Object date}) => 'Dernière activité : ${date}';
	@override String get revoke => 'Révoquer';
	@override String get revokeConfirmTitle => 'Révoquer l\'appareil ?';
	@override String revokeConfirmMessage({required Object name}) => '${name} sera déconnecté. Il pourra se reconnecter avec vos identifiants.';
	@override String get revokeCurrentConfirmMessage => 'Il s\'agit de votre appareil actuel — le révoquer vous déconnectera immédiatement.';
	@override String get revokeFailed => 'Impossible de révoquer cet appareil. Réessayez.';
	@override String get signOutAllDevices => 'Déconnecter tous les appareils';
	@override String get signOutAllConfirmTitle => 'Se déconnecter partout ?';
	@override String get signOutAllConfirmMessage => 'Vous serez déconnecté sur tous les appareils, y compris celui-ci.';
	@override String get signOutAllFailed => 'Impossible de se déconnecter de tous les appareils. Réessayez.';
	@override String get noDevices => 'Aucune session active trouvée';
	@override String get loadFailed => 'Impossible de charger vos sessions actives';
	@override String get changeEmail => 'Changer l\'email';
	@override String get changeEmailSubtitle => 'Nous enverrons un code de vérification à votre nouvelle adresse email. Après confirmation, vous vous connecterez avec le nouvel email.';
	@override String get newEmailLabel => 'Nouvel email';
	@override String get sendCode => 'Envoyer le code';
	@override String codeSentTo({required Object email}) => 'Saisissez le code à 6 chiffres envoyé à ${email}';
	@override String get confirmNewEmail => 'Confirmer le nouvel email';
	@override String get changeEmailSuccess => 'Votre email a été modifié. Reconnectez-vous avec votre nouvel email.';
	@override String get dangerZone => 'Zone dangereuse';
	@override String get deactivateAccount => 'Désactiver le compte';
	@override String get deactivateAccountSubtitle => 'Désactiver votre compte sans supprimer vos données';
	@override String get deactivateConfirmTitle => 'Désactiver le compte ?';
	@override String get deactivateConfirmMessage => 'Votre compte sera désactivé et vous serez déconnecté sur tous les appareils. Vos données ne seront pas supprimées. Contactez le support pour le réactiver.';
	@override String get deactivate => 'Désactiver';
	@override String get deactivateSuccess => 'Votre compte a été désactivé.';
	@override String get deleteAccount => 'Supprimer définitivement le compte';
	@override String get deleteAccountSubtitle => 'Effacer vos données. Cette action est irréversible.';
	@override String get deleteConfirmTitle => 'Supprimer définitivement votre compte ?';
	@override String get deleteConfirmWarning => 'Cette action est définitive et ne peut pas être annulée.';
	@override String get deleteConfirmMessage => 'Votre profil, vos dossiers médicaux, vos ordonnances et vos messages seront définitivement effacés. Vos rendez-vous à venir seront annulés et remboursés le cas échéant. Les enregistrements de paiement sont conservés sous forme anonymisée à des fins comptables, comme l\'exige la loi.';
	@override String get deleteAccountSuccess => 'Votre compte a été définitivement supprimé.';
}

// Path: status
class _Translations$status$fr extends Translations$status$en {
	_Translations$status$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get confirmed => 'Confirmé';
	@override String get pending => 'En attente';
	@override String get cancelled => 'Annulé';
	@override String get declined => 'Refusé';
	@override String get requiresRescheduling => 'Replanification requise';
	@override String get completed => 'Terminé';
	@override String get noShow => 'Absent';
}

// Path: home
class _Translations$home$fr extends Translations$home$en {
	_Translations$home$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String helloDoctor({required Object name}) => 'Bonjour, Dr ${name} !';
	@override String helloPatient({required Object name}) => 'Bonjour, ${name} !';
	@override String get doctorSubtitle => 'Gérez votre agenda\net vos rendez-vous.';
	@override String get patientSubtitle => 'Trouvez un médecin et\nprenez rendez-vous.';
	@override String get pendingRequests => 'Demandes en attente';
	@override String get upcoming => 'À venir';
	@override String get findDoctor => 'Trouver un médecin';
	@override String get aiAssistant => 'Assistant IA';
	@override String get myAppointments => 'Mes rendez-vous';
	@override String get appointments => 'Rendez-vous';
	@override String get workplaces => 'Lieux de travail';
	@override String get blockTime => 'Bloquer du temps';
	@override String get profile => 'Profil';
	@override String get allCaughtUp => 'Tout est à jour';
	@override String get noPendingRequests => 'Aucune demande de rendez-vous en attente';
	@override String get couldNotLoadAppointments => 'Impossible de charger les rendez-vous';
	@override String get noUpcoming => 'Aucun rendez-vous à venir';
	@override String get bookFirst => 'Prenez votre premier rendez-vous avec un médecin';
	@override String get findADoctor => 'Trouver un médecin';
	@override String get myWaitlist => 'File d\'attente';
	@override String get leaveWaitlist => 'Quitter';
	@override String get statsThisMonth => 'Ce mois';
	@override String get statsPatients => 'Patients';
	@override String get statsAcceptRate => 'Taux accept.';
	@override String get statsPending => 'En attente';
	@override String get schedule => 'Planning';
}

// Path: appointments
class _Translations$appointments$fr extends Translations$appointments$en {
	_Translations$appointments$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rendez-vous';
	@override String get myTitle => 'Mes rendez-vous';
	@override String get tabPending => 'En attente';
	@override String get tabAll => 'Tous';
	@override String get tabUpcoming => 'À venir';
	@override String get tabPast => 'Passés';
	@override String get noPendingRequests => 'Aucune demande en attente';
	@override String get newRequestsAppear => 'Les nouvelles demandes de rendez-vous apparaîtront ici';
	@override String get noAppointments => 'Aucun rendez-vous';
	@override String get appointmentsAppear => 'Vos rendez-vous apparaîtront ici';
	@override String get noUpcoming => 'Aucun rendez-vous à venir';
	@override String get bookFirst => 'Prenez votre premier rendez-vous avec un médecin';
	@override String get noPast => 'Aucun rendez-vous passé';
	@override String get pastAppear => 'Les rendez-vous terminés et annulés apparaissent ici';
	@override String get couldNotLoad => 'Impossible de charger les rendez-vous';
	@override String get detailTitle => 'Rendez-vous';
	@override String get patient => 'Patient';
	@override String get doctor => 'Médecin';
	@override String get workplace => 'Lieu de travail';
	@override String get dateTime => 'Date et heure';
	@override String get reason => 'Motif';
	@override String get doctorNotes => 'Notes du médecin';
	@override String get cancelTitle => 'Annuler le rendez-vous';
	@override String get cancelConfirm => 'Voulez-vous vraiment annuler ce rendez-vous ?';
	@override String get cancelAction => 'Annuler le rendez-vous';
	@override String get cancelledSuccess => 'Rendez-vous annulé.';
	@override String get cancelledRefunded => 'Rendez-vous annulé. Votre paiement a été remboursé.';
	@override String get cancelledNoRefund => 'Rendez-vous annulé. Aucun remboursement n\'a été effectué car l\'annulation est trop proche de l\'heure du rendez-vous.';
	@override String get bookedTitle => 'Réservé !';
	@override String get bookedMessage => 'Votre demande de rendez-vous a été envoyée.';
	@override String get reschedule => 'Reporter';
	@override String get rescheduleTitle => 'Reporter le rendez-vous';
	@override String get reviewTitle => 'Laisser un avis';
	@override String get reviewRating => 'Note';
	@override String get reviewComment => 'Commentaire (optionnel)';
	@override String get reviewSubmit => 'Envoyer';
	@override String get markCompleted => 'Marquer comme terminé';
	@override String get rescheduledSuccess => 'Rendez-vous reporté avec succès.';
	@override String get reviewSubmitted => 'Avis envoyé. Merci !';
	@override String get yourReview => 'Votre avis';
	@override String get editReviewTitle => 'Modifier l\'avis';
	@override String get reviewUpdated => 'Avis mis à jour.';
	@override String get deleteReviewTitle => 'Supprimer l\'avis';
	@override String get deleteReviewConfirm => 'Voulez-vous vraiment supprimer votre avis ?';
	@override String get reviewDeleted => 'Avis supprimé.';
	@override String get requestReschedule => 'Demander un report';
	@override String get requestRescheduleTitle => 'Demander un report';
	@override String get requestRescheduleConfirm => 'Demander au patient de choisir un nouveau créneau ? Le rendez-vous sera marqué comme à reporter.';
	@override String get requestRescheduleSuccess => 'Report demandé. Le patient sera notifié.';
	@override String get rescheduleNeededHint => 'Le médecin vous a demandé de choisir un nouveau créneau.';
	@override String get markNoShow => 'Marquer absent';
	@override String get markNoShowTitle => 'Marquer comme absent';
	@override String get markNoShowConfirm => 'Marquer ce rendez-vous comme absent ? Cela enregistre que le patient ne s’est pas présenté.';
}

// Path: booking
class _Translations$booking$fr extends Translations$booking$en {
	_Translations$booking$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String bookWith({required Object name}) => 'Réserver — ${name}';
	@override String get selectWorkplace => 'Sélectionner un lieu';
	@override String get pickDate => 'Choisir une date';
	@override String get slotsAppear => 'Les créneaux disponibles apparaîtront ici';
	@override String get couldNotLoadSlots => 'Impossible de charger les créneaux';
	@override String get noAvailableSlots => 'Aucun créneau disponible';
	@override String get noOpenSlots => 'Aucun créneau libre pour cette date. Essayez un autre jour.';
	@override String get confirmTitle => 'Confirmer la réservation';
	@override String get reasonForVisit => 'Motif de la visite (facultatif)';
	@override String get confirmButton => 'Confirmer la réservation';
	@override String get doctorLabel => 'Médecin';
	@override String get workplaceLabel => 'Lieu de travail';
	@override String get addressLabel => 'Adresse';
	@override String get startLabel => 'Début';
	@override String get endLabel => 'Fin';
	@override String get tryDifferentDate => 'Essayez une autre date';
}

// Path: doctorSearch
class _Translations$doctorSearch$fr extends Translations$doctorSearch$en {
	_Translations$doctorSearch$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Trouver un médecin';
	@override String get searchByName => 'Rechercher par nom...';
	@override String get city => 'Ville';
	@override String get search => 'Rechercher';
	@override String get noDoctorsFound => 'Aucun médecin trouvé';
	@override String get adjustSearch => 'Essayez d\'ajuster votre recherche ou vos filtres';
	@override String get couldNotLoadDoctors => 'Impossible de charger les médecins';
	@override String get loadMore => 'Charger plus';
	@override late final _Translations$doctorSearch$spec$fr spec = _Translations$doctorSearch$spec$fr._(_root);
	@override String get noAvailability => 'Indisponible';
	@override String get availableToday => 'Disponible auj.';
	@override String get availableTomorrow => 'Disponible demain';
	@override String availableOn({required Object date}) => 'Dispo le ${date}';
	@override String get sortBy => 'Trier par';
	@override String get sortDefault => 'Pertinence';
	@override String get sortRating => 'Mieux notés';
	@override String get sortPriceLow => 'Prix le plus bas';
	@override String get sortName => 'Nom (A–Z)';
	@override String get sortNearestSlot => 'Disponibilité la plus proche';
	@override String get sortDistance => 'Le plus proche de moi';
	@override String get locationDenied => 'L\'autorisation de localisation est nécessaire pour trier par distance. Autorisez-la dans les réglages ou filtrez par ville.';
	@override String get locationUnavailable => 'Impossible d\'obtenir votre position. Vérifiez que la localisation est activée ou filtrez par ville.';
	@override String distanceKm({required Object km}) => '${km} km';
}

// Path: doctorDetail
class _Translations$doctorDetail$fr extends Translations$doctorDetail$en {
	_Translations$doctorDetail$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get profileTitle => 'Profil du médecin';
	@override String get couldNotLoadProfile => 'Impossible de charger le profil';
	@override String get about => 'À propos';
	@override String get workplaces => 'Lieux de travail';
	@override String minPerSlot({required Object min}) => '${min} min par créneau';
	@override String get bookAppointment => 'Prendre rendez-vous';
	@override String get consultationFee => 'Frais de consultation';
	@override String get reviews => 'Avis';
	@override String reviewsCount({required Object count}) => '${count} avis';
	@override String get joinWaitlist => 'Rejoindre la liste d’attente';
	@override String get leaveWaitlist => 'Quitter la liste d’attente';
}

// Path: profile
class _Translations$profile$fr extends Translations$profile$en {
	_Translations$profile$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profil';
	@override String get changePassword => 'Changer le mot de passe';
	@override String get currentPassword => 'Mot de passe actuel';
	@override String get newPassword => 'Nouveau mot de passe';
	@override String get confirmNewPassword => 'Confirmer le nouveau mot de passe';
	@override String get firstName => 'Prénom';
	@override String get lastName => 'Nom';
	@override String get phone => 'Téléphone';
	@override String get failedToSave => 'Échec de l\'enregistrement du profil.';
	@override String get professionalInfo => 'Infos professionnelles';
	@override String get bio => 'Biographie';
	@override String get bioHint => 'Brève description de votre expérience';
	@override String get consultationFee => 'Frais de consultation';
	@override String get medicalInfo => 'Informations médicales';
	@override String get allergies => 'Allergies';
	@override String get allergiesHint => 'ex. Pénicilline, cacahuètes';
	@override String get chronicConditions => 'Maladies chroniques';
	@override String get chronicConditionsHint => 'ex. Diabète, hypertension';
	@override String get medications => 'Médicaments actuels';
	@override String get medicationsHint => 'ex. Metformine 500mg';
	@override String get appointmentLength => 'Durée du rendez-vous';
	@override String get cancellationWindow => 'Délai d’annulation';
	@override String get cancellationWindowHint => 'Combien de temps avant un rendez-vous les patients peuvent encore annuler/reporter.';
	@override String hoursValue({required Object h}) => '${h} h';
}

// Path: notifications
class _Translations$notifications$fr extends Translations$notifications$en {
	_Translations$notifications$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications';
	@override String get noNotifications => 'Aucune notification';
	@override String get allCaughtUp => 'Vous êtes à jour';
	@override String get couldNotLoad => 'Impossible de charger les notifications';
	@override String get markAllRead => 'Tout marquer lu';
	@override String get settingsTitle => 'Paramètres de notification';
	@override String get pushEnabled => 'Notifications push';
	@override String get pushEnabledSubtitle => 'Alertes sur cet appareil pour les rendez-vous et mises à jour';
	@override String get emailEnabled => 'Notifications par e-mail';
	@override String get emailEnabledSubtitle => 'Les mises à jour seront envoyées à votre adresse e-mail';
}

// Path: workplaces
class _Translations$workplaces$fr extends Translations$workplaces$en {
	_Translations$workplaces$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mes lieux de travail';
	@override String get noWorkplacesYet => 'Aucun lieu de travail';
	@override String get tapToAdd => 'Appuyez sur + pour ajouter votre premier lieu de travail';
	@override String get couldNotLoad => 'Impossible de charger les lieux de travail';
	@override String get deleteTitle => 'Supprimer le lieu de travail';
	@override String deleteConfirm({required Object name}) => 'Supprimer « ${name} » ?';
	@override String get cannotDelete => 'Impossible de supprimer le lieu de travail';
	@override String get workingHours => 'Heures de travail';
	@override String get setAsPrimary => 'Définir comme principal';
}

// Path: addWorkplace
class _Translations$addWorkplace$fr extends Translations$addWorkplace$en {
	_Translations$addWorkplace$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'Ajouter un lieu de travail';
	@override String get editTitle => 'Modifier le lieu de travail';
	@override String get name => 'Nom';
	@override String get address => 'Adresse (rue)';
	@override String get city => 'Ville';
	@override String get type => 'Type';
	@override String get clinic => 'Clinique';
	@override String get hospital => 'Hôpital';
	@override String get privatePractice => 'Cabinet privé';
	@override String get failedToSave => 'Échec de l\'enregistrement du lieu de travail.';
	@override String get addButton => 'Ajouter un lieu de travail';
	@override String get saveChanges => 'Enregistrer les modifications';
	@override String get pickOnMap => 'Choisir sur la carte';
	@override String get mapPickerTitle => 'Choisir l\'emplacement';
	@override String get useMyLocation => 'Utiliser ma position';
	@override String get confirmLocation => 'Confirmer l\'emplacement';
	@override String get locationSet => 'Emplacement défini depuis la carte ✓';
	@override String get locationPermissionDenied => 'L\'autorisation de localisation est nécessaire pour utiliser votre position actuelle. Vous pouvez toujours déplacer la carte manuellement.';
	@override String get locationUnavailable => 'Impossible d\'obtenir votre position. Vous pouvez toujours déplacer la carte manuellement.';
}

// Path: workingHours
class _Translations$workingHours$fr extends Translations$workingHours$en {
	_Translations$workingHours$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Heures de travail';
	@override String get sectionHint => 'Définissez les jours et horaires où les patients peuvent prendre rendez-vous à cette adresse.';
	@override String get invalidRange => 'L\'heure de fin doit être postérieure à l\'heure de début pour chaque jour actif.';
	@override String get saved => 'Heures de travail enregistrées';
	@override String get failedToSave => 'Échec de l\'enregistrement des heures de travail';
	@override late final _Translations$workingHours$days$fr days = _Translations$workingHours$days$fr._(_root);
}

// Path: blockTime
class _Translations$blockTime$fr extends Translations$blockTime$en {
	_Translations$blockTime$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bloquer du temps';
	@override String get dateRange => 'Plage de dates';
	@override String get tapToSelect => 'Appuyez pour sélectionner les dates';
	@override String get reason => 'Motif (facultatif)';
	@override String get notifyPatients => 'Notifier les patients concernés';
	@override String get notifyDesc => 'Envoyer des notifications aux patients ayant des rendez-vous durant cette période';
	@override String get selectDateRange => 'Veuillez sélectionner une plage de dates.';
	@override String get failedToBlock => 'Échec du blocage. Veuillez réessayer.';
	@override String get blockButton => 'Bloquer la période';
}

// Path: onboarding
class _Translations$onboarding$fr extends Translations$onboarding$en {
	_Translations$onboarding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Complétez votre profil';
	@override String get professionalInfo => 'Informations professionnelles';
	@override String get tellPatients => 'Parlez de votre pratique aux patients.';
	@override String get specialization => 'Spécialisation';
	@override String get selectSpecialization => 'Sélectionnez votre spécialisation';
	@override String get couldNotLoadSpecs => 'Impossible de charger les spécialisations. Revenez et réessayez.';
	@override String get licenseNumber => 'Numéro de licence';
	@override String get licenseHint => 'ex. AZ-123456';
	@override String get bio => 'Biographie (facultatif)';
	@override String get bioHint => 'Une brève présentation que les patients verront sur votre profil.';
	@override String get appointmentLength => 'Durée du rendez-vous';
	@override String get slotQuestion => 'Quelle est la durée d\'un créneau de rendez-vous ?';
	@override String get changeLater => 'Vous pourrez le modifier plus tard depuis votre profil.';
	@override String minutes({required Object min}) => '${min} min';
	@override String get verificationDoc => 'Document de vérification';
	@override String get uploadDiploma => 'Téléchargez votre diplôme ou licence médicale. Un administrateur l\'examine avant la vérification de votre compte.';
	@override String get tapToChoose => 'Appuyez pour choisir un fichier';
	@override String get tapToReplace => 'Appuyez pour remplacer';
	@override String get anyFileType => 'Tout type de fichier, jusqu\'à 10 Mo';
	@override String get selectSpecError => 'Veuillez sélectionner votre spécialisation.';
	@override String get licenseError => 'Veuillez saisir votre numéro de licence.';
	@override String get diplomaError => 'Veuillez joindre votre diplôme.';
	@override String get checkDetails => 'Veuillez vérifier vos informations et réessayer.';
	@override String get continueButton => 'Continuer';
	@override String get finish => 'Terminer';
}

// Path: pendingVerification
class _Translations$pendingVerification$fr extends Translations$pendingVerification$en {
	_Translations$pendingVerification$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vérification en attente';
	@override String get message => 'Votre compte est en cours d\'examen. Nous vous informerons une fois qu\'il sera vérifié.';
	@override String get checkStatus => 'Vérifier le statut';
	@override String get stillPending => 'Toujours en cours d\'examen. Nous vous informerons une fois vérifié.';
}

// Path: phoneField
class _Translations$phoneField$fr extends Translations$phoneField$en {
	_Translations$phoneField$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Numéro de téléphone';
	@override String get labelOptional => 'Numéro de téléphone (facultatif)';
	@override String get selectCountry => 'Sélectionner un pays';
	@override String get searchCountry => 'Rechercher un pays ou un code…';
	@override String get noCountriesFound => 'Aucun pays trouvé';
}

// Path: locations
class _Translations$locations$fr extends Translations$locations$en {
	_Translations$locations$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get pickCity => 'Sélectionner une ville';
	@override String get searchHint => 'Rechercher une ville ou une région…';
	@override String get noResultsFound => 'Aucune ville trouvée';
	@override String get couldNotLoad => 'Impossible de charger les villes. Appuyez pour réessayer.';
	@override String get allCities => 'Toutes les villes';
}

// Path: splash
class _Translations$splash$fr extends Translations$splash$en {
	_Translations$splash$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Votre santé, simplifiée';
}

// Path: appIntro
class _Translations$appIntro$fr extends Translations$appIntro$en {
	_Translations$appIntro$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get page1Title => 'Trouvez le bon médecin';
	@override String get page1Subtitle => 'Recherchez par spécialité, ville et note — puis réservez un créneau qui vous convient.';
	@override String get page2Title => 'Interrogez notre assistant IA';
	@override String get page2Subtitle => 'Décrivez vos symptômes et découvrez le spécialiste le plus adapté, à tout moment.';
	@override String get page3Title => 'Tout en une seule application';
	@override String get page3Subtitle => 'Gérez vos rendez-vous, suivez votre suivi médical et utilisez l\'application dans votre langue — en toute sécurité.';
	@override String get skip => 'Passer';
	@override String get next => 'Suivant';
	@override String get getStarted => 'Commencer';
}

// Path: agenda
class _Translations$agenda$fr extends Translations$agenda$en {
	_Translations$agenda$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Planning';
	@override String get today => 'Aujourd\'hui';
	@override String get empty => 'Aucun rendez-vous';
	@override String get emptySubtitle => 'Rien de prévu pour ce jour';
}

// Path: favorites
class _Translations$favorites$fr extends Translations$favorites$en {
	_Translations$favorites$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Favoris';
	@override String get empty => 'Aucun favori';
	@override String get emptySubtitle => 'Touchez le cœur d’un médecin pour l’enregistrer ici';
	@override String get add => 'Ajouter aux favoris';
	@override String get remove => 'Retirer des favoris';
}

// Path: assistant
class _Translations$assistant$fr extends Translations$assistant$en {
	_Translations$assistant$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Assistant IA';
	@override String get newChat => 'Nouvelle discussion';
	@override String get empty => 'Aucune discussion pour l\'instant';
	@override String get emptySubtitle => 'Décrivez vos symptômes et l\'assistant vous indiquera quel médecin consulter';
	@override String get couldNotLoad => 'Impossible de charger les discussions';
	@override String get couldNotLoadChat => 'Impossible de charger la discussion';
	@override String get newConversation => 'Nouvelle discussion';
	@override String get deleteTitle => 'Supprimer la discussion ?';
	@override String get deleteConfirm => 'La discussion et tous ses messages seront supprimés.';
	@override String get inputHint => 'Décrivez vos symptômes…';
	@override String get send => 'Envoyer';
	@override String get sendFailed => 'Le message n\'a pas pu être envoyé. Veuillez réessayer.';
	@override String get typing => 'L\'assistant écrit…';
	@override String get startTitle => 'Comment puis-je aider ?';
	@override String get startSubtitle => 'Décrivez ce qui vous préoccupe pour commencer';
	@override String get book => 'Prendre RDV';
	@override String get reportTooltip => 'Signaler cette réponse';
	@override String get reportTitle => 'Signaler la réponse';
	@override String get reportHint => 'Motif (facultatif)';
	@override String get reportSubmit => 'Signaler';
	@override String get reportSuccess => 'Merci, la réponse a été signalée.';
	@override String get reportFailed => 'Impossible de signaler la réponse. Veuillez réessayer.';
	@override String get topicsTooltip => 'Sujets';
	@override String get topicsSheetTitle => 'Choisissez un sujet';
}

// Path: messaging
class _Translations$messaging$fr extends Translations$messaging$en {
	_Translations$messaging$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Messages';
	@override String get sendMessage => 'Envoyer un message';
	@override String get typeMessage => 'Écrivez un message…';
	@override String get send => 'Envoyer';
	@override String get empty => 'Aucune discussion pour l\'instant';
	@override String get emptySubtitle => 'Vos discussions apparaîtront ici.';
	@override String get disclaimer => 'Ceci n\'est pas une ligne d\'urgence. Pour toute urgence, appelez les services d\'urgence.';
	@override String get noSharedHistory => 'Vous pourrez contacter un médecin dès que vous aurez un rendez-vous en commun avec lui.';
	@override String get newMessage => 'Vous avez un nouveau message';
}

// Path: legal
class _Translations$legal$fr extends Translations$legal$en {
	_Translations$legal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confidentialité et Conditions';
	@override String get controllerNotice => 'Medalize est exploité par [Fərdi Sahibkar adı — VÖEN: XXXXXXXXXXXX], Azerbaïdjan (« nous »). Dernière mise à jour : juillet 2026.';
	@override String get privacyTitle => 'Politique de confidentialité';
	@override String get privacyIntro => 'Cette politique explique quelles données personnelles Medalize collecte, pourquoi, et comment elles sont protégées. La prise et la gestion de rendez-vous médicaux impliquent nécessairement des informations de santé vous concernant, détaillées ci-dessous.';
	@override late final _Translations$legal$sections$fr sections = _Translations$legal$sections$fr._(_root);
	@override String get termsTitle => 'Conditions d\'utilisation';
	@override String get termsIntro => 'En créant un compte, vous acceptez ce qui suit.';
	@override String get termsBody => 'Fournir des informations exactes vous concernant. Utiliser Medalize uniquement pour trouver, réserver et gérer des rendez-vous médicaux. Garder vos identifiants de connexion confidentiels. Medalize vous met en relation avec des professionnels de santé indépendants et agréés — nous ne sommes pas nous-mêmes un prestataire de soins, et l\'assistant IA de vérification des symptômes ne remplace pas un diagnostic ou un avis médical professionnel. En cas d\'urgence médicale, contactez directement les services d\'urgence, pas cette application. Nous pouvons suspendre ou résilier les comptes qui enfreignent ces conditions ou qui font un usage abusif de la plateforme.';
	@override String get contact => 'Des questions sur vos données ? Contactez support@medalize.az';
	@override String get consentPrefix => 'J\'ai lu et j\'accepte la ';
	@override String get consentPrivacyLink => 'Politique de confidentialité';
	@override String get consentMiddle => ' et les ';
	@override String get consentTermsLink => 'Conditions d\'utilisation';
	@override String get consentSuffix => ', et je consens explicitement au traitement de mes données de santé tel que décrit.';
	@override String get viewAsPdf => 'Voir en PDF';
	@override String get pdfDocumentTitle => 'Medalize — Politique de confidentialité et conditions d\'utilisation';
	@override String get pdfLoadError => 'Impossible de charger le document. Vérifiez votre connexion internet et réessayez.';
}

// Path: medications
class _Translations$medications$fr extends Translations$medications$en {
	_Translations$medications$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Médicaments';
	@override String get editMedication => 'Modifier le médicament';
	@override String get name => 'Nom';
	@override String get dosage => 'Dosage';
	@override String get notes => 'Notes';
	@override String get form => 'Forme';
	@override String get formPill => 'Comprimé';
	@override String get formCapsule => 'Gélule';
	@override String get formLiquid => 'Liquide';
	@override String get formInjection => 'Injection';
	@override String get formOther => 'Autre';
	@override String get schedule => 'Horaire';
	@override String get times => 'Heures de prise';
	@override String get addTime => 'Ajouter une heure';
	@override String get daysOfWeek => 'Jours de la semaine';
	@override String get everyDay => 'Tous les jours';
	@override String get startDate => 'Date de début';
	@override String get endDate => 'Date de fin';
	@override String get save => 'Enregistrer';
	@override String get delete => 'Supprimer';
	@override String get deleteConfirmTitle => 'Supprimer le médicament';
	@override String get deleteConfirmBody => 'Voulez-vous vraiment supprimer ce médicament ? L\'historique des prises sera conservé.';
	@override String get emptyTitle => 'Aucun médicament pour l\'instant';
	@override String get emptySubtitle => 'Les médicaments prescrits par votre médecin apparaîtront ici après votre consultation.';
	@override String get todaysDoses => 'Prises du jour';
	@override String get markTaken => 'Pris';
	@override String get markSkipped => 'Ignorer';
	@override String get statusTaken => 'Pris';
	@override String get statusSkipped => 'Ignoré';
	@override String get statusPending => 'En attente';
	@override String reminderTitle({required Object name}) => 'C\'est l\'heure de prendre ${name}';
	@override String reminderBody({required Object dosage}) => 'Dose : ${dosage}';
	@override String get tabActive => 'Actifs';
	@override String get tabArchive => 'Archivés';
	@override String get fromPrescription => 'Sur ordonnance';
	@override String get noSchedule => 'Aucun horaire défini — appuyez pour ajouter des heures de rappel';
	@override String get dayMon => 'Lun';
	@override String get dayTue => 'Mar';
	@override String get dayWed => 'Mer';
	@override String get dayThu => 'Jeu';
	@override String get dayFri => 'Ven';
	@override String get daySat => 'Sam';
	@override String get daySun => 'Dim';
	@override String get updatedSuccess => 'Médicament mis à jour.';
	@override String get deletedSuccess => 'Médicament supprimé.';
	@override String get atLeastOneTime => 'Ajoutez au moins une heure de rappel';
}

// Path: prescriptions
class _Translations$prescriptions$fr extends Translations$prescriptions$en {
	_Translations$prescriptions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ordonnances';
	@override String get writeTitle => 'Rédiger une ordonnance';
	@override String get addDrug => 'Ajouter un médicament';
	@override String get drugName => 'Nom du médicament';
	@override String get dosage => 'Dosage';
	@override String get frequency => 'Fréquence';
	@override String get duration => 'Durée';
	@override String get instructions => 'Instructions';
	@override String get notes => 'Notes';
	@override String get save => 'Enregistrer';
	@override String get empty => 'Aucune ordonnance pour l\'instant';
	@override String get emptySubtitle => 'Les ordonnances émises par votre médecin apparaîtront ici.';
	@override String get viewDetails => 'Voir les détails';
	@override String issuedBy({required Object name}) => 'Émise par le Dr ${name}';
	@override String issuedOn({required Object date}) => 'Émise le ${date}';
	@override String get applyToMedications => 'Ajouter à mes médicaments';
	@override String get applySuccess => 'Ajouté à vos médicaments. Configurez les heures de rappel pour être notifié.';
	@override String get alreadyApplied => 'Déjà ajouté à vos médicaments';
	@override String get noPrescriptionYet => 'Aucune ordonnance pour ce rendez-vous pour l\'instant';
	@override String get writePrescription => 'Rédiger une ordonnance';
	@override String get prescriptionIssued => 'Ordonnance émise.';
	@override String get removeDrug => 'Retirer';
	@override String get atLeastOneDrug => 'Ajoutez au moins un médicament';
	@override String get drugNameRequired => 'Le nom du médicament est requis';
	@override String get summaryTitle => 'Ordonnance';
	@override String itemsCount({required Object count}) => '${count} médicaments';
	@override String get newPrescription => 'Nouvelle ordonnance';
	@override String get youHavePrescription => 'Ce rendez-vous a une ordonnance';
}

// Path: records
class _Translations$records$fr extends Translations$records$en {
	_Translations$records$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dossier Médical';
	@override String get upload => 'Téléverser un document';
	@override String get recordType => 'Type de document';
	@override String get typeLabResult => 'Résultat d\'analyse';
	@override String get typeImaging => 'Imagerie';
	@override String get typeDocument => 'Document';
	@override String get typeOther => 'Autre';
	@override String get recordTitle => 'Titre';
	@override String get recordDate => 'Date';
	@override String get notes => 'Notes';
	@override String get chooseFile => 'Choisir un fichier';
	@override String get changeFile => 'Changer de fichier';
	@override String get noFileChosen => 'Aucun fichier choisi';
	@override String get save => 'Enregistrer';
	@override String get delete => 'Supprimer';
	@override String get deleteConfirmTitle => 'Supprimer le document';
	@override String get deleteConfirmBody => 'Voulez-vous vraiment supprimer ce document ? Cette action est irréversible.';
	@override String get empty => 'Aucun document médical pour l\'instant';
	@override String get emptySubtitle => 'Conservez vos résultats d\'analyses, imageries et autres documents au même endroit.';
	@override String get view => 'Ouvrir';
	@override String get fileRequired => 'Choisissez un fichier à téléverser';
	@override String get fileTooLarge => 'Le fichier est trop volumineux (max 15 Mo)';
	@override String get titleRequired => 'Le titre est requis';
	@override String get uploadSuccess => 'Document téléversé.';
	@override String get deletedSuccess => 'Document supprimé.';
	@override String get couldNotOpen => 'Impossible d\'ouvrir le fichier';
}

// Path: payments
class _Translations$payments$fr extends Translations$payments$en {
	_Translations$payments$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paiement';
	@override String get amount => 'Montant';
	@override String get payNow => 'Payer maintenant';
	@override String get payLater => 'Payer plus tard';
	@override String get statusPending => 'Paiement en attente';
	@override String get statusPaid => 'Payé';
	@override String get statusFailed => 'Échec du paiement';
	@override String get statusCancelled => 'Annulé';
	@override String get statusRefunded => 'Remboursé';
	@override String get statusRefundFailed => 'Échec du remboursement';
	@override String get paymentConfirmed => 'Paiement confirmé. Merci !';
	@override String get openingBrowser => 'Ouverture du navigateur…';
	@override String get checkStatus => 'Vérifier le statut';
}

// Path: family
class _Translations$family$fr extends Translations$family$en {
	_Translations$family$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Famille';
	@override String get myself => 'Moi-même';
	@override String get addFamilyMember => 'Ajouter un membre de la famille';
	@override String get editFamilyMember => 'Modifier le membre de la famille';
	@override String get firstName => 'Prénom';
	@override String get lastName => 'Nom';
	@override String get relationship => 'Lien de parenté';
	@override String get relationshipChild => 'Enfant';
	@override String get relationshipSpouse => 'Conjoint(e)';
	@override String get relationshipParent => 'Parent';
	@override String get relationshipSibling => 'Frère/Sœur';
	@override String get relationshipOther => 'Autre';
	@override String get dateOfBirth => 'Date de naissance';
	@override String get bloodType => 'Groupe sanguin';
	@override String get allergies => 'Allergies';
	@override String get chronicConditions => 'Maladies chroniques';
	@override String get medications => 'Médicaments actuels';
	@override String get save => 'Enregistrer';
	@override String get delete => 'Supprimer';
	@override String get deleteConfirmTitle => 'Supprimer le membre de la famille';
	@override String get deleteConfirmBody => 'Voulez-vous vraiment supprimer ce membre de la famille ? L\'historique des rendez-vous, médicaments et documents sera conservé.';
	@override String get empty => 'Aucun membre de la famille pour l\'instant';
	@override String get emptySubtitle => 'Ajoutez un enfant, un conjoint ou un autre proche pour gérer ses rendez-vous, médicaments et documents.';
	@override String get bookingForQuestion => 'Pour qui est ce rendez-vous ?';
	@override String bookingForLabel({required Object name}) => 'Rendez-vous pour : ${name}';
	@override String forLabel({required Object name}) => 'pour ${name}';
	@override String ageYears({required Object age}) => '${age} ans';
	@override String bookedByLabel({required Object name}) => 'Pris par ${name}';
	@override String get contactEmail => 'E-mail de contact';
	@override String get contactEmailHelp => 'Nous les informerons qu\'ils ont été ajoutés, avec un moyen simple de refuser.';
	@override String get contactPhoneOptional => 'Téléphone de contact (facultatif)';
	@override String get contactEmailRequiredForAdult => 'Une adresse e-mail est requise pour que nous puissions informer ce membre de la famille';
	@override String get adultConsentNotice => 'Comme cette personne a 18 ans ou plus, nous lui enverrons un e-mail pour l\'informer que vous l\'avez ajoutée — elle n\'a pas besoin de l\'application et peut supprimer cette connexion à tout moment.';
	@override String get noticeAlreadySent => 'Nous l\'avons informée qu\'elle a été ajoutée. Elle peut supprimer cette connexion à tout moment.';
	@override String get noticePendingBadge => 'Notification envoyée';
}

// Path: subscription
class _Translations$subscription$fr extends Translations$subscription$en {
	_Translations$subscription$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Abonnement';
	@override String get planNameBasic => 'Débutant';
	@override String get planNamePro => 'Professionnel';
	@override String get couldNotLoad => 'Impossible de charger votre abonnement.';
	@override String get nowActive => 'Votre abonnement est maintenant actif !';
	@override String get unavailable => 'Les abonnements ne sont pas disponibles pour le moment. Veuillez réessayer plus tard.';
	@override String trialDaysLeft({required Object days}) => 'Essai gratuit — ${days} jour(s) restant(s)';
	@override String graceDaysLeft({required Object days}) => 'Période de grâce — ${days} jour(s) restant(s) pour renouveler';
	@override String get expiredNotice => 'Votre abonnement a expiré. Abonnez-vous pour redevenir visible aux patients.';
	@override String get activeNotice => 'Votre abonnement est actif.';
	@override String get choosePlan => 'Choisissez un forfait pour commencer.';
	@override String get currentPlan => 'Forfait Actuel';
	@override String get mostPopular => 'Le Plus Populaire';
	@override String get perMonth => 'par mois';
	@override String get manageOnWeb => 'Gérez votre abonnement sur medalize.az';
	@override String get featureUnlimitedWorkplaces => 'Cliniques illimitées';
	@override String featureWorkplaces({required Object count}) => 'Jusqu\'à ${count} clinique(s)';
	@override String get featureUnlimitedBookings => 'Réservations mensuelles illimitées';
	@override String featureBookingsPerMonth({required Object count}) => 'Jusqu\'à ${count} réservations par mois';
	@override String get featureChat => 'Chat avec les patients';
	@override String get featurePromoted => 'Placement prioritaire + badge « Peşəkar »';
	@override String get renew => 'Renouveler';
	@override String get subscribe => 'S\'abonner';
	@override String get planNameHospitalBasic => 'Clinique';
	@override String get planNameHospitalPro => 'Clinique Plus';
	@override String featureDoctors({required Object count}) => 'Jusqu\'à ${count} médecin(s)';
	@override String get featureUnlimitedDoctors => 'Médecins illimités';
	@override String get featureAdvancedStats => 'Statistiques avancées';
}

// Path: hospitalPicker
class _Translations$hospitalPicker$fr extends Translations$hospitalPicker$en {
	_Translations$hospitalPicker$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sélectionner un hôpital';
	@override String get searchHint => 'Rechercher un hôpital…';
	@override String get noResultsFound => 'Aucun hôpital trouvé';
	@override String get selectCityFirst => 'Sélectionnez d\'abord une ville';
	@override String addVariant({required Object name}) => 'Ajouter « ${name} »';
	@override String get pendingReview => 'En cours de vérification';
}

// Path: hospitalRegistration
class _Translations$hospitalRegistration$fr extends Translations$hospitalRegistration$en {
	_Translations$hospitalRegistration$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Détails de l\'hôpital';
	@override String get subtitle => 'Sélectionnez votre ville, puis trouvez votre hôpital ci-dessous ou ajoutez-le.';
	@override String get cityStep => '1. Ville';
	@override String get hospitalStep => '2. Hôpital';
	@override String get searchHint => 'Rechercher un hôpital…';
	@override String get noResultsFound => 'Aucun hôpital trouvé';
	@override String get notFoundPrompt => 'Vous ne trouvez pas votre hôpital ?';
	@override String get addManually => 'Ajouter manuellement';
	@override String get useSearchInstead => 'Rechercher à nouveau';
	@override String get newHospitalName => 'Nom de l\'hôpital';
	@override String get selectedPrefix => 'Sélectionné :';
	@override String get pendingReviewNotice => 'Les nouveaux hôpitaux sont vérifiés par notre équipe avant d\'apparaître ailleurs.';
	@override String get submit => 'Créer un compte';
	@override String get hospitalRequired => 'Sélectionnez ou ajoutez votre hôpital pour continuer';
}

// Path: hospitalHome
class _Translations$hospitalHome$fr extends Translations$hospitalHome$en {
	_Translations$hospitalHome$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Bonjour, ${name}';
	@override String get subtitle => 'Gérez vos médecins et vos rendez-vous';
	@override String get doctors => 'Médecins';
	@override String get inviteDoctor => 'Inviter un médecin';
	@override String get appointments => 'Rendez-vous';
	@override String get profile => 'Profil';
	@override String pendingRequests({required Object count}) => '${count} demande(s) en attente';
}

// Path: hospitalDoctors
class _Translations$hospitalDoctors$fr extends Translations$hospitalDoctors$en {
	_Translations$hospitalDoctors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Médecins';
	@override String get tabConfirmed => 'Confirmés';
	@override String get tabRequests => 'Demandes';
	@override String get tabInvited => 'Invités';
	@override String get noConfirmedDoctors => 'Aucun médecin confirmé pour l\'instant';
	@override String get noRequests => 'Aucune demande en attente';
	@override String get noInvited => 'Aucune invitation en attente';
	@override String get approve => 'Approuver';
	@override String get reject => 'Refuser';
	@override String get remove => 'Retirer';
	@override String get removeConfirmTitle => 'Retirer ce médecin ?';
	@override String removeConfirmMessage({required Object name}) => '${name} ne sera plus affilié à votre hôpital. Cela n\'affecte pas son lieu de travail ni ses rendez-vous.';
	@override String get requestedToJoin => 'A demandé à rejoindre';
	@override String get invitedAwaiting => 'Invité — en attente de réponse';
	@override String get editHours => 'Modifier les horaires';
}

// Path: hospitalInvite
class _Translations$hospitalInvite$fr extends Translations$hospitalInvite$en {
	_Translations$hospitalInvite$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inviter un médecin';
	@override String get searchHint => 'Rechercher par nom ou spécialité…';
	@override String get noResultsFound => 'Aucun médecin trouvé';
	@override String get invite => 'Inviter';
	@override String get invited => 'Invité';
}

// Path: hospitalAppointments
class _Translations$hospitalAppointments$fr extends Translations$hospitalAppointments$en {
	_Translations$hospitalAppointments$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rendez-vous';
	@override String get empty => 'Aucun rendez-vous pour l\'instant';
}

// Path: hospitalProfile
class _Translations$hospitalProfile$fr extends Translations$hospitalProfile$en {
	_Translations$hospitalProfile$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profil de l\'hôpital';
	@override String usageDoctors({required Object count, required Object limit}) => '${count} sur ${limit} médecins';
	@override String usageDoctorsUnlimited({required Object count}) => '${count} médecins (illimité)';
	@override String get manageSubscription => 'Gérer l\'abonnement';
}

// Path: hospitalDoctorHours
class _Translations$hospitalDoctorHours$fr extends Translations$hospitalDoctorHours$en {
	_Translations$hospitalDoctorHours$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Horaires de travail';
	@override String get selectWorkplace => 'Sélectionner un lieu de travail';
	@override String get saved => 'Horaires enregistrés';
}

// Path: doctorHospitals
class _Translations$doctorHospitals$fr extends Translations$doctorHospitals$en {
	_Translations$doctorHospitals$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mes hôpitaux';
	@override String get tabInvitations => 'Invitations';
	@override String get tabRequests => 'Demandes';
	@override String get tabConfirmed => 'Hôpitaux';
	@override String get noInvitations => 'Aucune invitation en attente';
	@override String get noRequests => 'Aucune demande en attente';
	@override String get noConfirmed => 'Vous n\'êtes affilié à aucun hôpital pour l\'instant';
	@override String get accept => 'Accepter';
	@override String get decline => 'Refuser';
	@override String get cancelRequest => 'Annuler la demande';
	@override String get invitedYouToJoin => 'Vous a invité à le rejoindre';
	@override String get awaitingApproval => 'En attente de l\'approbation de l\'hôpital';
}

// Path: doctorSearch.spec
class _Translations$doctorSearch$spec$fr extends Translations$doctorSearch$spec$en {
	_Translations$doctorSearch$spec$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get general => 'Général';
	@override String get cardiology => 'Cardiologie';
	@override String get dermatology => 'Dermatologie';
	@override String get neurology => 'Neurologie';
	@override String get orthopedics => 'Orthopédie';
	@override String get pediatrics => 'Pédiatrie';
	@override String get psychiatry => 'Psychiatrie';
	@override String get gynecology => 'Gynécologie';
	@override String get urology => 'Urologie';
	@override String get ophthalmology => 'Ophtalmologie';
	@override String get ent => 'ORL';
}

// Path: workingHours.days
class _Translations$workingHours$days$fr extends Translations$workingHours$days$en {
	_Translations$workingHours$days$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get monday => 'Lundi';
	@override String get tuesday => 'Mardi';
	@override String get wednesday => 'Mercredi';
	@override String get thursday => 'Jeudi';
	@override String get friday => 'Vendredi';
	@override String get saturday => 'Samedi';
	@override String get sunday => 'Dimanche';
}

// Path: legal.sections
class _Translations$legal$sections$fr extends Translations$legal$sections$en {
	_Translations$legal$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$legal$sections$identity$fr identity = _Translations$legal$sections$identity$fr._(_root);
	@override late final _Translations$legal$sections$health$fr health = _Translations$legal$sections$health$fr._(_root);
	@override late final _Translations$legal$sections$professional$fr professional = _Translations$legal$sections$professional$fr._(_root);
	@override late final _Translations$legal$sections$location$fr location = _Translations$legal$sections$location$fr._(_root);
	@override late final _Translations$legal$sections$device$fr device = _Translations$legal$sections$device$fr._(_root);
	@override late final _Translations$legal$sections$payment$fr payment = _Translations$legal$sections$payment$fr._(_root);
	@override late final _Translations$legal$sections$family$fr family = _Translations$legal$sections$family$fr._(_root);
	@override late final _Translations$legal$sections$purposes$fr purposes = _Translations$legal$sections$purposes$fr._(_root);
	@override late final _Translations$legal$sections$legalBasis$fr legalBasis = _Translations$legal$sections$legalBasis$fr._(_root);
	@override late final _Translations$legal$sections$thirdParties$fr thirdParties = _Translations$legal$sections$thirdParties$fr._(_root);
	@override late final _Translations$legal$sections$retention$fr retention = _Translations$legal$sections$retention$fr._(_root);
	@override late final _Translations$legal$sections$rights$fr rights = _Translations$legal$sections$rights$fr._(_root);
	@override late final _Translations$legal$sections$security$fr security = _Translations$legal$sections$security$fr._(_root);
	@override late final _Translations$legal$sections$permissions$fr permissions = _Translations$legal$sections$permissions$fr._(_root);
	@override late final _Translations$legal$sections$children$fr children = _Translations$legal$sections$children$fr._(_root);
}

// Path: legal.sections.identity
class _Translations$legal$sections$identity$fr extends Translations$legal$sections$identity$en {
	_Translations$legal$sections$identity$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Données d\'identité';
	@override String get body => 'Nom et prénom, adresse e-mail, numéro de téléphone (facultatif), votre mot de passe (stocké sous forme de hachage irréversible, jamais en clair) et la langue préférée de l\'application.';
}

// Path: legal.sections.health
class _Translations$legal$sections$health$fr extends Translations$legal$sections$health$en {
	_Translations$legal$sections$health$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Données de santé';
	@override String get body => 'En tant que patient : groupe sanguin, allergies, maladies chroniques, médicaments actuels, motif indiqué lors de la prise de rendez-vous, documents médicaux téléversés (résultats de laboratoire, imagerie, autres dossiers), ordonnances qui vous sont délivrées, et le contenu de vos messages avec votre médecin. Si vous utilisez l\'assistant IA de vérification des symptômes, vos questions et ses réponses sont traitées de la même manière. Les données de santé bénéficient du plus haut niveau de protection selon le droit azerbaïdjanais, et nous ne les collectons qu\'avec votre consentement séparé et explicite (voir « Base légale » ci-dessous).';
}

// Path: legal.sections.professional
class _Translations$legal$sections$professional$fr extends Translations$legal$sections$professional$en {
	_Translations$legal$sections$professional$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Données professionnelles (médecins)';
	@override String get body => 'Spécialisation médicale, numéro de licence, diplôme ou autre document de vérification, informations sur le lieu de travail et tarif de consultation. Ces informations sont vérifiées par notre équipe avant que votre profil ne devienne visible aux patients.';
}

// Path: legal.sections.location
class _Translations$legal$sections$location$fr extends Translations$legal$sections$location$en {
	_Translations$legal$sections$location$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Localisation';
	@override String get body => 'Avec votre permission, une localisation approximative ou précise afin de trier les médecins par distance. Utilisée uniquement lorsque l\'application est ouverte — jamais stockée sur nos serveurs.';
}

// Path: legal.sections.device
class _Translations$legal$sections$device$fr extends Translations$legal$sections$device$en {
	_Translations$legal$sections$device$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Données de l\'appareil';
	@override String get body => 'Identifiants de l\'appareil et informations de session, afin que vous puissiez voir et révoquer vos connexions actives depuis les Paramètres, ainsi qu\'un jeton de notification push pour vous transmettre rappels de rendez-vous et messages.';
}

// Path: legal.sections.payment
class _Translations$legal$sections$payment$fr extends Translations$legal$sections$payment$en {
	_Translations$legal$sections$payment$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Données de paiement';
	@override String get body => 'Si vous payez une consultation dans l\'application, le paiement est traité entièrement par notre partenaire de paiement, Payriff — nous ne voyons ni ne stockons jamais votre numéro de carte. Nous conservons le montant du paiement, son statut et un identifiant de référence pour l\'historique de vos rendez-vous.';
}

// Path: legal.sections.family
class _Translations$legal$sections$family$fr extends Translations$legal$sections$family$en {
	_Translations$legal$sections$family$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profils de membres de la famille';
	@override String get body => 'Si vous gérez le profil d\'un membre de la famille (un enfant, ou une personne à charge sans compte propre), les mêmes catégories de données de santé ci-dessus peuvent être enregistrées pour lui sous votre compte. En ajoutant un membre de la famille, vous confirmez être son parent, tuteur, ou autrement autorisé à gérer ses informations de santé en son nom.';
}

// Path: legal.sections.purposes
class _Translations$legal$sections$purposes$fr extends Translations$legal$sections$purposes$en {
	_Translations$legal$sections$purposes$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pourquoi nous utilisons vos données';
	@override String get body => 'Pour vous permettre de trouver des médecins et de prendre rendez-vous ; permettre aux médecins de gérer leur agenda et leurs patients ; envoyer des rappels de rendez-vous et des mises à jour ; traiter les paiements des consultations ; fournir la fonctionnalité optionnelle de vérification des symptômes par IA ; et sécuriser votre compte.';
}

// Path: legal.sections.legalBasis
class _Translations$legal$sections$legalBasis$fr extends Translations$legal$sections$legalBasis$en {
	_Translations$legal$sections$legalBasis$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Base légale et votre consentement';
	@override String get body => 'Nous traitons vos données sur la base du consentement donné lors de votre inscription. Les données de santé constituent une catégorie particulière de données personnelles selon la loi de la République d\'Azerbaïdjan « Sur les données personnelles » (n° 998-IIIQ), qui exige votre consentement explicite et écrit avant leur collecte — c\'est ce qu\'enregistre la case à cocher de l\'écran d\'inscription. Vous pouvez retirer votre consentement à tout moment en supprimant votre compte, bien que nous puissions conserver certains registres lorsque la loi l\'exige (par exemple, des registres financiers à des fins fiscales).';
}

// Path: legal.sections.thirdParties
class _Translations$legal$sections$thirdParties$fr extends Translations$legal$sections$thirdParties$en {
	_Translations$legal$sections$thirdParties$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qui traite également vos données';
	@override String get body => 'Des prestataires de confiance agissant uniquement selon nos instructions, pour les finalités décrites ici : Cloudinary (stockage sécurisé des fichiers — documents et photos jamais accessibles publiquement, uniquement via des liens signés et à durée limitée) ; Firebase/Google (notifications push, et connexion Google si vous le choisissez) ; Apple (connexion avec Apple, si vous le choisissez) ; Payriff (paiements dans l\'application). Nous ne vendons pas vos données personnelles.';
}

// Path: legal.sections.retention
class _Translations$legal$sections$retention$fr extends Translations$legal$sections$retention$en {
	_Translations$legal$sections$retention$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Durée de conservation de vos données';
	@override String get body => 'Aussi longtemps que votre compte est actif. Si vous supprimez votre compte, nous supprimons vos données personnelles dans un délai raisonnable, à l\'exception des registres que nous devons légalement conserver (par exemple, les registres de paiement à des fins fiscales).';
}

// Path: legal.sections.rights
class _Translations$legal$sections$rights$fr extends Translations$legal$sections$rights$en {
	_Translations$legal$sections$rights$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vos droits';
	@override String get body => 'Vous pouvez accéder aux données que nous détenons sur vous, demander la correction de données inexactes, demander la suppression de votre compte et de vos données, et retirer votre consentement à tout moment. La plupart de ces actions sont disponibles directement dans Profil > Paramètres ; pour le reste, contactez-nous ci-dessous.';
}

// Path: legal.sections.security
class _Translations$legal$sections$security$fr extends Translations$legal$sections$security$en {
	_Translations$legal$sections$security$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comment nous protégeons vos données';
	@override String get body => 'Les messages entre vous et votre médecin, ainsi que les conversations avec l\'assistant IA, sont chiffrés. Les documents et photos téléversés sont stockés de manière privée, accessibles uniquement via des liens sécurisés et signés, jamais comme fichiers publics. Les mots de passe ne sont jamais stockés sous une forme lisible.';
}

// Path: legal.sections.permissions
class _Translations$legal$sections$permissions$fr extends Translations$legal$sections$permissions$en {
	_Translations$legal$sections$permissions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Autorisations que nous demandons';
	@override String get body => 'Appareil photo et photothèque — pour définir une photo de profil et téléverser des documents médicaux. Localisation — pour trier les médecins par distance. Notifications — pour transmettre rappels de rendez-vous et messages. Biométrie (Face ID / empreinte digitale) — un moyen optionnel et plus rapide de déverrouiller l\'application ; vos données biométriques ne quittent jamais votre appareil, nous recevons uniquement une confirmation oui/non de son système d\'exploitation.';
}

// Path: legal.sections.children
class _Translations$legal$sections$children$fr extends Translations$legal$sections$children$en {
	_Translations$legal$sections$children$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Condition d\'âge';
	@override String get body => 'Les comptes Medalize sont destinés aux adultes. Si vous avez moins de 18 ans, demandez à un parent ou tuteur de créer et de gérer un compte en votre nom via la fonctionnalité de profils familiaux.';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'Medalize',
			'common.cancel' => 'Annuler',
			'common.logout' => 'Se déconnecter',
			'common.doctor' => 'Médecin',
			'common.patient' => 'Patient',
			'common.save' => 'Enregistrer',
			'common.edit' => 'Modifier',
			'common.retry' => 'Réessayer',
			'common.back' => 'Retour',
			'common.ok' => 'OK',
			'common.delete' => 'Supprimer',
			'common.keep' => 'Conserver',
			'common.confirm' => 'Confirmer',
			'common.decline' => 'Refuser',
			'common.primary' => 'Principal',
			'common.somethingWrong' => 'Une erreur s\'est produite',
			'common.seeAll' => 'Tout voir',
			'common.signOut' => 'Se déconnecter',
			'common.search' => 'Rechercher',
			'common.tryAgain' => 'Veuillez réessayer',
			'common.required' => 'Requis',
			'common.noRatings' => 'Pas encore de note',
			'common.hospital' => 'Hôpital',
			'auth.login' => 'Se connecter',
			'auth.register' => 'Créer un compte',
			'auth.signIn' => 'Se connecter',
			'auth.signUp' => 'S\'inscrire',
			'auth.email' => 'E-mail',
			'auth.password' => 'Mot de passe',
			'auth.confirmPassword' => 'Confirmer le mot de passe',
			'auth.firstName' => 'Prénom',
			'auth.lastName' => 'Nom',
			'auth.rememberMe' => 'Se souvenir de moi',
			'auth.forgotPassword' => 'Mot de passe oublié ?',
			'auth.sendResetLink' => 'Envoyer le code',
			'auth.noAccount' => 'Vous n\'avez pas de compte ?',
			'auth.haveAccount' => 'Vous avez déjà un compte ?',
			'auth.welcomeBack' => 'Bon retour',
			'auth.signInToContinue' => 'Connectez-vous à votre compte pour continuer',
			'auth.createYourAccount' => 'Créez votre compte',
			'auth.joinMedalize' => 'Rejoignez Medalize dès aujourd\'hui',
			'auth.iAmA' => 'Je suis',
			'auth.emailHint' => 'you@example.com',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => 'Retour à la connexion',
			'auth.verificationCode' => 'Code de vérification',
			'auth.continueWithGoogle' => 'Continuer avec Google',
			'auth.continueWithApple' => 'Continuer avec Apple',
			'auth.orDivider' => 'ou',
			'forgotPassword.title' => 'Mot de passe oublié ?',
			'forgotPassword.subtitle' => 'Saisissez votre e-mail et nous vous enverrons un code de réinitialisation à 6 chiffres',
			'resetPassword.title' => 'Réinitialiser le mot de passe',
			'resetPassword.subtitle' => 'Saisissez le code envoyé par e-mail et choisissez un nouveau mot de passe',
			'resetPassword.button' => 'Réinitialiser le mot de passe',
			'resetPassword.success' => 'Mot de passe réinitialisé. Veuillez vous connecter.',
			'validation.emailRequired' => 'L\'e-mail est requis',
			'validation.emailInvalid' => 'Saisissez une adresse e-mail valide',
			'validation.passwordRequired' => 'Le mot de passe est requis',
			'validation.passwordTooShort' => '8 caractères minimum requis',
			'validation.passwordNeedsLetter' => 'Incluez au moins une lettre',
			'validation.passwordNeedsDigit' => 'Incluez au moins un chiffre',
			'validation.passwordMismatch' => 'Les mots de passe ne correspondent pas',
			'validation.passwordConfirmRequired' => 'Veuillez confirmer votre mot de passe',
			'validation.nameMinLength' => '2 caractères minimum',
			'validation.roleRequired' => 'Veuillez sélectionner un rôle',
			'validation.phoneRequired' => 'Le numéro de téléphone est requis',
			'validation.phoneTooShort' => 'Le numéro est trop court',
			'validation.phoneTooLong' => 'Le numéro est trop long',
			'validation.fieldRequired' => ({required Object field}) => '${field} est requis',
			'validation.fieldInvalid' => ({required Object field}) => '${field} contient des caractères invalides',
			'errors.network' => 'Erreur réseau. Vérifiez votre connexion.',
			'errors.rateLimit' => 'Trop de tentatives. Veuillez patienter et réessayer.',
			'errors.rateLimitWithSeconds' => ({required Object seconds}) => 'Trop de tentatives. Réessayez dans ${seconds} s.',
			'errors.invalidCredentials' => 'E-mail ou mot de passe invalide',
			'errors.sessionExpired' => 'Session expirée. Veuillez vous reconnecter.',
			'errors.authError' => 'Erreur d\'authentification. Veuillez vous reconnecter.',
			'errors.sessionRevoked' => 'Session révoquée. Veuillez vous reconnecter.',
			'errors.permissionDenied' => 'Vous n\'avez pas la permission de faire cela.',
			'errors.validationError' => 'Erreur de validation',
			'errors.serverError' => ({required Object code}) => 'Erreur serveur (${code}). Veuillez réessayer.',
			'errors.socialLoginFailed' => 'Échec de la connexion. Réessayez ou utilisez votre e-mail et mot de passe.',
			'errors.conflict' => 'Cette action ne peut pas être effectuée pour le moment.',
			'errors.onboardingIncomplete' => 'Veuillez remplir tous les champs requis pour terminer l\'inscription.',
			'errors.planLimitReached' => 'Vous avez atteint la limite de votre forfait. Passez à un forfait supérieur pour en ajouter davantage.',
			'errors.chatUnavailable' => 'Ce médecin ne propose pas le chat avec son forfait actuel.',
			'settings.title' => 'Paramètres',
			'settings.account' => 'Compte',
			'settings.profile' => 'Profil',
			'settings.notifications' => 'Notifications',
			'settings.appearance' => 'Apparence',
			'settings.themeSystem' => 'Système',
			'settings.themeLight' => 'Clair',
			'settings.themeDark' => 'Sombre',
			'settings.language' => 'Langue',
			'settings.languageSystem' => 'Par défaut du système',
			'settings.logoutTitle' => 'Déconnexion',
			'settings.logoutConfirm' => 'Voulez-vous vraiment vous déconnecter ?',
			'settings.version' => 'Medalize v1.0.0',
			'settings.legal' => 'Confidentialité et conditions',
			'security.title' => 'Sécurité',
			'security.biometricLogin' => 'Connexion biométrique',
			'security.biometricLoginSubtitle' => 'Utilisez Face ID / Touch ID pour déverrouiller l\'application',
			'security.biometricPrompt' => 'Authentifiez-vous pour accéder à Medalize',
			'security.biometricUnavailable' => 'L\'authentification biométrique n\'est pas disponible sur cet appareil',
			'security.biometricEnableFailed' => 'Impossible de vérifier votre biométrie. Réessayez.',
			'security.activeSessions' => 'Sessions actives',
			'security.activeSessionsSubtitle' => 'Appareils actuellement connectés à votre compte',
			'security.thisDevice' => 'Cet appareil',
			'security.lastActive' => ({required Object date}) => 'Dernière activité : ${date}',
			'security.revoke' => 'Révoquer',
			'security.revokeConfirmTitle' => 'Révoquer l\'appareil ?',
			'security.revokeConfirmMessage' => ({required Object name}) => '${name} sera déconnecté. Il pourra se reconnecter avec vos identifiants.',
			'security.revokeCurrentConfirmMessage' => 'Il s\'agit de votre appareil actuel — le révoquer vous déconnectera immédiatement.',
			'security.revokeFailed' => 'Impossible de révoquer cet appareil. Réessayez.',
			'security.signOutAllDevices' => 'Déconnecter tous les appareils',
			'security.signOutAllConfirmTitle' => 'Se déconnecter partout ?',
			'security.signOutAllConfirmMessage' => 'Vous serez déconnecté sur tous les appareils, y compris celui-ci.',
			'security.signOutAllFailed' => 'Impossible de se déconnecter de tous les appareils. Réessayez.',
			'security.noDevices' => 'Aucune session active trouvée',
			'security.loadFailed' => 'Impossible de charger vos sessions actives',
			'security.changeEmail' => 'Changer l\'email',
			'security.changeEmailSubtitle' => 'Nous enverrons un code de vérification à votre nouvelle adresse email. Après confirmation, vous vous connecterez avec le nouvel email.',
			'security.newEmailLabel' => 'Nouvel email',
			'security.sendCode' => 'Envoyer le code',
			'security.codeSentTo' => ({required Object email}) => 'Saisissez le code à 6 chiffres envoyé à ${email}',
			'security.confirmNewEmail' => 'Confirmer le nouvel email',
			'security.changeEmailSuccess' => 'Votre email a été modifié. Reconnectez-vous avec votre nouvel email.',
			'security.dangerZone' => 'Zone dangereuse',
			'security.deactivateAccount' => 'Désactiver le compte',
			'security.deactivateAccountSubtitle' => 'Désactiver votre compte sans supprimer vos données',
			'security.deactivateConfirmTitle' => 'Désactiver le compte ?',
			'security.deactivateConfirmMessage' => 'Votre compte sera désactivé et vous serez déconnecté sur tous les appareils. Vos données ne seront pas supprimées. Contactez le support pour le réactiver.',
			'security.deactivate' => 'Désactiver',
			'security.deactivateSuccess' => 'Votre compte a été désactivé.',
			'security.deleteAccount' => 'Supprimer définitivement le compte',
			'security.deleteAccountSubtitle' => 'Effacer vos données. Cette action est irréversible.',
			'security.deleteConfirmTitle' => 'Supprimer définitivement votre compte ?',
			'security.deleteConfirmWarning' => 'Cette action est définitive et ne peut pas être annulée.',
			'security.deleteConfirmMessage' => 'Votre profil, vos dossiers médicaux, vos ordonnances et vos messages seront définitivement effacés. Vos rendez-vous à venir seront annulés et remboursés le cas échéant. Les enregistrements de paiement sont conservés sous forme anonymisée à des fins comptables, comme l\'exige la loi.',
			'security.deleteAccountSuccess' => 'Votre compte a été définitivement supprimé.',
			'status.confirmed' => 'Confirmé',
			'status.pending' => 'En attente',
			'status.cancelled' => 'Annulé',
			'status.declined' => 'Refusé',
			'status.requiresRescheduling' => 'Replanification requise',
			'status.completed' => 'Terminé',
			'status.noShow' => 'Absent',
			'home.helloDoctor' => ({required Object name}) => 'Bonjour, Dr ${name} !',
			'home.helloPatient' => ({required Object name}) => 'Bonjour, ${name} !',
			'home.doctorSubtitle' => 'Gérez votre agenda\net vos rendez-vous.',
			'home.patientSubtitle' => 'Trouvez un médecin et\nprenez rendez-vous.',
			'home.pendingRequests' => 'Demandes en attente',
			'home.upcoming' => 'À venir',
			'home.findDoctor' => 'Trouver un médecin',
			'home.aiAssistant' => 'Assistant IA',
			'home.myAppointments' => 'Mes rendez-vous',
			'home.appointments' => 'Rendez-vous',
			'home.workplaces' => 'Lieux de travail',
			'home.blockTime' => 'Bloquer du temps',
			'home.profile' => 'Profil',
			'home.allCaughtUp' => 'Tout est à jour',
			'home.noPendingRequests' => 'Aucune demande de rendez-vous en attente',
			'home.couldNotLoadAppointments' => 'Impossible de charger les rendez-vous',
			'home.noUpcoming' => 'Aucun rendez-vous à venir',
			'home.bookFirst' => 'Prenez votre premier rendez-vous avec un médecin',
			'home.findADoctor' => 'Trouver un médecin',
			'home.myWaitlist' => 'File d\'attente',
			'home.leaveWaitlist' => 'Quitter',
			'home.statsThisMonth' => 'Ce mois',
			'home.statsPatients' => 'Patients',
			'home.statsAcceptRate' => 'Taux accept.',
			'home.statsPending' => 'En attente',
			'home.schedule' => 'Planning',
			'appointments.title' => 'Rendez-vous',
			'appointments.myTitle' => 'Mes rendez-vous',
			'appointments.tabPending' => 'En attente',
			'appointments.tabAll' => 'Tous',
			'appointments.tabUpcoming' => 'À venir',
			'appointments.tabPast' => 'Passés',
			'appointments.noPendingRequests' => 'Aucune demande en attente',
			'appointments.newRequestsAppear' => 'Les nouvelles demandes de rendez-vous apparaîtront ici',
			'appointments.noAppointments' => 'Aucun rendez-vous',
			'appointments.appointmentsAppear' => 'Vos rendez-vous apparaîtront ici',
			'appointments.noUpcoming' => 'Aucun rendez-vous à venir',
			'appointments.bookFirst' => 'Prenez votre premier rendez-vous avec un médecin',
			'appointments.noPast' => 'Aucun rendez-vous passé',
			'appointments.pastAppear' => 'Les rendez-vous terminés et annulés apparaissent ici',
			'appointments.couldNotLoad' => 'Impossible de charger les rendez-vous',
			'appointments.detailTitle' => 'Rendez-vous',
			'appointments.patient' => 'Patient',
			'appointments.doctor' => 'Médecin',
			'appointments.workplace' => 'Lieu de travail',
			'appointments.dateTime' => 'Date et heure',
			'appointments.reason' => 'Motif',
			'appointments.doctorNotes' => 'Notes du médecin',
			'appointments.cancelTitle' => 'Annuler le rendez-vous',
			'appointments.cancelConfirm' => 'Voulez-vous vraiment annuler ce rendez-vous ?',
			'appointments.cancelAction' => 'Annuler le rendez-vous',
			'appointments.cancelledSuccess' => 'Rendez-vous annulé.',
			'appointments.cancelledRefunded' => 'Rendez-vous annulé. Votre paiement a été remboursé.',
			'appointments.cancelledNoRefund' => 'Rendez-vous annulé. Aucun remboursement n\'a été effectué car l\'annulation est trop proche de l\'heure du rendez-vous.',
			'appointments.bookedTitle' => 'Réservé !',
			'appointments.bookedMessage' => 'Votre demande de rendez-vous a été envoyée.',
			'appointments.reschedule' => 'Reporter',
			'appointments.rescheduleTitle' => 'Reporter le rendez-vous',
			'appointments.reviewTitle' => 'Laisser un avis',
			'appointments.reviewRating' => 'Note',
			'appointments.reviewComment' => 'Commentaire (optionnel)',
			'appointments.reviewSubmit' => 'Envoyer',
			'appointments.markCompleted' => 'Marquer comme terminé',
			'appointments.rescheduledSuccess' => 'Rendez-vous reporté avec succès.',
			'appointments.reviewSubmitted' => 'Avis envoyé. Merci !',
			'appointments.yourReview' => 'Votre avis',
			'appointments.editReviewTitle' => 'Modifier l\'avis',
			'appointments.reviewUpdated' => 'Avis mis à jour.',
			'appointments.deleteReviewTitle' => 'Supprimer l\'avis',
			'appointments.deleteReviewConfirm' => 'Voulez-vous vraiment supprimer votre avis ?',
			'appointments.reviewDeleted' => 'Avis supprimé.',
			'appointments.requestReschedule' => 'Demander un report',
			'appointments.requestRescheduleTitle' => 'Demander un report',
			'appointments.requestRescheduleConfirm' => 'Demander au patient de choisir un nouveau créneau ? Le rendez-vous sera marqué comme à reporter.',
			'appointments.requestRescheduleSuccess' => 'Report demandé. Le patient sera notifié.',
			'appointments.rescheduleNeededHint' => 'Le médecin vous a demandé de choisir un nouveau créneau.',
			'appointments.markNoShow' => 'Marquer absent',
			'appointments.markNoShowTitle' => 'Marquer comme absent',
			'appointments.markNoShowConfirm' => 'Marquer ce rendez-vous comme absent ? Cela enregistre que le patient ne s’est pas présenté.',
			'booking.bookWith' => ({required Object name}) => 'Réserver — ${name}',
			'booking.selectWorkplace' => 'Sélectionner un lieu',
			'booking.pickDate' => 'Choisir une date',
			'booking.slotsAppear' => 'Les créneaux disponibles apparaîtront ici',
			'booking.couldNotLoadSlots' => 'Impossible de charger les créneaux',
			'booking.noAvailableSlots' => 'Aucun créneau disponible',
			'booking.noOpenSlots' => 'Aucun créneau libre pour cette date. Essayez un autre jour.',
			'booking.confirmTitle' => 'Confirmer la réservation',
			'booking.reasonForVisit' => 'Motif de la visite (facultatif)',
			'booking.confirmButton' => 'Confirmer la réservation',
			'booking.doctorLabel' => 'Médecin',
			'booking.workplaceLabel' => 'Lieu de travail',
			'booking.addressLabel' => 'Adresse',
			'booking.startLabel' => 'Début',
			'booking.endLabel' => 'Fin',
			'booking.tryDifferentDate' => 'Essayez une autre date',
			'doctorSearch.title' => 'Trouver un médecin',
			'doctorSearch.searchByName' => 'Rechercher par nom...',
			'doctorSearch.city' => 'Ville',
			'doctorSearch.search' => 'Rechercher',
			'doctorSearch.noDoctorsFound' => 'Aucun médecin trouvé',
			'doctorSearch.adjustSearch' => 'Essayez d\'ajuster votre recherche ou vos filtres',
			'doctorSearch.couldNotLoadDoctors' => 'Impossible de charger les médecins',
			'doctorSearch.loadMore' => 'Charger plus',
			'doctorSearch.spec.general' => 'Général',
			'doctorSearch.spec.cardiology' => 'Cardiologie',
			'doctorSearch.spec.dermatology' => 'Dermatologie',
			'doctorSearch.spec.neurology' => 'Neurologie',
			'doctorSearch.spec.orthopedics' => 'Orthopédie',
			'doctorSearch.spec.pediatrics' => 'Pédiatrie',
			'doctorSearch.spec.psychiatry' => 'Psychiatrie',
			'doctorSearch.spec.gynecology' => 'Gynécologie',
			'doctorSearch.spec.urology' => 'Urologie',
			'doctorSearch.spec.ophthalmology' => 'Ophtalmologie',
			'doctorSearch.spec.ent' => 'ORL',
			'doctorSearch.noAvailability' => 'Indisponible',
			'doctorSearch.availableToday' => 'Disponible auj.',
			'doctorSearch.availableTomorrow' => 'Disponible demain',
			'doctorSearch.availableOn' => ({required Object date}) => 'Dispo le ${date}',
			'doctorSearch.sortBy' => 'Trier par',
			'doctorSearch.sortDefault' => 'Pertinence',
			'doctorSearch.sortRating' => 'Mieux notés',
			'doctorSearch.sortPriceLow' => 'Prix le plus bas',
			'doctorSearch.sortName' => 'Nom (A–Z)',
			'doctorSearch.sortNearestSlot' => 'Disponibilité la plus proche',
			'doctorSearch.sortDistance' => 'Le plus proche de moi',
			'doctorSearch.locationDenied' => 'L\'autorisation de localisation est nécessaire pour trier par distance. Autorisez-la dans les réglages ou filtrez par ville.',
			'doctorSearch.locationUnavailable' => 'Impossible d\'obtenir votre position. Vérifiez que la localisation est activée ou filtrez par ville.',
			'doctorSearch.distanceKm' => ({required Object km}) => '${km} km',
			'doctorDetail.profileTitle' => 'Profil du médecin',
			'doctorDetail.couldNotLoadProfile' => 'Impossible de charger le profil',
			'doctorDetail.about' => 'À propos',
			'doctorDetail.workplaces' => 'Lieux de travail',
			'doctorDetail.minPerSlot' => ({required Object min}) => '${min} min par créneau',
			'doctorDetail.bookAppointment' => 'Prendre rendez-vous',
			'doctorDetail.consultationFee' => 'Frais de consultation',
			'doctorDetail.reviews' => 'Avis',
			'doctorDetail.reviewsCount' => ({required Object count}) => '${count} avis',
			'doctorDetail.joinWaitlist' => 'Rejoindre la liste d’attente',
			'doctorDetail.leaveWaitlist' => 'Quitter la liste d’attente',
			'profile.title' => 'Profil',
			'profile.changePassword' => 'Changer le mot de passe',
			'profile.currentPassword' => 'Mot de passe actuel',
			'profile.newPassword' => 'Nouveau mot de passe',
			'profile.confirmNewPassword' => 'Confirmer le nouveau mot de passe',
			'profile.firstName' => 'Prénom',
			'profile.lastName' => 'Nom',
			'profile.phone' => 'Téléphone',
			'profile.failedToSave' => 'Échec de l\'enregistrement du profil.',
			'profile.professionalInfo' => 'Infos professionnelles',
			'profile.bio' => 'Biographie',
			'profile.bioHint' => 'Brève description de votre expérience',
			'profile.consultationFee' => 'Frais de consultation',
			'profile.medicalInfo' => 'Informations médicales',
			'profile.allergies' => 'Allergies',
			'profile.allergiesHint' => 'ex. Pénicilline, cacahuètes',
			'profile.chronicConditions' => 'Maladies chroniques',
			'profile.chronicConditionsHint' => 'ex. Diabète, hypertension',
			'profile.medications' => 'Médicaments actuels',
			'profile.medicationsHint' => 'ex. Metformine 500mg',
			'profile.appointmentLength' => 'Durée du rendez-vous',
			'profile.cancellationWindow' => 'Délai d’annulation',
			'profile.cancellationWindowHint' => 'Combien de temps avant un rendez-vous les patients peuvent encore annuler/reporter.',
			'profile.hoursValue' => ({required Object h}) => '${h} h',
			'notifications.title' => 'Notifications',
			'notifications.noNotifications' => 'Aucune notification',
			'notifications.allCaughtUp' => 'Vous êtes à jour',
			'notifications.couldNotLoad' => 'Impossible de charger les notifications',
			'notifications.markAllRead' => 'Tout marquer lu',
			'notifications.settingsTitle' => 'Paramètres de notification',
			'notifications.pushEnabled' => 'Notifications push',
			'notifications.pushEnabledSubtitle' => 'Alertes sur cet appareil pour les rendez-vous et mises à jour',
			'notifications.emailEnabled' => 'Notifications par e-mail',
			'notifications.emailEnabledSubtitle' => 'Les mises à jour seront envoyées à votre adresse e-mail',
			'workplaces.title' => 'Mes lieux de travail',
			'workplaces.noWorkplacesYet' => 'Aucun lieu de travail',
			'workplaces.tapToAdd' => 'Appuyez sur + pour ajouter votre premier lieu de travail',
			'workplaces.couldNotLoad' => 'Impossible de charger les lieux de travail',
			'workplaces.deleteTitle' => 'Supprimer le lieu de travail',
			'workplaces.deleteConfirm' => ({required Object name}) => 'Supprimer « ${name} » ?',
			'workplaces.cannotDelete' => 'Impossible de supprimer le lieu de travail',
			'workplaces.workingHours' => 'Heures de travail',
			'workplaces.setAsPrimary' => 'Définir comme principal',
			'addWorkplace.addTitle' => 'Ajouter un lieu de travail',
			'addWorkplace.editTitle' => 'Modifier le lieu de travail',
			'addWorkplace.name' => 'Nom',
			'addWorkplace.address' => 'Adresse (rue)',
			'addWorkplace.city' => 'Ville',
			'addWorkplace.type' => 'Type',
			'addWorkplace.clinic' => 'Clinique',
			'addWorkplace.hospital' => 'Hôpital',
			'addWorkplace.privatePractice' => 'Cabinet privé',
			'addWorkplace.failedToSave' => 'Échec de l\'enregistrement du lieu de travail.',
			'addWorkplace.addButton' => 'Ajouter un lieu de travail',
			'addWorkplace.saveChanges' => 'Enregistrer les modifications',
			'addWorkplace.pickOnMap' => 'Choisir sur la carte',
			'addWorkplace.mapPickerTitle' => 'Choisir l\'emplacement',
			'addWorkplace.useMyLocation' => 'Utiliser ma position',
			'addWorkplace.confirmLocation' => 'Confirmer l\'emplacement',
			'addWorkplace.locationSet' => 'Emplacement défini depuis la carte ✓',
			'addWorkplace.locationPermissionDenied' => 'L\'autorisation de localisation est nécessaire pour utiliser votre position actuelle. Vous pouvez toujours déplacer la carte manuellement.',
			'addWorkplace.locationUnavailable' => 'Impossible d\'obtenir votre position. Vous pouvez toujours déplacer la carte manuellement.',
			'workingHours.title' => 'Heures de travail',
			'workingHours.sectionHint' => 'Définissez les jours et horaires où les patients peuvent prendre rendez-vous à cette adresse.',
			'workingHours.invalidRange' => 'L\'heure de fin doit être postérieure à l\'heure de début pour chaque jour actif.',
			'workingHours.saved' => 'Heures de travail enregistrées',
			'workingHours.failedToSave' => 'Échec de l\'enregistrement des heures de travail',
			'workingHours.days.monday' => 'Lundi',
			'workingHours.days.tuesday' => 'Mardi',
			'workingHours.days.wednesday' => 'Mercredi',
			'workingHours.days.thursday' => 'Jeudi',
			'workingHours.days.friday' => 'Vendredi',
			'workingHours.days.saturday' => 'Samedi',
			'workingHours.days.sunday' => 'Dimanche',
			'blockTime.title' => 'Bloquer du temps',
			'blockTime.dateRange' => 'Plage de dates',
			'blockTime.tapToSelect' => 'Appuyez pour sélectionner les dates',
			'blockTime.reason' => 'Motif (facultatif)',
			'blockTime.notifyPatients' => 'Notifier les patients concernés',
			'blockTime.notifyDesc' => 'Envoyer des notifications aux patients ayant des rendez-vous durant cette période',
			'blockTime.selectDateRange' => 'Veuillez sélectionner une plage de dates.',
			'blockTime.failedToBlock' => 'Échec du blocage. Veuillez réessayer.',
			'blockTime.blockButton' => 'Bloquer la période',
			'onboarding.title' => 'Complétez votre profil',
			'onboarding.professionalInfo' => 'Informations professionnelles',
			'onboarding.tellPatients' => 'Parlez de votre pratique aux patients.',
			'onboarding.specialization' => 'Spécialisation',
			'onboarding.selectSpecialization' => 'Sélectionnez votre spécialisation',
			'onboarding.couldNotLoadSpecs' => 'Impossible de charger les spécialisations. Revenez et réessayez.',
			'onboarding.licenseNumber' => 'Numéro de licence',
			'onboarding.licenseHint' => 'ex. AZ-123456',
			'onboarding.bio' => 'Biographie (facultatif)',
			'onboarding.bioHint' => 'Une brève présentation que les patients verront sur votre profil.',
			'onboarding.appointmentLength' => 'Durée du rendez-vous',
			'onboarding.slotQuestion' => 'Quelle est la durée d\'un créneau de rendez-vous ?',
			'onboarding.changeLater' => 'Vous pourrez le modifier plus tard depuis votre profil.',
			'onboarding.minutes' => ({required Object min}) => '${min} min',
			'onboarding.verificationDoc' => 'Document de vérification',
			'onboarding.uploadDiploma' => 'Téléchargez votre diplôme ou licence médicale. Un administrateur l\'examine avant la vérification de votre compte.',
			'onboarding.tapToChoose' => 'Appuyez pour choisir un fichier',
			'onboarding.tapToReplace' => 'Appuyez pour remplacer',
			'onboarding.anyFileType' => 'Tout type de fichier, jusqu\'à 10 Mo',
			'onboarding.selectSpecError' => 'Veuillez sélectionner votre spécialisation.',
			'onboarding.licenseError' => 'Veuillez saisir votre numéro de licence.',
			'onboarding.diplomaError' => 'Veuillez joindre votre diplôme.',
			'onboarding.checkDetails' => 'Veuillez vérifier vos informations et réessayer.',
			'onboarding.continueButton' => 'Continuer',
			'onboarding.finish' => 'Terminer',
			'pendingVerification.title' => 'Vérification en attente',
			'pendingVerification.message' => 'Votre compte est en cours d\'examen. Nous vous informerons une fois qu\'il sera vérifié.',
			'pendingVerification.checkStatus' => 'Vérifier le statut',
			'pendingVerification.stillPending' => 'Toujours en cours d\'examen. Nous vous informerons une fois vérifié.',
			'phoneField.label' => 'Numéro de téléphone',
			'phoneField.labelOptional' => 'Numéro de téléphone (facultatif)',
			'phoneField.selectCountry' => 'Sélectionner un pays',
			'phoneField.searchCountry' => 'Rechercher un pays ou un code…',
			'phoneField.noCountriesFound' => 'Aucun pays trouvé',
			'locations.pickCity' => 'Sélectionner une ville',
			'locations.searchHint' => 'Rechercher une ville ou une région…',
			'locations.noResultsFound' => 'Aucune ville trouvée',
			'locations.couldNotLoad' => 'Impossible de charger les villes. Appuyez pour réessayer.',
			'locations.allCities' => 'Toutes les villes',
			'splash.tagline' => 'Votre santé, simplifiée',
			'appIntro.page1Title' => 'Trouvez le bon médecin',
			'appIntro.page1Subtitle' => 'Recherchez par spécialité, ville et note — puis réservez un créneau qui vous convient.',
			'appIntro.page2Title' => 'Interrogez notre assistant IA',
			'appIntro.page2Subtitle' => 'Décrivez vos symptômes et découvrez le spécialiste le plus adapté, à tout moment.',
			'appIntro.page3Title' => 'Tout en une seule application',
			'appIntro.page3Subtitle' => 'Gérez vos rendez-vous, suivez votre suivi médical et utilisez l\'application dans votre langue — en toute sécurité.',
			'appIntro.skip' => 'Passer',
			'appIntro.next' => 'Suivant',
			'appIntro.getStarted' => 'Commencer',
			'agenda.title' => 'Planning',
			'agenda.today' => 'Aujourd\'hui',
			'agenda.empty' => 'Aucun rendez-vous',
			'agenda.emptySubtitle' => 'Rien de prévu pour ce jour',
			'favorites.title' => 'Favoris',
			'favorites.empty' => 'Aucun favori',
			'favorites.emptySubtitle' => 'Touchez le cœur d’un médecin pour l’enregistrer ici',
			'favorites.add' => 'Ajouter aux favoris',
			'favorites.remove' => 'Retirer des favoris',
			'assistant.title' => 'Assistant IA',
			'assistant.newChat' => 'Nouvelle discussion',
			'assistant.empty' => 'Aucune discussion pour l\'instant',
			'assistant.emptySubtitle' => 'Décrivez vos symptômes et l\'assistant vous indiquera quel médecin consulter',
			'assistant.couldNotLoad' => 'Impossible de charger les discussions',
			'assistant.couldNotLoadChat' => 'Impossible de charger la discussion',
			'assistant.newConversation' => 'Nouvelle discussion',
			'assistant.deleteTitle' => 'Supprimer la discussion ?',
			'assistant.deleteConfirm' => 'La discussion et tous ses messages seront supprimés.',
			'assistant.inputHint' => 'Décrivez vos symptômes…',
			'assistant.send' => 'Envoyer',
			'assistant.sendFailed' => 'Le message n\'a pas pu être envoyé. Veuillez réessayer.',
			'assistant.typing' => 'L\'assistant écrit…',
			'assistant.startTitle' => 'Comment puis-je aider ?',
			'assistant.startSubtitle' => 'Décrivez ce qui vous préoccupe pour commencer',
			'assistant.book' => 'Prendre RDV',
			'assistant.reportTooltip' => 'Signaler cette réponse',
			'assistant.reportTitle' => 'Signaler la réponse',
			'assistant.reportHint' => 'Motif (facultatif)',
			'assistant.reportSubmit' => 'Signaler',
			'assistant.reportSuccess' => 'Merci, la réponse a été signalée.',
			'assistant.reportFailed' => 'Impossible de signaler la réponse. Veuillez réessayer.',
			'assistant.topicsTooltip' => 'Sujets',
			'assistant.topicsSheetTitle' => 'Choisissez un sujet',
			'messaging.title' => 'Messages',
			'messaging.sendMessage' => 'Envoyer un message',
			'messaging.typeMessage' => 'Écrivez un message…',
			'messaging.send' => 'Envoyer',
			'messaging.empty' => 'Aucune discussion pour l\'instant',
			'messaging.emptySubtitle' => 'Vos discussions apparaîtront ici.',
			'messaging.disclaimer' => 'Ceci n\'est pas une ligne d\'urgence. Pour toute urgence, appelez les services d\'urgence.',
			'messaging.noSharedHistory' => 'Vous pourrez contacter un médecin dès que vous aurez un rendez-vous en commun avec lui.',
			'messaging.newMessage' => 'Vous avez un nouveau message',
			'legal.title' => 'Confidentialité et Conditions',
			'legal.controllerNotice' => 'Medalize est exploité par [Fərdi Sahibkar adı — VÖEN: XXXXXXXXXXXX], Azerbaïdjan (« nous »). Dernière mise à jour : juillet 2026.',
			'legal.privacyTitle' => 'Politique de confidentialité',
			'legal.privacyIntro' => 'Cette politique explique quelles données personnelles Medalize collecte, pourquoi, et comment elles sont protégées. La prise et la gestion de rendez-vous médicaux impliquent nécessairement des informations de santé vous concernant, détaillées ci-dessous.',
			'legal.sections.identity.title' => 'Données d\'identité',
			'legal.sections.identity.body' => 'Nom et prénom, adresse e-mail, numéro de téléphone (facultatif), votre mot de passe (stocké sous forme de hachage irréversible, jamais en clair) et la langue préférée de l\'application.',
			'legal.sections.health.title' => 'Données de santé',
			'legal.sections.health.body' => 'En tant que patient : groupe sanguin, allergies, maladies chroniques, médicaments actuels, motif indiqué lors de la prise de rendez-vous, documents médicaux téléversés (résultats de laboratoire, imagerie, autres dossiers), ordonnances qui vous sont délivrées, et le contenu de vos messages avec votre médecin. Si vous utilisez l\'assistant IA de vérification des symptômes, vos questions et ses réponses sont traitées de la même manière. Les données de santé bénéficient du plus haut niveau de protection selon le droit azerbaïdjanais, et nous ne les collectons qu\'avec votre consentement séparé et explicite (voir « Base légale » ci-dessous).',
			'legal.sections.professional.title' => 'Données professionnelles (médecins)',
			'legal.sections.professional.body' => 'Spécialisation médicale, numéro de licence, diplôme ou autre document de vérification, informations sur le lieu de travail et tarif de consultation. Ces informations sont vérifiées par notre équipe avant que votre profil ne devienne visible aux patients.',
			'legal.sections.location.title' => 'Localisation',
			'legal.sections.location.body' => 'Avec votre permission, une localisation approximative ou précise afin de trier les médecins par distance. Utilisée uniquement lorsque l\'application est ouverte — jamais stockée sur nos serveurs.',
			'legal.sections.device.title' => 'Données de l\'appareil',
			'legal.sections.device.body' => 'Identifiants de l\'appareil et informations de session, afin que vous puissiez voir et révoquer vos connexions actives depuis les Paramètres, ainsi qu\'un jeton de notification push pour vous transmettre rappels de rendez-vous et messages.',
			'legal.sections.payment.title' => 'Données de paiement',
			'legal.sections.payment.body' => 'Si vous payez une consultation dans l\'application, le paiement est traité entièrement par notre partenaire de paiement, Payriff — nous ne voyons ni ne stockons jamais votre numéro de carte. Nous conservons le montant du paiement, son statut et un identifiant de référence pour l\'historique de vos rendez-vous.',
			'legal.sections.family.title' => 'Profils de membres de la famille',
			'legal.sections.family.body' => 'Si vous gérez le profil d\'un membre de la famille (un enfant, ou une personne à charge sans compte propre), les mêmes catégories de données de santé ci-dessus peuvent être enregistrées pour lui sous votre compte. En ajoutant un membre de la famille, vous confirmez être son parent, tuteur, ou autrement autorisé à gérer ses informations de santé en son nom.',
			'legal.sections.purposes.title' => 'Pourquoi nous utilisons vos données',
			'legal.sections.purposes.body' => 'Pour vous permettre de trouver des médecins et de prendre rendez-vous ; permettre aux médecins de gérer leur agenda et leurs patients ; envoyer des rappels de rendez-vous et des mises à jour ; traiter les paiements des consultations ; fournir la fonctionnalité optionnelle de vérification des symptômes par IA ; et sécuriser votre compte.',
			'legal.sections.legalBasis.title' => 'Base légale et votre consentement',
			'legal.sections.legalBasis.body' => 'Nous traitons vos données sur la base du consentement donné lors de votre inscription. Les données de santé constituent une catégorie particulière de données personnelles selon la loi de la République d\'Azerbaïdjan « Sur les données personnelles » (n° 998-IIIQ), qui exige votre consentement explicite et écrit avant leur collecte — c\'est ce qu\'enregistre la case à cocher de l\'écran d\'inscription. Vous pouvez retirer votre consentement à tout moment en supprimant votre compte, bien que nous puissions conserver certains registres lorsque la loi l\'exige (par exemple, des registres financiers à des fins fiscales).',
			'legal.sections.thirdParties.title' => 'Qui traite également vos données',
			'legal.sections.thirdParties.body' => 'Des prestataires de confiance agissant uniquement selon nos instructions, pour les finalités décrites ici : Cloudinary (stockage sécurisé des fichiers — documents et photos jamais accessibles publiquement, uniquement via des liens signés et à durée limitée) ; Firebase/Google (notifications push, et connexion Google si vous le choisissez) ; Apple (connexion avec Apple, si vous le choisissez) ; Payriff (paiements dans l\'application). Nous ne vendons pas vos données personnelles.',
			'legal.sections.retention.title' => 'Durée de conservation de vos données',
			'legal.sections.retention.body' => 'Aussi longtemps que votre compte est actif. Si vous supprimez votre compte, nous supprimons vos données personnelles dans un délai raisonnable, à l\'exception des registres que nous devons légalement conserver (par exemple, les registres de paiement à des fins fiscales).',
			'legal.sections.rights.title' => 'Vos droits',
			'legal.sections.rights.body' => 'Vous pouvez accéder aux données que nous détenons sur vous, demander la correction de données inexactes, demander la suppression de votre compte et de vos données, et retirer votre consentement à tout moment. La plupart de ces actions sont disponibles directement dans Profil > Paramètres ; pour le reste, contactez-nous ci-dessous.',
			'legal.sections.security.title' => 'Comment nous protégeons vos données',
			'legal.sections.security.body' => 'Les messages entre vous et votre médecin, ainsi que les conversations avec l\'assistant IA, sont chiffrés. Les documents et photos téléversés sont stockés de manière privée, accessibles uniquement via des liens sécurisés et signés, jamais comme fichiers publics. Les mots de passe ne sont jamais stockés sous une forme lisible.',
			'legal.sections.permissions.title' => 'Autorisations que nous demandons',
			'legal.sections.permissions.body' => 'Appareil photo et photothèque — pour définir une photo de profil et téléverser des documents médicaux. Localisation — pour trier les médecins par distance. Notifications — pour transmettre rappels de rendez-vous et messages. Biométrie (Face ID / empreinte digitale) — un moyen optionnel et plus rapide de déverrouiller l\'application ; vos données biométriques ne quittent jamais votre appareil, nous recevons uniquement une confirmation oui/non de son système d\'exploitation.',
			'legal.sections.children.title' => 'Condition d\'âge',
			'legal.sections.children.body' => 'Les comptes Medalize sont destinés aux adultes. Si vous avez moins de 18 ans, demandez à un parent ou tuteur de créer et de gérer un compte en votre nom via la fonctionnalité de profils familiaux.',
			'legal.termsTitle' => 'Conditions d\'utilisation',
			'legal.termsIntro' => 'En créant un compte, vous acceptez ce qui suit.',
			'legal.termsBody' => 'Fournir des informations exactes vous concernant. Utiliser Medalize uniquement pour trouver, réserver et gérer des rendez-vous médicaux. Garder vos identifiants de connexion confidentiels. Medalize vous met en relation avec des professionnels de santé indépendants et agréés — nous ne sommes pas nous-mêmes un prestataire de soins, et l\'assistant IA de vérification des symptômes ne remplace pas un diagnostic ou un avis médical professionnel. En cas d\'urgence médicale, contactez directement les services d\'urgence, pas cette application. Nous pouvons suspendre ou résilier les comptes qui enfreignent ces conditions ou qui font un usage abusif de la plateforme.',
			'legal.contact' => 'Des questions sur vos données ? Contactez support@medalize.az',
			'legal.consentPrefix' => 'J\'ai lu et j\'accepte la ',
			'legal.consentPrivacyLink' => 'Politique de confidentialité',
			'legal.consentMiddle' => ' et les ',
			'legal.consentTermsLink' => 'Conditions d\'utilisation',
			'legal.consentSuffix' => ', et je consens explicitement au traitement de mes données de santé tel que décrit.',
			'legal.viewAsPdf' => 'Voir en PDF',
			'legal.pdfDocumentTitle' => 'Medalize — Politique de confidentialité et conditions d\'utilisation',
			'legal.pdfLoadError' => 'Impossible de charger le document. Vérifiez votre connexion internet et réessayez.',
			'medications.title' => 'Médicaments',
			'medications.editMedication' => 'Modifier le médicament',
			'medications.name' => 'Nom',
			'medications.dosage' => 'Dosage',
			'medications.notes' => 'Notes',
			'medications.form' => 'Forme',
			_ => null,
		} ?? switch (path) {
			'medications.formPill' => 'Comprimé',
			'medications.formCapsule' => 'Gélule',
			'medications.formLiquid' => 'Liquide',
			'medications.formInjection' => 'Injection',
			'medications.formOther' => 'Autre',
			'medications.schedule' => 'Horaire',
			'medications.times' => 'Heures de prise',
			'medications.addTime' => 'Ajouter une heure',
			'medications.daysOfWeek' => 'Jours de la semaine',
			'medications.everyDay' => 'Tous les jours',
			'medications.startDate' => 'Date de début',
			'medications.endDate' => 'Date de fin',
			'medications.save' => 'Enregistrer',
			'medications.delete' => 'Supprimer',
			'medications.deleteConfirmTitle' => 'Supprimer le médicament',
			'medications.deleteConfirmBody' => 'Voulez-vous vraiment supprimer ce médicament ? L\'historique des prises sera conservé.',
			'medications.emptyTitle' => 'Aucun médicament pour l\'instant',
			'medications.emptySubtitle' => 'Les médicaments prescrits par votre médecin apparaîtront ici après votre consultation.',
			'medications.todaysDoses' => 'Prises du jour',
			'medications.markTaken' => 'Pris',
			'medications.markSkipped' => 'Ignorer',
			'medications.statusTaken' => 'Pris',
			'medications.statusSkipped' => 'Ignoré',
			'medications.statusPending' => 'En attente',
			'medications.reminderTitle' => ({required Object name}) => 'C\'est l\'heure de prendre ${name}',
			'medications.reminderBody' => ({required Object dosage}) => 'Dose : ${dosage}',
			'medications.tabActive' => 'Actifs',
			'medications.tabArchive' => 'Archivés',
			'medications.fromPrescription' => 'Sur ordonnance',
			'medications.noSchedule' => 'Aucun horaire défini — appuyez pour ajouter des heures de rappel',
			'medications.dayMon' => 'Lun',
			'medications.dayTue' => 'Mar',
			'medications.dayWed' => 'Mer',
			'medications.dayThu' => 'Jeu',
			'medications.dayFri' => 'Ven',
			'medications.daySat' => 'Sam',
			'medications.daySun' => 'Dim',
			'medications.updatedSuccess' => 'Médicament mis à jour.',
			'medications.deletedSuccess' => 'Médicament supprimé.',
			'medications.atLeastOneTime' => 'Ajoutez au moins une heure de rappel',
			'prescriptions.title' => 'Ordonnances',
			'prescriptions.writeTitle' => 'Rédiger une ordonnance',
			'prescriptions.addDrug' => 'Ajouter un médicament',
			'prescriptions.drugName' => 'Nom du médicament',
			'prescriptions.dosage' => 'Dosage',
			'prescriptions.frequency' => 'Fréquence',
			'prescriptions.duration' => 'Durée',
			'prescriptions.instructions' => 'Instructions',
			'prescriptions.notes' => 'Notes',
			'prescriptions.save' => 'Enregistrer',
			'prescriptions.empty' => 'Aucune ordonnance pour l\'instant',
			'prescriptions.emptySubtitle' => 'Les ordonnances émises par votre médecin apparaîtront ici.',
			'prescriptions.viewDetails' => 'Voir les détails',
			'prescriptions.issuedBy' => ({required Object name}) => 'Émise par le Dr ${name}',
			'prescriptions.issuedOn' => ({required Object date}) => 'Émise le ${date}',
			'prescriptions.applyToMedications' => 'Ajouter à mes médicaments',
			'prescriptions.applySuccess' => 'Ajouté à vos médicaments. Configurez les heures de rappel pour être notifié.',
			'prescriptions.alreadyApplied' => 'Déjà ajouté à vos médicaments',
			'prescriptions.noPrescriptionYet' => 'Aucune ordonnance pour ce rendez-vous pour l\'instant',
			'prescriptions.writePrescription' => 'Rédiger une ordonnance',
			'prescriptions.prescriptionIssued' => 'Ordonnance émise.',
			'prescriptions.removeDrug' => 'Retirer',
			'prescriptions.atLeastOneDrug' => 'Ajoutez au moins un médicament',
			'prescriptions.drugNameRequired' => 'Le nom du médicament est requis',
			'prescriptions.summaryTitle' => 'Ordonnance',
			'prescriptions.itemsCount' => ({required Object count}) => '${count} médicaments',
			'prescriptions.newPrescription' => 'Nouvelle ordonnance',
			'prescriptions.youHavePrescription' => 'Ce rendez-vous a une ordonnance',
			'records.title' => 'Dossier Médical',
			'records.upload' => 'Téléverser un document',
			'records.recordType' => 'Type de document',
			'records.typeLabResult' => 'Résultat d\'analyse',
			'records.typeImaging' => 'Imagerie',
			'records.typeDocument' => 'Document',
			'records.typeOther' => 'Autre',
			'records.recordTitle' => 'Titre',
			'records.recordDate' => 'Date',
			'records.notes' => 'Notes',
			'records.chooseFile' => 'Choisir un fichier',
			'records.changeFile' => 'Changer de fichier',
			'records.noFileChosen' => 'Aucun fichier choisi',
			'records.save' => 'Enregistrer',
			'records.delete' => 'Supprimer',
			'records.deleteConfirmTitle' => 'Supprimer le document',
			'records.deleteConfirmBody' => 'Voulez-vous vraiment supprimer ce document ? Cette action est irréversible.',
			'records.empty' => 'Aucun document médical pour l\'instant',
			'records.emptySubtitle' => 'Conservez vos résultats d\'analyses, imageries et autres documents au même endroit.',
			'records.view' => 'Ouvrir',
			'records.fileRequired' => 'Choisissez un fichier à téléverser',
			'records.fileTooLarge' => 'Le fichier est trop volumineux (max 15 Mo)',
			'records.titleRequired' => 'Le titre est requis',
			'records.uploadSuccess' => 'Document téléversé.',
			'records.deletedSuccess' => 'Document supprimé.',
			'records.couldNotOpen' => 'Impossible d\'ouvrir le fichier',
			'payments.title' => 'Paiement',
			'payments.amount' => 'Montant',
			'payments.payNow' => 'Payer maintenant',
			'payments.payLater' => 'Payer plus tard',
			'payments.statusPending' => 'Paiement en attente',
			'payments.statusPaid' => 'Payé',
			'payments.statusFailed' => 'Échec du paiement',
			'payments.statusCancelled' => 'Annulé',
			'payments.statusRefunded' => 'Remboursé',
			'payments.statusRefundFailed' => 'Échec du remboursement',
			'payments.paymentConfirmed' => 'Paiement confirmé. Merci !',
			'payments.openingBrowser' => 'Ouverture du navigateur…',
			'payments.checkStatus' => 'Vérifier le statut',
			'family.title' => 'Famille',
			'family.myself' => 'Moi-même',
			'family.addFamilyMember' => 'Ajouter un membre de la famille',
			'family.editFamilyMember' => 'Modifier le membre de la famille',
			'family.firstName' => 'Prénom',
			'family.lastName' => 'Nom',
			'family.relationship' => 'Lien de parenté',
			'family.relationshipChild' => 'Enfant',
			'family.relationshipSpouse' => 'Conjoint(e)',
			'family.relationshipParent' => 'Parent',
			'family.relationshipSibling' => 'Frère/Sœur',
			'family.relationshipOther' => 'Autre',
			'family.dateOfBirth' => 'Date de naissance',
			'family.bloodType' => 'Groupe sanguin',
			'family.allergies' => 'Allergies',
			'family.chronicConditions' => 'Maladies chroniques',
			'family.medications' => 'Médicaments actuels',
			'family.save' => 'Enregistrer',
			'family.delete' => 'Supprimer',
			'family.deleteConfirmTitle' => 'Supprimer le membre de la famille',
			'family.deleteConfirmBody' => 'Voulez-vous vraiment supprimer ce membre de la famille ? L\'historique des rendez-vous, médicaments et documents sera conservé.',
			'family.empty' => 'Aucun membre de la famille pour l\'instant',
			'family.emptySubtitle' => 'Ajoutez un enfant, un conjoint ou un autre proche pour gérer ses rendez-vous, médicaments et documents.',
			'family.bookingForQuestion' => 'Pour qui est ce rendez-vous ?',
			'family.bookingForLabel' => ({required Object name}) => 'Rendez-vous pour : ${name}',
			'family.forLabel' => ({required Object name}) => 'pour ${name}',
			'family.ageYears' => ({required Object age}) => '${age} ans',
			'family.bookedByLabel' => ({required Object name}) => 'Pris par ${name}',
			'family.contactEmail' => 'E-mail de contact',
			'family.contactEmailHelp' => 'Nous les informerons qu\'ils ont été ajoutés, avec un moyen simple de refuser.',
			'family.contactPhoneOptional' => 'Téléphone de contact (facultatif)',
			'family.contactEmailRequiredForAdult' => 'Une adresse e-mail est requise pour que nous puissions informer ce membre de la famille',
			'family.adultConsentNotice' => 'Comme cette personne a 18 ans ou plus, nous lui enverrons un e-mail pour l\'informer que vous l\'avez ajoutée — elle n\'a pas besoin de l\'application et peut supprimer cette connexion à tout moment.',
			'family.noticeAlreadySent' => 'Nous l\'avons informée qu\'elle a été ajoutée. Elle peut supprimer cette connexion à tout moment.',
			'family.noticePendingBadge' => 'Notification envoyée',
			'subscription.title' => 'Abonnement',
			'subscription.planNameBasic' => 'Débutant',
			'subscription.planNamePro' => 'Professionnel',
			'subscription.couldNotLoad' => 'Impossible de charger votre abonnement.',
			'subscription.nowActive' => 'Votre abonnement est maintenant actif !',
			'subscription.unavailable' => 'Les abonnements ne sont pas disponibles pour le moment. Veuillez réessayer plus tard.',
			'subscription.trialDaysLeft' => ({required Object days}) => 'Essai gratuit — ${days} jour(s) restant(s)',
			'subscription.graceDaysLeft' => ({required Object days}) => 'Période de grâce — ${days} jour(s) restant(s) pour renouveler',
			'subscription.expiredNotice' => 'Votre abonnement a expiré. Abonnez-vous pour redevenir visible aux patients.',
			'subscription.activeNotice' => 'Votre abonnement est actif.',
			'subscription.choosePlan' => 'Choisissez un forfait pour commencer.',
			'subscription.currentPlan' => 'Forfait Actuel',
			'subscription.mostPopular' => 'Le Plus Populaire',
			'subscription.perMonth' => 'par mois',
			'subscription.manageOnWeb' => 'Gérez votre abonnement sur medalize.az',
			'subscription.featureUnlimitedWorkplaces' => 'Cliniques illimitées',
			'subscription.featureWorkplaces' => ({required Object count}) => 'Jusqu\'à ${count} clinique(s)',
			'subscription.featureUnlimitedBookings' => 'Réservations mensuelles illimitées',
			'subscription.featureBookingsPerMonth' => ({required Object count}) => 'Jusqu\'à ${count} réservations par mois',
			'subscription.featureChat' => 'Chat avec les patients',
			'subscription.featurePromoted' => 'Placement prioritaire + badge « Peşəkar »',
			'subscription.renew' => 'Renouveler',
			'subscription.subscribe' => 'S\'abonner',
			'subscription.planNameHospitalBasic' => 'Clinique',
			'subscription.planNameHospitalPro' => 'Clinique Plus',
			'subscription.featureDoctors' => ({required Object count}) => 'Jusqu\'à ${count} médecin(s)',
			'subscription.featureUnlimitedDoctors' => 'Médecins illimités',
			'subscription.featureAdvancedStats' => 'Statistiques avancées',
			'hospitalPicker.title' => 'Sélectionner un hôpital',
			'hospitalPicker.searchHint' => 'Rechercher un hôpital…',
			'hospitalPicker.noResultsFound' => 'Aucun hôpital trouvé',
			'hospitalPicker.selectCityFirst' => 'Sélectionnez d\'abord une ville',
			'hospitalPicker.addVariant' => ({required Object name}) => 'Ajouter « ${name} »',
			'hospitalPicker.pendingReview' => 'En cours de vérification',
			'hospitalRegistration.title' => 'Détails de l\'hôpital',
			'hospitalRegistration.subtitle' => 'Sélectionnez votre ville, puis trouvez votre hôpital ci-dessous ou ajoutez-le.',
			'hospitalRegistration.cityStep' => '1. Ville',
			'hospitalRegistration.hospitalStep' => '2. Hôpital',
			'hospitalRegistration.searchHint' => 'Rechercher un hôpital…',
			'hospitalRegistration.noResultsFound' => 'Aucun hôpital trouvé',
			'hospitalRegistration.notFoundPrompt' => 'Vous ne trouvez pas votre hôpital ?',
			'hospitalRegistration.addManually' => 'Ajouter manuellement',
			'hospitalRegistration.useSearchInstead' => 'Rechercher à nouveau',
			'hospitalRegistration.newHospitalName' => 'Nom de l\'hôpital',
			'hospitalRegistration.selectedPrefix' => 'Sélectionné :',
			'hospitalRegistration.pendingReviewNotice' => 'Les nouveaux hôpitaux sont vérifiés par notre équipe avant d\'apparaître ailleurs.',
			'hospitalRegistration.submit' => 'Créer un compte',
			'hospitalRegistration.hospitalRequired' => 'Sélectionnez ou ajoutez votre hôpital pour continuer',
			'hospitalHome.greeting' => ({required Object name}) => 'Bonjour, ${name}',
			'hospitalHome.subtitle' => 'Gérez vos médecins et vos rendez-vous',
			'hospitalHome.doctors' => 'Médecins',
			'hospitalHome.inviteDoctor' => 'Inviter un médecin',
			'hospitalHome.appointments' => 'Rendez-vous',
			'hospitalHome.profile' => 'Profil',
			'hospitalHome.pendingRequests' => ({required Object count}) => '${count} demande(s) en attente',
			'hospitalDoctors.title' => 'Médecins',
			'hospitalDoctors.tabConfirmed' => 'Confirmés',
			'hospitalDoctors.tabRequests' => 'Demandes',
			'hospitalDoctors.tabInvited' => 'Invités',
			'hospitalDoctors.noConfirmedDoctors' => 'Aucun médecin confirmé pour l\'instant',
			'hospitalDoctors.noRequests' => 'Aucune demande en attente',
			'hospitalDoctors.noInvited' => 'Aucune invitation en attente',
			'hospitalDoctors.approve' => 'Approuver',
			'hospitalDoctors.reject' => 'Refuser',
			'hospitalDoctors.remove' => 'Retirer',
			'hospitalDoctors.removeConfirmTitle' => 'Retirer ce médecin ?',
			'hospitalDoctors.removeConfirmMessage' => ({required Object name}) => '${name} ne sera plus affilié à votre hôpital. Cela n\'affecte pas son lieu de travail ni ses rendez-vous.',
			'hospitalDoctors.requestedToJoin' => 'A demandé à rejoindre',
			'hospitalDoctors.invitedAwaiting' => 'Invité — en attente de réponse',
			'hospitalDoctors.editHours' => 'Modifier les horaires',
			'hospitalInvite.title' => 'Inviter un médecin',
			'hospitalInvite.searchHint' => 'Rechercher par nom ou spécialité…',
			'hospitalInvite.noResultsFound' => 'Aucun médecin trouvé',
			'hospitalInvite.invite' => 'Inviter',
			'hospitalInvite.invited' => 'Invité',
			'hospitalAppointments.title' => 'Rendez-vous',
			'hospitalAppointments.empty' => 'Aucun rendez-vous pour l\'instant',
			'hospitalProfile.title' => 'Profil de l\'hôpital',
			'hospitalProfile.usageDoctors' => ({required Object count, required Object limit}) => '${count} sur ${limit} médecins',
			'hospitalProfile.usageDoctorsUnlimited' => ({required Object count}) => '${count} médecins (illimité)',
			'hospitalProfile.manageSubscription' => 'Gérer l\'abonnement',
			'hospitalDoctorHours.title' => 'Horaires de travail',
			'hospitalDoctorHours.selectWorkplace' => 'Sélectionner un lieu de travail',
			'hospitalDoctorHours.saved' => 'Horaires enregistrés',
			'doctorHospitals.title' => 'Mes hôpitaux',
			'doctorHospitals.tabInvitations' => 'Invitations',
			'doctorHospitals.tabRequests' => 'Demandes',
			'doctorHospitals.tabConfirmed' => 'Hôpitaux',
			'doctorHospitals.noInvitations' => 'Aucune invitation en attente',
			'doctorHospitals.noRequests' => 'Aucune demande en attente',
			'doctorHospitals.noConfirmed' => 'Vous n\'êtes affilié à aucun hôpital pour l\'instant',
			'doctorHospitals.accept' => 'Accepter',
			'doctorHospitals.decline' => 'Refuser',
			'doctorHospitals.cancelRequest' => 'Annuler la demande',
			'doctorHospitals.invitedYouToJoin' => 'Vous a invité à le rejoindre',
			'doctorHospitals.awaitingApproval' => 'En attente de l\'approbation de l\'hôpital',
			_ => null,
		};
	}
}
