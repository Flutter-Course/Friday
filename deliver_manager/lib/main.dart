import 'package:deliver_manager/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode theme;
  @override
  void initState() {
    super.initState();
    theme = ThemeMode.light;
  }

  void toggleTheme() {
    setState(() {
      if (theme == ThemeMode.light) {
        theme = ThemeMode.dark;
      } else {
        theme = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery Manager',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.grey[900],
        accentColor: Colors.grey[600],
      ),
      themeMode: theme,
      home: HomeScreen(toggleTheme),
    );
  }
}
