import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/data/models/moviedb/movie_details.dart';
import 'package:rappi_themoviedb/data/models/moviedb/movie_moviedb.dart';

class MovieMapper {

  static Movie movieDBTOEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath:
        (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
    genreIds: moviedb.genreIds,
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath:
        (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'https://movieeo.com/no-poster.png',
    releaseDate:
        moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
    title: moviedb.title,
    voteAverage: moviedb.voteAverage ?? 0.0,
    voteCount: moviedb.voteCount,
  );

  static MovieDetail movieDetailsToEntity(MovieDetails moviedb) =>
      MovieDetail(
        id: moviedb.id,
        title: moviedb.title,
        originalTitle: moviedb.originalTitle,
        tagline: moviedb.tagline,
        overview: moviedb.overview,
        posterPath:
            (moviedb.posterPath != '')
                ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
                : 'https://movieeo.com/no-poster.png',
        backdropPath:
            (moviedb.backdropPath != '')
                ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
                : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        releaseDate: moviedb.releaseDate,
        runtime: moviedb.runtime,
        status: moviedb.status,
        genres: moviedb.genres
            .map((genre) => Genre(id: genre.id, name: genre.name))
            .toList(),
        popularity: moviedb.popularity,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
        budget: moviedb.budget,
        revenue: moviedb.revenue,
        homepage: moviedb.homepage,
        originalLanguage: moviedb.originalLanguage,
      );
}
