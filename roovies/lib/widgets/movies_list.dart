import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:roovies/helpers/dummy_data.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/user.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/providers/user_provider.dart';
import 'package:roovies/screens/authentication_screen.dart';
import 'package:roovies/screens/movie_details_screen.dart';

class MoviesList extends StatefulWidget {
  final int genreId;
  MoviesList.byGenre(this.genreId);
  MoviesList.trending() : this.genreId = null;

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  bool firstRun;
  bool successful;
  @override
  void initState() {
    super.initState();
    firstRun = true;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      bool done;
      if (widget.genreId != null) {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchMoviesByGenreId(widget.genreId);
      } else {
        done = await Provider.of<MoviesProvider>(context, listen: false)
            .fetchTrendingMovies();
      }
      setState(() {
        successful = done;
        firstRun = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4 - 48,
      child: (firstRun)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (successful)
              ? ListView.builder(
                  itemExtent: 140,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    Movie movie = (widget.genreId != null)
                        ? Provider.of<MoviesProvider>(context)
                            .moviesbyGenre[index]
                        : Provider.of<MoviesProvider>(context)
                            .trendingMovies[index];

                    bool isFav = Provider.of<MoviesProvider>(context)
                        .isFavorite(movie.id);
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  MovieDetailsScreen.routeName,
                                  arguments: movie);
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          movie.posterUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      movie.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            '${movie.rating}',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        FittedBox(
                                          child: RatingBar(
                                            itemCount: 5,
                                            initialRating: movie.rating / 2,
                                            allowHalfRating: true,
                                            ignoreGestures: true,
                                            itemSize: 20,
                                            itemPadding: EdgeInsets.all(2),
                                            itemBuilder: (context, index) {
                                              return Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              );
                                            },
                                            onRatingUpdate: null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 2,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  gradient: RadialGradient(colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withOpacity(0),
                              ])),
                              child: IconButton(
                                icon: Icon(
                                  (isFav)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Theme.of(context).accentColor,
                                ),
                                onPressed: () async {
                                  bool validToken =
                                      await Provider.of<UserProvider>(context,
                                              listen: false)
                                          .refreshTokenIfNecessary();

                                  if (validToken) {
                                    User user = Provider.of<UserProvider>(
                                            context,
                                            listen: false)
                                        .currentUser;
                                    Provider.of<MoviesProvider>(context,
                                            listen: false)
                                        .toggleFavoriteStatus(movie, user);
                                  } else {
                                    await showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        title: Text('Error has occurred'),
                                        content: Text(
                                            'Sorry,  you have to login again.'),
                                        actions: [
                                          FlatButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .removeUserData();
                                    Navigator.of(context).pushReplacementNamed(
                                        AuthenticationScreen.routeName);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Error has occurred',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
    );
  }
}
