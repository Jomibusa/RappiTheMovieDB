import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/presentation/providers/actors/actors_repository_provider.dart';

final actorsByMovieProvider =
    FutureProvider.family<List<Actor>, String>((ref, movieID) {
  final repository = ref.watch(actorsRepositoryProvider);
  return repository.getActorsByMovie(movieID);
});
