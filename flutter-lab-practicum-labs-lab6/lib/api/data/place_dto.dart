import 'package:json_annotation/json_annotation.dart';
import 'package:surf_mad_teacher_training/api/data/place_type_dto.dart';

part 'place_dto.g.dart';

@JsonSerializable(createToJson: false)
class PlaceDto {
  final String description;
  final double? distance;
  final int id;
  @JsonKey(name: 'urls')
  final List<String> images;
  final double lat;
  @JsonKey(name: 'lng')
  final double lon;
  final String name;
  final PlaceTypeDto placeType;
  const PlaceDto({
    required this.id,
    required this.name,
    required this.description,
    required this.placeType,
    required this.images,
    required this.lat,
    required this.lon,
    this.distance,
  });

  factory PlaceDto.fromJson(Map<String, dynamic> json) => _$PlaceDtoFromJson(json);
}
