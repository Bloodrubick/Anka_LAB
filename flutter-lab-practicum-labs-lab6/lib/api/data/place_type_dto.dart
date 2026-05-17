import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum PlaceTypeDto {
  @JsonValue('temple')
  temple('temple'),
  @JsonValue('monument')
  monument('monument'),
  @JsonValue('park')
  park('park'),
  @JsonValue('theatre')
  theatre('theatre'),
  @JsonValue('museum')
  museum('museum'),
  @JsonValue('hotel')
  hotel('hotel'),
  @JsonValue('restaurant')
  restaurant('restaurant'),
  @JsonValue('cafe')
  cafe('cafe'),
  @JsonValue('other')
  other('other'),
  $unknown('other');

  const PlaceTypeDto(this.json);

  factory PlaceTypeDto.fromJson(String json) =>
      values.firstWhere((value) => value.json == json, orElse: () => $unknown);

  final String? json;

  String? toJson() => json;
}
