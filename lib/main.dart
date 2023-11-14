import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_movies_flutter/providers/movies_provider.dart';
import 'package:my_movies_flutter/router/routes.dart';
import 'package:my_movies_flutter/theme/theme_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const AppState());
  });
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
          title: 'Movies',
          initialRoute: 'home',
          routes: Routes.routes,
        );
      }),
    );
  }
}
