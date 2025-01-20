import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crazy_fortune_wheel/src/_base_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/arrow_widget.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/color_wheel.dart';

class NormalWheel extends BaseWheel {
  NormalWheel({
    required super.animation,
    required super.children,
    super.scaling,
    super.previousWinnerIndex,
    super.rotations,
    super.winnerIndex,
    super.onEnd,
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
