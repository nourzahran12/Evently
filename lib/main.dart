import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EventlyApp());
}

class EventlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routName: (_) => HomeScreen(),
        RegisterScreen.routName: (_) => RegisterScreen(),
        LoginScreen.routName: (_) => LoginScreen(),
      },
      initialRoute: LoginScreen.routName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: .light,
    );
  }
}
