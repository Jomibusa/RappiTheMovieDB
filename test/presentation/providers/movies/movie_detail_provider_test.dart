import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rappi_themoviedb/domain/errors/errors.dart';
import 'package:rappi_themoviedb/domain/repositories/movies_repository.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/movie_detail_provider.dart';
import 'package:rappi_themoviedb/presentation/providers/movies/movies_repository_provider.dart';

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
      'Given una película con id 42 en el repositorio, '
      'When el usuario navega del listado al detalle de esa película, '
      'Then se obtiene el detalle correspondiente a ese id', () async {
    // Given
    final detail = buildMovieDetail(id: 42, title: 'Interstellar');
    when(() => repository.getMovieByID('42')).thenAnswer((_) async => detail);

    // When
    final result = await container.read(movieDetailProvider('42').future);

    // Then
    expect(result, detail);
    verify(() => repository.getMovieByID('42')).called(1);
  });

  test(
      'Given detalles distintos disponibles para los ids 1 y 2, '
      'When se navega al detalle de cada uno, '
      'Then cada navegación obtiene el detalle correspondiente a su propio id',
      () async {
    // Given
    when(() => repository.getMovieByID('1'))
        .thenAnswer((_) async => buildMovieDetail(id: 1));
    when(() => repository.getMovieByID('2'))
        .thenAnswer((_) async => buildMovieDetail(id: 2));

    // When
    final detail1 = await container.read(movieDetailProvider('1').future);
    final detail2 = await container.read(movieDetailProvider('2').future);

    // Then
    expect(detail1.id, 1);
    expect(detail2.id, 2);
  });

  test(
      'Given que el repositorio falla al pedir el detalle de una película, '
      'When se navega al detalle de esa película, '
      'Then el estado del provider expone el error', () async {
    // Given
    when(() => repository.getMovieByID('99'))
        .thenThrow(const NotFoundFailure('99'));
    AsyncValue<void>? lastValue;
    container.listen(movieDetailProvider('99'), (_, next) {
      lastValue = next;
    }, fireImmediately: true);

    // When
    await Future.delayed(const Duration(milliseconds: 50));

    // Then
    expect(lastValue?.hasError, isTrue);
    expect(lastValue?.error, isA<NotFoundFailure>());
  });
}
