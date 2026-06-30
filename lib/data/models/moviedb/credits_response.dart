import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_response.freezed.dart';
part 'credits_response.g.dart';

@freezed
abstract class CreditsResponse with _$CreditsResponse {
  const factory CreditsResponse({
    required int id,
    required List<Cast> cast,
    required List<Cast> crew,
  }) = _CreditsResponse;

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditsResponseFromJson(json);
}

@freezed
abstract class Cast with _$Cast {
  const factory Cast({
    required bool adult,
    required int gender,
    required int id,
    @JsonKey(name: 'known_for_department') required String knownForDepartment,
    required String name,
    @JsonKey(name: 'original_name') required String originalName,
    required double popularity,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'cast_id') int? castId,
    String? character,
    @JsonKey(name: 'credit_id') required String creditId,
    int? order,
    String? department,
    String? job,
  }) = _Cast;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}
