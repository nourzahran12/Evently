import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/onboarding_screen.dart';
import 'package:evently/onboarding_setup_screen.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  bool isOnboardingSeen = prefs.getBool('onboarding_seen') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EventsProvider()..getEvents()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: EventlyApp(isOnboardingSeen: isOnboardingSeen),
    ),
  );
}

class EventlyApp extends StatelessWidget {
  bool isOnboardingSeen;
  EventlyApp({required this.isOnboardingSeen});
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routName: (_) => HomeScreen(),
        RegisterScreen.routName: (_) => RegisterScreen(),
        LoginScreen.routName: (_) => LoginScreen(),
        CreateEventScreen.routName: (_) => CreateEventScreen(),
        OnboardingSetupScreen.routName: (_) => OnboardingSetupScreen(),
        OnboardingScreen.routName: (_) => OnboardingScreen(),
      },
      initialRoute: isOnboardingSeen
          ? LoginScreen.routName
          : OnboardingSetupScreen.routName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: settingsProvider.languageCode == null
          ? null
          : Locale(settingsProvider.languageCode!),
    );
  }
}
