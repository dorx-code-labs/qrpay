import 'package:flutter/material.dart';
import 'package:qrpay/constants/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

  
import 'theme_controller.dart';
import 'theme_switch.dart';

class ThemeSwitch extends StatefulWidget {
  ThemeSwitch({Key key}) : super(key: key);

  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return DayNightSwitch(
      height: 30.0,
      width: 80.0,
      onSelection: (isCheck) async {
        if (isCheck) {
          //light
          ThemeBuilder.of(context).makeLight();
          final prefs = await SharedPreferences.getInstance();
          prefs.setString(
           sharedPrefBrightness,
            "light",
          );
        } else {
          //dark
          ThemeBuilder.of(context).makeDark();
          final prefs = await SharedPreferences.getInstance();
          prefs.setString(
          sharedPrefBrightness,
            "dark",
          );
        }
      },
    );
  }
}
