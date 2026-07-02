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
    Future.microtask(() {
      ref.read(popularMoviesProvider.notifier).loadNextPage();
      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RappiMovies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body: ListView(
        children: [
          MovieSection(title: 'Populares', provider: popularMoviesProvider),
          const SizedBox(height: 16),
          MovieSection(
            title: 'Mejor calificadas',
            provider: topRatedMoviesProvider,
          ),
        ],
      ),
    );
  }
}
