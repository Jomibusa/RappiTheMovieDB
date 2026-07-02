import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rappi_themoviedb/domain/errors/errors.dart';
import 'package:rappi_themoviedb/domain/repositories/movies_repository.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/movies_repository_provider.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/popular_movies_provider.dart';

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

  test('Given un listado recién creado, When se lee su estado inicial, '
      'Then está vacío y sin error', () {
    // When
    final state = container.read(popularMoviesProvider);

    // Then
    expect(state.movies, isEmpty);
    expect(state.error, isNull);
    expect(state.isLoadingNextPage, isFalse);
  });

  test(
      'Given que el repositorio tiene una primera página de películas, '
      'When se carga la siguiente página, '
      'Then el estado contiene esas películas sin error', () async {
    // Given
    final page1 = [buildMovie(id: 1), buildMovie(id: 2)];
    when(() => repository.getPopular(page: 1)).thenAnswer((_) async => page1);

    // When
    await container.read(popularMoviesProvider.notifier).loadNextPage();

    // Then
    final state = container.read(popularMoviesProvider);
    expect(state.movies, page1);
    expect(state.error, isNull);
    verify(() => repository.getPopular(page: 1)).called(1);
  });

  test(
      'Given que ya se cargó la primera página, '
      'When el usuario hace scroll hasta el final y se pide la siguiente página, '
      'Then las películas nuevas se acumulan sobre las anteriores', () async {
    // Given
    final page1 = [buildMovie(id: 1), buildMovie(id: 2)];
    final page2 = [buildMovie(id: 3), buildMovie(id: 4)];
    when(() => repository.getPopular(page: 1)).thenAnswer((_) async => page1);
    when(() => repository.getPopular(page: 2)).thenAnswer((_) async => page2);
    final notifier = container.read(popularMoviesProvider.notifier);
    await notifier.loadNextPage();

    // When
    await notifier.loadNextPage();

    // Then
    expect(container.read(popularMoviesProvider).movies, [
      ...page1,
      ...page2,
    ]);
    verify(() => repository.getPopular(page: 1)).called(1);
    verify(() => repository.getPopular(page: 2)).called(1);
  });

  test(
      'Given que una carga de página está en curso, '
      'When se dispara otro scroll antes de que termine, '
      'Then la segunda solicitud se ignora y solo se pide una página', () async {
    // Given
    final page1 = [buildMovie(id: 1)];
    when(() => repository.getPopular(page: 1)).thenAnswer((_) async {
      await Future.delayed(const Duration(milliseconds: 50));
      return page1;
    });
    final notifier = container.read(popularMoviesProvider.notifier);

    // When
    final firstCall = notifier.loadNextPage();
    final secondCall = notifier.loadNextPage();
    await Future.wait([firstCall, secondCall]);

    // Then
    expect(container.read(popularMoviesProvider).movies, page1);
    verify(() => repository.getPopular(page: 1)).called(1);
  });

  test(
      'Given que la carga de una página falla, '
      'When se pide la siguiente página, '
      'Then el estado expone el error sin perder las películas ya cargadas',
      () async {
    // Given
    final page1 = [buildMovie(id: 1)];
    when(() => repository.getPopular(page: 1)).thenAnswer((_) async => page1);
    final notifier = container.read(popularMoviesProvider.notifier);
    await notifier.loadNextPage();
    when(() => repository.getPopular(page: 2))
        .thenThrow(const NetworkFailure());

    // When
    await notifier.loadNextPage();

    // Then
    final state = container.read(popularMoviesProvider);
    expect(state.error, isA<NetworkFailure>());
    expect(state.movies, page1);
    expect(state.isLoadingNextPage, isFalse);
  });

  test(
      'Given que la carga de una página falló, '
      'When se reintenta, '
      'Then se vuelve a pedir la misma página que falló, no la siguiente',
      () async {
    // Given
    when(() => repository.getPopular(page: 1))
        .thenThrow(const NetworkFailure());
    final notifier = container.read(popularMoviesProvider.notifier);
    await notifier.loadNextPage();

    // When
    final page1 = [buildMovie(id: 1)];
    when(() => repository.getPopular(page: 1)).thenAnswer((_) async => page1);
    await notifier.loadNextPage();

    // Then
    expect(container.read(popularMoviesProvider).movies, page1);
    expect(container.read(popularMoviesProvider).error, isNull);
    verify(() => repository.getPopular(page: 1)).called(2);
    verifyNever(() => repository.getPopular(page: 2));
  });
}
