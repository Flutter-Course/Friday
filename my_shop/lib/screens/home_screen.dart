import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/auth_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Logout'),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
          },
        ),
      ),
    );
  }
}
