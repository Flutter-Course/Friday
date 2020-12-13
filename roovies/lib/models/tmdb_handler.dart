import 'package:dio/dio.dart';
import 'package:roovies/helpers/api_keys.dart';
import 'package:roovies/models/genre.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/movie_details.dart';
import 'package:roovies/models/person.dart';

class TMDBHandler {
  static TMDBHandler _instance = TMDBHandler._private();
  TMDBHandler._private();
  static TMDBHandler get instance => _instance;

  String mainUrl = 'https://api.themoviedb.org/3';
  Dio _dio = Dio();

  Future<List<Movie>> getNowPlaying() async {
    String url = '$mainUrl/movie/now_playing';
    Map<String, String> params = {
      'api_key': ApiKeys.apiKey,
    };

    Response response = await _dio.get(url, queryParameters: params);

    return (response.data['results'] as List).map((movie) {
      return Movie.fromJson(movie);
    }).toList();
  }

  Future<List<Genre>> getGenres() async {
    String url = '$mainUrl/genre/movie/list';
    Map<String, String> params = {
      'api_key': ApiKeys.apiKey,
    };

    Response response = await _dio.get(url, queryParameters: params);

    return (response.data['genres'] as List).map((genre) {
      return Genre.fromJson(genre);
    }).toList();
  }

  Future<List<Movie>> getMoviesByGenreId(int genreId) async {
    String url = '$mainUrl/discover/movie';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.apiKey,
      'with_genres': genreId,
    };

    Response response = await _dio.get(url, queryParameters: params);

    return (response.data['results'] as List).map((movie) {
      return Movie.fromJson(movie);
    }).toList();
  }

  Future<List<Person>> getTrendingPersons() async {
    String url = '$mainUrl/trending/person/week';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.apiKey,
    };

    Response response = await _dio.get(url, queryParameters: params);

    return (response.data['results'] as List).map((person) {
      return Person.fromJson(person);
    }).toList();
  }

  Future<List<Movie>> getTrendingMovies() async {
    String url = '$mainUrl/trending/movie/week';
    Map<String, dynamic> params = {
      'api_key': ApiKeys.apiKey,
    };

    Response response = await _dio.get(url, queryParameters: params);

    return (response.data['results'] as List).map((movie) {
      return Movie.fromJson(movie);
    }).toList();
  }

  Future<MovieDetails> getMovieDetailsById(int movieId) async {
    String url = '$mainUrl/movie/$movieId';
    final params = {
      'api_key': ApiKeys.apiKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return MovieDetails.fromJson(response.data);
  }

  Future<String> getVideoKeyByMovieId(int movieId) async {
    String url = '$mainUrl/movie/$movieId/videos';
    final params = {
      'api_key': ApiKeys.apiKey,
    };
    Response response = await _dio.get(url, queryParameters: params);
    return response.data['results'][0]['key'];
  }
}
