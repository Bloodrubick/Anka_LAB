import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:surf_mad_teacher_training/feature/common/data/converters/favorite_place_to_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';

void main() {
  group('FavoritePlaceToDbConverter Tests', () {
    late FavoritePlaceToDbConverter converter;

    setUp(() {
      converter = const FavoritePlaceToDbConverter();
    });

    test('convert returns FavoritePlacesTableCompanion from PlaceEntity', () {
      // Arrange
      const entity = PlaceEntity(
        id: 1,
        name: 'Test name',
        description: 'Test description',
        type: PlaceType.other,
        images: ['image1', 'image2'],
        lat: 55.5,
        lon: 37.7,
      );

      // Act
      final result = converter.convert(entity);

      // Assert
      expect(result, isA<FavoritePlacesTableCompanion>());
      expect(result.placeId.value, entity.id);
      expect(result.name.value, entity.name);
      expect(result.description.value, entity.description);
      expect(result.type.value, entity.type);
      expect(result.images.value, entity.images);
      expect(result.lat.value, entity.lat);
      expect(result.lon.value, entity.lon);
    });
  });
}
