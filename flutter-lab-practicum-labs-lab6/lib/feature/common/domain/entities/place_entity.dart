import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';

/// {@template place_entity.class}
/// Сущность места.
/// {@endtemplate}
class PlaceEntity {
  final String description;
  final double? distance;
  final int id;
  final List<String> images;
  final double lat;
  final double lon;
  final String name;
  final PlaceType type;

  /// {@macro place_entity.class}
  const PlaceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.images,
    required this.lat,
    required this.lon,
    this.distance,
  });
}
