import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/utils/extension/place_type_extension.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/entities/favorites_button_type.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/favorites_button_widget_builder.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/entities/place_card_type.dart';
import 'package:surf_mad_teacher_training/uikit/images/network_image_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

/// {@template place_card_widget.class}
/// Карточка места для списка мест.
/// {@endtemplate}
class PlaceCardWidget extends StatelessWidget {
  final PlaceEntity place;
  final ValueChanged<PlaceEntity> onPressed;
  final PlaceCardType cardType;

  /// {@macro place_card_widget.class}
  const PlaceCardWidget({
    required this.place,
    required this.onPressed,
    this.cardType = PlaceCardType.place,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Material(
        color: colorTheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    NetworkImageWidget(imgUrl: place.images.first, height: 96),
                    Positioned(
                      left: 16,
                      top: 16,
                      right: 12,
                      child: Text(
                        place.type.label.toLowerCase(),
                        style: textTheme.smallBold.copyWith(color: colorTheme.neutralWhite),
                      ),
                    ),
                  ],
                ),
                _ContentWidget(place: place),
              ],
            ),
            Positioned.fill(
              child: Material(type: MaterialType.transparency, child: InkWell(onTap: () => onPressed(place))),
            ),
            Positioned(
              top: 8,
              right: 16,
              child: FavoritesButtonWidgetBuilder(
                place: place,
                buttonType: FavoritesButtonType.small,
                cardType: cardType,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  final PlaceEntity place;

  const _ContentWidget({required this.place});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name,
            style: textTheme.text.copyWith(color: colorTheme.textSecondary),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(width: double.infinity, height: 2),
          Text(
            place.description,
            style: textTheme.small.copyWith(color: colorTheme.textSecondaryVariant),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
