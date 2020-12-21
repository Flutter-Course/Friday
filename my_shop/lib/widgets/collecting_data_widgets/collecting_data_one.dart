import 'package:flutter/material.dart';
import 'package:my_shop/widgets/collecting_data_widgets/collecting_data_title.dart';
import 'package:my_shop/widgets/collecting_data_widgets/image_frame.dart';

class CollectingDataOne extends StatefulWidget {
  @override
  _CollectingDataOneState createState() => _CollectingDataOneState();
}

class _CollectingDataOneState extends State<CollectingDataOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            CollectingDataTitle('Few steps left to complete your profile.'),
            ImageFrame.fromFile(null),
          ],
        ),
      ),
    );
  }
}
