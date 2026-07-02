import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/movies_repository_provider.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/paginated_movies_notifier.dart';

final topRatedMoviesProvider =
    NotifierProvider<TopRatedMoviesNotifier, PaginatedMoviesState>(
        TopRatedMoviesNotifier.new);

class TopRatedMoviesNotifier extends PaginatedMoviesNotifier {
  @override
  Future<List<Movie>> fetchPage(int page) {
    final repository = ref.read(moviesRepositoryProvider);
    return repository.getTopRated(page: page);
  }
}
