part of '../filter_screen.dart';

/// {@template _categories_widget_sliver.class}
/// Виджет Категории для фильтра.
/// {@endtemplate}
class _CategoriesWidgetSliver extends StatelessWidget {
  final ValueListenable<Set<PlaceType>> selectedTypesListenable;
  final ValueChanged<PlaceType> onPressed;

  /// {@macro _category_widget_sliver.class}
  const _CategoriesWidgetSliver({required this.selectedTypesListenable, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<PlaceType>>(
      valueListenable: selectedTypesListenable,
      builder:
          (_, selectedTypes, __) => SliverGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children:
                PlaceType.values
                    .map(
                      (type) =>
                          _CategoryWidget(type: type, isSelected: selectedTypes.contains(type), onPressed: onPressed),
                    )
                    .toList(),
          ),
    );
  }
}
