import 'package:flutter/material.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';

class MovieGenreLabels extends StatelessWidget {
  final List<Genre> genres;

  const MovieGenreLabels({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: genres
          .map((genre) => Chip(label: Text(genre.name)))
          .toList(),
    );
  }
}
