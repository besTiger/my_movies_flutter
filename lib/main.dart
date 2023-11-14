import 'package:flutter/material.dart';
import 'package:my_movies_flutter/providers/movies_provider.dart';
import 'package:my_movies_flutter/router/routes.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {

  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false)
      ],
      child: const MyApp()
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: 'home',
      routes: Routes.routes,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.black87
        )
      )
    );
  }
}