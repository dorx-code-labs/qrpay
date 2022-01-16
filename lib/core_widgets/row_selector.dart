import 'package:flutter/material.dart';
import 'package:qrpay/constants/ui.dart';
 

class RowSelector extends StatelessWidget {
  final String text;
  final Color selectedColor;
  final Widget child;
  final bool selected;
  final Function onTap;
  RowSelector({
    Key key,
    @required this.onTap,
    @required this.selected,
    @required this.text,
    this.child,
    this.selectedColor = primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: selected ? selectedColor : null,
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(
            width: 2,
            color: selected
                ? selectedColor
                : Colors.grey,
          ),
        ),
        padding: EdgeInsets.only(
          left: 6,
          right: 6,
          bottom: 6,
          top: 6,
        ),
        margin: EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: 2,
          right: 2,
        ),
        child: Center(
          child: child ?? Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected ? Colors.white : null,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
