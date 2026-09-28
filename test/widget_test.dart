import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:motigraph/main.dart';
import 'package:motigraph/settings/app_settings_controller.dart';

void main() {
  testWidgets(
    'Counter increments smoke test',
        (WidgetTester tester) async {
      final settingsController =
      AppSettingsController();

      await settingsController.loadSettings();

      await tester.pumpWidget(
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

      // Verify that the app starts.
      expect(find.byType(MyApp), findsOneWidget);
    },
  );
}