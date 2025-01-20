import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crazy_fortune_wheel/src/_base_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/color_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/wheel_parts/wheel_center.dart';
import 'package:flutter_shader_snap/flutter_shader_snap.dart';

class DisappearingWheel extends BaseWheel {
  DisappearingWheel({
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
            builder: (context, child) => _WheelParts(
              children: children,
              winnerIndex: winnerIndex,
              animationValue: animation.value,
            ),
          ),
        ),
      ),
    );
  }
}

class _WheelParts extends StatefulWidget {
  final List<Widget> children;
  final int winnerIndex;
  final double animationValue;
  final List<Color> colors;

  const _WheelParts({
    required this.children,
    List<Color>? colors,
    required this.winnerIndex,
    required this.animationValue,
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
  State<_WheelParts> createState() => _WheelPartsState();
}

class _WheelPartsState extends State<_WheelParts> with TickerProviderStateMixin {
  double _getAnimationValueForPart(int index) {
    int animatedIndex = index;
    final animationCount = widget.children.length - 1;
    final double animationValue = widget.animationValue;
    if (index == widget.winnerIndex) {
      return 0;
    } else if (animatedIndex > widget.winnerIndex) {
      animatedIndex -= 1;
    }
    animatedIndex = (widget.winnerIndex * 7 + animatedIndex * 13) % animationCount;
    return (animationValue * animationValue * (animationCount - animatedIndex)).clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: Stack(
          children: [
            for (var i = 0; i < widget.children.length; i++) ...[
              Positioned.fill(
                child: SnapShader(
                  controller: AnimationController(
                    vsync: this,
                    duration: Duration(seconds: 1),
                  )..value = _getAnimationValueForPart(i),
                  child: Transform.rotate(
                    angle: 2 * pi * (i + (widget.children.length % 2 == 0 ? 0.5 : 0)) / widget.children.length + pi * 63 / 64,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerRight,
                      widthFactor: 0.5,
                      child: ClipPath(
                        clipper: ArcClipper(amountOfChildren: widget.children.length),
                        child: Container(
                          color: i == widget.children.length - 1 && i % widget.colors.length == 0
                              ? widget.colors[(i + 1) % widget.colors.length]
                              : widget.colors[i % widget.colors.length],
                          child: Align(
                            alignment: Alignment(0.5, 0),
                            child: FractionallySizedBox(
                              widthFactor: 0.3,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: widget.children[i],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            for (var i = 0; i < widget.children.length; i++) ...[
              Positioned.fill(
                child: Transform.rotate(
                  angle: 2 * pi * i / widget.children.length - pi / 64,
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
                  angle: 2 * pi * i / widget.children.length - pi / 64,
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
