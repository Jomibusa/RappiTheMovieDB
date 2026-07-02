import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/utils/date_converter.dart';

part 'movie_moviedb.freezed.dart';
part 'movie_moviedb.g.dart';

@freezed
abstract class MovieMovieDB with _$MovieMovieDB {
  const factory MovieMovieDB({
    @Default(false) bool adult,
    @JsonKey(name: 'backdrop_path') @Default('') String backdropPath,
    @JsonKey(name: 'genre_ids') @Default(<int>[]) List<int> genreIds,
    required int id,
    @JsonKey(name: 'original_language')
    @Default('')
    String originalLanguage,
    @JsonKey(name: 'original_title') @Default('') String originalTitle,
    @Default('') String overview,
    @Default(0) double popularity,
    @JsonKey(name: 'poster_path') @Default('') String posterPath,
    @JsonKey(name: 'release_date') @NullableDateConverter() DateTime? releaseDate,
    @Default('No Title') String title,
    @Default(false) bool video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
  }) = _MovieMovieDB;

  factory MovieMovieDB.fromJson(Map<String, dynamic> json) =>
      _$MovieMovieDBFromJson(json);
}
