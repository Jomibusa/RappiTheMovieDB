import 'package:freezed_annotation/freezed_annotation.dart';

import 'genre.dart';

part 'movie_detail.freezed.dart';

@freezed
abstract class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    required int id,
    required String title,
    required String originalTitle,
    required String tagline,
    required String overview,
    required String posterPath,
    required String backdropPath,
    required DateTime? releaseDate,
    required int runtime,
    required String status,
    required List<Genre> genres,
    required double popularity,
    required double voteAverage,
    required int voteCount,
    required int budget,
    required int revenue,
    required String homepage,
    required String originalLanguage,
  }) = _MovieDetail;
}
