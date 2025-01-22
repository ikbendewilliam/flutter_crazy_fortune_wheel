# flutter_crazy_fortune_wheel

[![pub package](https://img.shields.io/pub/v/flutter_crazy_fortune_wheel.svg)](https://pub.dartlang.org/packages/flutter_crazy_fortune_wheel)


https://github.com/ikbendewilliam/flutter_crazy_fortune_wheel/blob/main/example/screenshots/example.gif?raw=true

## Getting Started

If you use the SlicedWheel (or the RandomWheel), you will need to add this shader to your pubspec.yaml:

```yaml
flutter:
  shaders:
    - packages/flutter_crazy_fortune_wheel/shaders/sliced_wheel_shader.frag
```

Create an animationController, and optionally "drive" it using `FortuneWheelCurve` to improve the animation:

```dart
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );
  late final animation = controller.drive(CurveTween(curve: FortuneWheelCurve()));
```

Create the wheel:

```dart
NormalWheel( // or SlicedWheel, DisappearingWheel, or RandomWheel
    animation: animation, // AnimationController or animation<double>
    winnerIndex: winnerIndex, // For example: winnerIndex = Random.secure().nextInt(childrenMedium.length);
    children: children, // The widgets that will be displayed on the wheel
),
```
