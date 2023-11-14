import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';
import '../search/search_delegate.dart';
import '../widgets/card_swiper.dart';
import '../widgets/movie_slider.dart';


class HomePage extends StatelessWidget {

	const HomePage({super.key});

	@override
	Widget build(BuildContext context) {

		final MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);

  	return Scaffold(
			appBar: AppBar(
				title: const Text('Movies'),
				elevation: 0,
				actions: [
					Container(
						margin: const EdgeInsets.only(right: 4),
					  child: IconButton(
					  		onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate(context)),
					  		icon: const Icon(Icons.search_outlined)
					  ),
					)
				]
			),
    	body: SingleChildScrollView(
    	  child: Column(
					children: [
						//Swiper of movie cards
						CardsSwiper(
							movies: moviesProvider.onDisplayMovies
						),

						const SizedBox(height: 4),
						//Slider of movie items
						MovieSlider(
							movies: moviesProvider.popularMovies,
							title: 'Populars',
							onNextPage: () => moviesProvider.getPopularMovies()
						)
					],
				),
    	),
		);
	}

}