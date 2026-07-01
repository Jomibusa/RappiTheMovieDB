import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/data/datasources/actor_moviedb_datasource.dart';
import 'package:rappi_themoviedb/data/repositories/actor_repository_impl.dart';
import 'package:rappi_themoviedb/domain/repositories/actors_repository.dart';

final actorsRepositoryProvider = Provider<ActorsRepository>((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
