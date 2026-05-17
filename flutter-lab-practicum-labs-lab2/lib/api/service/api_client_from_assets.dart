import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:surf_mad_teacher_training/api/constants/assets_urls.dart';
import 'package:surf_mad_teacher_training/api/data/filter_places_request_dto.dart';
import 'package:surf_mad_teacher_training/api/data/place_dto.dart';
import 'package:surf_mad_teacher_training/api/service/api_client.dart';

/// {@template api_client_from_assets.class}
/// Реализация интерфейса для api из assets.
/// {@endtemplate}
class ApiClientFromAssets implements ApiClient {
  /// {@macro api_client_from_assets.class}
  const ApiClientFromAssets();

  @override
  Future<List<PlaceDto>> getFilteredPlaces({required FilterPlacesRequestDto filter}) async {
    final places = await getPlaces();

    return places.where((element) => filter.typeFilter?.contains(element.placeType) ?? false).toList();
  }

  @override
  Future<List<PlaceDto>> getPlaces() async {
    final places = <PlaceDto>[];

    await _addDelay(300);
    final jsonString = await _loadAsset(AssetsUrls.places);
    final data = jsonDecode(jsonString) as Map<String, dynamic>;

    final placesData = data['places'] as List;

    if (placesData.isNotEmpty) {
      for (final place in placesData) {
        places.add(PlaceDto.fromJson(place as Map<String, dynamic>));
      }
    }

    return places;
  }

  /// Имитируем задержку чтобы увидеть лоадер.
  Future<void> _addDelay(int ms) => Future<void>.delayed(Duration(milliseconds: ms));

  /// Загружаем строку из asset приложения.
  Future<String> _loadAsset(String path) => rootBundle.loadString(path);
}
