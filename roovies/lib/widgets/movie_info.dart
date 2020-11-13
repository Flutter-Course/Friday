import 'package:flutter/material.dart';
import 'package:roovies/widgets/movie_info_item.dart';

class MovieInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MovieInfoItem('Budget', '10000'),
          MovieInfoItem('Duration', '120'),
          MovieInfoItem('Release Date', '2020-11-13'),
        ],
      ),
    );
  }
}
