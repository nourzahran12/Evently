import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryLight = Color(0xFF0E3A99);
  static const Color primaryDark = Color(0xFF457AED);
  static const Color backgroundLight = Color(0xFFF4F7FF);
  static const Color backgroundDark = Color(0xFF000F30);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF0F0F0);
  static const Color black = Color(0xFF1C1C1C);
  static const Color lightGrey = Color(0xFFE9EAEB);
  static const Color darkGrey = Color(0xFF686868);
  static const Color grey = Color(0xFFB9B9B9);
  static const Color red = Color(0xFFFF3232);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryLight,
    scaffoldBackgroundColor: backgroundLight,
    listTileTheme: ListTileThemeData(
      tileColor: AppTheme.white,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(16)),
      minTileHeight: 0,
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black,
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: white,
      filled: true,
      hintStyle: TextStyle(fontSize: 14, fontWeight: .w400, color: grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: offWhite),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: offWhite),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: red),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: primaryDark,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: white,
      shape: CircleBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        foregroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: TextStyle(fontSize: 20, fontWeight: .w500),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: .w600,
          decoration: .underline,
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryLight,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: grey,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData();
}
