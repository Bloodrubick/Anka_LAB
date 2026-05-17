import 'package:surf_mad_teacher_training/core/data/converter/converter.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';

/// Конвертер [FavoritePlacesTableData] -> [PlaceEntity] при извлечении из базы данных.
typedef IFavoritePlaceFromDbConverter = Converter<PlaceEntity, FavoritePlacesTableData>;

/// {@template favorite_place_from_db_converter.class}
/// Реализация для [IFavoritePlaceFromDbConverter].
/// {@endtemplate}
final class FavoritePlaceFromDbConverter extends IFavoritePlaceFromDbConverter {
  /// {@macro favorite_place_from_db_converter.class}
  const FavoritePlaceFromDbConverter();

  @override
  PlaceEntity convert(FavoritePlacesTableData input) {
    return PlaceEntity(
      id: input.placeId,
      name: input.name,
      description: input.description,
      type: input.type,
      images: input.images,
      lat: input.lat,
      lon: input.lon,
    );
  }
}
