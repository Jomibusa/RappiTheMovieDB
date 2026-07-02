import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/domain/errors/errors.dart';
import 'package:rappi_themoviedb/presentation/providers/providers.dart';
import 'package:rappi_themoviedb/presentation/widgets/widgets.dart';

class MovieSection extends ConsumerWidget {
  final String title;
  final NotifierProvider<PaginatedMoviesNotifier, PaginatedMoviesState>
      provider;

  const MovieSection({super.key, required this.title, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    ref.listen(provider, (previous, next) {
      final failedWithMoviesAlreadyLoaded =
          next.error != null && next.movies.isNotEmpty;
      if (failedWithMoviesAlreadyLoaded) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
          SnackBar(
            content: Text('No se pudo cargar más "$title"'),
            action: SnackBarAction(
              label: 'Reintentar',
              onPressed: () => ref.read(provider.notifier).loadNextPage(),
            ),
          ),
        );
      }
    });

    if (state.movies.isEmpty && state.error != null) {
      final message = switch (state.error) {
        NetworkFailure() => 'Sin conexión a internet',
        TimeoutFailure() => 'Conexión lenta, reintenta',
        UnauthorizedFailure() => 'Acceso no autorizado',
        ServerFailure() => 'Servicio no disponible',
        NotFoundFailure() => 'Contenido no encontrado',
        ParseFailure() => 'Error al leer los datos',
        _ => 'Error inesperado',
      };
      return _SectionPlaceholder(
        title: title,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.read(provider.notifier).loadNextPage(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.movies.isEmpty) {
      return _SectionPlaceholder(title: title, child: const MovieSkeletonListview());
    }

    return MovieHorizontalListview(
      title: title,
      movies: state.movies,
      onLoadNextPage: () => ref.read(provider.notifier).loadNextPage(),
    );
  }
}

class _SectionPlaceholder extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionPlaceholder({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        SizedBox(height: 220, child: child),
      ],
    );
  }
}
