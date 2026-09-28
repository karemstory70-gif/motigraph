import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motigraph/core/models/feature_data.dart';
import 'package:motigraph/screens/details/details_page.dart';
import 'package:motigraph/widgets/moti_glass_card.dart';
import 'package:motigraph/settings/app_settings_controller.dart';

class WorksPage extends StatefulWidget {
  final AppSettingsController settingsController;

  const WorksPage({
    super.key,
    required this.settingsController,
  });

  // ======================================================
  // Services
  // ======================================================

  static const List<ServiceData> services = [
    ServiceData(
      title: 'web_development',
      description: 'web_development_description',
      image: 'assets/images/onboarding_1.png',

      detailsTitle:
      'web_development_service_details_title',

      detailsDescription:
      'web_development_service_details_description',

      sections: [
        DetailSection(
          title: 'web_development_service_section_1_title',
          description:
          'web_development_service_section_1_description',
          points: [
            'web_development_service_point_1',
            'web_development_service_point_2',
            'web_development_service_point_3',
          ],
        ),
        DetailSection(
          title: 'web_development_service_section_2_title',
          description:
          'web_development_service_section_2_description',
          points: [
            'web_development_service_point_4',
            'web_development_service_point_5',
          ],
        ),
      ],

      videoUrl: null,
    ),

    ServiceData(
      title: 'app_development',
      description: 'app_development_description',
      image: 'assets/images/onboarding_2.png',

      detailsTitle:
      'app_development_service_details_title',

      detailsDescription:
      'app_development_service_details_description',

      sections: [
        DetailSection(
          title: 'app_development_service_section_1_title',
          description:
          'app_development_service_section_1_description',
          points: [
            'app_development_service_point_1',
            'app_development_service_point_2',
            'app_development_service_point_3',
          ],
        ),
        DetailSection(
          title: 'app_development_service_section_2_title',
          description:
          'app_development_service_section_2_description',
          points: [
            'app_development_service_point_4',
            'app_development_service_point_5',
          ],
        ),
      ],

      videoUrl: null,
    ),

    ServiceData(
      title: 'digital_marketing',
      description: 'digital_marketing_description',
      image: 'assets/images/onboarding_3.png',

      detailsTitle:
      'digital_marketing_service_details_title',

      detailsDescription:
      'digital_marketing_service_details_description',

      sections: [
        DetailSection(
          title: 'digital_marketing_service_section_1_title',
          description:
          'digital_marketing_service_section_1_description',
          points: [
            'digital_marketing_service_point_1',
            'digital_marketing_service_point_2',
            'digital_marketing_service_point_3',
          ],
        ),
        DetailSection(
          title: 'digital_marketing_service_section_2_title',
          description:
          'digital_marketing_service_section_2_description',
          points: [
            'digital_marketing_service_point_4',
            'digital_marketing_service_point_5',
          ],
        ),
      ],

      videoUrl: null,
    ),

    ServiceData(
      title: 'motion_graphics',
      description: 'motion_graphics_description',
      image: 'assets/images/onboarding_1.png',

      detailsTitle:
      'motion_graphics_service_details_title',

      detailsDescription:
      'motion_graphics_service_details_description',

      sections: [
        DetailSection(
          title: 'motion_graphics_service_section_1_title',
          description:
          'motion_graphics_service_section_1_description',
          points: [
            'motion_graphics_service_point_1',
            'motion_graphics_service_point_2',
            'motion_graphics_service_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),

    ServiceData(
      title: 'cybersecurity',
      description: 'cybersecurity_description',
      image: 'assets/images/onboarding_2.png',

      detailsTitle:
      'cybersecurity_service_details_title',

      detailsDescription:
      'cybersecurity_service_details_description',

      sections: [
        DetailSection(
          title: 'cybersecurity_service_section_1_title',
          description:
          'cybersecurity_service_section_1_description',
          points: [
            'cybersecurity_service_point_1',
            'cybersecurity_service_point_2',
            'cybersecurity_service_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),
  ];

  @override
  State<WorksPage> createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage> {

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
                'services'.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: theme.colorScheme.primary,
                ),
              ),

              const Spacer(),

              // =========================
              // Get Started
              // =========================

              Material(
                color: theme.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(100),

                child: InkWell(
                  onTap: _getStarted,

                  borderRadius: BorderRadius.circular(100),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),

                    child: Text(
                      'get_started'.tr(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ==================================================
      // Body
      // ==================================================

      body: CustomScrollView(
        slivers: [

          // ==================================================
          // Services Intro
          // ==================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                8,
              ),
              child: MotiGlassCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [

                      // =========================
                      // Title
                      // =========================

                      Text(
                        'services_title'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color:
                          theme.colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // =========================
                      // Description
                      // =========================

                      ConstrainedBox(
                        constraints:
                        const BoxConstraints(
                          maxWidth: 650,
                        ),
                        child: Text(
                          'services_description'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: theme
                                .colorScheme
                                .onSurface
                                .withValues(
                              alpha: 0.65,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ==================================================
          // Services Cards
          // ==================================================

          SliverPadding(
            padding: const EdgeInsets.all(3),

            sliver: SliverGrid(
              delegate:
              SliverChildBuilderDelegate(
                    (context, index) {
                      final service = WorksPage.services[index];
                  return Material(
                    color: Colors.transparent,

                    child: InkWell(
                      borderRadius:
                      BorderRadius.circular(28),

                      onTap: () {
                        _openService(
                          service,
                        );
                      },

                      child: MotiGlassCard(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            // =========================
                            // Image
                            // =========================

                            if (service.image != null) ...[
                              Image.asset(
                                service.image!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.contain,
                              ),

                              const SizedBox(height: 12),
                            ],

                            // =========================
                            // Title
                            // =========================

                            Text(
                              service.title.tr(),
                              textAlign:
                              TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.bold,
                                color: theme
                                    .colorScheme
                                    .onSurface,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // =========================
                            // Description
                            // =========================

                            Flexible(
                              child: Text(
                                service.description.tr(),
                                textAlign:
                                TextAlign.center,
                                overflow:
                                TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 11,
                                  height: 1.4,
                                  color: theme
                                      .colorScheme
                                      .onSurface
                                      .withValues(
                                    alpha: 0.65,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },

                childCount:
                WorksPage.services.length,
              ),

              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.80,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // Get Started
  // ======================================================

  void _getStarted() {
    debugPrint(
      'Get Started pressed',
    );

    // هنا بعدين هنفتح صفحة Contact
    // أو صفحة طلب الخدمة.
  }

  // ======================================================
  // Open Service
  // ======================================================

  void _openService(
      FeatureData feature,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            DetailsPage(
              item: feature,
            ),
      ),
    );
  }
}