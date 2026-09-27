import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motigraph/settings/app_settings_controller.dart';
import 'package:motigraph/widgets/golden_wave_background.dart';

class MotiGraphSplashScreen extends StatefulWidget {
  final VoidCallback? onFinished;
  final Duration totalDuration;
  final AppSettingsController settingsController;

  const MotiGraphSplashScreen({
    super.key,
    this.onFinished,
    this.totalDuration = const Duration(
      milliseconds: 3200,
    ),
    required this.settingsController,
  });

  @override
  State<MotiGraphSplashScreen> createState() =>
      _MotiGraphSplashScreenState();
}

class _MotiGraphSplashScreenState
    extends State<MotiGraphSplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _introController;

  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;

  late final List<Animation<double>> _wordFade;
  late final List<Animation<Offset>> _wordSlide;

  static const _words = [
    'CREATE',
    'LEARN',
    'GROW',
  ];

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: widget.totalDuration,
    )..forward();

    // ======================================================
    // Logo Animation
    // ======================================================

    _logoFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(
        0.0,
        0.35,
        curve: Curves.easeOut,
      ),
    );

    _logoScale = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(
          0.0,
          0.35,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    // ======================================================
    // Words Animation
    // ======================================================

    _wordFade = List.generate(
      _words.length,
          (i) {
        final start = 0.35 + i * 0.15;
        final end =
        (start + 0.25).clamp(0.0, 1.0);

        return CurvedAnimation(
          parent: _introController,
          curve: Interval(
            start,
            end,
            curve: Curves.easeOut,
          ),
        );
      },
    );

    _wordSlide = List.generate(
      _words.length,
          (i) {
        final start = 0.35 + i * 0.15;
        final end =
        (start + 0.25).clamp(0.0, 1.0);

        return Tween<Offset>(
          begin: const Offset(0, 0.4),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _introController,
            curve: Interval(
              start,
              end,
              curve: Curves.easeOut,
            ),
          ),
        );
      },
    );

    // ======================================================
    // Splash Finished
    // ======================================================

    _introController.addStatusListener(
          (status) {
        if (status == AnimationStatus.completed) {
          widget.onFinished?.call();
        }
      },
    );
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
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
    final colorScheme =
        Theme.of(context).colorScheme;

    final isArabic =
        context.locale.languageCode == 'ar';

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics:
          const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                // =================================================
                // Logo
                // =================================================

                FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: _MotiGraphLogo(
                      textColor:
                      colorScheme.onSurface,
                      separatorColor:
                      colorScheme.onSurface
                          .withValues(
                        alpha: 0.4,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // =================================================
                // CREATE | LEARN | GROW
                // =================================================

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    _words.length * 2 - 1,
                        (i) {
                      if (i.isOdd) {
                        final wordIndex =
                            (i - 1) ~/ 2;

                        return FadeTransition(
                          opacity:
                          _wordFade[wordIndex],
                          child: Padding(
                            padding:
                            const EdgeInsets
                                .symmetric(
                              horizontal: 10,
                            ),
                            child: Text(
                              '|',
                              style: TextStyle(
                                color:
                                colorScheme
                                    .onSurface
                                    .withValues(
                                  alpha: 0.4,
                                ),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }

                      final wordIndex = i ~/ 2;

                      return ClipRect(
                        child: SlideTransition(
                          position:
                          _wordSlide[wordIndex],
                          child: FadeTransition(
                            opacity:
                            _wordFade[wordIndex],
                            child: Text(
                              _words[wordIndex],
                              style: TextStyle(
                                color:
                                colorScheme
                                    .onSurface,
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w500,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 50),

                // =================================================
                // Golden Wave
                // =================================================

                const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: GoldenWaveBackground(),
                ),

                const SizedBox(height: 30),

                // =================================================
                // Welcome
                // =================================================

                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'welcome'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                      colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // =================================================
                // Description
                // =================================================

                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'description'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorScheme.onSurface
                          .withValues(
                        alpha: 0.7,
                      ),
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // =================================================
                // Language Toggle
                // آخر حاجة في الـ Splash
                // =================================================

                _LanguageToggle(
                  isArabic: isArabic,
                  onArabic: () {
                    _changeLanguage(
                      const Locale('ar'),
                    );
                  },
                  onEnglish: () {
                    _changeLanguage(
                      const Locale('en'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// Language Toggle
// ======================================================

class _LanguageToggle extends StatelessWidget {
  final bool isArabic;
  final VoidCallback onArabic;
  final VoidCallback onEnglish;

  const _LanguageToggle({
    required this.isArabic,
    required this.onArabic,
    required this.onEnglish,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(3),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.55),
        borderRadius:
        BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _LanguageButton(
            label: 'العربية',
            selected: isArabic,
            onTap: onArabic,
          ),
          _LanguageButton(
            label: 'English',
            selected: !isArabic,
            onTap: onEnglish,
          ),
        ],
      ),
    );
  }
}

// ======================================================
// Language Button
// ======================================================

class _LanguageButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageButton({
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
          width: 150,
          duration: const Duration(
            milliseconds: 220,
          ),
          padding:
           EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFD4AF37)
                : Colors.transparent,
            borderRadius:
            BorderRadius.circular(100),
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.language_outlined),
              SizedBox(width: 10,),
              Text(
                label,
                textAlign:TextAlign.center ,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: selected
                      ? Colors.black
                      : colorScheme.onSurface
                      .withValues(
                    alpha: 0.7,
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}

// ======================================================
// MotiGraph Logo
// ======================================================

class _MotiGraphLogo extends StatelessWidget {
  final Color textColor;
  final Color separatorColor;

  const _MotiGraphLogo({
    required this.textColor,
    required this.separatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 46,
          fontWeight: FontWeight.w800,
          color: textColor,
          shadows: [
            Shadow(
              color: textColor.withValues(
                alpha: 0.65,
              ),
              blurRadius: 24,
            ),
            const Shadow(
              color: Color(0x55D4AF37),
              blurRadius: 40,
            ),
          ],
          letterSpacing: 0.5,
        ),
        children: [
          const TextSpan(
            text: 'Moti',
          ),
          TextSpan(
            text: ' | ',
            style: TextStyle(
              color: separatorColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          const TextSpan(
            text: 'Graph',
          ),
        ],
      ),
    );
  }
}