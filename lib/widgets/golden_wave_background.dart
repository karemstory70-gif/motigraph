import 'dart:math' as math;
import 'package:flutter/material.dart';

class GoldenWaveBackground extends StatefulWidget {
  const GoldenWaveBackground({
    super.key,
  });

  @override
  State<GoldenWaveBackground> createState() =>
      _GoldenWaveBackgroundState();
}

class _GoldenWaveBackgroundState
    extends State<GoldenWaveBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _GoldenWavePainter(
              progress: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class _GoldenWavePainter extends CustomPainter {
  final double progress;

  const _GoldenWavePainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // =========================================
    // مكان الموجات داخل الـ Widget
    // =========================================

    final centerY = size.height * 0.5;

    // =========================================
    // إنشاء التلات موجات
    // =========================================

    final wave1 = _createWave(
      size: size,
      centerY: centerY - 14,
      amplitude: 18,
      wavelength: size.width * 0.90,
      speed: 1.0,
    );

    final wave2 = _createWave(
      size: size,
      centerY: centerY,
      amplitude: 17,
      wavelength: size.width * 0.95,
      speed: 0.75,
    );

    final wave3 = _createWave(
      size: size,
      centerY: centerY + 14,
      amplitude: 16,
      wavelength: size.width * 1.00,
      speed: 0.55,
    );

    // =========================================
    // الشعاع بين الخط الأول والثاني
    // =========================================

    _drawLightBetweenWaves(
      canvas: canvas,
      size: size,
      topWave: wave1,
      bottomWave: wave2,
    );

    // =========================================
    // الشعاع بين الخط الثاني والثالث
    // =========================================

    _drawLightBetweenWaves(
      canvas: canvas,
      size: size,
      topWave: wave2,
      bottomWave: wave3,
    );

    // =========================================
    // رسم الخطوط
    // =========================================

    _drawWaveLine(
      canvas: canvas,
      size: size,
      path: wave1,
      opacity: 0.95,
      width: 2.3,
    );

    _drawWaveLine(
      canvas: canvas,
      size: size,
      path: wave2,
      opacity: 0.65,
      width: 1.7,
    );

    _drawWaveLine(
      canvas: canvas,
      size: size,
      path: wave3,
      opacity: 0.40,
      width: 1.3,
    );
  }

  // =========================================
  // إنشاء Wave
  // =========================================

  Path _createWave({
    required Size size,
    required double centerY,
    required double amplitude,
    required double wavelength,
    required double speed,
  }) {
    final path = Path();

    final phase = progress * 2 * math.pi * speed;

    bool firstPoint = true;

    for (
    double x = -10;
    x <= size.width + 10;
    x += 3
    ) {
      final y = centerY +
          amplitude *
              math.sin(
                (x / wavelength) * 2 * math.pi + phase,
              );

      if (firstPoint) {
        path.moveTo(x, y);
        firstPoint = false;
      } else {
        path.lineTo(x, y);
      }
    }

    return path;
  }

  // =========================================
  // الشعاع بين موجتين
  // =========================================

  void _drawLightBetweenWaves({
    required Canvas canvas,
    required Size size,
    required Path topWave,
    required Path bottomWave,
  }) {
    final lightPath = Path();

    final pointsTop = <Offset>[];
    final pointsBottom = <Offset>[];

    final topMetrics = topWave.computeMetrics().first;
    final bottomMetrics = bottomWave.computeMetrics().first;

    const step = 5.0;

    for (
    double distance = 0;
    distance <= topMetrics.length;
    distance += step
    ) {
      final tangent =
      topMetrics.getTangentForOffset(distance);

      if (tangent != null) {
        pointsTop.add(tangent.position);
      }
    }

    for (
    double distance = 0;
    distance <= bottomMetrics.length;
    distance += step
    ) {
      final tangent =
      bottomMetrics.getTangentForOffset(distance);

      if (tangent != null) {
        pointsBottom.add(tangent.position);
      }
    }

    if (pointsTop.isEmpty || pointsBottom.isEmpty) {
      return;
    }

    lightPath.moveTo(
      pointsTop.first.dx,
      pointsTop.first.dy,
    );

    for (final point in pointsTop) {
      lightPath.lineTo(
        point.dx,
        point.dy,
      );
    }

    for (final point in pointsBottom.reversed) {
      lightPath.lineTo(
        point.dx,
        point.dy,
      );
    }

    lightPath.close();

    // =========================================
    // الضوء الناعم
    // =========================================

    final lightPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0x00D4AF37),
          const Color(0x18D4AF37),
          const Color(0x35FAC72A),
          const Color(0x18D4AF37),
          const Color(0x00D4AF37),
        ],
        stops: const [
          0.0,
          0.25,
          0.5,
          0.75,
          1.0,
        ],
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      )
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        8,
      );

    canvas.drawPath(
      lightPath,
      lightPaint,
    );
  }

  // =========================================
  // رسم الخط
  // =========================================

  void _drawWaveLine({
    required Canvas canvas,
    required Size size,
    required Path path,
    required double opacity,
    required double width,
  }) {
    // Glow خفيف جدًا
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width * 2.8
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFD4AF37)
          .withOpacity(opacity * 0.06)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        7,
      );

    canvas.drawPath(
      path,
      glowPaint,
    );

    // الخط الأساسي
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: [
          const Color(0x00D4AF37),
          const Color(0xFFD4AF37)
              .withOpacity(opacity),
          const Color(0xFFF2C94C)
              .withOpacity(opacity),
          const Color(0xFFD4AF37)
              .withOpacity(opacity),
          const Color(0x00D4AF37),
        ],
        stops: const [
          0.0,
          0.25,
          0.50,
          0.75,
          1.0,
        ],
      ).createShader(
        Offset.zero & size,
      );

    canvas.drawPath(
      path,
      linePaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant _GoldenWavePainter oldDelegate,
      ) {
    return oldDelegate.progress != progress;
  }
}