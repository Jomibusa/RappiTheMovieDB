import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/errors/errors.dart';
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
        error: (error, stackTrace) {
          final message = switch (error) {
            NetworkFailure() => 'Sin conexión a internet',
            TimeoutFailure() => 'Conexión lenta, reintenta',
            UnauthorizedFailure() => 'Acceso no autorizado',
            ServerFailure() => 'Servicio no disponible',
            NotFoundFailure() => 'Película no encontrada',
            ParseFailure() => 'Error al leer los datos',
            _ => 'Error inesperado',
          };
          return Center(child: Text(message));
        },
      ),
    );
  }
}
