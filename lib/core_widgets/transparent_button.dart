import 'package:flutter/material.dart';
import 'package:qrpay/theming/theme_controller.dart';

class TransparentButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final Icon icon;
  const TransparentButton({
    Key key,
    @required this.onTap,
    @required this.text,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1,
              color: ThemeBuilder.of(context).getCurrentTheme() ==
                      Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
