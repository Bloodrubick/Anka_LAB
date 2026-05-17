import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/presentation/filter_wm.dart';
import 'package:surf_mad_teacher_training/uikit/placeholder/todo_placeholder.dart';

/// {@template filter_screen.class}
/// Экран с фильтром.
/// {@endtemplate}
class FilterScreen extends StatelessWidget {
  final IFilterWM wm;
  final FilterPlacesEntity initialFilter;

  /// {@macro filter_screen.class}
  const FilterScreen({required this.wm, required this.initialFilter, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Фильтр'), iconTheme: IconThemeData(color: Colors.black)),
      body: TodoPlaceholder(
        todo:
            'Сверстайте все элементы в соответствии с дизайном. Отдельные смысловые элементы экрана вынесите в отдельные виджеты в папку widgets.',
        child: Column(
          children: [
            TodoPlaceholder(todo: 'Кнопка "Очистить"'),
            TodoPlaceholder(todo: 'Виджет для отображения типов мест.'),
            TodoPlaceholder(todo: 'Виджет для отображения слайдера.'),
            TodoPlaceholder(todo: 'Виджет для отображения кнопки "Показать".'),
          ],
        ),
      ),
    );
  }
}
