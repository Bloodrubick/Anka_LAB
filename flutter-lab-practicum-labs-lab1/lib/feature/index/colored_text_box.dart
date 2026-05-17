import 'package:flutter/material.dart';

class ColoredTextBox extends StatelessWidget {
  /// Текст, который будет отображаться в виджете.
  final String text;

  /// Цвет фона для виджета.
  final Color color;

  const ColoredTextBox({required this.text, this.color = Colors.lightBlueAccent, super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: color, child: Padding(padding: const EdgeInsets.all(16), child: Text('Привет, $text!')));
  }
}
