import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/entities/favorites_button_type.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/favorites_button_wm.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/entities/place_card_type.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/icon_action_button.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

part 'widgets/_big_button_widget.dart';
part 'widgets/_small_button_widget.dart';

/// {@template favorites_button_widget.class}
/// Виджет для кнопки Избранное.
/// {@endtemplate}
class FavoritesButtonWidget extends StatelessWidget {
  final IFavoritesButtonWM wm;
  final PlaceEntity place;
  final FavoritesButtonType buttonType;
  final PlaceCardType cardType;

  /// {@macro favorites_button_widget.class}
  const FavoritesButtonWidget({
    required this.wm,
    required this.place,
    required this.buttonType,
    required this.cardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: wm.isFavoriteState,
      builder: (_, isFavorite, __) {
        return switch (buttonType) {
          FavoritesButtonType.small => _SmallButtonWidget(
            onPressed: () => wm.onFavoritePressed(place),
            isFavorite: isFavorite,
            cardType: cardType,
          ),
          FavoritesButtonType.big => _BigButtonWidget(
            onPressed: () => wm.onFavoritePressed(place),
            isFavorite: isFavorite,
          ),
        };
      },
    );
  }
}
