part of '../places_screen.dart';

/// {@template _places_list_widget.class}
/// Виджет для отображения списка мест.
/// {@endtemplate}
class _PlacesListWidget extends StatelessWidget {
  final List<PlaceEntity> places;
  final ValueChanged<PlaceEntity> onPressed;
  final AsyncCallback onRefresh;
  final VoidCallback onSearchPressed;
  final VoidCallback onFilterPressed;

  /// {@macro _places_list_widget.class}
  const _PlacesListWidget({
    required this.places,
    required this.onPressed,
    required this.onRefresh,
    required this.onSearchPressed,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (_, __) => [_SliverPlacesAppBar()],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _FakeSearchBarWidget(onSearchPressed: onSearchPressed, onFilterPressed: onFilterPressed),
            Expanded(
              child: RefreshIndicator.adaptive(
                onRefresh: onRefresh,
                child:
                    places.isEmpty
                        ? FullScreenErrorWidget(
                          title: AppStrings.commonEmptyStateTitle,
                          description: AppStrings.commonEmptyStateDescription,
                          iconAssetName: AppSvgIcons.icEmptySearch,
                        )
                        : ListView.separated(
                          padding: EdgeInsets.only(top: 34),
                          itemBuilder: (_, index) => PlaceCardWidget(place: places[index], onPressed: onPressed),
                          separatorBuilder: (_, __) => const SizedBox(height: 24),
                          itemCount: places.length,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
