import 'package:json_annotation/json_annotation.dart';
import 'package:surf_mad_teacher_training/api/data/place_type_dto.dart';

part 'filter_places_request_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class FilterPlacesRequestDto {
  final double? lat;
  final double? lng;
  final String? nameFilter;
  final double? radius;
  final List<PlaceTypeDto>? typeFilter;
  const FilterPlacesRequestDto({this.lat, this.lng, this.radius, this.typeFilter, this.nameFilter});

  /// Создать фильтр по умолчанию на старте приложения.
  /// По умолчанию координаты на московском кремле.
  factory FilterPlacesRequestDto.createDefault() =>
      FilterPlacesRequestDto(lat: 55.754194, lng: 37.620139, radius: 3000, typeFilter: PlaceTypeDto.values);

  factory FilterPlacesRequestDto.fromJson(Map<String, Object?> json) => _$FilterPlacesRequestDtoFromJson(json);

  Map<String, Object?> toJson() => _$FilterPlacesRequestDtoToJson(this);
}
