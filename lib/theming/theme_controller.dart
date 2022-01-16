import 'package:flutter/material.dart';
import 'package:qrpay/constants/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

  

class ThemeBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    Brightness brightness,
  ) builder;

  ThemeBuilder({Key key, this.builder}) : super(key: key);

  @override
  _ThemeBuilderState createState() => _ThemeBuilderState();

  static _ThemeBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeBuilderState>();
  }
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  Brightness _brightness = Brightness.dark;

  @override
  void initState() {
    super.initState();
    getThemePref();
  }

  getThemePref() async {
    final prefs = await SharedPreferences.getInstance();
    String bright = prefs.getString(
         sharedPrefBrightness,
        ) ??
        'light';
    if (bright == "light") {
      _brightness = Brightness.light;
    } else {
      _brightness = Brightness.dark;
    }
    if (mounted) setState(() {});
  }

  void makeLight() {
    setState(() {
      _brightness = Brightness.light;
    });
  }

  void makeDark() {
    setState(() {
      _brightness = Brightness.dark;
    });
  }

  Brightness getCurrentTheme() {
    return _brightness;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _brightness);
  }
}
