import 'package:flutter/material.dart';
import '../pages/bottom_bar_page.dart';
import '../pages/details_page.dart';
import '../pages/favorite_page.dart';
import '../pages/home_page.dart';


class Routes {

  static const String initialRoute = 'home';

  static Map<String, WidgetBuilder> routes = {
    'bottom': (_) => const BottomBarPage(),
    'home': (_) => const HomePage(),
    'favorite': (_) => const FavoritePage(),
    'details': (_) => const DetailsPage()
  };

}