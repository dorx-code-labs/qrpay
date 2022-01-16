import 'package:flutter/material.dart';
import 'package:qrpay/constants/images.dart';
import 'package:qrpay/constants/ui.dart';
import 'package:qrpay/core_widgets/logo.dart';
import 'package:qrpay/core_widgets/only_when_logged_in.dart';
import 'package:qrpay/core_widgets/proceed_button.dart';
import 'package:qrpay/models/onboarding_item.dart';
import 'package:qrpay/services/navigation.dart';
import 'package:qrpay/services/ui_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'about_us_view.dart';

class OnboardingPage extends StatefulWidget {
  final bool justChecking;
  OnboardingPage({
    Key key,
    this.justChecking = false,
  }) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnBoardingItem> dayta = [
    OnBoardingItem(
      "Explore Homes away from Home",
      compound,
      "Browse the cheapest and best homes worldwide",
    ),
    OnBoardingItem(
      "Buy / Rent Houses",
      happyMan,
      "You can buy and rent houses at your convenience",
    ),
    OnBoardingItem(
      "Shop for interior Decor",
      livingRoom,
      "Shop for all types of interior decor and home items",
    ),
    OnBoardingItem(
      "Buy Land easily and hustle free",
      land,
      "We have hundreds of plots of land up for grabs",
    ),
    OnBoardingItem(
      "Agents",
      agent,
      "Get in touch with our verified agents who can help you.",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: dayta.length,
                  onPageChanged: (v) {
                    setState(() {
                      _currentIndex = v;
                    });
                  },
                  itemBuilder: (c, i) => SingleOnboardingPage(
                    length: dayta.length,
                    index: _currentIndex,
                    item: dayta[i],
                    justChecking: widget.justChecking,
                    onTap: () async {
                      if (_currentIndex != dayta.length - 1) {
                        _pageController.animateToPage(
                          _currentIndex + 1,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.fastOutSlowIn,
                        );
                      } else {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool(
                          sharedPrefDoneWithOnBoarding,
                          true,
                        );

                        NavigationService().popToFirst(context);
                      }
                    },
                  ),
                ),
                Positioned(
                  //TODO: Fix nothing for now in the dashboard
                  top: 2,
                  //TODO: Put a message to make the maybe later have context
                  right: 2,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        NavigationService().push(
                          context,
                          AboutUs(),
                        );
                      },
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(50),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Logo(
                            withImage: true,
                            picSize: 40,
                            withString: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    dayta.length,
                    (v) => createCircle(
                      v == _currentIndex,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: OnlyWhenLoggedIn(
              loadingView: widget.justChecking
                  ? SizedBox()
                  : Column(
                      children: [
                        ProceedButton(
                          onTap: () {
                            UIServices().showLoginSheet(
                              AuthFormType.signIn,
                              () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool(
                                  sharedPrefDoneWithOnBoarding,
                                  true,
                                );

                                NavigationService().popToFirst(context);

                                NavigationService().pushReplacement(
                                  context,
                                  MyHomePage(),
                                );
                              },
                              context,
                            );
                          },
                          text: "Sign In",
                        ),
                        TextButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool(
                              sharedPrefDoneWithOnBoarding,
                              true,
                            );

                            NavigationService().popToFirst(context);

                            NavigationService().pushReplacement(
                              context,
                              MyHomePage(),
                            );
                          },
                          child: Text(
                            "Maybe Later",
                          ),
                        ),
                      ],
                    ),
              notSignedIn: Column(
                children: [
                  ProceedButton(
                    onTap: () {
                      UIServices().showLoginSheet(
                        AuthFormType.signIn,
                        () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool(
                            sharedPrefDoneWithOnBoarding,
                            true,
                          );

                          NavigationService().popToFirst(context);

                          NavigationService().pushReplacement(
                            context,
                            MyHomePage(),
                          );
                        },
                        context,
                      );
                    },
                    text: "Sign In",
                  ),
                  TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool(
                        sharedPrefDoneWithOnBoarding,
                        true,
                      );

                      NavigationService().popToFirst(context);

                      NavigationService().pushReplacement(
                        context,
                        MyHomePage(),
                      );
                    },
                    child: Text(
                      "Maybe Later",
                    ),
                  ),
                ],
              ),
              signedInView: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ProceedButton(
                    text: "Skip To Dashboard",
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool(
                        sharedPrefDoneWithOnBoarding,
                        true,
                      );

                      NavigationService().popToFirst(context);

                      NavigationService().pushReplacement(
                        context,
                        MyHomePage(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  createCircle(bool large) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(right: 4),
      height: 5,
      width: large ? 25 : 8, // current indicator is wider
      decoration: BoxDecoration(
        color: altColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class SingleOnboardingPage extends StatelessWidget {
  final OnBoardingItem item;
  final Function onTap;
  final int length;
  final int index;
  final bool justChecking;

  const SingleOnboardingPage({
    Key key,
    @required this.item,
    @required this.onTap,
    @required this.length,
    @required this.justChecking,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Stack(
              children: [
                Image.asset(
                  item.image,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.7, 0.8, 0.9],
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 3,
                  left: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          item.desc,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
