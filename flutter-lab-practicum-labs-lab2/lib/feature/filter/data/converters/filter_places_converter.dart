import 'package:surf_mad_teacher_training/api/data/filter_places_request_dto.dart';
import 'package:surf_mad_teacher_training/api/data/place_type_dto.dart';
import 'package:surf_mad_teacher_training/core/data/converter/converter.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';

/// Конвертер [FilterPlacesEntity] <-> [FilterPlacesRequestDto].
typedef IFilterPlacesConverter = ConverterToAndFrom<FilterPlacesEntity, FilterPlacesRequestDto>;

/// {@template filter_places_converter.class}
/// Реализация [IFilterPlacesConverter].
/// {@endtemplate}
final class FilterPlacesConverter extends IFilterPlacesConverter {
  /// {@macro filter_places_converter.class}
  const FilterPlacesConverter();

  @override
  Converter<FilterPlacesEntity, FilterPlacesRequestDto> get converter => const _FilterConverter();

  @override
  Converter<FilterPlacesRequestDto, FilterPlacesEntity> get reverseConverter => const _FilterReversConverter();
}

base class _FilterConverter extends Converter<FilterPlacesEntity, FilterPlacesRequestDto> {
  const _FilterConverter();

  @override
  FilterPlacesEntity convert(FilterPlacesRequestDto input) {
    final typeFilter = input.typeFilter;

    return FilterPlacesEntity(
      lat: input.lat,
      lon: input.lng,
      radius: input.radius,
      type: typeFilter == null ? null : _convertType(typeFilter),
      name: input.nameFilter,
    );
  }

  Set<PlaceType> _convertType(List<PlaceTypeDto> input) {
    return input
        .map(
          (apiType) => PlaceType.values.firstWhere(
            (domainType) => domainType.name == apiType.name,
            orElse: () => PlaceType.other,
          ),
        )
        .toSet();
  }
}

base class _FilterReversConverter extends Converter<FilterPlacesRequestDto, FilterPlacesEntity> {
  const _FilterReversConverter();

  @override
  FilterPlacesRequestDto convert(FilterPlacesEntity input) {
    final typeFilter = input.type;

    return FilterPlacesRequestDto(
      lat: input.lat,
      lng: input.lon,
      radius: input.radius,
      typeFilter: typeFilter == null ? null : _convertType(typeFilter),
      nameFilter: input.name,
    );
  }

  List<PlaceTypeDto> _convertType(Set<PlaceType> input) {
    return input
        .map(
          (domainType) => PlaceTypeDto.values.firstWhere(
            (apiType) => apiType.name == domainType.name,
            orElse: () => PlaceTypeDto.other,
          ),
        )
        .toList();
  }
}
