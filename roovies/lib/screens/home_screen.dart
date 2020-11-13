import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/providers/genres_provider.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/providers/persons_provider.dart';
import 'package:roovies/widgets/movies_by_genre.dart';
import 'package:roovies/widgets/now_playing.dart';
import 'package:roovies/widgets/trending_movies.dart';
import 'package:roovies/widgets/trending_persosn.dart';

class HomeScreen extends StatefulWidget {
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
      List<bool> results = await Future.wait([
        Provider.of<MoviesProvider>(context, listen: false)
            .fetchNowPlayingMovies(),
        Provider.of<GenresProvider>(context, listen: false).fetchGenres(),
        Provider.of<PersonsProvider>(context, listen: false)
            .fetchTrendingPersons(),
      ]);
      setState(() {
        successful = !results.any((element) => element == false);
        firstRun = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.dehaze), onPressed: () {}),
        title: Text('Roovies'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
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
