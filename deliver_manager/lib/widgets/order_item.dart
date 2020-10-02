import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ).add(
        EdgeInsets.only(
          bottom: 8,
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 30,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '50.00\$',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text('Muhammed Aly'),
          subtitle: Text('2:00PM'),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
