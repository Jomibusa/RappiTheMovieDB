import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';

class PaginatedMoviesState {
  final List<Movie> movies;
  final bool isLoadingNextPage;
  final Object? error;

  const PaginatedMoviesState({
    this.movies = const [],
    this.isLoadingNextPage = false,
    this.error,
  });

  PaginatedMoviesState copyWith({
    List<Movie>? movies,
    bool? isLoadingNextPage,
    Object? error,
  }) {
    return PaginatedMoviesState(
      movies: movies ?? this.movies,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
      error: error,
    );
  }
}

abstract class PaginatedMoviesNotifier extends Notifier<PaginatedMoviesState> {
  int _currentPage = 0;

  Future<List<Movie>> fetchPage(int page);

  @override
  PaginatedMoviesState build() => const PaginatedMoviesState();

  Future<void> loadNextPage() async {
    if (state.isLoadingNextPage) return;

    state = state.copyWith(isLoadingNextPage: true, error: null);
    final nextPage = _currentPage + 1;

    try {
      final newMovies = await fetchPage(nextPage);
      _currentPage = nextPage;
      state = state.copyWith(
        movies: [...state.movies, ...newMovies],
        isLoadingNextPage: false,
      );
    } catch (error) {
      state = state.copyWith(isLoadingNextPage: false, error: error);
    }
  }
}
