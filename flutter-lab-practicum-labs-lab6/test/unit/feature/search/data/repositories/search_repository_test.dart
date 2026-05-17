import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:surf_mad_teacher_training/api/service/api_client.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/result.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/place_response_converter.dart';
import 'package:surf_mad_teacher_training/feature/search/data/converters/search_keyword_from_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/search/data/converters/search_keyword_to_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/search/data/repositories/search_repository.dart';
import 'package:surf_mad_teacher_training/persistence/database/daos/history_search_dao.dart';

import 'search_repository_test.mocks.dart';

@GenerateMocks([
  ApiClient,
  HistorySearchDao,
])
void main() {
  late SearchRepository searchRepository;
  late MockApiClient mockApiClient;
  late MockHistorySearchDao mockHistorySearchDao;
  late FilterPlacesConverter filterPlacesConverter;
  late PlaceResponseConverter placeResponseConverter;
  late SearchKeywordFromDbConverter fromDbConverter;
  late SearchKeywordToDbConverter toDbConverter;

  setUp(() {
    mockApiClient = MockApiClient();
    mockHistorySearchDao = MockHistorySearchDao();
    filterPlacesConverter = const FilterPlacesConverter();
    placeResponseConverter = const PlaceResponseConverter();
    fromDbConverter = const SearchKeywordFromDbConverter();
    toDbConverter = const SearchKeywordToDbConverter();

    searchRepository = SearchRepository(
      apiClient: mockApiClient,
      historySearchDao: mockHistorySearchDao,
      filterPlacesConverter: filterPlacesConverter,
      placeResponseConverter: placeResponseConverter,
      fromDbConverter: fromDbConverter,
      toDbConverter: toDbConverter,
    );
  });

  group('SearchRepository Tests', () {
    test('getFilteredPlaces returns success on successful API call', () async {
      // Arrange
      final filter = FilterPlacesEntity(name: 'test');
      when(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).thenAnswer((_) async => []);

      // Act
      final result = await searchRepository.getFilteredPlaces(filter: filter);

      // Assert
      expect(result, isA<ResultOk<List<PlaceEntity>, Object>>());
      verify(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).called(1);
    });

    test('getFilteredPlaces returns failure on API error', () async {
      // Arrange
      final filter = FilterPlacesEntity(name: 'test');
      final dioException = DioException(
        requestOptions: RequestOptions(),
        response: Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
        ),
      );
      when(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).thenThrow(dioException);

      // Act
      final result = await searchRepository.getFilteredPlaces(filter: filter);

      // Assert
      expect(result, isA<ResultFailed<List<PlaceEntity>, Object>>());
      verify(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).called(1);
    });
  });
}
