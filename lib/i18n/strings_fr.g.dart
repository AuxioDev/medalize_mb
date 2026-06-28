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
	@override late final _Translations$splash$fr splash = _Translations$splash$fr._(_root);
	@override late final _Translations$agenda$fr agenda = _Translations$agenda$fr._(_root);
	@override late final _Translations$favorites$fr favorites = _Translations$favorites$fr._(_root);
	@override late final _Translations$legal$fr legal = _Translations$legal$fr._(_root);
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
	@override String get myWaitlist => 'Ma liste d\'attente';
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
	@override String get address => 'Adresse';
	@override String get city => 'Ville';
	@override String get type => 'Type';
	@override String get clinic => 'Clinique';
	@override String get hospital => 'Hôpital';
	@override String get privatePractice => 'Cabinet privé';
	@override String get failedToSave => 'Échec de l\'enregistrement du lieu de travail.';
	@override String get addButton => 'Ajouter un lieu de travail';
	@override String get saveChanges => 'Enregistrer les modifications';
}

// Path: workingHours
class _Translations$workingHours$fr extends Translations$workingHours$en {
	_Translations$workingHours$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Heures de travail';
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

// Path: splash
class _Translations$splash$fr extends Translations$splash$en {
	_Translations$splash$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'Votre santé, simplifiée';
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

// Path: legal
class _Translations$legal$fr extends Translations$legal$en {
	_Translations$legal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confidentialité et conditions';
	@override String get privacyTitle => 'Politique de confidentialité';
	@override String get privacyBody => 'Medalize traite vos informations personnelles et de santé afin que vous puissiez prendre et gérer des rendez-vous médicaux. Nous ne vendons pas vos données. La politique de confidentialité complète sera publiée ici avant le lancement public.';
	@override String get termsTitle => 'Conditions d’utilisation';
	@override String get termsBody => 'En utilisant Medalize, vous acceptez d’utiliser le service de manière responsable pour la prise et la gestion des rendez-vous. Les conditions d’utilisation complètes seront publiées ici avant le lancement public.';
	@override String get draftNotice => 'Brouillon — en attente de la révision juridique finale.';
	@override String get contact => 'Des questions sur vos données ? Contactez support@medalize.app';
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
			'home.myWaitlist' => 'Ma liste d\'attente',
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
			'addWorkplace.address' => 'Adresse',
			'addWorkplace.city' => 'Ville',
			'addWorkplace.type' => 'Type',
			'addWorkplace.clinic' => 'Clinique',
			'addWorkplace.hospital' => 'Hôpital',
			'addWorkplace.privatePractice' => 'Cabinet privé',
			'addWorkplace.failedToSave' => 'Échec de l\'enregistrement du lieu de travail.',
			'addWorkplace.addButton' => 'Ajouter un lieu de travail',
			'addWorkplace.saveChanges' => 'Enregistrer les modifications',
			'workingHours.title' => 'Heures de travail',
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
			'phoneField.label' => 'Numéro de téléphone',
			'phoneField.labelOptional' => 'Numéro de téléphone (facultatif)',
			'phoneField.selectCountry' => 'Sélectionner un pays',
			'phoneField.searchCountry' => 'Rechercher un pays ou un code…',
			'phoneField.noCountriesFound' => 'Aucun pays trouvé',
			'splash.tagline' => 'Votre santé, simplifiée',
			'agenda.title' => 'Planning',
			'agenda.today' => 'Aujourd\'hui',
			'agenda.empty' => 'Aucun rendez-vous',
			'agenda.emptySubtitle' => 'Rien de prévu pour ce jour',
			'favorites.title' => 'Favoris',
			'favorites.empty' => 'Aucun favori',
			'favorites.emptySubtitle' => 'Touchez le cœur d’un médecin pour l’enregistrer ici',
			'favorites.add' => 'Ajouter aux favoris',
			'favorites.remove' => 'Retirer des favoris',
			'legal.title' => 'Confidentialité et conditions',
			'legal.privacyTitle' => 'Politique de confidentialité',
			'legal.privacyBody' => 'Medalize traite vos informations personnelles et de santé afin que vous puissiez prendre et gérer des rendez-vous médicaux. Nous ne vendons pas vos données. La politique de confidentialité complète sera publiée ici avant le lancement public.',
			'legal.termsTitle' => 'Conditions d’utilisation',
			'legal.termsBody' => 'En utilisant Medalize, vous acceptez d’utiliser le service de manière responsable pour la prise et la gestion des rendez-vous. Les conditions d’utilisation complètes seront publiées ici avant le lancement public.',
			'legal.draftNotice' => 'Brouillon — en attente de la révision juridique finale.',
			'legal.contact' => 'Des questions sur vos données ? Contactez support@medalize.app',
			_ => null,
		};
	}
}
