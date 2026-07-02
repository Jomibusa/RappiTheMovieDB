import 'package:rappi_themoviedb/domain/entities/entities.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<MovieDetail> getMovieByID(String id);
  Future<List<Movie>> searchMovies(String query);
}
