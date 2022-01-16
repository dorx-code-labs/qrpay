import 'package:flutter/material.dart';

class DeletedItem extends StatelessWidget {
  final String what;
  const DeletedItem({
    Key key,
    @required this.what,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          border: Border.all(
        width: 1,
        color: Colors.grey,
      )),
      padding: EdgeInsets.all(15),
      child: Center(
        child: Text("Sorry. This $what was deleted by its owner."),
      ),
    );
  }
}
