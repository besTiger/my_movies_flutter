import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../models/movie.dart';


class CardsSwiper extends StatelessWidget {

	final List<Movie> movies;

	const CardsSwiper({
		super.key,
		required this.movies
	});

	@override
	Widget build(BuildContext context) {

		final size = MediaQuery.of(context).size;

		if (movies.isEmpty) {
			return SizedBox(
				width: double.infinity,
				height: size.height * 0.54,
				child: const Center(
					child: CircularProgressIndicator()
				),
			);
		}

  	return SizedBox(
    	width: double.infinity,
      height: size.height * 0.50,
			child: Swiper(
				itemCount: movies.length,
				layout: SwiperLayout.STACK,
				itemWidth: size.width * 0.70,
				itemHeight: size.height * 0.44,
				itemBuilder: (_, index) {
					final movie = movies[index];

					movie.heroId = 'swiper-${movie.id}';

					return GestureDetector(
						onTap: () => Navigator.pushNamed(_, 'details', arguments: movie),
					  child: Hero(
							tag: movie.heroId!,
					    child: ClipRRect(
					    	borderRadius: BorderRadius.circular(15),
					      child: FadeInImage(
					      	placeholder: const AssetImage('assets/no_image.jpg'),
					      	image: NetworkImage(movie.fullPosterPath),
					    		fit: BoxFit.cover
					      ),
					    ),
					  ),
					);
				},
			),
		);
	}

}