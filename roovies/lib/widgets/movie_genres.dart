import 'package:flutter/material.dart';
import 'package:roovies/models/genre.dart';
import 'package:roovies/widgets/movie_genre_item.dart';

class MovieGenres extends StatelessWidget {
  List<Genre> genres;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Wrap(
        children: genres.map((genre) {
          return MovieGenreItem(genre.name);
        }).toList(),
      ),
    );
  }
}
