import 'dart:math';

import 'package:flutter/material.dart';

class ColorWheel extends StatelessWidget {
  final List<Widget> children;
  final List<Color> colors;

  const ColorWheel({
    required this.children,
    this.colors = Colors.accents,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: Stack(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              Positioned.fill(
                child: Transform.rotate(
                  angle: 2 * pi * (i + (children.length % 2 == 0 ? 0.5 : 0)) / children.length + pi * 63 / 64,
                  child: ClipPath(
                    clipper: _ArcClipper(amountOfChildren: children.length),
                    child: Container(
                      color: i == children.length - 1 && i % colors.length == 0 ? colors[(i + 1) % colors.length] : colors[i % colors.length],
                      child: Align(
                        alignment: Alignment(0.9, 0),
                        child: FractionallySizedBox(
                          widthFactor: 0.3,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: children[i],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            for (var i = 0; i < children.length; i++) ...[
              Positioned.fill(
                child: Transform.rotate(
                  angle: 2 * pi * i / children.length - pi / 64,
                  child: Center(
                    child: Container(
                      height: 1,
                      width: double.maxFinite,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Transform.rotate(
                  angle: 2 * pi * i / children.length - pi / 64,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.grey,
                            Colors.grey[700]!,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ArcClipper extends CustomClipper<Path> {
  final int amountOfChildren;

  _ArcClipper({required this.amountOfChildren});

  @override
  getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    path.arcTo(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height,
      ),
      -pi / amountOfChildren,
      pi / amountOfChildren * 2,
      false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class ArrowWidget extends StatelessWidget {
  final double rotation;

  const ArrowWidget({
    required this.rotation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ArrowPainter(rotation),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final double rotation;

  _ArrowPainter(this.rotation);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.height / 2));
    path.addOval(Rect.fromCircle(center: Offset(size.height / 4, size.height / 2), radius: size.height / 4));
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
