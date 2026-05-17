import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/persistence/filter_storage/filter_storage_keys.dart';
import 'package:surf_mad_teacher_training/persistence/filter_storage/i_filter_storage.dart';

/// {@template filter_storage.class}
/// Реализация хранилища фильтра на основе [SharedPreferences].
/// {@endtemplate}
class FilterStorage implements IFilterStorage {
  static final _defaultFilter = FilterPlacesEntity.createDefault();

  final SharedPreferences _prefs;

  /// {@macro filter_storage.class}
  FilterStorage(this._prefs);

  @override
  Future<FilterPlacesEntity> getFilter() async {
    final filterJson = _prefs.getString(FilterStorageKeys.filter.keyName);
    if (filterJson == null || filterJson.trim().isEmpty) return _defaultFilter;

    try {
      final decoded = jsonDecode(filterJson) as Map<String, dynamic>;
      return _fromJson(decoded);
    } on FormatException {
      // Данные повреждены — возвращаем дефолт
      return _defaultFilter;
    }
  }

  @override
  Future<void> saveFilter({required FilterPlacesEntity filter}) async {
    final encoded = jsonEncode(_toJson(filter));
    await _prefs.setString(FilterStorageKeys.filter.keyName, encoded);
  }

  @override
  Future<void> clearFilter() async {
    await _prefs.remove(FilterStorageKeys.filter.keyName);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Map<String, dynamic> _toJson(FilterPlacesEntity filter) {
    return {
      'lat': filter.lat,
      'lon': filter.lon,
      'radius': filter.radius,
      'name': filter.name,
      'type': filter.type?.map((t) => t.name).toList(),
    };
  }

  FilterPlacesEntity _fromJson(Map<String, dynamic> json) {
    final typeList = json['type'] as List<dynamic>?;
    final types = typeList
        ?.map((name) => PlaceType.values.firstWhere(
              (t) => t.name == name,
              orElse: () => PlaceType.other,
            ))
        .toSet();

    return FilterPlacesEntity(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      radius: (json['radius'] as num?)?.toDouble(),
      name: json['name'] as String?,
      type: types,
    );
  }
}
