import 'package:flutter/material.dart';

/// {@template index_screen.class}
/// Шкала сложности заданий.
/// {@endtemplate}
class TasksDifficultyWidget extends StatelessWidget {
  /// {@macro index_screen.class}
  const TasksDifficultyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ColoredBox(color: Colors.green, child: Text('простой'))),
        Expanded(child: ColoredBox(color: Colors.yellow, child: Text('средний'))),
        Expanded(child: ColoredBox(color: Colors.red, child: Text('сложный'))),
      ],
    );
  }
}
