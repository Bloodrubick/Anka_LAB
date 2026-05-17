import 'package:surf_mad_teacher_training/api/data/filter_places_request_dto.dart';

/// Persistent storage for текущих настроек фильтра.
abstract class IFilterStorage {
  /// Очистить все данные хранилища.
  Future<void> clear();

  /// Получить фильтр.
  Future<FilterPlacesRequestDto> getFilter();

  /// Сохранить фильтр.
  Future<void> saveFilter({required FilterPlacesRequestDto filterDto});
}
