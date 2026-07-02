import 'package:flutter/material.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/presentation/widgets/widgets.dart';

class MovieSearchItem extends StatelessWidget {
  final Movie movie;

  const MovieSearchItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, '/movie/${movie.id}'),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AppNetworkImage(
          url: movie.posterPath,
          width: 56,
        ),
      ),
      title: Text(
        movie.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        movie.overview,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
