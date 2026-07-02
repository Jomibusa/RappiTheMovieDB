import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/presentation/providers/providers.dart';
import 'package:rappi_themoviedb/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:rappi_themoviedb/presentation/widgets/shared/full_screen_loader.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
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
      return _SectionPlaceholder(
        title: title,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No se pudo cargar'),
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
      return _SectionPlaceholder(title: title, child: const FullScreenLoader());
    }

    return MovieHorizontalListview(
      title: title,
      movies: state.movies,
      onLoadNextPage: () => ref.read(provider.notifier).loadNextPage(),
    );
  }
}

/// Título + caja de 220px que se muestra mientras la sección no tiene
/// películas que mostrar (cargando o con error). Cuando sí hay películas,
/// MovieSection usa MovieHorizontalListview directamente, no esto.
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
