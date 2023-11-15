import 'package:flutter/material.dart';
import 'package:my_movies_flutter/pages/home_page.dart';

import '../widgets/bottom_bar_widget.dart';
import 'favorite_page.dart';


class BottomBarPage extends StatefulWidget {
  const BottomBarPage({Key? key}) : super(key: key);

  @override
  BottomBarScreenState createState() => BottomBarScreenState();
}

class BottomBarScreenState extends State<BottomBarPage> {
  int _selectedIndex = 0; //default index

  final List<Widget> widgetOptions = [
    const HomePage(),
    const FavoritePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}