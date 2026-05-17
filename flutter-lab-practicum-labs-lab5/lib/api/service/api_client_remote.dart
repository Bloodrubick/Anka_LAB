import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:surf_mad_teacher_training/api/constants/api_urls.dart';
import 'package:surf_mad_teacher_training/api/data/filter_places_request_dto.dart';
import 'package:surf_mad_teacher_training/api/data/place_dto.dart';
import 'package:surf_mad_teacher_training/api/service/api_client.dart';

part 'api_client_remote.g.dart';

/// Интерфейс API для работы с местами.
@RestApi()
abstract class ApiClientRemote implements ApiClient {
  factory ApiClientRemote(Dio dio, {String baseUrl}) = _ApiClientRemote;

  @override
  @GET(ApiUrls.places)
  Future<List<PlaceDto>> getPlaces();

  @override
  @POST(ApiUrls.filteredPlaces)
  Future<List<PlaceDto>> getFilteredPlaces({@Body() required FilterPlacesRequestDto filter});

  @GET(ApiUrls.placeDetails)
  Future<PlaceDto> getPlaceDetails(@Path() int placeId);
}
