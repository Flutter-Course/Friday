import 'package:flutter/material.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/widgets/movie_info.dart';
import 'package:roovies/widgets/movie_overview.dart';
import 'package:roovies/widgets/movie_rating.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = '/movie-details';
  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context).settings.arguments as Movie;
    return Scaffold(
      body: SliverFab(
        floatingWidget: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.play_arrow),
          backgroundColor: Theme.of(context).accentColor,
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.4,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                margin: EdgeInsets.only(right: 75),
                child: Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              background: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      movie.backPosterUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  MovieRating(movie.rating),
                  MovieOverview(),
                  MovieInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
