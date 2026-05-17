import 'dart:io';

/// Адреса для работы с местами.
class ApiUrls {
  static final String baseUrl = Platform.isAndroid ? 'http://10.0.2.2:8888' : 'http://localhost:8888';
  // Все места что есть базе данных.
  static const String places = '/place';
  static const String placeDetails = '/place/{placeId}';
  static const String filteredPlaces = '/filtered_places';
  static const String uploadFile = '/upload_file';

  const ApiUrls._();
}
