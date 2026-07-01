import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/entities/entities.dart';
import 'package:rappi_themoviedb/presentation/providers/providers.dart';
import 'package:rappi_themoviedb/presentation/widgets/widgets.dart';

class MovieDetailBody extends ConsumerWidget {
  final MovieDetail movie;
  final String movieId;

  const MovieDetailBody({
    super.key,
    required this.movie,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsAsync = ref.watch(actorsByMovieProvider(movieId));

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  MovieTagline(tagline: movie.tagline),
                  const SizedBox(height: 8),
                  MovieInfoRow(
                    releaseDate: movie.releaseDate,
                    originalLanguage: movie.originalLanguage,
                    voteAverage: movie.voteAverage,
                    runtime: movie.runtime,
                  ),
                  const SizedBox(height: 12),
                  MovieGenreLabels(genres: movie.genres),
                  const SizedBox(height: 16),
                  Text(movie.overview),
                  const SizedBox(height: 16),
                  Text(
                    'Actores',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180,
                    child: actorsAsync.when(
                      data: (actors) =>
                          ActorHorizontalListview(actors: actors),
                      loading: () => const FullScreenLoader(),
                      error: (error, stackTrace) =>
                          Text('No se pudo cargar el elenco: $error'),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
