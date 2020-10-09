import 'dart:collection';
import 'dart:math';

import 'package:deliver_manager/models/order.dart';
import 'package:deliver_manager/widgets/chart.dart';
import 'package:deliver_manager/widgets/order_item.dart';
import 'package:deliver_manager/widgets/sticky_header_head.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showUpButton = false;
  ScrollController controller = ScrollController();
  SplayTreeMap<String, Map<String, dynamic>> orders =
      SplayTreeMap<String, Map<String, dynamic>>((String a, String b) {
    return -a.compareTo(b);
  });
  List<String> deliveryMen = ['Muhammed Aly', 'Toka Ehab', 'Ahmed Aly'];
  @override
  void initState() {
    super.initState();
    final ordersList = List.generate(12, (index) {
      return Order(
        id: index,
        deliveryMan: deliveryMen[Random().nextInt(3)],
        price: Random().nextDouble() * 500,
        orderDate: DateTime.now().subtract(
          Duration(
            days: Random().nextInt(12),
            hours: Random().nextInt(24),
            minutes: Random().nextInt(60),
          ),
        ),
      );
    });

    ordersList.forEach((element) {
      final key = DateFormat('yyyyMMdd').format(element.orderDate);
      if (!orders.containsKey(key)) {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(element.orderDate);
        orders[key]['list'] = SplayTreeSet<Order>((Order a, Order b) {
          String timeA, timeB;
          timeA = DateFormat('hhmm').format(a.orderDate);
          timeB = DateFormat('hhmm').format(b.orderDate);
          return timeA.compareTo(timeB);
        });
      }
      orders[key]['list'].add(element);
    });
  }

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
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels >= 20 &&
                            showUpButton == false) {
                          setState(() {
                            showUpButton = true;
                          });
                        } else if (notification.metrics.pixels < 20 &&
                            showUpButton == true) {
                          setState(() {
                            showUpButton = false;
                          });
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: controller,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 56,
                        ),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final List keys = orders.keys.toList();
                          final key = keys[index];
                          final date = orders[key]['date'];
                          return StickyHeader(
                            header: StickyHeaderHead(date),
                            content: Column(
                              children: [
                                Text('a'),
                                Text('b'),
                                Text('c'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          left: 2 * kFloatingActionButtonMargin,
        ),
        child: Row(
          mainAxisAlignment: (showUpButton)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (showUpButton)
              FloatingActionButton(
                backgroundColor: Colors.grey,
                mini: true,
                child: Icon(Icons.keyboard_arrow_up),
                onPressed: () {
                  controller.jumpTo(0.0);
                },
              ),
            FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
