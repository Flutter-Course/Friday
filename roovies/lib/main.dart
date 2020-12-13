import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/helpers/constants.dart';
import 'package:roovies/models/tmdb_handler.dart';
import 'package:roovies/providers/genres_provider.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/providers/persons_provider.dart';
import 'package:roovies/providers/user_provider.dart';
import 'package:roovies/screens/authentication_screen.dart';
import 'package:roovies/screens/home_screen.dart';
import 'package:roovies/screens/movie_details_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MoviesProvider()),
    ChangeNotifierProvider(create: (context) => GenresProvider()),
    ChangeNotifierProvider(create: (context) => PersonsProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roovies',
      theme: ThemeData(
        primarySwatch: Constants.primaryColor,
        accentColor: Color.fromRGBO(244, 193, 15, 1),
        scaffoldBackgroundColor: Constants.primaryColor,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
            headline6: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
          future:
              Provider.of<UserProvider>(context, listen: false).isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == true) {
              return HomeScreen();
            } else {
              return AuthenticationScreen();
            }
          }),
      routes: {
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
      },
    );
  }
}
