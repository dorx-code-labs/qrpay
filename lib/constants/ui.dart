import 'package:flutter/material.dart';
import 'package:qrpay/theming/theme_controller.dart';

import '../theming/theme_controller.dart';
import 'basic.dart';

BorderRadius standardBorderRadius = BorderRadius.circular(15);

getTabColor(
  BuildContext context,
  bool selected,
) {
  Color selectedColor =
      ThemeBuilder.of(context).getCurrentTheme() == Brightness.dark
          ? Colors.white
          : Colors.black;
  Color notSelectedColor = selectedColor.withOpacity(0.5);

  return selected ? selectedColor : notSelectedColor;
}

String sharedPrefBrightness = "${appName}_brightness";

String sharedPrefDoneWithProductsOnboarding = "${appName}_products_onboarding";
String sharedPrefDoneWithVehiclesOnboarding = "${appName}_vehicles_onboarding";
String sharedPrefDoneWithOnBoarding = "${appName}_onboarding";

const primaryColor = Colors.purple;
Color altColor = Colors.blue[900];

const List<LinearGradient> listColors = [
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.indigoAccent,
      Colors.teal,
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.purple,
      Colors.red,
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.green,
      Colors.blue,
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange,
      Colors.redAccent,
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.purple,
      Colors.blue,
    ],
  ),
];
