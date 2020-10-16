import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final bool portrait;
  BackgroundContainer(this.portrait);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * ((portrait) ? 0.3 : 0.4),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
    );
  }
}
