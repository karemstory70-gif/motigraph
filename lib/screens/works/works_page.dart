import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motigraph/core/feature_data.dart';
import 'package:motigraph/core/moti_glass_card.dart';
import 'package:motigraph/settings/app_settings_controller.dart';
import 'package:motigraph/widgets/theme_toggle.dart';

class WorksPage extends StatefulWidget {
  final AppSettingsController settingsController;

  const WorksPage({
    super.key,
    required this.settingsController,
  });

  static const List<FeatureData> features = [
    FeatureData(
      title: 'web_development',
      description: 'web_development_description',
      image: 'assets/images/onboarding_1.png',
    ),
    FeatureData(
      title: 'app_development',
      description: 'app_development_description',
      image: 'assets/images/onboarding_2.png',
    ),
    FeatureData(
      title: 'digital_marketing',
      description: 'digital_marketing_description',
      image: 'assets/images/onboarding_3.png',
    ),
    FeatureData(
      title: 'motion_graphics',
      description: 'motion_graphics_description',
      image: 'assets/images/onboarding_1.png',
    ),
    FeatureData(
      title: 'cybersecurity',
      description: 'cybersecurity_description',
      image: 'assets/images/onboarding_2.png',
    ),
    FeatureData(
      title: 'training',
      description: 'training_description',
      image: 'assets/images/onboarding_3.png',
    ),
    FeatureData(
      title: 'courses',
      description: 'courses_description',
      image: 'assets/images/onboarding_1.png',
    ),
  ];

  @override
  State<WorksPage> createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage> {

  // ======================================================
  // Theme
  // ======================================================

  bool get isDark =>
      widget.settingsController.themeMode ==
          ThemeMode.dark;

  // ======================================================
  // Change Theme
  // ======================================================

  Future<void> _changeTheme(
      ThemeMode mode,
      ) async {
    await widget.settingsController.changeTheme(
      mode,
    );

    if (!mounted) return;

    setState(() {});
  }

  // ======================================================
  // Build
  // ======================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      // ==================================================
      // AppBar
      // ==================================================

      appBar: AppBar(
        toolbarHeight: 120,
        elevation: 0,
        backgroundColor:
        theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,

        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            children: [

              // =========================
              // Logo
              // =========================

              Text(
                'MOTIGRAPH',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: theme.colorScheme.primary,
                ),
              ),

              const Spacer(),

              // =========================
              // Theme Toggle
              // =========================

              ThemeToggle(
                isDark: isDark,

                lightLabel: 'light'.tr(),
                darkLabel: 'dark'.tr(),

                onLight: () {
                  _changeTheme(
                    ThemeMode.light,
                  );
                },

                onDark: () {
                  _changeTheme(
                    ThemeMode.dark,
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // ==================================================
      // Body
      // ==================================================

      body: GridView.builder(
        padding: const EdgeInsets.all(16),

        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.80,
        ),

        itemCount: WorksPage.features.length,

        itemBuilder: (context, index) {
          final feature =
          WorksPage.features[index];

          return Material(
            color: Colors.transparent,

            child: InkWell(
              borderRadius:
              BorderRadius.circular(28),

              onTap: () {
                _openService(
                  feature,
                );
              },

              child: MotiGlassCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    if (feature.image != null) ...[
                      Image.asset(
                        feature.image!,
                        height: 60,
                        width: 60,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 12),
                    ],

                    Text(
                      feature.title.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Flexible(
                      child: Text(
                        feature.description.tr(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.4,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.65),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ======================================================
  // Open Service
  // ======================================================

  void _openService(
      FeatureData feature,
      ) {
    debugPrint(
      'Selected service: ${feature.title}',
    );

    // هنا بعدين هنفتح صفحة تفاصيل الخدمة
  }
}