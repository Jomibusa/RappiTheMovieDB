import 'package:dio/dio.dart';
import 'package:rappi_themoviedb/config/constants/environment.dart';

Dio buildMovieDbDio() {
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDBKey,
        'language': 'es-MX',
      },
    ),
  );
}
