import 'package:deliver_manager/widgets/chart.dart';
import 'package:deliver_manager/widgets/order_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height:
                MediaQuery.of(context).size.height * ((portrait) ? 0.3 : 0.4),
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Delivery Manager',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Chart(),
                  Expanded(
                      child: ListView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.12,
                    ),
                    children: [
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
      ),
    );
  }
}
