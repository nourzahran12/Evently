import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = .dark;

  bool get isDark => themeMode == .dark;

  void changeTheme(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }
}
