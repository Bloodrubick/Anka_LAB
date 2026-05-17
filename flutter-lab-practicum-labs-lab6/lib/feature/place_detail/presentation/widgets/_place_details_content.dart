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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(place.name, style: textTheme.title.copyWith(color: colorTheme.textSecondary)),
        SizedBox(height: 2),
        Text(place.type.label.toLowerCase(), style: textTheme.smallBold.copyWith(color: colorTheme.textSecondary)),
        SizedBox(height: 24),
        Text(place.description, style: textTheme.small.copyWith(color: colorTheme.textSecondary)),
      ],
    );
  }
}
