import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/locale/locale_provider.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_mode_provider.dart';
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

class MedalizeApp extends ConsumerWidget {
  const MedalizeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
