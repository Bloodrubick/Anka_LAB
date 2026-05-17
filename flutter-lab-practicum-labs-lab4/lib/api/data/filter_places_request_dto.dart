import 'package:json_annotation/json_annotation.dart';

part 'filter_places_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class FilterPlacesRequestDto {
  final double? lat;
  @JsonKey(name: 'lng')
  final double? lon;
  final double? radius;
  @JsonKey(name: 'typeFilter')
  final List<String>? typeFilter;
  final String? nameFilter;

  const FilterPlacesRequestDto({
    this.lat,
    this.lon,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  });

  Map<String, dynamic> toJson() => _$FilterPlacesRequestDtoToJson(this);
}
