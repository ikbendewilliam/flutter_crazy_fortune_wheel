import 'dart:math';

import 'package:flutter/material.dart';

class WheelCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.center,
      heightFactor: 0.2,
      widthFactor: 0.2,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
        ),
        child: CustomPaint(
          painter: _SpiralPainter(),
        ),
      ),
    );
  }
}

class _SpiralPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );

    final parts = 5;
    final sweepAngle = 2 * pi / parts;
    for (double angleStart = 0; angleStart < pi * 2; angleStart += sweepAngle) {
      final path = Path();
      path.moveTo(size.width / 2, size.height / 2);
      path.quadraticBezierTo(
        size.width / 2 - size.width / 4 * cos(pi / 2 + angleStart),
        size.height / 2 - size.width / 4 * sin(pi / 2 + angleStart),
        size.width / 2 - size.width / 2 * cos(sweepAngle / 2 + angleStart),
        size.height / 2 - size.width / 2 * sin(sweepAngle / 2 + angleStart),
      );
      path.arcToPoint(
        Offset(
          size.width / 2 - size.width / 2 * cos(angleStart),
          size.height / 2 - size.width / 2 * sin(angleStart),
        ),
        radius: Radius.circular(size.width / 2),
        largeArc: false,
        clockwise: false,
      );
      path.quadraticBezierTo(
        size.width / 2 -
            size.width / 4 * cos(pi / 2 + angleStart - sweepAngle / 2),
        size.height / 2 -
            size.width / 4 * sin(pi / 2 + angleStart - sweepAngle / 2),
        size.width / 2,
        size.height / 2,
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
