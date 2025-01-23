import 'package:flutter/material.dart';
import 'package:flutter_crazy_fortune_wheel/src/disappearing_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/normal_wheel.dart';
import 'package:flutter_crazy_fortune_wheel/src/sliced_wheel.dart';

class RandomWheel extends StatefulWidget {
  /// For controlling the animation of the wheel
  /// start the animation by calling [animation.forward()]
  /// await [animation.forward()] to wait
  /// for the animation to finish.
  ///
  /// Add a curve to the animation like this:
  /// ```dart
  /// final controller = AnimationController(
  ///   vsync: this,
  ///   duration: Duration(seconds: 10),
  /// );
  /// late final animation = controller.drive(CurveTween(curve: FortuneWheelCurve()));
  /// ```
  final Animation<double> animation;

  /// The scaling of the wheel in case the size is not woking on your format
  /// The default value is 1.0
  final double scaling;

  /// The index of the previous winner in the children list
  /// set this while resetting the animation to keep the wheel
  /// in the same position.
  final int previousWinnerIndex;

  /// The number of rotations the wheel will do before stopping
  final int rotations;

  /// The children of the wheel
  final List<Widget> children;

  /// Which colors to use, defaults to
  /// (a subset of) [Colors.accents].
  /// When there are more children than colors,
  /// the colors will be repeated, but
  /// the last and first color will always be different.
  final List<Color>? colors;

  /// The index of the winner in the children list
  /// if this is null the wheel will decide the winner.
  /// The winner is then returned in the [widget.onEnd] callback
  final int winnerIndex;

  /// Which type of wheel to use
  /// Use `WheelType.values[Random().nextInt(WheelType.values.length)];`
  /// to get a random wheel type and change it when you want to.
  final WheelType wheelType;

  RandomWheel({
    required this.animation,
    required this.children,
    required this.winnerIndex,
    required this.wheelType,
    this.scaling = 1,
    this.previousWinnerIndex = 0,
    this.rotations = 10,
    this.colors,
    super.key,
  });

  @override
  State<RandomWheel> createState() => _RandomWheelState();
}

class _RandomWheelState extends State<RandomWheel> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.wheelType) {
      WheelType.normal => NormalWheel(
          animation: widget.animation,
          children: widget.children,
          scaling: widget.scaling,
          previousWinnerIndex: widget.previousWinnerIndex,
          rotations: widget.rotations,
          winnerIndex: widget.winnerIndex,
          colors: widget.colors,
        ),
      WheelType.sliced => SlicedWheel(
          animation: widget.animation,
          children: widget.children,
          scaling: widget.scaling,
          previousWinnerIndex: widget.previousWinnerIndex,
          rotations: widget.rotations,
          winnerIndex: widget.winnerIndex,
          colors: widget.colors,
        ),
      WheelType.disappearing => DisappearingWheel(
          animation: widget.animation,
          children: widget.children,
          scaling: widget.scaling,
          previousWinnerIndex: widget.previousWinnerIndex,
          rotations: widget.rotations,
          winnerIndex: widget.winnerIndex,
          colors: widget.colors,
        ),
    };
  }
}

enum WheelType {
  normal,
  sliced,
  disappearing,
}
