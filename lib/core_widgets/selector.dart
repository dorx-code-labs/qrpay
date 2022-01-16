import 'package:flutter/material.dart';

class SelectorThingie extends StatelessWidget {
  const SelectorThingie({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Center(
        child: Icon(
          Icons.done,
          color: Colors.green,
          size: 25,
        ),
      ),
    );
  }
}
