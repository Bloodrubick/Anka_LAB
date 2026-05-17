import 'package:surf_mad_teacher_training/api/data/place_dto.dart';

/// Интерфейс для api.
abstract class ApiClient {
  // TODO(sugina): используется для получения мест из assets. Удалить можно только после полного подключения бека.
  /// Получить список мест.
  Future<List<PlaceDto>> getPlaces();
}
