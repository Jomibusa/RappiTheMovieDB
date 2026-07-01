import 'package:flutter/material.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';

class MovieHorizontalListview extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final VoidCallback onLoadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.title,
    required this.movies,
    required this.onLoadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        SizedBox(
          height: 220,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels + 200 >=
                  notification.metrics.maxScrollExtent) {
                onLoadNextPage();
              }
              return false;
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, '/movie/${movie.id}'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        movie.posterPath,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
