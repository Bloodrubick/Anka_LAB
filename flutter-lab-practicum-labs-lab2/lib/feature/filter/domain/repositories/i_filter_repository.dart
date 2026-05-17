import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';

/// Интерфейс для репозитория для Фильтра.
abstract interface class IFilterRepository {
  /// Получение количества найденных мест.
  RequestOperation<int> getFilteredPlaces({required FilterPlacesEntity filter});

  /// Получение сохранённого фильтра пользователя или дефолтного фильтра.
  Future<FilterPlacesEntity> getSavedFilter();

  /// Сохранить фильтр.
  Future<void> saveFilter({required FilterPlacesEntity filter});
}
