import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/providers/user_provider.dart';
import 'package:roovies/screens/authentication_screen.dart';
import 'package:roovies/screens/home_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              color: Theme.of(context).accentColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Provider.of<UserProvider>(context).currentUser.email,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Theme.of(context).accentColor,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 12,
              shadowColor: Theme.of(context).accentColor,
              child: ListTile(
                onTap: () {
                  if (ModalRoute.of(context).settings.name ==
                      HomeScreen.routeName) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  }
                },
                title: Text('Home'),
                trailing: Icon(Icons.home),
              ),
            ),
            Card(
              color: Theme.of(context).accentColor,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 12,
              shadowColor: Theme.of(context).accentColor,
              child: ListTile(
                onTap: () {},
                title: Text('Favorites'),
                trailing: Icon(Icons.favorite),
              ),
            ),
            Card(
              color: Theme.of(context).accentColor,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 12,
              shadowColor: Theme.of(context).accentColor,
              child: ListTile(
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false)
                      .removeUserData();
                  Navigator.of(context)
                      .pushReplacementNamed(AuthenticationScreen.routeName);
                },
                title: Text('Logout'),
                trailing: Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
