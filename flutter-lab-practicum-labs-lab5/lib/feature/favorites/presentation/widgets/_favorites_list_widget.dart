part of '../favorites_screen.dart';

/// {@template _favorites_list_widget.class}
/// Виджет для отображения списка избранных мест.
/// {@endtemplate}
class _FavoritesListWidget extends StatelessWidget {
  final List<PlaceEntity> places;
  final ValueChanged<PlaceEntity> onPlacePressed;
  final ValueChanged<PlaceEntity> onRemovePressed;

  /// {@macro _favorites_list_widget.class}
  const _FavoritesListWidget({
    required this.places,
    required this.onPlacePressed,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    return places.isEmpty
        ? FullScreenErrorWidget(
          title: AppStrings.favoritesEmptyStateTitle,
          description: AppStrings.favoritesEmptyStateDescription,
          iconAssetName: AppSvgIcons.icEmptyPlanned,
        )
        : ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder:
              (_, index) => _DismissibleWrapper(
                place: places[index],
                onRemovePressed: onRemovePressed,
                child: PlaceCardWidget(
                  place: places[index],
                  onPressed: onPlacePressed,
                  cardType: PlaceCardType.favorite,
                ),
              ),
          separatorBuilder: (_, __) => const SizedBox(height: 24),
          itemCount: places.length,
        );
  }
}
