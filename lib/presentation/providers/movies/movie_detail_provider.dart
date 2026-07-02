import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/movies_repository_provider.dart';

final movieDetailProvider = FutureProvider.family<MovieDetail, String>((ref, id) {
  final repository = ref.watch(moviesRepositoryProvider);
  return repository.getMovieByID(id);
});
