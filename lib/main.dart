import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/locale/locale_provider.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_mode_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:medalize_mb/routing/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase powers FCM push notifications. With a placeholder
  // GoogleService-Info.plist (before the real project is registered) init can
  // fail — that must not block app launch, so we degrade gracefully.
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase init skipped (push notifications disabled): $e');
  }
  await initLocale();
  runApp(TranslationProvider(child: const ProviderScope(child: MedalizeApp())));
}

class MedalizeApp extends ConsumerStatefulWidget {
  const MedalizeApp({super.key});

  @override
  ConsumerState<MedalizeApp> createState() => _MedalizeAppState();
}

class _MedalizeAppState extends ConsumerState<MedalizeApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Drives the biometric re-lock gate: a long-enough stint in the
    // background re-prompts for Face ID/Touch ID before the restored session
    // is trusted again. See AuthNotifier.handleAppPaused/handleAppResumed.
    final notifier = ref.read(authProvider.notifier);
    if (state == AppLifecycleState.paused) {
      notifier.handleAppPaused();
    } else if (state == AppLifecycleState.resumed) {
      notifier.handleAppResumed();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild when the language changes (selection drives LocaleSettings, which
    // TranslationProvider exposes via context below).
    ref.watch(localeProvider);
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Medalize',
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
