import 'dart:math';

import 'package:flutter/material.dart';

const circleProgressColor = Color(0x000095ff);
const circleBgColor = Color.fromRGBO(173, 229, 252, 1.0);

const progressTextColor = Color.fromRGBO(12, 102, 166, 1.0);

class ProgressPainter extends CustomPainter {
  final Animation<double> progress;
  final double circleRadius;
  final bool isDarkMode; // Adicionado isDarkMode

  ProgressPainter({
    required this.progress,
    required this.circleRadius,
    required this.isDarkMode, // Adicionado isDarkMode
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);

    _drawCircleProgress(canvas);
    _drawProgressText(canvas);
  }

  void _drawCircleProgress(Canvas canvas) {
    Paint circlePaint = Paint()
      ..color = circleBgColor // Lógica aplicada
      ..strokeWidth = circleRadius * 0.077
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    Paint shadow = Paint()
      ..color = isDarkMode ? Colors.white.withOpacity(0.2) : Colors.black // Lógica aplicada
      ..strokeWidth = circleRadius * 0.077
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 30);

    canvas.drawCircle(
      Offset.zero,
      circleRadius,
      circlePaint,
    );
    canvas.drawCircle(Offset.zero, circleRadius, shadow);

    circlePaint
      ..color = circleProgressColor
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: circleRadius),
      -0.5 * pi,
      2 * pi * (progress.value / 100),
      false,
      circlePaint,
    );
  }

  void _drawProgressText(Canvas canvas) {
    final textSpan = TextSpan(
      text: "${(progress.value).toInt()}%",
      style: TextStyle(
        color: isDarkMode ? Colors.white : progressTextColor, // Lógica aplicada
        fontSize: circleRadius * 0.25,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, textPainter.height / 1),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}