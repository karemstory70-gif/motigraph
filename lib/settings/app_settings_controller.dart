import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsController extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language';

  ThemeMode _themeMode = ThemeMode.system;

  Locale _locale = const Locale('ar');

  ThemeMode get themeMode => _themeMode;

  Locale get locale => _locale;

  // تحميل الإعدادات المحفوظة
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // Theme
    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme == 'light') {
      _themeMode = ThemeMode.light;
    } else if (savedTheme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }

    // Language
    final savedLanguage = prefs.getString(_languageKey);

    if (savedLanguage != null) {
      _locale = Locale(savedLanguage);
    }

    notifyListeners();
  }

  // تغيير الـ Theme
  Future<void> changeTheme(ThemeMode mode) async {
    _themeMode = mode;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _themeKey,
      mode.name,
    );

    notifyListeners();
  }

  // تغيير اللغة
  Future<void> changeLanguage(Locale locale) async {
    _locale = locale;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _languageKey,
      locale.languageCode,
    );

    notifyListeners();
  }
}
