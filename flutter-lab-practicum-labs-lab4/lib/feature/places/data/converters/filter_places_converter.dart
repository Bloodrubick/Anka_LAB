import 'package:surf_mad_teacher_training/api/data/filter_places_request_dto.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';

abstract class IFilterPlacesConverter {
  FilterPlacesRequestDto convertEntityToDto(FilterPlacesEntity entity);
  Map<String, dynamic> convertEntityToMap(FilterPlacesEntity entity);
  FilterPlacesEntity convertMapToEntity(Map<String, dynamic> map);
}

class FilterPlacesConverter implements IFilterPlacesConverter {
  @override
  FilterPlacesRequestDto convertEntityToDto(FilterPlacesEntity entity) {
    return FilterPlacesRequestDto(
      lat: entity.lat,
      lon: entity.lon,
      radius: entity.radius,
      typeFilter: entity.type?.map((e) => e.name).toList(),
      nameFilter: entity.name,
    );
  }

  @override
  Map<String, dynamic> convertEntityToMap(FilterPlacesEntity entity) {
    return {
      if (entity.lat != null) 'lat': entity.lat,
      if (entity.lon != null) 'lon': entity.lon,
      if (entity.radius != null) 'radius': entity.radius,
      if (entity.name != null) 'name': entity.name,
      if (entity.type != null) 'type': entity.type!.map((e) => e.name).toList(),
    };
  }

  @override
  FilterPlacesEntity convertMapToEntity(Map<String, dynamic> map) {
    Set<PlaceType>? types;
    if (map['type'] != null) {
      final list = map['type'] as List<dynamic>;
      types = list
          .map((e) => PlaceType.values.firstWhere((t) => t.name == e as String, orElse: () => PlaceType.other))
          .toSet();
    }

    return FilterPlacesEntity(
      lat: map['lat'] as double?,
      lon: map['lon'] as double?,
      radius: map['radius'] as double?,
      name: map['name'] as String?,
      type: types,
    );
  }
}
