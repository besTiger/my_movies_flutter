import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "This is Favorite page",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        )
      ],
    );
  }
}