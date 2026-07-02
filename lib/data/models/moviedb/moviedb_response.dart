import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/utils/date_converter.dart';
import 'movie_moviedb.dart';

part 'moviedb_response.freezed.dart';
part 'moviedb_response.g.dart';

@freezed
abstract class MovieDbResponse with _$MovieDbResponse {
  const factory MovieDbResponse({
    required Dates? dates,
    required int page,
    required List<MovieMovieDB> results,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _MovieDbResponse;

  factory MovieDbResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDbResponseFromJson(json);
}

@freezed
abstract class Dates with _$Dates {
  const factory Dates({
    @DateConverter() required DateTime maximum,
    @DateConverter() required DateTime minimum,
  }) = _Dates;

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);
}
