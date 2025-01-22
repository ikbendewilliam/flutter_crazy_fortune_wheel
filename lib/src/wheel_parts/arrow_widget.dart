import 'dart:math';

import 'package:flutter/material.dart';

class ArrowWidget extends StatelessWidget {
  final double animationValue;
  final int winnerIndex;
  final int rotations;
  final int childrenCount;

  const ArrowWidget({
    required this.animationValue,
    required this.winnerIndex,
    required this.rotations,
    required this.childrenCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var angleInFullRotation =
        (animationValue * 2 * pi * (rotations * childrenCount + winnerIndex)) %
            (2 * pi);
    angleInFullRotation *=
        8 / childrenCount; // Makes the animation work great for 3-30 children
    final double angle = switch (angleInFullRotation) {
      _ when animationValue <= 0 || animationValue == 1 => 0,
      (< 0.35 * pi) => -angleInFullRotation / 2,
      (< 0.7 * pi) => -0.35 * pi + angleInFullRotation / 2,
      _ => 0,
    };

    return CustomPaint(
      painter: _ArrowPainter(angle),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final double rotation;

  _ArrowPainter(this.rotation);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.height / 2));
    path.addOval(Rect.fromCircle(
        center: Offset(size.height / 4, size.height / 2),
        radius: size.height / 4));
    path.moveTo(size.height / 4, size.height / 2 - size.height / 4);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.height / 4, size.height / 2 + size.height / 4);
    path.close();

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotation);
    canvas.translate(-size.width / 2, -size.height / 2);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);

    paint
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
