import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_keyword_entity.dart';

/// Интерфейс для репозитория для Поиска.
abstract interface class ISearchRepository {
  /// [Stream] c историей поисковых запросов.
  ValueStream<List<SearchKeywordEntity>> get historySearchStream;

  /// Получение найденных мест по поисковому слову.
  RequestOperation<List<PlaceEntity>> getFilteredPlaces({required FilterPlacesEntity filter});

  /// Сохранить ключевое слово поиска.
  Future<void> saveKeyword({required String keyword});

  /// Удалить ключевое слово поиска.
  Future<void> removeKeyword({required SearchKeywordEntity keyword});

  /// Очистить историю поисковых запросов.
  Future<void> clearHistory();

  /// Освободить ресурсы.
  void dispose();
}
