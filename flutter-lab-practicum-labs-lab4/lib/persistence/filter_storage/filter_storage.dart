import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IFilterStorage {
  Future<void> saveFilter(Map<String, dynamic> filterData);
  Future<Map<String, dynamic>?> getFilter();
}

class FilterStorage implements IFilterStorage {
  final SharedPreferences _prefs;
  static const _filterKey = 'filter_key';

  const FilterStorage(this._prefs);

  @override
  Future<void> saveFilter(Map<String, dynamic> filterData) async {
    final jsonString = jsonEncode(filterData);
    await _prefs.setString(_filterKey, jsonString);
  }

  @override
  Future<Map<String, dynamic>?> getFilter() async {
    final jsonString = _prefs.getString(_filterKey);
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
