import 'package:freezed_annotation/freezed_annotation.dart';

String _formatDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

/// Converts a `yyyy-MM-dd` JSON string to/from a non-nullable [DateTime].
class DateConverter implements JsonConverter<DateTime, String> {
  const DateConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime date) => _formatDate(date);
}

/// Converts a `yyyy-MM-dd` JSON string to/from a nullable [DateTime],
/// treating `null` or empty strings as `null`.
class NullableDateConverter implements JsonConverter<DateTime?, String?> {
  const NullableDateConverter();

  @override
  DateTime? fromJson(String? json) =>
      (json == null || json.isEmpty) ? null : DateTime.parse(json);

  @override
  String? toJson(DateTime? date) => date == null ? null : _formatDate(date);
}
