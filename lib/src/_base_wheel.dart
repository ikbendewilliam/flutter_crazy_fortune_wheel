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
  /// final animation = controller.drive(CurveTween(curve: Curves.easeInOut));
  /// ```
  final Animation<double> animation;

  BaseWheel({
    required this.animation,
    super.key,
  });
}
