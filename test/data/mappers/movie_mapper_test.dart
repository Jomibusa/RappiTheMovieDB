import 'package:flutter_test/flutter_test.dart';
import 'package:rappi_themoviedb/data/mappers/movie_mapper.dart';
import 'package:rappi_themoviedb/data/models/moviedb/movie_details.dart';
import 'package:rappi_themoviedb/data/models/moviedb/movie_moviedb.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';

void main() {
  const mapper = MovieMapper();

  group('MovieMapper.movieDBTOEntity', () {
    test(
        'Given un MovieMovieDB con paths y datos completos, '
        'When se mapea a la entidad de dominio, '
        'Then arma las URLs completas de imagen y copia los campos', () {
      // Given
      final dto = MovieMovieDB(
        adult: false,
        backdropPath: '/backdrop.jpg',
        genreIds: const [28, 12],
        id: 10,
        originalLanguage: 'en',
        originalTitle: 'Original Title',
        overview: 'An overview',
        popularity: 12.3,
        posterPath: '/poster.jpg',
        releaseDate: DateTime(2020, 5, 1),
        title: 'A Title',
        voteAverage: 7.5,
        voteCount: 100,
      );

      // When
      final movie = mapper.movieDBTOEntity(dto);

      // Then
      expect(movie.id, 10);
      expect(movie.title, 'A Title');
      expect(movie.genreIds, [28, 12]);
      expect(movie.voteAverage, 7.5);
      expect(movie.releaseDate, DateTime(2020, 5, 1));
      expect(
        movie.backdropPath,
        'https://image.tmdb.org/t/p/w500/backdrop.jpg',
      );
      expect(
        movie.posterPath,
        'https://image.tmdb.org/t/p/w500/poster.jpg',
      );
    });

    test(
        'Given un MovieMovieDB sin poster ni backdrop, '
        'When se mapea a la entidad de dominio, '
        'Then usa las imágenes de reemplazo por defecto', () {
      // Given
      final dto = MovieMovieDB(
        id: 11,
        backdropPath: '',
        posterPath: '',
      );

      // When
      final movie = mapper.movieDBTOEntity(dto);

      // Then
      expect(movie.backdropPath, isNot(contains('image.tmdb.org')));
      expect(movie.posterPath, isNot(contains('image.tmdb.org')));
    });

    test(
        'Given un MovieMovieDB sin voteAverage ni releaseDate, '
        'When se mapea a la entidad de dominio, '
        'Then usa 0.0 como voto y la fecha no queda nula', () {
      // Given
      final dto = MovieMovieDB(id: 12, voteAverage: null, releaseDate: null);

      // When
      final movie = mapper.movieDBTOEntity(dto);

      // Then
      expect(movie.voteAverage, 0.0);
      expect(movie.releaseDate, isNotNull);
    });
  });

  group('MovieMapper.movieDetailsToEntity', () {
    test(
        'Given un MovieDetails con géneros y paths completos, '
        'When se mapea a la entidad de dominio, '
        'Then copia los datos y mapea la lista de géneros', () {
      // Given
      final dto = MovieDetails(
        adult: false,
        backdropPath: '/backdrop.jpg',
        budget: 1000,
        genres: const [GenreDto(id: 1, name: 'Action')],
        homepage: 'https://example.com',
        id: 20,
        imdbId: 'tt123',
        originalLanguage: 'en',
        originalTitle: 'Original',
        overview: 'Overview',
        popularity: 5.0,
        posterPath: '/poster.jpg',
        productionCompanies: const [],
        productionCountries: const [],
        releaseDate: DateTime(2021, 1, 1),
        revenue: 2000,
        runtime: 130,
        spokenLanguages: const [],
        status: 'Released',
        tagline: 'A tagline',
        title: 'A Title',
        video: false,
        voteAverage: 8.2,
        voteCount: 500,
      );

      // When
      final detail = mapper.movieDetailsToEntity(dto);

      // Then
      expect(detail.id, 20);
      expect(detail.genres, [const Genre(id: 1, name: 'Action')]);
      expect(
        detail.posterPath,
        'https://image.tmdb.org/t/p/w500/poster.jpg',
      );
      expect(detail.runtime, 130);
      expect(detail.tagline, 'A tagline');
    });

    test(
        'Given un MovieDetails sin poster ni backdrop, '
        'When se mapea a la entidad de dominio, '
        'Then usa las imágenes de reemplazo por defecto', () {
      // Given
      final dto = MovieDetails(
        adult: false,
        backdropPath: '',
        budget: 0,
        genres: const [],
        homepage: '',
        id: 21,
        imdbId: 'tt000',
        originalLanguage: 'en',
        originalTitle: 'Original',
        overview: '',
        popularity: 0,
        posterPath: '',
        productionCompanies: const [],
        productionCountries: const [],
        releaseDate: DateTime(2021, 1, 1),
        revenue: 0,
        runtime: 0,
        spokenLanguages: const [],
        status: 'Released',
        tagline: '',
        title: 'A Title',
        video: false,
        voteAverage: 0,
        voteCount: 0,
      );

      // When
      final detail = mapper.movieDetailsToEntity(dto);

      // Then
      expect(detail.posterPath, isNot(contains('image.tmdb.org')));
      expect(detail.backdropPath, isNot(contains('image.tmdb.org')));
    });
  });
}
