import 'package:fluro/fluro.dart';

import '../main.dart';

class AppRouter {
  static final FluroRouter router = FluroRouter();

  static void configureRoutes() {
    router.define(
      '/',
      handler: Handler(
        handlerFunc: (context, params) =>
            const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
