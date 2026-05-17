part of '../filter_screen.dart';

/// {@template clear_button_widget.class}
/// Кнопка Очистить для фильтра.
/// {@endtemplate}
class _ClearButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  /// {@macro clear_button_widget.class}
  const _ClearButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget(title: AppStrings.filterClearButtonTitle, onPressed: onPressed);
  }
}
