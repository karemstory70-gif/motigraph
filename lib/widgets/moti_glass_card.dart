import 'dart:ui';

import 'package:flutter/material.dart';

import 'golden_rays_painter.dart';

class MotiGlassCard extends StatelessWidget {
  final Widget child;

  final EdgeInsetsGeometry padding;

  final BorderRadius borderRadius;

  final double blur;

  final bool showGoldenRays;

  const MotiGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(28),
    ),
    this.blur = 22,
    this.showGoldenRays = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isDark =
        theme.brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius,

            // =================================================
            // Glass background
            // =================================================

            color: isDark
                ? const Color(0xFF151515)
                .withValues(alpha: 0.48)
                : Colors.white.withValues(alpha: 0.58),

            // =================================================
            // Glass border
            // =================================================

            border: Border.all(
              color: isDark
                  ? const Color(0xFFD4AF37)
                  .withValues(alpha: 0.25)
                  : Colors.white
                  .withValues(alpha: 0.80),
              width: 1,
            ),

            // =================================================
            // Shadow
            // =================================================

            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black
                    .withValues(alpha: 0.45)
                    : Colors.black
                    .withValues(alpha: 0.08),
                blurRadius: 35,
                spreadRadius: -8,
                offset: const Offset(
                  0,
                  16,
                ),
              ),
            ],
          ),

          child: Stack(
            children: [
              // =================================================
              // Golden light
              // =================================================

              if (showGoldenRays)
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: GoldenRaysPainter(
                        isDark: isDark,
                      ),
                    ),
                  ),
                ),

              // =================================================
              // Glass highlight
              // =================================================

              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [
                          Colors.white
                              .withValues(
                            alpha: 0.045,
                          ),
                          Colors.transparent,
                          Colors.transparent,
                        ]
                            : [
                          Colors.white
                              .withValues(
                            alpha: 0.32,
                          ),
                          Colors.white
                              .withValues(
                            alpha: 0.04,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // =================================================
              // Content
              // =================================================

              child,
            ],
          ),
        ),
      ),
    );
  }
}