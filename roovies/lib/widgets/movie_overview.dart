import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            'dndbkqsadbkja daldnalsdnajdn dadnasjdnaskdnasjdndadd dlnljnjnkjnkjnknjn nlnljnnj',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
