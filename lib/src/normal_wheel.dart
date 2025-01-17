import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crazy_fortune_wheel/src/_base_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/color_wheel.dart';

class NormalWheel extends BaseWheel {
  final int winnerIndex = 3;
  final int rotations = 10;

  /// The scaling of the wheel in case the size is not woking on your format
  /// The default value is 1.0
  final double scaling;

  final List<Widget> children;

  NormalWheel({
    required super.animation,
    required this.children,
    this.scaling = 1,
    super.key,
  });

  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 800 / scaling,
          height: 800 / scaling,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: animation.value == 0
                      ? child!
                      : Transform.rotate(
                          angle: animation.value * 2 * pi * (rotations + winnerIndex / children.length),
                          child: child,
                        ),
                ),
                Positioned(
                  right: -72,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: SizedBox(
                      height: 24,
                      width: 96,
                      child: ArrowWidget(
                        rotation: _calculateArrowRotation(animation.value),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            child: ColorWheel(
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  double _calculateArrowRotation(double animationValue) {
    var angleInFullRotation = (animationValue * 2 * pi * (rotations * children.length + winnerIndex)) % (2 * pi);
    angleInFullRotation *= 8 / children.length; // Makes the animation work great for 3-30 children
    return switch (angleInFullRotation) {
      < 0.25 * pi => -angleInFullRotation,
      < 0.5 * pi => -0.5 * pi + angleInFullRotation,
      _ => 0,
    };
  }
}
