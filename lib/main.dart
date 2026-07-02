import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'i18n/strings/gen/strings.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  AppRouter.configureRoutes();
  LocaleSettings.useDeviceLocale();
  runApp(
    ProviderScope(
      child: TranslationProvider(child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: t.appTitle,
      theme: AppTheme.theme,
      onGenerateRoute: AppRouter.router.generator,
      initialRoute: '/',
    );
  }
}

