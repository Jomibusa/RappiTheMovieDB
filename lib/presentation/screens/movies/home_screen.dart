import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappi_themoviedb/presentation/providers/providers.dart';
import 'package:rappi_themoviedb/presentation/widgets/widgets.dart';
import 'package:rappi_themoviedb/i18n/strings/gen/strings.g.dart';

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
    return ScaffoldMessenger(
      child: Scaffold(
      appBar: AppBar(
        title: Text(t.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body: ListView(
        children: [
          MovieSection(title: t.home.popular, provider: popularMoviesProvider),
          const SizedBox(height: 16),
          MovieSection(
            title: t.home.topRated,
            provider: topRatedMoviesProvider,
          ),
        ],
      ),
    ),
    );
  }
}
