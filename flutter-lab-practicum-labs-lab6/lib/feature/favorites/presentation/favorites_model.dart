import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/repositories/i_favorites_repository.dart';

/// {@template favorites_model.class}
/// Модель для FavoritesScreen.
/// {@endtemplate}
final class FavoritesModel implements IFavoritesModel {
  final IFavoritesRepository _favoritesRepository;

  /// {@macro favorites_model.class}
  const FavoritesModel({required IFavoritesRepository favoritesRepository})
    : _favoritesRepository = favoritesRepository;

  @override
  ValueStream<List<PlaceEntity>> get favoritesStream => _favoritesRepository.favoritesStream;

  @override
  Future<void> removePlace({required PlaceEntity place}) async {
    _favoritesRepository.toggleFavorite(place);
  }
}

abstract interface class IFavoritesModel {
  ValueStream<List<PlaceEntity>> get favoritesStream;

  Future<void> removePlace({required PlaceEntity place});
}
