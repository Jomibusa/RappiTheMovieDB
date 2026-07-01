import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/movies_repository_provider.dart';

final popularMoviesProvider =
    NotifierProvider<PopularMoviesNotifier, List<Movie>>(
        PopularMoviesNotifier.new);

class PopularMoviesNotifier extends Notifier<List<Movie>> {
  int _currentPage = 0;
  bool _isLoading = false;

  @override
  List<Movie> build() => [];

  Future<void> loadNextPage() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      _currentPage++;
      final repository = ref.read(moviesRepositoryProvider);
      final movies = await repository.getPopular(page: _currentPage);
      state = [...state, ...movies];
    } finally {
      _isLoading = false;
    }
  }
}
