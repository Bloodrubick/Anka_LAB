import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class AppDioConfigurator {
  const AppDioConfigurator();

  Dio create({
    required Iterable<Interceptor> interceptors,
    required String url,
    String? proxyUrl,
  }) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = url
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        client.findProxy = (uri) => 'PROXY $proxyUrl';
        client.badCertificateCallback = (_, __, ___) => true;
      }
      return client;
    };

    dio.interceptors.addAll(interceptors);

    return dio;
  }
}
