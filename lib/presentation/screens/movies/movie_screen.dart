import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/errors/errors.dart';
import 'package:rappi_themoviedb/presentation/providers/providers.dart';
import 'package:rappi_themoviedb/presentation/widgets/widgets.dart';
import 'package:rappi_themoviedb/i18n/strings/gen/strings.g.dart';

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
            NetworkFailure() => t.errors.network,
            TimeoutFailure() => t.errors.timeout,
            UnauthorizedFailure() => t.errors.unauthorized,
            ServerFailure() => t.errors.server,
            NotFoundFailure() => t.errors.movieNotFound,
            ParseFailure() => t.errors.parse,
            _ => t.errors.unexpected,
          };
          return Center(child: Text(message));
        },
      ),
    );
  }
}
