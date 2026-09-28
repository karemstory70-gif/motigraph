import 'dart:math' as math;
import 'package:flutter/material.dart';

class GoldenRaysPainter extends CustomPainter {
  final bool isDark;

  const GoldenRaysPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // مصدر الضوء خارج الكارت من منتصف اليمين
    final lightSource = Offset(
      size.width * 1.35,
      size.height * 0.42,
    );

    // اتجاه الضوء:
    // من اليمين -> أسفل اليسار
    final direction = const Offset(
      -0.75,
      0.66,
    ).normalized;

    final length =
        math.sqrt(
          size.width * size.width +
              size.height * size.height,
        ) *
            2.0;

    // =====================================================
    // 1. الضوء الرئيسي الكبير
    // =====================================================

    final perpendicular = Offset(
      -direction.dy,
      direction.dx,
    );

    const double spread = 0.42;

    final startLeft = lightSource +
        perpendicular * (-spread * size.width);

    final startRight = lightSource +
        perpendicular * (spread * size.width);

    final endPoint =
        lightSource + direction * length;

    final mainPath = Path()
      ..moveTo(
        startLeft.dx,
        startLeft.dy,
      )
      ..lineTo(
        endPoint.dx,
        endPoint.dy,
      )
      ..lineTo(
        startRight.dx,
        startRight.dy,
      )
      ..close();

    final mainPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.bottomLeft,
        colors: isDark
            ? [
          const Color(0xFFD4AF37)
              .withValues(alpha: 0.14),
          const Color(0xFFD4AF37)
              .withValues(alpha: 0.055),
          const Color(0xFFD4AF37)
              .withValues(alpha: 0.012),
          Colors.transparent,
        ]
            : [
          const Color(0xFFD4AF37)
              .withValues(alpha: 0.075),
          const Color(0xFFD4AF37)
              .withValues(alpha: 0.03),
          const Color(0xFFD4AF37)
              .withValues(alpha: 0.008),
          Colors.transparent,
        ],
        stops: const [
          0.0,
          0.30,
          0.65,
          1.0,
        ],
      ).createShader(
        Offset.zero & size,
      )
      ..style = PaintingStyle.fill;

    canvas.drawPath(
      mainPath,
      mainPaint,
    );

    // =====================================================
    // 2. الأشعة الداخلية الناعمة
    // =====================================================

    final int rayCount = isDark ? 6 : 4;

    for (int i = 0; i < rayCount; i++) {
      final offset =
          (i - (rayCount - 1) / 2) * 0.11;

      final rayDirection = Offset(
        direction.dx + offset,
        direction.dy,
      ).normalized;

      final rayPerpendicular = Offset(
        -rayDirection.dy,
        rayDirection.dx,
      );

      final rayStart = lightSource +
          perpendicular *
              (offset * size.width);

      final rayEnd =
          rayStart + rayDirection * length;

      final rayWidth =
          size.width *
              (0.045 + (i % 2) * 0.025);

      final rayPath = Path()
        ..moveTo(
          rayStart.dx +
              rayPerpendicular.dx * rayWidth,
          rayStart.dy +
              rayPerpendicular.dy * rayWidth,
        )
        ..lineTo(
          rayEnd.dx,
          rayEnd.dy,
        )
        ..lineTo(
          rayStart.dx -
              rayPerpendicular.dx * rayWidth,
          rayStart.dy -
              rayPerpendicular.dy * rayWidth,
        )
        ..close();

      final rayPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFFD4AF37).withValues(
              alpha: isDark ? 0.055 : 0.025,
            ),
            const Color(0xFFD4AF37).withValues(
              alpha: isDark ? 0.018 : 0.008,
            ),
            Colors.transparent,
          ],
          stops: const [
            0.0,
            0.35,
            1.0,
          ],
        ).createShader(
          Rect.fromPoints(
            rayStart,
            rayEnd,
          ),
        );

      canvas.drawPath(
        rayPath,
        rayPaint,
      );
    }

    // =====================================================
    // 3. انعكاس ناعم على الزجاج
    // =====================================================

    final reflectionPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: isDark
            ? [
          Colors.white.withValues(alpha: 0.045),
          Colors.white.withValues(alpha: 0.012),
          Colors.transparent,
        ]
            : [
          Colors.white.withValues(alpha: 0.20),
          Colors.white.withValues(alpha: 0.055),
          Colors.transparent,
        ],
        stops: const [
          0.0,
          0.35,
          0.75,
        ],
      ).createShader(
        Offset.zero & size,
      );

    canvas.drawRect(
      Offset.zero & size,
      reflectionPaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant GoldenRaysPainter oldDelegate,
      ) {
    return oldDelegate.isDark != isDark;
  }
}

extension on Offset {
  Offset get normalized {
    final length = distance;

    if (length == 0) {
      return Offset.zero;
    }

    return this / length;
  }
}