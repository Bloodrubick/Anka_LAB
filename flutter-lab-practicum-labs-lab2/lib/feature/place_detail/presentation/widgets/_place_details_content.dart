part of '../place_detail_screen.dart';

/// {@template _place_details_content.class}
/// Основной текстовый контент для детальной страницы.
/// {@endtemplate}
class _PlaceDetailsContent extends StatelessWidget {
  final PlaceEntity place;

  /// {@macro _place_details_content.class}
  const _PlaceDetailsContent({required this.place});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    final typeName = switch (place.type) {
      PlaceType.temple => 'храм',
      PlaceType.monument => 'памятник',
      PlaceType.park => 'парк',
      PlaceType.theatre => 'театр',
      PlaceType.museum => 'музей',
      PlaceType.hotel => 'отель',
      PlaceType.restaurant => 'ресторан',
      PlaceType.cafe => 'кафе',
      PlaceType.other => 'особое место',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          place.name,
          style: textTheme.title.copyWith(color: colorTheme.textPrimary),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              typeName,
              style: textTheme.smallBold.copyWith(color: colorTheme.textSecondaryVariant),
            ),
            const SizedBox(width: 16),
            Text(
              'закрыто до 09:00', // Mock status as requested by design
              style: textTheme.small.copyWith(color: colorTheme.textSecondaryVariant),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          place.description,
          style: textTheme.small.copyWith(color: colorTheme.textPrimary),
        ),
      ],
    );
  }
}
