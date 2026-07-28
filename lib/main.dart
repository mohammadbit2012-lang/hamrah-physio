import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/theme/app_theme.dart';
import 'core/config/router/app_router.dart';
import 'core/localization/app_localizations.dart';

/// The main entry point for the Hamrah Physio commercial software project.
/// This structure adheres to clean architecture principles and integrates
/// Riverpod for reactive state management and GoRouter for declarative routing.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Wrap the entire app inside ProviderScope for Riverpod state tracking.
  runApp(
    const ProviderScope(
      child: HamrahPhysioApp(),
    ),
  );
}

class HamrahPhysioApp extends ConsumerWidget {
  const HamrahPhysioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the configured declarative router from our config module
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Hamrah Physio',
      debugShowCheckedModeBanner: false,
      
      // Configuration for Declarative Navigation via GoRouter
      routerConfig: router,
      
      // High-Fidelity Material 3 Theme Configuration
      themeMode: ThemeMode.light, // Configurable via state management
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      
      // Localization Configurations (Strict RTL for Persian / Persian Localizations)
      locale: const Locale('fa', 'IR'), // Default locale set to Persian RTL
      supportedLocales: const [
        Locale('fa', 'IR'), // Persian (Iran)
        Locale('en', 'US'), // English (USA) for professional fallbacks
      ],
      
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Forces RTL directionality when locale is Persian
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('fa', 'IR'); // Default fallback to Persian RTL
      },
    );
  }
}