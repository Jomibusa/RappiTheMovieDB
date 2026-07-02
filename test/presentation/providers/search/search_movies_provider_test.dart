import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rappi_themoviedb/domain/repositories/movies_repository.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/movies_repository_provider.dart';
import 'package:rappi_themoviedb/presentation/providers/search/search_movies_provider.dart';

import '../../../helpers/movie_builders.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  late MockMoviesRepository repository;
  late ProviderContainer container;

  setUp(() {
    // Given: un repositorio simulado inyectado en el provider bajo prueba.
    repository = MockMoviesRepository();
    container = ProviderContainer(
      overrides: [
        moviesRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
  });

  test(
      'Given un buscador recién creado, '
      'When se lee su estado inicial, '
      'Then no hay resultados', () {
    // When
    final state = container.read(searchMoviesProvider);

    // Then
    expect(state, isEmpty);
  });

  test(
      'Given que el repositorio tiene resultados para una búsqueda, '
      'When se busca por ese texto, '
      'Then el estado se actualiza con esos resultados', () async {
    // Given
    final results = [buildMovie(id: 1, title: 'Interstellar')];
    when(() => repository.searchMovies('inter'))
        .thenAnswer((_) async => results);

    // When
    await container
        .read(searchMoviesProvider.notifier)
        .searchMoviesByQuery('inter');

    // Then
    expect(container.read(searchMoviesProvider), results);
    verify(() => repository.searchMovies('inter')).called(1);
  });

  test(
      'Given que el repositorio no encuentra resultados para una búsqueda, '
      'When se busca por ese texto, '
      'Then el estado queda vacío', () async {
    // Given
    when(() => repository.searchMovies('sin resultados'))
        .thenAnswer((_) async => []);

    // When
    await container
        .read(searchMoviesProvider.notifier)
        .searchMoviesByQuery('sin resultados');

    // Then
    expect(container.read(searchMoviesProvider), isEmpty);
  });

  test(
      'Given resultados previos de una búsqueda anterior, '
      'When se hace una nueva búsqueda con otro texto, '
      'Then el estado se reemplaza por los resultados de la nueva búsqueda',
      () async {
    // Given
    final firstResults = [buildMovie(id: 1, title: 'Interstellar')];
    final secondResults = [buildMovie(id: 2, title: 'Inception')];
    when(() => repository.searchMovies('inter'))
        .thenAnswer((_) async => firstResults);
    when(() => repository.searchMovies('incep'))
        .thenAnswer((_) async => secondResults);
    final notifier = container.read(searchMoviesProvider.notifier);
    await notifier.searchMoviesByQuery('inter');

    // When
    await notifier.searchMoviesByQuery('incep');

    // Then
    expect(container.read(searchMoviesProvider), secondResults);
  });
}
