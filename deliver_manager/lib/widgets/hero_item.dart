import 'package:flutter/material.dart';

class HeroItem extends StatelessWidget {
  final Color color;
  final String name;
  HeroItem(this.name, this.color);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        Text(name),
      ],
    );
  }
}
