import 'package:flutter/material.dart';
import 'package:my_shop/widgets/collecting_data_widgets/collecting_data_one.dart';
import 'package:my_shop/widgets/collecting_data_widgets/collecting_data_two.dart';
import 'package:page_indicator/page_indicator.dart';

class CollectingDataScreen extends StatefulWidget {
  @override
  _CollectingDataScreenState createState() => _CollectingDataScreenState();
}

class _CollectingDataScreenState extends State<CollectingDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PageIndicatorContainer(
            length: 2,
            indicatorSelectorColor: Colors.black,
            indicatorColor: Colors.grey,
            shape: IndicatorShape.roundRectangleShape(
              size: Size(20, 5),
              cornerSize: Size.square(20),
            ),
            child: PageView(
              children: [
                CollectingDataOne(),
                CollectingDataTwo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
