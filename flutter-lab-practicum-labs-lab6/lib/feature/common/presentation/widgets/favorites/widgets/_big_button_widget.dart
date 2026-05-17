part of '../favorites_button_widget.dart';

/// Кнопка Избранное Большая для экрана PlaceDetailsScreen.
class _BigButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isFavorite;

  const _BigButtonWidget({required this.onPressed, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: TextButton(
        key: ValueKey(isFavorite),
        onPressed: onPressed,
        style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPictureWidget(
              isFavorite ? AppSvgIcons.icFavoritesFull : AppSvgIcons.icFavorites,
              color: colorTheme.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              isFavorite ? AppStrings.placeDetailsIsFavouritesButton : AppStrings.placeDetailsAddToFavouritesButton,
              style: textTheme.small.copyWith(color: colorTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
