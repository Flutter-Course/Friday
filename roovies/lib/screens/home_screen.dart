import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/models/user.dart';
import 'package:roovies/providers/genres_provider.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/providers/persons_provider.dart';
import 'package:roovies/providers/user_provider.dart';
import 'package:roovies/screens/authentication_screen.dart';
import 'package:roovies/widgets/movies_by_genre.dart';
import 'package:roovies/widgets/my_drawer.dart';
import 'package:roovies/widgets/now_playing.dart';
import 'package:roovies/widgets/trending_movies.dart';
import 'package:roovies/widgets/trending_persosn.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstRun, successful;
  @override
  void initState() {
    super.initState();
    firstRun = true;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      bool validToken = await Provider.of<UserProvider>(context, listen: false)
          .refreshTokenIfNecessary();
      User user = Provider.of<UserProvider>(context, listen: false).currentUser;
      List<bool> results = await Future.wait([
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchFavorites(user),
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchNowPlayingMovies(),
        Provider.of<GenresProvider>(context, listen: false).fetchGenres(),
        Provider.of<PersonsProvider>(context, listen: false)
            .fetchTrendingPersons(),
      ]);
      setState(() {
        successful =
            (!results.any((element) => element == false) && validToken);
        firstRun = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Roovies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: (firstRun)
          ? Center(child: CircularProgressIndicator())
          : (successful)
              ? ListView(
                  children: [
                    NowPlaying(),
                    MoviesByGenre(),
                    TrendingPersons(),
                    TrendingMovies(),
                  ],
                )
              : Center(
                  child: Text(
                    'Error has occurres',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}
