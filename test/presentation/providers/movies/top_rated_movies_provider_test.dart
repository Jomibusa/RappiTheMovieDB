import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rappi_themoviedb/domain/repositories/movies_repository.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/movies_repository_provider.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/top_rated_movies_provider.dart';

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
      'Then está vacío', () {
    // When
    final state = container.read(topRatedMoviesProvider);

    // Then
    expect(state, isEmpty);
  });

  test(
      'Given que el repositorio tiene una primera página de películas, '
      'When se carga la siguiente página, '
      'Then el estado contiene esas películas', () async {
    // Given
    final page1 = [buildMovie(id: 1), buildMovie(id: 2)];
    when(() => repository.getTopRated(page: 1))
        .thenAnswer((_) async => page1);

    // When
    await container.read(topRatedMoviesProvider.notifier).loadNextPage();

    // Then
    expect(container.read(topRatedMoviesProvider), page1);
    verify(() => repository.getTopRated(page: 1)).called(1);
  });

  test(
      'Given que ya se cargó la primera página, '
      'When el usuario hace scroll hasta el final y se pide la siguiente página, '
      'Then las películas nuevas se acumulan sobre las anteriores', () async {
    // Given
    final page1 = [buildMovie(id: 1), buildMovie(id: 2)];
    final page2 = [buildMovie(id: 3), buildMovie(id: 4)];
    when(() => repository.getTopRated(page: 1))
        .thenAnswer((_) async => page1);
    when(() => repository.getTopRated(page: 2))
        .thenAnswer((_) async => page2);
    final notifier = container.read(topRatedMoviesProvider.notifier);
    await notifier.loadNextPage();

    // When
    await notifier.loadNextPage();

    // Then
    expect(container.read(topRatedMoviesProvider), [...page1, ...page2]);
    verify(() => repository.getTopRated(page: 1)).called(1);
    verify(() => repository.getTopRated(page: 2)).called(1);
  });

  test(
      'Given que una carga de página está en curso, '
      'When se dispara otro scroll antes de que termine, '
      'Then la segunda solicitud se ignora y solo se pide una página', () async {
    // Given
    final page1 = [buildMovie(id: 1)];
    when(() => repository.getTopRated(page: 1)).thenAnswer((_) async {
      await Future.delayed(const Duration(milliseconds: 50));
      return page1;
    });
    final notifier = container.read(topRatedMoviesProvider.notifier);

    // When
    final firstCall = notifier.loadNextPage();
    final secondCall = notifier.loadNextPage();
    await Future.wait([firstCall, secondCall]);

    // Then
    expect(container.read(topRatedMoviesProvider), page1);
    verify(() => repository.getTopRated(page: 1)).called(1);
  });

  test(
      'Given que la carga de una página falla, '
      'When se vuelve a pedir la siguiente página, '
      'Then el pedido no queda bloqueado por el fallo anterior', () async {
    // Given
    when(() => repository.getTopRated(page: 1))
        .thenThrow(Exception('network error'));
    final notifier = container.read(topRatedMoviesProvider.notifier);
    await expectLater(notifier.loadNextPage(), throwsException);

    // When
    final page2 = [buildMovie(id: 2)];
    when(() => repository.getTopRated(page: 2))
        .thenAnswer((_) async => page2);
    await notifier.loadNextPage();

    // Then
    expect(container.read(topRatedMoviesProvider), page2);
    verify(() => repository.getTopRated(page: 1)).called(1);
    verify(() => repository.getTopRated(page: 2)).called(1);
  });
}
