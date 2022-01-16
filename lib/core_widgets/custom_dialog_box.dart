import 'package:flutter/material.dart';
import 'package:qrpay/constants/basic.dart';
import 'package:qrpay/constants/images.dart';
import 'package:qrpay/services/navigation.dart';
import 'package:qrpay/services/ui_services.dart';

  

class CustomDialogBox extends StatelessWidget {
  final String bodyText;
  final bool showSignInButton;
  final bool showOtherButton;
  final String buttonText;
  final List<String> bullets;
  final Function onButtonTap;
  final String afterBullets;
  final Widget child;

  CustomDialogBox({
    Key key,
    this.showSignInButton = false,
    @required this.bodyText,
    @required this.buttonText,
    @required this.onButtonTap,
    @required this.showOtherButton,
    this.afterBullets,
    this.bullets,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    width: 80,
                    height: 80,
                    image: AssetImage(
                     logo,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    appName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (child != null) child,
              if (child == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bodyText ?? "You need to log in or create an account to use this feature. Press the button below to log in.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (bullets != null && bullets.isNotEmpty)
                      Column(
                        children: bullets.map((e) {
                          return Padding(
                            padding: EdgeInsets.all(3),
                            child: Row(
                              children: [
                                Text("-"),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    e,
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    if (afterBullets != null)
                      Text(
                        afterBullets,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              if (child == null)
                SizedBox(
                  height: 20,
                ),
              if (child == null)
                Container(
                    child: showSignInButton != null && showSignInButton
                        ? InkWell(
                            onTap: () {
                              NavigationService().pop( context);

                              UIServices().showLoginSheet(
                                AuthFormType.signUp,
                                () {},
                                context,
                              );
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              elevation: 8,
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        : showOtherButton != null && showOtherButton
                            ? InkWell(
                                onTap: () async {
                                  NavigationService().pop(context);
                                  onButtonTap();
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                  elevation: 8,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Text(
                                      buttonText,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 1,
                              ))
            ],
          ),
        ),
      ),
    );
  }
}
