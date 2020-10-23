import 'dart:collection';

import 'package:deliver_manager/models/order.dart';
import 'package:deliver_manager/widgets/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final SplayTreeMap<String, Map<String, dynamic>> orders;

  Chart(this.orders);
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Map<String, Color> colors = Map<String, Color>();
  Map<String, int> count = Map<String, int>();
  bool showChart;
  String selectedDate;
  @override
  void initState() {
    super.initState();
    colors = {
      'Muhammed Aly': Colors.blue,
      'Toka Ehab': Colors.yellow,
      'Ahmed Aly': Colors.purple,
    };
    selectedDate = DateFormat('dd/MM').format(DateTime.now());
    filterByDate(DateTime.now());
  }

  void filterByDate(DateTime date) {
    final selectedDate = DateFormat('yyyyMMdd').format(date);
    if (widget.orders.containsKey(selectedDate)) {
      showChart = true;
      SplayTreeSet<Order> list = widget.orders[selectedDate]['list'];
      count['Muhammed Aly'] = 0;
      count['Toka Ehab'] = 0;
      count['Ahmed Aly'] = 0;
      list.forEach((element) {
        count[element.deliveryMan]++;
      });
    } else {
      showChart = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ).add(
        EdgeInsets.only(
          bottom: 20,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final date = DateTime.now().subtract(Duration(days: index));
                  return Container(
                    margin: EdgeInsets.only(
                        left: index != 6 ? 2 : 0, right: index != 0 ? 2 : 0),
                    child: FlatButton(
                      shape: StadiumBorder(),
                      color: selectedDate == DateFormat('dd/MM').format(date)
                          ? Colors.amber
                          : Colors.amber[100],
                      child: Text(DateFormat('dd/MM').format(date)),
                      onPressed: () {
                        setState(() {
                          selectedDate = DateFormat('dd/MM').format(date);
                          filterByDate(date);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: showChart
                  ? Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text('#Orders'),
                              Expanded(child: Container()),
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    HeroItem(
                                        'Muhammed Aly', colors['Muhammed Aly']),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    HeroItem('Toka Ehab', colors['Toka Ehab']),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    HeroItem('Ahmed Aly', colors['Ahmed Aly']),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                children: [
                                  Container(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth * 0.1,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('20'),
                                        Text('10'),
                                        Text('0'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: constraints.maxHeight,
                                    width: constraints.maxWidth * 0.9,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: count['Muhammed Aly'] *
                                              constraints.maxHeight /
                                              20,
                                          color: Colors.blue,
                                        ),
                                        Container(
                                          width: 20,
                                          height: count['Toka Ehab'] *
                                              constraints.maxHeight /
                                              20,
                                          color: Colors.yellow,
                                        ),
                                        Container(
                                          width: 20,
                                          height: count['Ahmed Aly'] *
                                              constraints.maxHeight /
                                              20,
                                          color: Colors.purple,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.all(16.0),
                      child: FittedBox(
                          child: Center(child: Text('No Orders Yet'))),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
