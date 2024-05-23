import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeClass {
  Color lightPrimaryColor = Color.fromARGB(200, 101, 101, 101);
  Color darkPrimaryColor = Color(0xFF480032);
  Color secondaryColor = Color(0xFFFF8B6A);
  Color accentColor = Color(0xFFFFD2BB);

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: _themeClass.lightPrimaryColor,
      secondary: _themeClass.secondaryColor,
    )
  );

   static ThemeData darkTheme = ThemeData(
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.grey),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _themeClass.darkPrimaryColor,
      )
    );
}

ThemeClass _themeClass = ThemeClass();
