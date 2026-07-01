import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/movies_repository_provider.dart';

final searchMoviesProvider =
    NotifierProvider<SearchMoviesNotifier, List<Movie>>(
        SearchMoviesNotifier.new);

class SearchMoviesNotifier extends Notifier<List<Movie>> {
  @override
  List<Movie> build() => [];

  Future<void> searchMoviesByQuery(String query) async {
    final repository = ref.read(moviesRepositoryProvider);
    state = await repository.searchMovies(query);
  }
}
