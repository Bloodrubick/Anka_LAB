part of '../filter_screen.dart';

/// {@template _sliver_title_widget.class}
/// Виджет Заголовок для Категорий фильтра.
/// {@endtemplate}
class _SliverTitleWidget extends StatelessWidget {
  /// {@macro _sliver_title_widget.class}
  const _SliverTitleWidget();

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Text(
          AppStrings.filterCategories.toUpperCase(),
          style: textTheme.text.copyWith(color: colorTheme.inactive),
        ),
      ),
    );
  }
}
