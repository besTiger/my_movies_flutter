import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../helpers/debouncer.dart';
import '../models/cast.dart';
import '../models/credits_response.dart';
import '../models/movie.dart';
import '../models/now_playing_response.dart';
import '../models/popular_response.dart';
import '../models/search_response.dart';

class MoviesProvider extends ChangeNotifier {

  final String _serviceUrl = 'api.themoviedb.org';
  final String _serviceApiKey = 'e8bf0a88d8c448b3069dca27bd1d7619';
  final String _language = 'en-US';
  int _popularPage = 1;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCasting = {};


  final debouncer = Debouncer<String>(
      duration: const Duration(milliseconds: 500)
  );

  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionsStream => _suggestionsStreamController.stream;


  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();

    debouncer.value = '';
    debouncer.onValue = (String value) async {
      final movies = await searchMovies(value);
      _suggestionsStreamController.add(movies);
    };
  }

  Future<Response> _getJsonData(String urlEndPath, [int page = 1]) async {
    final url = Uri.https(_serviceUrl, urlEndPath, {
        'api_key': _serviceApiKey,
        'language': _language,
        'page': '$page'
      }
    );

    return await http.get(url);
  }

  Future getOnDisplayMovies() async {
    final Response response = await _getJsonData('/3/movie/now_playing');

    if (response.statusCode == 200) {
      onDisplayMovies = NowPlayingResponse.fromRawJson(response.body).results;
      notifyListeners();
    }
  }

  Future getPopularMovies() async {
    final Response response = await _getJsonData('/3/movie/popular', _popularPage);

    if (response.statusCode == 200) {
      final popularResponse = PopularResponse.fromRawJson(response.body);
      popularMovies = [...popularMovies, ...popularResponse.movies];
      _popularPage++;
      notifyListeners();
    }
  }

  Future<List<Cast>> getMovieCasting(int movieId) async {
    if (moviesCasting.containsKey(movieId)) {
      return moviesCasting[movieId]!;
    }

    final response = await _getJsonData('/3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromRawJson(response.body);

    moviesCasting[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_serviceUrl, '/3/search/movie', {
        'api_key': _serviceApiKey,
        'language': _language,
        'query': query
      }
    );

    final response = await http.get(url);

    final SearchResponse searchResponse = SearchResponse.fromRawJson(response.body);
    return searchResponse.movies;
  }

  void getSuggestionsByQuery(String query) async {
    debouncer.value = query;
  }

}