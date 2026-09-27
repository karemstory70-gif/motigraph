import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motigraph/onpoding/onbording_screen.dart';
import 'package:motigraph/splash_screen.dart';
import 'package:motigraph/settings/app_settings_controller.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  final settingsController =
  AppSettingsController();

  await settingsController.loadSettings();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],

      path: 'assets/translations',

      fallbackLocale: const Locale('en'),

      startLocale: settingsController.locale,

      child: MyApp(
        settingsController: settingsController,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final AppSettingsController settingsController;

  const MyApp({
    super.key,
    required this.settingsController,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    widget.settingsController.addListener(
      _settingsChanged,
    );
  }

  @override
  void dispose() {
    widget.settingsController.removeListener(
      _settingsChanged,
    );

    super.dispose();
  }

  void _settingsChanged() {
    setState(() {});

    context.setLocale(
      widget.settingsController.locale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // =========================
      // Theme
      // =========================

      theme: AppTheme.light,

      darkTheme: AppTheme.dark,

      themeMode:
      widget.settingsController.themeMode,

      // =========================
      // Localization
      // =========================

      localizationsDelegates:
      context.localizationDelegates,

      supportedLocales:
      context.supportedLocales,

      locale: context.locale,

      // =========================
      // Home
      // =========================

      home: OnboardingScreen(
        settingsController:
        widget.settingsController,
      ),
    );
  }
}