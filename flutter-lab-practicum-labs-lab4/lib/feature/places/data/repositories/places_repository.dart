import 'package:surf_mad_teacher_training/api/service/api_client.dart';
import 'package:surf_mad_teacher_training/core/data/repositories/base_repository.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/place_response_converter.dart';
import 'package:surf_mad_teacher_training/feature/places/domain/repositories/i_places_repository.dart';
import 'package:surf_mad_teacher_training/persistence/filter_storage/filter_storage.dart';
import 'package:surf_mad_teacher_training/api/service/api_client_remote.dart';

/// {@template places_repository.class}
/// Implementation of [IPlacesRepository].
/// {@endtemplate}
final class PlacesRepository extends BaseRepository implements IPlacesRepository {
  final ApiClientRemote _apiClient;
  final IPlaceResponseConverter _placeResponseConverter;
  final IFilterStorage _filterStorage;
  final IFilterPlacesConverter _filterPlacesConverter;

  /// {@macro places_repository.class}
  const PlacesRepository({
    required ApiClientRemote apiClient,
    required IPlaceResponseConverter placeResponseConverter,
    required IFilterStorage filterStorage,
    required IFilterPlacesConverter filterPlacesConverter,
  }) : _apiClient = apiClient,
       _placeResponseConverter = placeResponseConverter,
       _filterStorage = filterStorage,
       _filterPlacesConverter = filterPlacesConverter;

  @override
  RequestOperation<List<PlaceEntity>> getPlaces({FilterPlacesEntity? filter}) => makeApiCall(() async {
    final effectiveFilter = filter ?? await getSavedFilter();
    final filterDto = _filterPlacesConverter.convertEntityToDto(effectiveFilter);

    // Save filter internally if provided directly and not loaded from storage
    if (filter != null) {
      await _filterStorage.saveFilter(_filterPlacesConverter.convertEntityToMap(filter));
    }

    final data = await _apiClient.getFilteredPlaces(filter: filterDto);

    return _placeResponseConverter.convertMultiple(data).toList();
  });

  @override
  Future<FilterPlacesEntity> getSavedFilter() async {
    final map = await _filterStorage.getFilter();
    if (map != null) {
      return _filterPlacesConverter.convertMapToEntity(map);
    }
    return FilterPlacesEntity.createDefault();
  }
}
