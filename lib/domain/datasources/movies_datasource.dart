import 'package:rappi_themoviedb/domain/entities/entities.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<Movie> getMovieByID(String id);
  Future<List<Movie>> searchMovies(String query);
}
