import 'package:rappi_themoviedb/config/network/moviedb_client.dart';
import 'package:rappi_themoviedb/domain/datasources/actors_datasource.dart';
import 'package:rappi_themoviedb/domain/entities/actor.dart';
import 'package:rappi_themoviedb/data/mappers/actor_mapper.dart';
import 'package:rappi_themoviedb/data/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final Dio dio;

  ActorMovieDbDatasource({Dio? dio}) : dio = dio ?? buildMovieDbDio();

  @override
  Future<List<Actor>> getActorsByMovie(String movieID) async {
    final response = await dio.get('/movie/$movieID/credits');
    if (response.statusCode != 200) {
      throw Exception('Movie with ID: $movieID not found');
    }
    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
