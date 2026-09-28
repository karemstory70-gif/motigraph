import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motigraph/core/models/feature_data.dart';
import 'package:motigraph/screens/details/details_page.dart';
import 'package:motigraph/widgets/academy_toggle.dart';
import 'package:motigraph/widgets/moti_glass_card.dart';
import 'package:motigraph/settings/app_settings_controller.dart';

class AcademyPage extends StatefulWidget {
  final AppSettingsController settingsController;

  const AcademyPage({
    super.key,
    required this.settingsController,
  });

  // ======================================================
  // Courses
  // ======================================================

// ======================================================
// Courses
// ======================================================

  static const List<CourseData> courses = [
    CourseData(
      title: 'web_development',
      description: 'web_development_description',
      image: 'assets/images/onboarding_1.png',

      detailsTitle:
      'web_development_course_details_title',

      detailsDescription:
      'web_development_course_details_description',

      sections: [
        DetailSection(
          title: 'course_content',
          description:
          'web_development_course_content_description',
          points: [
            'web_development_course_point_1',
            'web_development_course_point_2',
            'web_development_course_point_3',
          ],
        ),
        DetailSection(
          title: 'what_you_will_learn',
          description:
          'web_development_course_learning_description',
          points: [
            'web_development_course_learning_point_1',
            'web_development_course_learning_point_2',
            'web_development_course_learning_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),

    CourseData(
      title: 'app_development',
      description: 'app_development_description',
      image: 'assets/images/onboarding_2.png',

      detailsTitle:
      'app_development_course_details_title',

      detailsDescription:
      'app_development_course_details_description',

      sections: [
        DetailSection(
          title: 'course_content',
          description:
          'app_development_course_content_description',
          points: [
            'app_development_course_point_1',
            'app_development_course_point_2',
            'app_development_course_point_3',
          ],
        ),
        DetailSection(
          title: 'what_you_will_learn',
          description:
          'app_development_course_learning_description',
          points: [
            'app_development_course_learning_point_1',
            'app_development_course_learning_point_2',
            'app_development_course_learning_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),

    CourseData(
      title: 'digital_marketing',
      description: 'digital_marketing_description',
      image: 'assets/images/onboarding_3.png',

      detailsTitle:
      'digital_marketing_course_details_title',

      detailsDescription:
      'digital_marketing_course_details_description',

      sections: [
        DetailSection(
          title: 'course_content',
          description:
          'digital_marketing_course_content_description',
          points: [
            'digital_marketing_course_point_1',
            'digital_marketing_course_point_2',
            'digital_marketing_course_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),

    CourseData(
      title: 'motion_graphics',
      description: 'motion_graphics_description',
      image: 'assets/images/onboarding_1.png',

      detailsTitle:
      'motion_graphics_course_details_title',

      detailsDescription:
      'motion_graphics_course_details_description',

      sections: [
        DetailSection(
          title: 'course_content',
          description:
          'motion_graphics_course_content_description',
          points: [
            'motion_graphics_course_point_1',
            'motion_graphics_course_point_2',
            'motion_graphics_course_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),

    CourseData(
      title: 'cybersecurity',
      description: 'cybersecurity_description',
      image: 'assets/images/onboarding_2.png',

      detailsTitle:
      'cybersecurity_course_details_title',

      detailsDescription:
      'cybersecurity_course_details_description',

      sections: [
        DetailSection(
          title: 'course_content',
          description:
          'cybersecurity_course_content_description',
          points: [
            'cybersecurity_course_point_1',
            'cybersecurity_course_point_2',
            'cybersecurity_course_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),
  ];
  static const List<TrainingData> training = [
    TrainingData(
      title: 'web_development',
      description: 'web_development_description',
      image: 'assets/images/onboarding_1.png',

      detailsTitle:
      'web_development_training_details_title',

      detailsDescription:
      'web_development_training_details_description',

      sections: [
        DetailSection(
          title: 'training_content',
          description:
          'web_development_training_content_description',
          points: [
            'web_development_training_point_1',
            'web_development_training_point_2',
            'web_development_training_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),

    TrainingData(
      title: 'app_development',
      description: 'app_development_description',
      image: 'assets/images/onboarding_2.png',

      detailsTitle:
      'app_development_training_details_title',

      detailsDescription:
      'app_development_training_details_description',

      sections: [
        DetailSection(
          title: 'training_content',
          description:
          'app_development_training_content_description',
          points: [
            'app_development_training_point_1',
            'app_development_training_point_2',
            'app_development_training_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),

    TrainingData(
      title: 'cybersecurity',
      description: 'cybersecurity_description',
      image: 'assets/images/onboarding_3.png',

      detailsTitle:
      'cybersecurity_training_details_title',

      detailsDescription:
      'cybersecurity_training_details_description',

      sections: [
        DetailSection(
          title: 'training_content',
          description:
          'cybersecurity_training_content_description',
          points: [
            'cybersecurity_training_point_1',
            'cybersecurity_training_point_2',
            'cybersecurity_training_point_3',
          ],
        ),
      ],

      videoUrl: null,
    ),
  ];

// ======================================================
// Training
// ======================================================


  @override
  State<AcademyPage> createState() => _AcademyPageState();
}

class _AcademyPageState extends State<AcademyPage> {
  // 0 = Courses
  // 1 = Training
  int _selectedTab = 0;

  // ======================================================
  // Current Data
  // ======================================================

  List<FeatureData> get _currentItems {
    return _selectedTab == 0
        ? AcademyPage.courses
        : AcademyPage.training;
  }

  // ======================================================
  // Current Title
  // ======================================================

  String get _currentTitle {
    return _selectedTab == 0
        ? 'academy_courses_title'
        : 'academy_training_title';
  }

  // ======================================================
  // Current Description
  // ======================================================

  String get _currentDescription {
    return _selectedTab == 0
        ? 'academy_courses_description'
        : 'academy_training_description';
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
                'academy'.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: theme.colorScheme.primary,
                ),
              ),

              const Spacer(),

              // =========================
              // Academy Toggle
              // =========================

              AcademyToggle(
                isTraining: _selectedTab == 1,

                coursesLabel: 'courses'.tr(),
                trainingLabel: 'training'.tr(),

                onCourses: () {
                  setState(() {
                    _selectedTab = 0;
                  });
                },

                onTraining: () {
                  setState(() {
                    _selectedTab = 1;
                  });
                },
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
          // Academy Intro
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

                      Text(
                        _currentTitle.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 12),

                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 650,
                        ),
                        child: Text(
                          _currentDescription.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.65),
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
          // Academy Cards
          // ==================================================

          SliverPadding(
            padding: const EdgeInsets.all(3),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final feature = _currentItems[index];

                  return Material(
                    color: Colors.transparent,

                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),

                      onTap: () {
                        _openDetails(feature);
                      },

                      child: MotiGlassCard(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
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
                                color:
                                theme.colorScheme.onSurface,
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
                                  color:
                                  theme.colorScheme.onSurface
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
                childCount: _currentItems.length,
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
  // Open Academy Item
  // ======================================================

  void _openDetails(FeatureData feature) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsPage(
          item: feature,
        ),
      ),
    );
  }

    // هنا بعدين هنفتح صفحة تفاصيل الكورس أو التدريب
  }