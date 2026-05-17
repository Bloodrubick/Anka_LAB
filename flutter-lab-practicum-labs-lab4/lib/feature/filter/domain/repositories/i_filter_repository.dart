import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';

/// Интерфейс для репозитория для Фильтра.
abstract interface class IFilterRepository {
  /// Получение количества найденных мест.
  RequestOperation<int> getPlaces({required FilterPlacesEntity filter});
}
