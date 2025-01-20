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
  late final animation = controller.drive(CurveTween(curve: FortuneWheelCurve()));

  @override
  void initState() {
    super.initState();
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
                    children: childrenShort,
                  ),
                ),
                Expanded(
                  child: SlicedWheel(
                    animation: animation,
                    children: childrenShort,
                  ),
                ),
                Expanded(
                  child: DisappearingWheel(
                    animation: animation,
                    children: childrenShort,
                  ),
                ),
                Expanded(
                  child: RandomWheel(
                    animation: animation,
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
                    children: childrenMedium,
                  ),
                ),
                Expanded(
                  child: SlicedWheel(
                    animation: animation,
                    children: childrenMedium,
                  ),
                ),
                Expanded(
                  child: DisappearingWheel(
                    animation: animation,
                    children: childrenMedium,
                  ),
                ),
                Expanded(
                  child: RandomWheel(
                    animation: animation,
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
                    children: childrenLong,
                  ),
                ),
                Expanded(
                  child: SlicedWheel(
                    animation: animation,
                    children: childrenLong,
                  ),
                ),
                Expanded(
                  child: DisappearingWheel(
                    animation: animation,
                    children: childrenLong,
                  ),
                ),
                Expanded(
                  child: RandomWheel(
                    animation: animation,
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
        child: FloatingActionButton(
          onPressed: () {
            controller.forward(from: 0);
          },
          child: const Icon(Icons.play_arrow),
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
  'Justin',
  'Kevin',
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
