import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/presentation/providers/providers.dart';
import 'package:rappi_themoviedb/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('RappiMovies')),
      body: popularMovies.isEmpty
          ? const FullScreenLoader()
          : ListView(
              children: [
                MovieHorizontalListview(
                  title: 'Populares',
                  movies: popularMovies,
                  onLoadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  title: 'Mejor calificadas',
                  movies: topRatedMovies,
                  onLoadNextPage: () => ref
                      .read(topRatedMoviesProvider.notifier)
                      .loadNextPage(),
                ),
              ],
            ),
    );
  }
}
