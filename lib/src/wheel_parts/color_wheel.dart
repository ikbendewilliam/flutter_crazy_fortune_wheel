import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/wheel_center.dart';

class ColorWheel extends StatelessWidget {
  final List<Widget> children;

  /// Which colors to use, defaults to
  /// (a subset of) [Colors.accents].
  /// When there are more children than colors,
  /// the colors will be repeated, but
  /// the last and first color will always be different.
  final List<Color> colors;

  const ColorWheel({
    required this.children,
    List<Color>? colors,
    super.key,
  }) : this.colors = colors ??
            (children.length > 10
                ? Colors.accents
                : const [
                    Colors.redAccent,
                    Colors.blueAccent,
                    Colors.greenAccent,
                    Colors.lightGreenAccent,
                    Colors.yellowAccent,
                    Colors.pinkAccent,
                    Colors.purpleAccent,
                    Colors.tealAccent,
                    Colors.limeAccent,
                    Colors.amberAccent,
                  ]);

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
                  angle: 2 * pi * (i + 0.5) / children.length - pi * 0.02,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerRight,
                    widthFactor: 0.5,
                    child: ClipPath(
                      clipper: ArcClipper(amountOfChildren: children.length),
                      child: Container(
                        color:
                            i == children.length - 1 && i % colors.length == 0
                                ? colors[(i + 1) % colors.length]
                                : colors[i % colors.length],
                        child: Align(
                          alignment: Alignment(0.5, 0),
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
              ),
            ],
            for (var i = 0; i < children.length; i++) ...[
              Positioned.fill(
                child: Transform.rotate(
                  angle: 2 * pi * i / children.length - pi * 0.02,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Container(
                        height: 1,
                        width: double.maxFinite,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Transform.rotate(
                  angle: 2 * pi * i / children.length - pi * 0.02,
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
            ),
            Positioned.fill(
              child: WheelCenter(),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  final int amountOfChildren;

  ArcClipper({required this.amountOfChildren});

  @override
  getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.arcTo(
      Rect.fromCircle(
        center: Offset(size.width, size.height / 2),
        radius: 999999,
      ),
      -pi / amountOfChildren,
      2 * pi / amountOfChildren,
      false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
