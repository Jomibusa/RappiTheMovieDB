import 'package:flutter/material.dart';

class MovieInfoRow extends StatelessWidget {
  final DateTime? releaseDate;
  final String originalLanguage;
  final double voteAverage;
  final int runtime;

  const MovieInfoRow({
    super.key,
    required this.releaseDate,
    required this.originalLanguage,
    required this.voteAverage,
    required this.runtime,
  });

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';

  String _formatRuntime(int minutes) => '${minutes ~/ 60}h ${minutes % 60}m';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text(voteAverage.toStringAsFixed(1)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 4),
            Text(releaseDate != null ? _formatDate(releaseDate!) : '-'),
          ],
        ),
        if (runtime > 0)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.schedule, size: 16),
              const SizedBox(width: 4),
              Text(_formatRuntime(runtime)),
            ],
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: 16),
            const SizedBox(width: 4),
            Text(originalLanguage.toUpperCase()),
          ],
        ),
      ],
    );
  }
}
