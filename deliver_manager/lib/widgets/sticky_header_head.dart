import 'package:flutter/material.dart';

class StickyHeaderHead extends StatelessWidget {
  final String date;
  StickyHeaderHead(this.date);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Theme.of(context).primaryColor,
      elevation: 10,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: 20,
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Text(
          date,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
