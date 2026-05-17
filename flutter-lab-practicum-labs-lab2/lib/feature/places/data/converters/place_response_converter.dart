import 'package:surf_mad_teacher_training/api/data/place_dto.dart';
import 'package:surf_mad_teacher_training/api/data/place_type_dto.dart';
import 'package:surf_mad_teacher_training/core/data/converter/converter.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';

/// Конвертер для [PlaceEntity].
typedef IPlaceResponseConverter = Converter<PlaceEntity, PlaceDto>;

/// {@template place_response_converter.class}
/// Реализация [IPlaceResponseConverter].
/// {@endtemplate}
final class PlaceResponseConverter extends IPlaceResponseConverter {
  /// {@macro place_response_converter.class}
  const PlaceResponseConverter();

  @override
  PlaceEntity convert(PlaceDto input) {
    return PlaceEntity(
      id: input.id,
      name: input.name,
      description: input.description,
      type: _convertType(input.placeType),
      images: input.images,
      lat: input.lat,
      lon: input.lon,
    );
  }

  PlaceType _convertType(PlaceTypeDto input) {
    return PlaceType.values.firstWhere((element) => element.name == input.name, orElse: () => PlaceType.other);
  }
}
