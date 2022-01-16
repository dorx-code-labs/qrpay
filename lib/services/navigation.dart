import 'package:flutter/material.dart';

class NavigationService {
  void push(
    BuildContext context,
    Widget page,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  popCount(
    int count,
    BuildContext context,
  ) {
    int ct = 0;
    Navigator.of(context).popUntil((route) {
      return ct++ == count;
    });
  }

  popToFirst(BuildContext context) {
    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );
  }

  void pushReplacement(
    BuildContext context,
    Widget page,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
