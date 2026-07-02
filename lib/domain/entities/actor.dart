import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor.freezed.dart';

@freezed
abstract class Actor with _$Actor {
  const factory Actor({
    required int id,
    required String name,
    required String profilePath,
    required String? character,
  }) = _Actor;
}
