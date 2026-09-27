import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motigraph/core/navigation/main_navigation_screen.dart';

import 'package:motigraph/onpoding/onboarding_data.dart';
import 'package:motigraph/onpoding/onbording_page.dart';
import 'package:motigraph/splash_screen.dart';
import 'package:motigraph/settings/app_settings_controller.dart';

class OnboardingScreen extends StatefulWidget {
  final AppSettingsController settingsController;

  const OnboardingScreen({
    super.key,
    required this.settingsController,
  });

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _pageController =
  PageController();

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ======================================================
  // Next
  // ======================================================

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(
          milliseconds: 450,
        ),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  // ======================================================
  // Skip
  // ======================================================

  void _skip() {
    _pageController.animateToPage(
      3,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeInOut,
    );
  }

  // ======================================================
  // Finish
  // ======================================================

  void _finishOnboarding() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigationScreen(
            settingsController: widget.settingsController,
          ),
        ),
      );
    }

  // ======================================================
  // Change Theme
  // ======================================================

  Future<void> _changeTheme(
      ThemeMode mode,
      ) async {
    await widget.settingsController.changeTheme(
      mode,
    );
  }

  // ======================================================
  // Change Language
  // ======================================================

  Future<void> _changeLanguage(
      Locale locale,
      ) async {
    await widget.settingsController.changeLanguage(
      locale,
    );

    if (!mounted) return;

    await context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark =
        widget.settingsController.themeMode ==
            ThemeMode.dark;

    final isArabic =
        context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      // ==================================================
      // AppBar
      // ==================================================

      appBar:  AppBar(
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
            // Theme
            // =========================

            _ToggleContainer(
              children: [
                _ToggleButton(
                  icon: Icons.light_mode_outlined,
                  label: 'light'.tr(),
                  selected: !isDark,
                  onTap: () {
                    _changeTheme(
                      ThemeMode.light,
                    );
                  },
                ),

                _ToggleButton(
                  icon: Icons.dark_mode_outlined,
                  label: 'dark'.tr(),
                  selected: isDark,
                  onTap: () {
                    _changeTheme(
                      ThemeMode.dark,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),

      // ==================================================
      // Body
      // ==================================================

      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,

              physics:
              const BouncingScrollPhysics(),

              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },

              children: [
                // =========================
                // Page 1 - Splash
                // =========================

                MotiGraphSplashScreen(
                  settingsController:
                  widget.settingsController,
                ),

                // =========================
                // Page 2 - 4
                // =========================

                ...onboardingPages.map(
                      (page) => OnboardingPage(
                    data: page,
                  ),
                ),
              ],
            ),
          ),

          // ==================================================
          // Buttons
          // ==================================================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Row(
              children: [
                if (_currentPage < 3)
                  TextButton(
                    onPressed: _skip,
                    child: Text(
                      'skip'.tr(),
                    ),
                  ),

                if (_currentPage < 3)
                  const Spacer(),

                if (_currentPage < 3)
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'next'.tr(),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _finishOnboarding,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'start_now'.tr(),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),

          // ==================================================
          // Dots
          // ==================================================

          Padding(
            padding: const EdgeInsets.only(
              bottom: 25,
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: List.generate(
                4,
                    (index) {
                  final active =
                      index == _currentPage;

                  return AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    margin:
                    const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: active ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: active
                          ? theme.colorScheme.primary
                          : theme.dividerColor,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// Toggle Container
// ======================================================

class _ToggleContainer
    extends StatelessWidget {
  final List<Widget> children;

  const _ToggleContainer({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.55),
        borderRadius:
        BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

// ======================================================
// Toggle Button
// ======================================================

class _ToggleButton
    extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleButton({
    this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
        BorderRadius.circular(100),
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 220,
          ),
          padding:
          const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFD4AF37)
                : Colors.transparent,
            borderRadius:
            BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize:
            MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: selected
                      ? Colors.black
                      : colorScheme.onSurface
                      .withValues(alpha: 0.7),
                ),
                const SizedBox(width: 5),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: selected
                      ? Colors.black
                      : colorScheme.onSurface
                      .withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}