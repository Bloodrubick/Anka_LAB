import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_mad_teacher_training/api/data/filter_places_request_dto.dart';
import 'package:surf_mad_teacher_training/persistence/filter_storage/i_filter_storage.dart';

/// {@template filter_storage.class}
/// Persistent storage for настроек фильтра.
/// {@endtemplate}
class FilterStorage implements IFilterStorage {
  static final _defaultFilter = FilterPlacesRequestDto.createDefault();

  final SharedPreferences _prefs;

  /// {@macro filter_storage.class}
  const FilterStorage(this._prefs);

  @override
  Future<void> clear() async {
    for (final key in FilterStorageKeys.values) {
      await _prefs.remove(key.keyName);
    }
  }

  @override
  Future<FilterPlacesRequestDto> getFilter() async {
    final filter = _prefs.getString(FilterStorageKeys.filter.keyName);
    if (filter == null || filter.trim().isEmpty) return _defaultFilter;

    final decoded = jsonDecode(filter) as Map<String, dynamic>;
    if (decoded.isEmpty) return _defaultFilter;

    return FilterPlacesRequestDto.fromJson(decoded);
  }

  @override
  Future<void> saveFilter({required FilterPlacesRequestDto filterDto}) async {
    await _prefs.setString(FilterStorageKeys.filter.keyName, jsonEncode(filterDto));
  }
}

/// Keys for [FilterStorageKeys].
enum FilterStorageKeys {
  /// Настройки фильтра.
  filter('filter_settings');

  /// Key Name.
  final String keyName;

  const FilterStorageKeys(this.keyName);
}
