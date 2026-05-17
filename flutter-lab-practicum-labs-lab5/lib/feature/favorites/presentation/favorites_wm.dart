import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/favorites/presentation/favorites_model.dart';
import 'package:surf_mad_teacher_training/navigation/router.dart';

abstract interface class IFavoritesWM {
  ValueListenable<List<PlaceEntity>> get favoritesListenable;

  void dispose();

  void onRemovePressed(PlaceEntity place);

  void onPlacePressed(PlaceEntity place);
}

final class FavoritesWM implements IFavoritesWM {
  final IFavoritesModel _model;
  final BuildContext _context;
  final _favoritesState = ValueNotifier<List<PlaceEntity>>([]);
  late final StreamSubscription<List<PlaceEntity>> _favoritesSubscription;

  FavoritesWM({required BuildContext context, required IFavoritesModel model}) : _context = context, _model = model {
    _init();
  }

  @override
  ValueListenable<List<PlaceEntity>> get favoritesListenable => _favoritesState;

  @override
  void dispose() {
    unawaited(_favoritesSubscription.cancel());
    _favoritesState.dispose();
  }

  @override
  void onPlacePressed(PlaceEntity place) {
    unawaited(
      _context.router.push(PlaceDetailRouteBuilder(place: place)),
    );
  }

  @override
  void onRemovePressed(PlaceEntity place) {
    unawaited(_model.removePlace(place: place));
  }

  void _init() {
    _favoritesSubscription = _model.favoritesStream.listen(_favoritesStreamListener);
  }

  void _favoritesStreamListener(List<PlaceEntity> favoritesList) {
    _favoritesState.value = List.from(favoritesList);
  }
}
