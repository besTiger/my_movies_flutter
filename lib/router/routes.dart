import 'package:flutter/material.dart';
import '../pages/details_page.dart';
import '../pages/home_page.dart';


class Routes {

  static const String initialRoute = 'home';

  static Map<String, WidgetBuilder> routes = {
    'home': (_) => const HomePage(),
    'details': (_) => const DetailsPage()
  };

}