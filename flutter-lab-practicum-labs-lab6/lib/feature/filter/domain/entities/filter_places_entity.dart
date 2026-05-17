import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';

/// {@template filter_places_entity.class}
/// Сущность фильтра для мест.
/// {@endtemplate}
class FilterPlacesEntity {
  final double? lat;
  final double? lon;
  final String? name;
  final double? radius;
  final Set<PlaceType>? type;

  /// {@macro filter_places_entity.class}
  const FilterPlacesEntity({this.lat, this.lon, this.radius, this.type, this.name});

  factory FilterPlacesEntity.createDefault() =>
      FilterPlacesEntity(lat: 55.754194, lon: 37.620139, radius: 3000, type: PlaceType.values.toSet());

  FilterPlacesEntity copyWith({double? lat, double? lon, double? radius, Set<PlaceType>? type, String? name}) {
    return FilterPlacesEntity(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      radius: radius ?? this.radius,
      type: type ?? this.type,
      name: name ?? this.name,
    );
  }
}
