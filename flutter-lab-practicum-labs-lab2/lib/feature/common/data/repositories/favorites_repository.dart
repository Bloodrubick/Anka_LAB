import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/feature/common/data/converters/favorite_place_from_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/common/data/converters/favorite_place_to_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/repositories/i_favorites_repository.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';
import 'package:surf_mad_teacher_training/persistence/database/daos/favorites_dao.dart';

/// {@template favorites_repository.class}
/// Implementation of [IFavoritesRepository] для Избранного.
/// {@endtemplate}
final class FavoritesRepository implements IFavoritesRepository {
  final FavoritesDao _favoritesDao;
  final IFavoritePlaceFromDbConverter _fromDbConverter;
  final IFavoritePlaceToDbConverter _toDbConverter;

  /// Стрим для работы с избранными местами.
  final _favoritesSubject = BehaviorSubject<List<PlaceEntity>>.seeded([]);
  late final StreamSubscription<List<FavoritePlacesTableData>> _favoritesTableDataSubscription;

  /// {@macro favorites_repository.class}
  FavoritesRepository({
    required FavoritesDao favoritesDao,
    required IFavoritePlaceFromDbConverter fromDbConverter,
    required IFavoritePlaceToDbConverter toDbConverter,
  }) : _favoritesDao = favoritesDao,
       _fromDbConverter = fromDbConverter,
       _toDbConverter = toDbConverter {
    unawaited(_init());
  }

  @override
  ValueStream<List<PlaceEntity>> get favoritesStream => _favoritesSubject.stream;

  @override
  void dispose() {
    unawaited(_favoritesSubject.close());
    unawaited(_favoritesTableDataSubscription.cancel());
  }

  @override
  void toggleFavorite(PlaceEntity place) {
    final favorites = _favoritesSubject.value;
    final index = favorites.indexWhere((element) => element.id == place.id);

    if (index == -1) {
      unawaited(_favoritesDao.addFavorite(_toDbConverter.convert(place)));
    } else {
      unawaited(_favoritesDao.removeFavorite(place.id));
    }
  }

  Future<void> _init() async {
    try {
      await _favoritesDao.fetchFavorites().then(_updateFavorites);
      _favoritesTableDataSubscription = _favoritesDao.favoritesStream.listen(_updateFavorites);
    } on Exception catch (e) {
      debugPrint('🟡-------- Не удалось загрузить данные из БД: $e');
    }
  }

  void _updateFavorites(List<FavoritePlacesTableData> dbPlaces) {
    _favoritesSubject.add(_fromDbConverter.convertMultiple(dbPlaces).toList());
  }
}
