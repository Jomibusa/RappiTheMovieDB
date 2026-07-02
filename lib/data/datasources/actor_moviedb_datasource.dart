import 'package:rappi_themoviedb/config/network/moviedb_client.dart';
import 'package:rappi_themoviedb/domain/datasources/actors_datasource.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/data/mappers/mappers.dart';
import 'package:rappi_themoviedb/data/models/models.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final Dio dio;
  final ActorMapper _mapper;

  ActorMovieDbDatasource({Dio? dio, ActorMapper? mapper})
      : dio = dio ?? buildMovieDbDio(),
        _mapper = mapper ?? const ActorMapper();

  @override
  Future<List<Actor>> getActorsByMovie(String movieID) async {
    final response = await dio.get('/movie/$movieID/credits');
    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => _mapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
