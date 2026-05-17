part of '../search_screen.dart';

/// {@template _result_widget.class}
/// Виджет для отображения списка результатов поиска.
/// {@endtemplate}
class _ResultWidget extends StatelessWidget {
  final List<PlaceEntity> placesList;
  final ValueChanged<PlaceEntity> onPressed;
  final String keyword;

  /// {@macro _result_widget.class}
  const _ResultWidget({
    required this.placesList,
    required this.onPressed,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    return placesList.isEmpty
        ? FullScreenErrorWidget(
          title: AppStrings.commonEmptyStateTitle,
          description: AppStrings.commonEmptyStateDescription,
          iconAssetName: AppSvgIcons.icEmptySearch,
        )
        : ListView.separated(
          physics:
              Theme.of(context).platform == TargetPlatform.iOS
                  ? const BouncingScrollPhysics()
                  : const ClampingScrollPhysics(),
          padding: EdgeInsets.only(left: 4, top: 24, right: 4),
          itemBuilder:
              (_, index) => _ResultItemWidget(
                place: placesList[index],
                onPressed: onPressed,
                keyword: keyword,
              ),
          separatorBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 88, right: 12),
              child: Divider(),
            );
          },
          itemCount: placesList.length,
        );
  }
}
