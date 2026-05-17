part of '../favorites_button_widget.dart';

/// Кнопка-иконка Избранное для карточек мест.
class _SmallButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isFavorite;
  final PlaceCardType cardType;

  const _SmallButtonWidget({required this.onPressed, required this.isFavorite, required this.cardType});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);

    return cardType == PlaceCardType.place
        ? AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: IconActionButton(
            svgPath: isFavorite ? AppSvgIcons.icFavoritesFull : AppSvgIcons.icFavorites,
            color: colorTheme.neutralWhite,
            onPressed: onPressed,
            key: ValueKey(isFavorite),
          ),
        )
        : IconActionButton(
          svgPath: AppSvgIcons.icClose,
          color: colorTheme.neutralWhite,
          onPressed: onPressed,
        );
  }
}
