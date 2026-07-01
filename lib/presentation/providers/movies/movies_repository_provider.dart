import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/data/datasources/moviedb_datasource.dart';
import 'package:rappi_themoviedb/data/repositories/movie_repository_impl.dart';
import 'package:rappi_themoviedb/domain/repositories/movies_repository.dart';

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MovieRepositoryImpl(MovieDbDatasource());
});
