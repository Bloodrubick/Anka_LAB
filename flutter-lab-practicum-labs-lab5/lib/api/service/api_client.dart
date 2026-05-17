import 'package:surf_mad_teacher_training/api/data/filter_places_request_dto.dart';
import 'package:surf_mad_teacher_training/api/data/place_dto.dart';

/// Интерфейс для api.
abstract class ApiClient {
  /// Получить отфильтрованный список мест.
  Future<List<PlaceDto>> getFilteredPlaces({required FilterPlacesRequestDto filter});

  /// Получить список мест.
  Future<List<PlaceDto>> getPlaces();
}
