import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrpay/constants/basic.dart';
import 'package:qrpay/constants/images.dart';
import 'package:qrpay/constants/ui.dart';
import 'package:qrpay/core_widgets/pulser.dart';
import 'package:qrpay/services/navigation.dart';
import 'package:qrpay/core_views.dart/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';


class SplashScreenView extends StatefulWidget {
  SplashScreenView({Key key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool g = prefs.getBool(
          sharedPrefDoneWithOnBoarding,
        ) ??
        false;

    NavigationService().pushReplacement(
      context,
      g ? MyHomePage() : OnboardingPage(),
    );
  }

  startTime() async {
    var _duration =  Duration(seconds:4 );
    return  Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              Center(
                child: Pulser(
                  duration: 800,
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.4,
                    image: AssetImage(
                      logo,
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "By",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      launch(niranWebsite);
                    },
                    child: Image.asset(
                      niranLogo,
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
