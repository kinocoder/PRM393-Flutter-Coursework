import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/ui/Screens/core_widget_demo.dart';

import '../Screens/InputControlsDemo.dart';

class LapExercise extends StatelessWidget {
  const LapExercise({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    style: TextStyle(fontSize: 25),
                    "Exercise 1 - Core Widgets Demo",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.chevron_right),
                    iconSize: 35,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const CoreWidgetDemo() as Widget));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    style: TextStyle(fontSize: 25),
                    "Exercise 2 - Input Controls Demo",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.chevron_right),
                    iconSize: 35,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const ExeWidget2() as Widget));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    style: TextStyle(fontSize: 25),
                    "Exercise 3 - Layout Demo",
                  ),
                ),
                Expanded(flex: 1, child: Icon(size: 35, Icons.chevron_right)),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    style: TextStyle(fontSize: 25),
                    "Exercise 4 - App Structure & Theme",
                  ),
                ),
                Expanded(flex: 1, child: Icon(size: 35, Icons.chevron_right)),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    style: TextStyle(fontSize: 25),
                    "Exercise 5 - Common UI Fixes",
                  ),
                ),
                Expanded(flex: 1, child: Icon(size: 35, Icons.chevron_right)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
