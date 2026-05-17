import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';

/// Интерфейс для фичи Список мест.
abstract interface class IPlacesRepository {
  /// Получение списка мест.
  RequestOperation<List<PlaceEntity>> getPlaces({FilterPlacesEntity? filter});

  /// Получение сохраненного фильтра.
  Future<FilterPlacesEntity> getSavedFilter();
}
