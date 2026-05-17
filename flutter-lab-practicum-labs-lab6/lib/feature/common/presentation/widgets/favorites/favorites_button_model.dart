import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/repositories/i_favorites_repository.dart';

/// {@template favorites_button_model.class}
/// Модель для FavoritesButtonWidget.
/// {@endtemplate}
final class FavoritesButtonModel implements IFavoritesButtonModel {
  final IFavoritesRepository _favoriteButtonRepository;
  late final StreamSubscription<List<PlaceEntity>> _favoritesStreamSubscription;
  final _isFavoriteState = ValueNotifier<bool>(false);
  final PlaceEntity _place;

  /// {@macro favorites_button_model.class}
  FavoritesButtonModel({
    required PlaceEntity place,
    required IFavoritesRepository favoritesButtonRepository,
  }) : _place = place,
       _favoriteButtonRepository = favoritesButtonRepository {
    _init();
  }

  @override
  ValueListenable<bool> get isFavoriteState => _isFavoriteState;

  @override
  void dispose() {
    _isFavoriteState.dispose();
    unawaited(_favoritesStreamSubscription.cancel());
  }

  @override
  void toggleFavorite(PlaceEntity place) {
    _favoriteButtonRepository.toggleFavorite(place);
  }

  void _init() {
    _favoritesStreamSubscription = _favoriteButtonRepository.favoritesStream.listen((places) {
      final index = places.indexWhere((element) => element.id == _place.id);
      _isFavoriteState.value = index != -1;
    });
  }
}

abstract interface class IFavoritesButtonModel {
  ValueListenable<bool> get isFavoriteState;

  void dispose();

  void toggleFavorite(PlaceEntity place);
}
