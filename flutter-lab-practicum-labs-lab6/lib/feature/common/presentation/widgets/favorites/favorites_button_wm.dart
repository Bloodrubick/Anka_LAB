import 'package:flutter/foundation.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/favorites_button_model.dart';

final class FavoritesButtonWM implements IFavoritesButtonWM {
  final IFavoritesButtonModel _model;

  const FavoritesButtonWM({required IFavoritesButtonModel model}) : _model = model;

  @override
  ValueListenable<bool> get isFavoriteState => _model.isFavoriteState;

  @override
  void dispose() {
    _model.dispose();
  }

  @override
  void onFavoritePressed(PlaceEntity place) {
    _model.toggleFavorite(place);
  }
}

abstract interface class IFavoritesButtonWM {
  ValueListenable<bool> get isFavoriteState;

  void dispose();

  void onFavoritePressed(PlaceEntity place);
}
