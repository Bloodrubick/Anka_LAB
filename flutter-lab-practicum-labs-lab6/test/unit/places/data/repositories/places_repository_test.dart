import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:surf_mad_teacher_training/api/data/place_dto.dart';
import 'package:surf_mad_teacher_training/api/data/place_type_dto.dart';
import 'package:surf_mad_teacher_training/api/service/api_client.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/result.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/place_response_converter.dart';
import 'package:surf_mad_teacher_training/feature/places/data/repositories/places_repository.dart';
import 'package:surf_mad_teacher_training/persistence/filter_storage/filter_storage.dart';

import 'places_repository_test.mocks.dart';

@GenerateMocks([
  ApiClient,
  FilterStorage,
])
void main() {
  late PlacesRepository placesRepository;
  late MockApiClient mockApiClient;
  late FilterStorage filterStorage;
  late FilterPlacesConverter filterPlacesConverter;
  late PlaceResponseConverter placeResponseConverter;

  setUp(() {
    mockApiClient = MockApiClient();
    filterStorage = MockFilterStorage();
    filterPlacesConverter = FilterPlacesConverter();
    placeResponseConverter = PlaceResponseConverter();
    placesRepository = PlacesRepository(
      apiClient: mockApiClient,
      filterStorage: filterStorage,
      filterPlacesConverter: filterPlacesConverter,
      placeResponseConverter: placeResponseConverter,
    );
  });

  group(
    'группа тестов для PlacesRepository',
    () {
      final filter = FilterPlacesEntity();
      const placeResponse = PlaceDto(
        id: 1,
        name: 'Test name',
        description: 'Test description',
        placeType: PlaceTypeDto.other,
        images: [],
        lat: 1,
        lon: 1,
      );

      test(
        'getPlaces возвращает успех при успешном вызове API',
        () async {
          when(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).thenAnswer((_) async => [placeResponse]);

          final result = await placesRepository.getPlaces(filter: filter);

          expect(result, isA<ResultOk<List<PlaceEntity>, Object>>());
          expect((result as ResultOk<List<PlaceEntity>, Object>).data, hasLength(1));
          verify(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).called(1);
        },
      );

      test(
        'getPlaces возвращает ошибку при вызове API',
        () async {
          final dioException = DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 404,
            ),
          );
          when(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).thenThrow(dioException);

          final result = await placesRepository.getPlaces(filter: filter);

          expect(result, isA<ResultFailed<List<PlaceEntity>, Object>>());
          verify(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).called(1);
        },
      );
    },
  );
}
