import 'package:rappi_themoviedb/data/utils/repository_runner.dart';
import 'package:rappi_themoviedb/domain/datasources/actors_datasource.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieID) =>
      repositoryRun(() => datasource.getActorsByMovie(movieID));
}
