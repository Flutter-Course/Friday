import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/tmdb_handler.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> nowplaying;
  List<Movie> moviesbyGenre;
  List<Movie> trendingMovies;
  Future<bool> fetchNowPlayingMovies() async {
    try {
      nowplaying = await TMDBHandler.instance.getNowPlaying();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> fetchMoviesByGenreId(int genreId) async {
    try {
      moviesbyGenre = await TMDBHandler.instance.getMoviesByGenreId(genreId);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> fetchTrendingMovies() async {
    try {
      trendingMovies = await TMDBHandler.instance.getTrendingMovies();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
