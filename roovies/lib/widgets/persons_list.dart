import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/helpers/dummy_data.dart';
import 'package:roovies/models/person.dart';
import 'package:roovies/providers/persons_provider.dart';

class PersonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        itemExtent: 100,
        scrollDirection: Axis.horizontal,
        itemCount: DummyData.nowPlaying.length,
        itemBuilder: (context, index) {
          Person person =
              Provider.of<PersonsProvider>(context).trendingPersons[index];
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          person.posterUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: FittedBox(
                    child: Text(
                      person.name,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
