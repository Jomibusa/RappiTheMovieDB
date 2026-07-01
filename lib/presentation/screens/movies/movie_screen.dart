import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/presentation/providers/providers.dart';
import 'package:rappi_themoviedb/presentation/widgets/widgets.dart';

class MovieScreen extends ConsumerWidget {
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      body: movieAsync.when(
        data: (movie) => MovieDetailBody(movie: movie, movieId: movieId),
        loading: () => const FullScreenLoader(),
        error: (error, stackTrace) =>
            Center(child: Text('No se pudo cargar la película: $error')),
      ),
    );
  }
}
