import 'package:dio/dio.dart';
import 'package:rappi_themoviedb/config/constants/environment.dart';

Dio buildMovieDbDio() {
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'language': 'es-MX'},
      headers: {'Authorization': 'Bearer ${Environment.theMovieDBKey}'},
    ),
  );
}
