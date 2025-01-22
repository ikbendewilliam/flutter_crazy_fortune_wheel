import 'package:flutter/material.dart';

/// Base class for all the wheels
abstract class BaseWheel extends StatelessWidget {
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

  /// The index of the winner in the children list
  final int winnerIndex;

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

  BaseWheel({
    required this.animation,
    required this.children,
    required this.winnerIndex,
    this.scaling = 1,
    this.previousWinnerIndex = 0,
    this.rotations = 10,
    this.colors,
    super.key,
  });
}
