import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';
import '../search/search_delegate.dart';
import '../theme/theme_model.dart';
import '../widgets/card_swiper.dart';
import '../widgets/movie_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);

    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white30,
            title: const Text(
              'Movies',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  themeNotifier.isDark = !themeNotifier.isDark;
                },
                icon: Icon(
                  themeNotifier.isDark
                      ? Icons.nightlight_round
                      : Icons.wb_sunny,
                  color: themeNotifier.isDark ? Colors.white : Colors.black,
                  size: 28,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 4),
                child: IconButton(
                    onPressed: () => showSearch(
                        context: context,
                        delegate: MovieSearchDelegate(context)),
                    icon: const Icon(
                      Icons.search_outlined,
                      size: 28,
                      color: Colors.black,
                    )),
              )
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Swiper of movie cards
              CardsSwiper(movies: moviesProvider.onDisplayMovies),

              const SizedBox(height: 4),
              //Slider of movie items
              MovieSlider(
                  movies: moviesProvider.popularMovies,
                  title: 'Populars',
                  onNextPage: () => moviesProvider.getPopularMovies())
            ],
          ),
        ),
      ));
    });
  }
}
