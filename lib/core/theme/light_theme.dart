import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      scaffoldBackgroundColor: Colors.white,

      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.black,

        tertiary: Color(0xFFD4AF37),

        surface: Colors.white,

        onPrimary: Colors.white,
        onSecondary: Colors.white,

        onTertiary: Colors.black,

        onSurface: Colors.black,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black),
        titleSmall: TextStyle(color: Colors.black),
      ),
    );
  }
}