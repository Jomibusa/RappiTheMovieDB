import 'package:rappi_themoviedb/config/network/moviedb_client.dart';
import 'package:rappi_themoviedb/domain/datasources/movies_datasource.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/data/mappers/mappers.dart';
import 'package:rappi_themoviedb/data/models/models.dart';

import 'package:dio/dio.dart';

class MovieDbDatasource extends MoviesDatasource {
  final Dio dio;

  MovieDbDatasource({Dio? dio}) : dio = dio ?? buildMovieDbDio();

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final moviedbReponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = moviedbReponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBTOEntity(moviedb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<MovieDetail> getMovieByID(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with ID: $id not found');
    }
    final movieDetails = MovieDetails.fromJson(response.data);

    return MovieMapper.movieDetailsToEntity(movieDetails);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});
    return _jsonToMovies(response.data);
  }

}
