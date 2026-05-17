import 'package:surf_mad_teacher_training/api/service/api_client.dart';
import 'package:surf_mad_teacher_training/core/data/repositories/base_repository.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/place_response_converter.dart';
import 'package:surf_mad_teacher_training/feature/places/domain/repositories/i_places_repository.dart';

/// {@template places_repository.class}
/// Implementation of [IPlacesRepository].
/// {@endtemplate}
final class PlacesRepository extends BaseRepository implements IPlacesRepository {
  final ApiClient _apiClient;
  final IFilterPlacesConverter _filterPlacesConverter;
  final IPlaceResponseConverter _placeResponseConverter;

  /// {@macro places_repository.class}
  const PlacesRepository({
    required ApiClient apiClient,
    required IFilterPlacesConverter filterPlacesConverter,
    required IPlaceResponseConverter placeResponseConverter,
  }) : _apiClient = apiClient,
       _filterPlacesConverter = filterPlacesConverter,
       _placeResponseConverter = placeResponseConverter;

  @override
  RequestOperation<List<PlaceEntity>> getPlaces({required FilterPlacesEntity filter}) => makeApiCall(() async {
    final data = await _apiClient.getFilteredPlaces(filter: _filterPlacesConverter.convertReverse(filter));

    return _placeResponseConverter.convertMultiple(data).toList();
  });

  @override
  Future<FilterPlacesEntity> getSavedFilter() async {
    return FilterPlacesEntity();
  }
}
