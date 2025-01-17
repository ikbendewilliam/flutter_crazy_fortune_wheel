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
  late final animation = controller.drive(CurveTween(curve: Cubic(.09, -0.17, .6, 1.05)));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: NormalWheel(
              animation: animation,
              children: [
                'Justin',
                'Kevin',
                'Sam',
                'Kate',
                'John',
                'Debbie but a very long name',
                'Sarah',
                'Justin',
                'Kevin',
                'Sam',
                'Kate',
                'John',
                'Debbie',
                'Sarah',
                'Justin',
                'Kevin',
                'Sam',
                'Kate',
                'John',
                'Debbie',
                'Sarah',
                'Justin',
                'Kevin',
                'Sam',
                'Kate',
                'John',
                'Debbie',
                'Sarah',
                'Debbie',
                'Sarah',
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
                  .toList(),
            ),
          ),
          Slider(
            value: animation.value,
            onChanged: (value) {
              controller.value = value;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward(from: 0);
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
