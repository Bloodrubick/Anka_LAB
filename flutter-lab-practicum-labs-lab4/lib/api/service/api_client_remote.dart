import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:surf_mad_teacher_training/api/constants/api_urls.dart';
import 'package:surf_mad_teacher_training/api/data/filter_places_request_dto.dart';
import 'package:surf_mad_teacher_training/api/data/place_dto.dart';

part 'api_client_remote.g.dart';

@RestApi()
abstract class ApiClientRemote {
  factory ApiClientRemote(Dio dio, {String baseUrl}) = _ApiClientRemote;

  @GET(ApiUrls.places)
  Future<List<PlaceDto>> getPlaces();

  @POST(ApiUrls.filteredPlaces)
  Future<List<PlaceDto>> getFilteredPlaces({
    @Body() required FilterPlacesRequestDto filter,
  });

  @GET(ApiUrls.placeDetails)
  Future<PlaceDto> getPlaceDetails(@Path() int placeId);

  @POST(ApiUrls.uploadFile)
  @MultiPart()
  Future<String> uploadFile(@Part() File file);
}
