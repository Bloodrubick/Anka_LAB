import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';

/// {@template i_filter_storage.class}
/// Интерфейс хранилища для настроек фильтра.
/// {@endtemplate}
abstract interface class IFilterStorage {
  /// Получение сохранённого фильтра.
  /// Возвращает дефолтный фильтр, если ничего не сохранено.
  Future<FilterPlacesEntity> getFilter();

  /// Сохранение фильтра.
  Future<void> saveFilter({required FilterPlacesEntity filter});

  /// Очистка сохранённого фильтра.
  Future<void> clearFilter();
}
