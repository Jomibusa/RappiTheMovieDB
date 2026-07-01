import 'package:rappi_themoviedb/domain/entities/entities.dart';

Movie buildMovie({required int id, String? title}) {
  return Movie(
    id: id,
    title: title ?? 'Movie $id',
    originalTitle: title ?? 'Movie $id',
    overview: 'Overview $id',
    posterPath: '/poster$id.jpg',
    backdropPath: '/backdrop$id.jpg',
    releaseDate: DateTime(2020, 1, 1),
    popularity: 1.0,
    voteAverage: 5.0,
    voteCount: 10,
    genreIds: const [1, 2],
    adult: false,
    originalLanguage: 'en',
  );
}

MovieDetail buildMovieDetail({required int id, String? title}) {
  return MovieDetail(
    id: id,
    title: title ?? 'Movie $id',
    originalTitle: title ?? 'Movie $id',
    tagline: 'Tagline $id',
    overview: 'Overview $id',
    posterPath: '/poster$id.jpg',
    backdropPath: '/backdrop$id.jpg',
    releaseDate: DateTime(2020, 1, 1),
    runtime: 120,
    status: 'Released',
    genres: const [],
    popularity: 1.0,
    voteAverage: 5.0,
    voteCount: 10,
    budget: 1000,
    revenue: 2000,
    homepage: 'https://example.com',
    originalLanguage: 'en',
  );
}
