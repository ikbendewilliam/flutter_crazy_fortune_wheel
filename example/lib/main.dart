import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crazy_fortune_wheel/flutter_crazy_fortune_wheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );
  late final animation =
      controller.drive(CurveTween(curve: FortuneWheelCurve()));

  final _childrenLong = childrenLong;
  var _childrenLongWinnerIndex = 0;
  var _childrenMediumWinnerIndex = 0;

  @override
  void initState() {
    super.initState();
    _setNextWinnerIndex();
  }

  void _startAnimation() {
    if (animation.status == AnimationStatus.dismissed) {
      setState(() {
        _setNextWinnerIndex();
      });
      controller.forward();
    } else {
      setState(() {
        controller.value = 0;
        _removeWinner();
      });
    }
  }

  void _setNextWinnerIndex() {
    _childrenMediumWinnerIndex = Random.secure().nextInt(childrenMedium.length);
    _childrenLongWinnerIndex = Random.secure().nextInt(_childrenLong.length);
  }

  void _removeWinner() {
    setState(() {
      if (_childrenLong.length > 2)
        _childrenLong.removeAt(_childrenLongWinnerIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Normal Wheel',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Sliced Wheel',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Disappearing Wheel',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Random Wheel',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: NormalWheel(
                    animation: animation,
                    winnerIndex: 1,
                    previousWinnerIndex: 1,
                    children: childrenShort,
                  ),
                ),
                Expanded(
                  child: SlicedWheel(
                    animation: animation,
                    winnerIndex: 1,
                    previousWinnerIndex: 1,
                    children: childrenShort,
                  ),
                ),
                Expanded(
                  child: DisappearingWheel(
                    animation: animation,
                    winnerIndex: 1,
                    previousWinnerIndex: 1,
                    children: childrenShort,
                  ),
                ),
                Expanded(
                  child: RandomWheel(
                    animation: animation,
                    winnerIndex: 1,
                    previousWinnerIndex: 1,
                    children: childrenShort,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: NormalWheel(
                    animation: animation,
                    winnerIndex: _childrenMediumWinnerIndex,
                    children: childrenMedium,
                  ),
                ),
                Expanded(
                  child: SlicedWheel(
                    animation: animation,
                    winnerIndex: _childrenMediumWinnerIndex,
                    children: childrenMedium,
                  ),
                ),
                Expanded(
                  child: DisappearingWheel(
                    animation: animation,
                    winnerIndex: _childrenMediumWinnerIndex,
                    children: childrenMedium,
                  ),
                ),
                Expanded(
                  child: RandomWheel(
                    animation: animation,
                    winnerIndex: _childrenMediumWinnerIndex,
                    children: childrenMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: NormalWheel(
                    animation: animation,
                    winnerIndex: _childrenLongWinnerIndex,
                    children: childrenLong,
                  ),
                ),
                Expanded(
                  child: SlicedWheel(
                    animation: animation,
                    winnerIndex: _childrenLongWinnerIndex,
                    children: childrenLong,
                  ),
                ),
                Expanded(
                  child: DisappearingWheel(
                    animation: animation,
                    winnerIndex: _childrenLongWinnerIndex,
                    children: childrenLong,
                  ),
                ),
                Expanded(
                  child: RandomWheel(
                    animation: animation,
                    winnerIndex: _childrenLongWinnerIndex,
                    children: childrenLong,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) => Slider(
              value: controller.value,
              onChanged: (value) {
                controller.value = value;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _childrenLong.add(
                      _childrenLong[Random().nextInt(_childrenLong.length)]);
                });
              },
              child: Icon(Icons.plus_one),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: _startAnimation,
              child: Icon(animation.status == AnimationStatus.dismissed
                  ? Icons.play_arrow
                  : Icons.replay_sharp),
            ),
          ],
        ),
      ),
    );
  }
}

final childrenLong = [
  'Justin',
  'Kevin',
  'John',
  'Sarah',
  'Alex',
  'Michael',
  'Jessica',
  'William',
  'Ashley',
  'Chris',
  'Amanda',
  'Daniel',
  'Megan',
  'Matthew',
  'Emily',
  'David',
  'Brittany',
  'Andrew',
  'Stephanie',
  'James',
  'Samantha',
  'Joseph',
  'Lauren',
  'Ryan',
  'Nicole',
  'Nicholas',
  'Kayla',
  'Robert',
  'Melissa',
]
    .map(
      (s) => Text(
        s,
        style: const TextStyle(
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    )
    .toList();
final childrenMedium = [
  'Justin',
  'Kevin',
  'John',
  'Sarah',
  'Alex',
  'Michael',
  'Jessica',
  'William',
  'Ashley',
  'Chris',
]
    .map(
      (s) => Text(
        s,
        style: const TextStyle(
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    )
    .toList();
final childrenShort = [
  '0Justin',
  '1Kevin',
  '2John',
]
    .map(
      (s) => Text(
        s,
        style: const TextStyle(
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    )
    .toList();
