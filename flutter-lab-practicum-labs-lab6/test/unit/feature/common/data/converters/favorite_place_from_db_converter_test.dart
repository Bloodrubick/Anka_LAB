import 'package:flutter_test/flutter_test.dart';
import 'package:surf_mad_teacher_training/feature/common/data/converters/favorite_place_from_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';

void main() {
  group('FavoritePlaceFromDbConverter Tests', () {
    late FavoritePlaceFromDbConverter converter;

    setUp(() {
      converter = const FavoritePlaceFromDbConverter();
    });

    test('convert returns PlaceEntity from FavoritePlacesTableData', () {
      // Arrange
      final data = FavoritePlacesTableData(
        id: 1,
        placeId: 1,
        name: 'Test name',
        description: 'Test description',
        type: PlaceType.other,
        images: ['image1', 'image2'],
        lat: 55.5,
        lon: 37.7,
      );

      // Act
      final result = converter.convert(data);

      // Assert
      expect(result, isA<PlaceEntity>());
      expect(result.id, data.placeId);
      expect(result.name, data.name);
      expect(result.description, data.description);
      expect(result.type, data.type);
      expect(result.images, data.images);
      expect(result.lat, data.lat);
      expect(result.lon, data.lon);
    });
  });
}
