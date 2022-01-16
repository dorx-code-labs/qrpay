import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String text;
  final Color textColor;
  const OrDivider({
    Key key,
    this.text = "OR",
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 2,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
