import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crazy_fortune_wheel/src/_base_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/arrow_widget.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/color_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/wheel_center.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class SlicedWheel extends BaseWheel {
  /// The amount of rings the wheel should have,
  /// needs to be the same as the value in the shader
  /// for the arrow animation to work
  static const ringCount = 8;

  SlicedWheel({
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
    return ShaderBuilder(
      assetKey: 'packages/flutter_crazy_fortune_wheel/shaders/sliced_wheel_shader.frag',
      (context, shader, child) => AspectRatio(
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
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: AnimatedSampler(
                                    (image, size, canvas) {
                                      shader
                                        ..setFloat(0, size.width)
                                        ..setFloat(1, size.height)
                                        ..setFloat(2, animation.value.clamp(0, 1))
                                        ..setImageSampler(0, image);

                                      final paint = Paint()..shader = shader;
                                      canvas.drawRect(
                                        Rect.fromLTWH(0, 0, size.width, size.height),
                                        paint,
                                      );
                                    },
                                    child: child!,
                                  ),
                                ),
                                Positioned.fill(
                                  child: WheelCenter(),
                                ),
                              ],
                            ),
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
                          rotations: rotations + ringCount - 1,
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
      ),
    );
  }
}
