part of '../search_screen.dart';

/// {@template _result_item_widget.class}
/// Виджет для отображения карточки результата поиска.
/// {@endtemplate}
class _ResultItemWidget extends StatelessWidget {
  final PlaceEntity place;
  final ValueChanged<PlaceEntity> onPressed;
  final String keyword;

  /// {@macro _result_item_widget.class}
  const _ResultItemWidget({
    required this.place,
    required this.onPressed,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return InkWell(
      onTap: () => onPressed(place),
      highlightColor: colorTheme.background.withValues(alpha: 0),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 56,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: NetworkImageWidget(imgUrl: place.images.first, height: 56),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.rich(
                    TextSpan(
                      children: place.name.getNameWithKeyword(
                        keyword,
                        colorTheme,
                        textTheme,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    place.type.label,
                    style: textTheme.text.copyWith(color: colorTheme.secondaryVariant),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
