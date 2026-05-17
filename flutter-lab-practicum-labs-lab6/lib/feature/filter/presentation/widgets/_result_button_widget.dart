part of '../filter_screen.dart';

/// {@template _result_button_widget.class}
/// Кнопка Показать результаты для фильтра.
/// {@endtemplate}
class _ResultButtonWidget extends StatelessWidget {
  final ValueListenable<FilteredPlacesState> placesStateListenable;
  final VoidCallback onPressed;

  /// {@macro _result_button_widget.class}
  const _ResultButtonWidget({required this.placesStateListenable, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final emptyResult = AppStrings.filterResultButtonTitle(0).toUpperCase();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ValueListenableBuilder(
          valueListenable: placesStateListenable,
          builder: (_, state, __) {
            return switch (state) {
              FilteredPlacesStateLoading() => MainButton(
                onPressed: onPressed,
                state: ButtonState.loading,
                child: Text(emptyResult),
              ),
              FilteredPlacesStateFailure() => MainButton(
                onPressed: onPressed,
                state: ButtonState.inactive,
                child: Text(emptyResult),
              ),
              FilteredPlacesStateData(:final int foundQuantity) => MainButton(
                onPressed: onPressed,
                state: foundQuantity > 0 ? ButtonState.active : ButtonState.inactive,
                child: Text(AppStrings.filterResultButtonTitle(foundQuantity).toUpperCase()),
              ),
            };
          },
        ),
      ),
    );
  }
}
