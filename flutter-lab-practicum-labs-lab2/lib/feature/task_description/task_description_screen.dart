import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/uikit/placeholder/todo_placeholder.dart';

/// {@template task_description_screen.dart.class}
/// Виджет описания задания.
/// {@endtemplate}
class TaskDescriptionScreen extends StatelessWidget {
  /// Заголовок задания.
  final String title;

  /// Описание задания.
  final String description;

  /// {@macro task_description_screen.dart.class}
  const TaskDescriptionScreen({required this.title, required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(description),

              TodoPlaceholder(todo: 'Разместите результат выполнения задания вместо этого placeholder'),

              Spacer(),

              FilledButton(onPressed: Navigator.of(context).pop, child: Text('Назад')),
            ],
          ),
        ),
      ),
    );
  }
}
