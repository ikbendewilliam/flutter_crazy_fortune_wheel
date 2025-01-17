import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crazy_fortune_wheel/src/_base_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/color_wheel.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class SlicedWheel extends BaseWheel {
  final int winnerIndex = 3;
  final int rotations = 3;
  final List<Widget> children;

  SlicedWheel({
    required super.animation,
    required this.children,
    super.key,
  });

  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: 'packages/flutter_crazy_fortune_wheel/shaders/sliced_wheel_shader.frag',
      (context, shader, child) => AspectRatio(
        aspectRatio: 1,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) => animation.value == 0
                    ? child!
                    : Transform.rotate(
                        angle: animation.value * 2 * pi * (rotations + winnerIndex / children.length),
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
                child: child,
              ),
            ),
            Positioned(
              right: -16,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text('<---'),
              ),
            ),
          ],
        ),
      ),
      child: ColorWheel(
        children: children,
      ),
    );
  }
}
