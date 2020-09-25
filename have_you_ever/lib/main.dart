import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> questions = [
    'Have you ever wrote a letter?',
    'Have you ever smoked a cigarette?',
    'Have you ever been hit on by someone who was too old?',
    'Have you ever been on the radio or on television?',
    'Have you ever stayed awake for an entire night?',
    'Have you ever broken something, like a window, and ran away?',
    'Have you ever won a contest and received a prize?',
    'Have you ever met a famous person or a celebrity?',
  ];
  int questionIndex = 0, yes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Have You Ever'),
      ),
      body: Center(
        child: (questionIndex < 5)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    questions[questionIndex],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    color: Colors.green[900],
                    onPressed: () {
                      setState(() {
                        questionIndex++;
                        yes++;
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        questionIndex++;
                      });
                    },
                  )
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (yes < 3)
                        ? Image.asset('assets/images/winner.png')
                        : Image.asset('assets/images/loser.png'),
                    RaisedButton(
                      child: Text('Play again'),
                      onPressed: () {
                        setState(() {
                          questions.shuffle();
                          yes = 0;
                          questionIndex = 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
