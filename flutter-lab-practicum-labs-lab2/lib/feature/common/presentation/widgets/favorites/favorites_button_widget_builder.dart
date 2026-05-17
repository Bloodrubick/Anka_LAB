import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/entities/favorites_button_type.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/favorites_button_model.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/favorites_button_widget.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/favorites_button_wm.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/entities/place_card_type.dart';

/// {@template favorites_button_widget_create.class}
/// Виджет-обёртка для кнопки Избранное.
/// {@endtemplate}
class FavoritesButtonWidgetBuilder extends StatelessWidget {
  final PlaceEntity place;
  final FavoritesButtonType buttonType;
  final PlaceCardType cardType;

  /// {@macro favorites_button_widget_create.class}
  const FavoritesButtonWidgetBuilder({
    required this.place,
    required this.buttonType,
    required this.cardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider(
      create:
          (_) => FavoritesButtonWM(
            model: FavoritesButtonModel(
              place: place,
              favoritesButtonRepository: context.read<IAppScope>().favoritesRepository,
            ),
          ),
      dispose: (_, wm) => wm.dispose(),
      builder:
          (builderContext, __) => FavoritesButtonWidget(
            wm: builderContext.read<FavoritesButtonWM>(),
            place: place,
            buttonType: buttonType,
            cardType: cardType,
          ),
    );
  }
}
