import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/api/service/api_client.dart';
import 'package:surf_mad_teacher_training/core/data/repositories/base_repository.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/place_response_converter.dart';
import 'package:surf_mad_teacher_training/feature/search/data/converters/search_keyword_from_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/search/data/converters/search_keyword_to_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_keyword_entity.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/repositories/i_search_repository.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';
import 'package:surf_mad_teacher_training/persistence/database/daos/history_search_dao.dart';

/// {@template search_repository.class}
/// Implementation of [ISearchRepository].
/// {@endtemplate}
final class SearchRepository extends BaseRepository implements ISearchRepository {
  final ApiClient _apiClient;
  final HistorySearchDao _historySearchDao;
  final IFilterPlacesConverter _filterPlacesConverter;
  final IPlaceResponseConverter _placeResponseConverter;
  final ISearchKeywordFromDbConverter _fromDbConverter;
  final ISearchKeywordToDbConverter _toDbConverter;

  /// Стрим для получения списка ключевых слов поиска на экране Поиск.
  final _historySearchSubject = BehaviorSubject<List<String>>.seeded([]);

  /// {@macro search_repository.class}
  SearchRepository({
    required ApiClient apiClient,
    required HistorySearchDao historySearchDao,
    required IFilterPlacesConverter filterPlacesConverter,
    required IPlaceResponseConverter placeResponseConverter,
    required ISearchKeywordFromDbConverter fromDbConverter,
    required ISearchKeywordToDbConverter toDbConverter,
  }) : _apiClient = apiClient,
       _historySearchDao = historySearchDao,
       _filterPlacesConverter = filterPlacesConverter,
       _placeResponseConverter = placeResponseConverter,
       _fromDbConverter = fromDbConverter,
       _toDbConverter = toDbConverter;

  @override
  ValueStream<List<SearchKeywordEntity>> get historySearchStream =>
      _historySearchDao.historySearchStream.map(_convertToSearchKeywordEntity).shareValue();

  @override
  RequestOperation<List<PlaceEntity>> getFilteredPlaces({required FilterPlacesEntity filter}) => makeApiCall(() async {
    final data = await _apiClient.getFilteredPlaces(filter: _filterPlacesConverter.convertReverse(filter));

    return _placeResponseConverter.convertMultiple(data).toList();
  });

  @override
  Future<void> saveKeyword({required String keyword}) async {
    unawaited(_historySearchDao.saveKeyword(_toDbConverter.convert(keyword)));
  }

  @override
  Future<void> removeKeyword({required SearchKeywordEntity keyword}) async {
    unawaited(_historySearchDao.removeKeyword(keyword.id));
  }

  @override
  Future<void> clearHistory() async {
    unawaited(_historySearchDao.clearHistory());
  }

  @override
  void dispose() {
    unawaited(_historySearchSubject.close());
  }

  List<SearchKeywordEntity> _convertToSearchKeywordEntity(List<HistorySearchTableData> dbHistory) {
    return _fromDbConverter.convertMultiple(dbHistory).toList();
  }
}
