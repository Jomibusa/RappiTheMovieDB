import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

@freezed
abstract class Movie with _$Movie {
  const factory Movie({
    required int id,
    required String title,
    required String originalTitle,
    required String overview,
    required String posterPath,
    required String backdropPath,
    required DateTime? releaseDate,
    required double popularity,
    required double voteAverage,
    required int voteCount,
    required List<int> genreIds,
    required bool adult,
    required String originalLanguage,
  }) = _Movie;
}
