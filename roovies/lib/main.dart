import 'package:flutter/material.dart';
import 'package:roovies/helpers/constants.dart';
import 'package:roovies/screens/home_screen.dart';

void main() {
  runApp(MyApp());
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
      home: HomeScreen(),
    );
  }
}
