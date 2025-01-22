import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crazy_fortune_wheel/src/_base_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/arrow_widget.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/color_wheel.dart';

class NormalWheel extends BaseWheel {
  /// Creates a wheel that has its children sliced into
  /// rings.
  /// Add [animation] for controlling the animation of the wheel
  /// start the animation by calling [controller.forward()]
  /// await [controller.forward()] to wait
  /// for the animation to finish.
  ///
  /// Add a curve to the animation like this and pass `animation`
  /// ```dart
  /// final controller = AnimationController(
  ///   vsync: this,
  ///   duration: Duration(seconds: 10),
  /// );
  /// late final animation = controller.drive(CurveTween(curve: FortuneWheelCurve()));
  /// ```
  ///
  /// After the animation, you can remove the winning child
  /// and reset the animation to go again. If you don't remove
  /// the winner, you can set [previousWinnerIndex] so the animation
  /// starts from the previous winner.
  NormalWheel({
    required super.animation,
    required super.children,
    required super.winnerIndex,
    super.scaling,
    super.previousWinnerIndex,
    super.rotations,
    super.colors,
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
            child: ColorWheel(
              children: children,
              colors: colors,
            ),
            builder: (context, child) => Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: animation.value == 0 && previousWinnerIndex == 0
                      ? child!
                      : Transform.rotate(
                          angle: animation.value *
                                  2 *
                                  pi *
                                  (rotations +
                                      (previousWinnerIndex - winnerIndex) /
                                          children.length) -
                              2 * pi * previousWinnerIndex / children.length,
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
                        animationValue: animation.value,
                        childrenCount: children.length,
                        rotations: rotations,
                        winnerIndex: winnerIndex,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
