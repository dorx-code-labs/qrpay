import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrpay/constants/images.dart';
 
import 'package:qrpay/theming/theme_controller.dart';

class MenuButton extends StatelessWidget {
  final double size;
  final Color color;
  MenuButton({
    Key key,
    this.size = 25,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: SvgPicture.asset(
          menu,
          width: size,
          color: color ?? ThemeBuilder.of(context).getCurrentTheme() == Brightness.dark
                  ? Colors.white
                  : Colors.black,
        ),
      ),
    );
  }
}
