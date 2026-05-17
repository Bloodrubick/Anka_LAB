import 'package:drift/drift.dart';
import 'package:surf_mad_teacher_training/core/data/converter/converter.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';

/// Конвертер [PlaceEntity] -> [FavoritePlacesTableCompanion] для добавления в базу данных.
typedef IFavoritePlaceToDbConverter = Converter<FavoritePlacesTableCompanion, PlaceEntity>;

/// {@template favorite_place_to_db_converter}
/// Реализация для [IFavoritePlaceToDbConverter].
/// {@endtemplate}
final class FavoritePlaceToDbConverter extends IFavoritePlaceToDbConverter {
  /// {@macro favorite_place_to_db_converter}
  const FavoritePlaceToDbConverter();

  @override
  FavoritePlacesTableCompanion convert(PlaceEntity input) {
    return FavoritePlacesTableCompanion(
      placeId: Value(input.id),
      name: Value(input.name),
      description: Value(input.description),
      type: Value(input.type),
      images: Value(input.images),
      lat: Value(input.lat),
      lon: Value(input.lon),
    );
  }
}
