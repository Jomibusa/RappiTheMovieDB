import 'package:fluro/fluro.dart';
import 'package:rappi_themoviedb/presentation/screens/screens.dart';

class AppRouter {
  static final FluroRouter router = FluroRouter();

  static void configureRoutes() {
    router.define(
      '/',
      handler: Handler(
        handlerFunc: (context, params) => const HomeScreen(),
      ),
    );

    router.define(
      '/movie/:id',
      handler: Handler(
        handlerFunc: (context, params) =>
            MovieScreen(movieId: params['id']!.first),
      ),
    );

    router.define(
      '/search',
      handler: Handler(
        handlerFunc: (context, params) => const SearchScreen(),
      ),
    );
  }
}
