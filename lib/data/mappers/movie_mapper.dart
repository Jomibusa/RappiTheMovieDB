import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/data/models/models.dart';
import 'package:rappi_themoviedb/data/utils/image_url_resolver.dart';

class MovieMapper {
  final ImageUrlResolver _urls;

  const MovieMapper({ImageUrlResolver urls = const ImageUrlResolver()})
      : _urls = urls;

  Movie movieDBTOEntity(MovieMovieDB moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: _urls.backdrop(moviedb.backdropPath),
        genreIds: moviedb.genreIds,
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: _urls.poster(moviedb.posterPath),
        releaseDate:
            moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
        title: moviedb.title,
        voteAverage: moviedb.voteAverage ?? 0.0,
        voteCount: moviedb.voteCount,
      );

  MovieDetail movieDetailsToEntity(MovieDetails moviedb) => MovieDetail(
        id: moviedb.id,
        title: moviedb.title,
        originalTitle: moviedb.originalTitle,
        tagline: moviedb.tagline,
        overview: moviedb.overview,
        posterPath: _urls.poster(moviedb.posterPath),
        backdropPath: _urls.backdrop(moviedb.backdropPath),
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
