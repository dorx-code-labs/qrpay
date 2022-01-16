import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:qrpay/core_widgets/custom_divider.dart';
import 'package:qrpay/core_widgets/top_back_bar.dart';
import 'package:qrpay/services/text_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qrpay/constants/basic.dart';
import 'package:qrpay/constants/constants_used_in_the_ui.dart';
import 'package:qrpay/constants/images.dart';
import 'package:qrpay/constants/ui.dart';
import 'package:qrpay/models/push_notification.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth_provider_widget.dart';
import 'auth_service.dart';
import 'communications.dart';
import 'firebase_service.dart';

enum AuthFormType { signIn, signUp, reset }

class UIServices {
  dynamic getColor(String colorString, Color color) {
    if (colorString != null) {
      return allColors[colorString] ?? primaryColor;
    } else {
      String kala = BLUE;
      allColors.forEach((key, value) {
        if (value == color) {
          kala = key;
        }
      });

      return kala;
    }
  }

  Future<dynamic> showDatSheet(
    Widget sheet,
    bool willThisThingNeedScrolling,
    BuildContext context, {
    double height,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: willThisThingNeedScrolling,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SizedBox(
          height: height ?? MediaQuery.of(context).size.height * 0.8,
          child: StatefulBuilder(builder: (context, setIt) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Theme.of(context).canvasColor,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 10,
                    width: 50,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16,
                      ),
                      topRight: Radius.circular(
                        16,
                      ),
                    ),
                    child: Container(
                      color: Theme.of(context).canvasColor,
                      child: sheet,
                    ),
                  ),
                )
              ],
            );
          }),
        );
      },
    );
  }

  Color colorFromString(String color) {
    return color == PINK
        ? Colors.pink
        : color == GREEN
            ? Colors.green
            : color == RED
                ? Colors.red
                : color == ORANGE
                    ? Colors.orange
                    : color == BLUE
                        ? Colors.blue
                        : color == PURPLE
                            ? Colors.purple
                            : color == YELLOW
                                ? Colors.yellow
                                : color == VIOLET
                                    ? Colors.purpleAccent
                                    : color == WHITE
                                        ? Colors.white
                                        : color == BLACK
                                            ? Colors.black
                                            : Colors.blue;
  }

  DecorationImage decorationImage(
    dynamic asset,
    bool darken,
  ) {
    return asset == null
        ? null
        : DecorationImage(
            image: asset is File
                ? FileImage(asset)
                : asset.toString().trim().contains(
                          "assets/images",
                        )
                    ? AssetImage(
                        asset,
                      )
                    : CachedNetworkImageProvider(
                        asset,
                      ),
            fit: BoxFit.cover,
            colorFilter: darken
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  )
                : null,
          );
  }

  showPopUpPushNotification(
    PushNotification notification,
    BuildContext context,
  ) {
    showSimpleNotification(
      Text(notification.title),
      leading: GestureDetector(
        onTap: () {
          StorageServices().handlePushNotificationClick(
            notification,
            context,
          );
        },
        child: CircleAvatar(
          backgroundImage: notification.image == null
              ? AssetImage(logo)
              : CachedNetworkImageProvider(
                  notification.image,
                ),
        ),
      ),
      subtitle: GestureDetector(
        onTap: () {
          StorageServices().handlePushNotificationClick(
            notification,
            context,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            notification.body,
          ),
        ),
      ),
      slideDismissDirection: DismissDirection.horizontal,
      background: primaryColor,
      duration: Duration(
        seconds: 10,
      ),
    );
  }

  showLoginSheet(
    AuthFormType initialAuthFormType,
    Function doAfterWards,
    BuildContext context,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        final _screenheight = MediaQuery.of(context).size.height;

        return SizedBox(
          height: _screenheight * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: Theme.of(context).canvasColor,
                elevation: 8,
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: 10,
                  width: 50,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      16,
                    ),
                    topRight: Radius.circular(
                      16,
                    ),
                  ),
                  child: Container(
                    color: Theme.of(context).canvasColor,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                      child: LoginSheet(
                        doAfterWards: doAfterWards,
                        initialAuthFormType: initialAuthFormType,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoginSheet extends StatefulWidget {
  final AuthFormType initialAuthFormType;
  final Function doAfterWards;

  LoginSheet({
    Key key,
    @required this.initialAuthFormType,
    @required this.doAfterWards,
  }) : super(key: key);

  @override
  _LoginSheetState createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  AuthFormType authFormType;
  TextEditingController userNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool processing = false;
  final formKey = GlobalKey<FormState>();
  String _email, _password, _warning;
  String _username = "${appName.capitalizeFirstOfEach} User";
  bool visible = false;
  String _switchButton, _submitButtonText;
  bool _showForgotPassword = false;

  @override
  void initState() {
    authFormType = widget.initialAuthFormType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenheight = MediaQuery.of(context).size.height;
    if (authFormType == AuthFormType.signIn) {
      _switchButton = "Create A New Account";
      _submitButtonText = "Log In";
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButton = "Return to Log In";
      _showForgotPassword = false;
      _submitButtonText = "Submit";
    } else {
      _switchButton = "Have an Account? Log In";
      _showForgotPassword = false;
      _submitButtonText = "Sign Up";
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BackBar(
              icon: null,
              onPressed: null,
              text: "",
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    authFormType == AuthFormType.signIn
                        ? "Log In"
                        : authFormType == AuthFormType.signUp
                            ? "Create Account"
                            : "Reset Password",
                    style: TextStyle(
                      fontSize: 30,
                      // color: altColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    ".",
                    style: TextStyle(color: primaryColor, fontSize: 40),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0.002 * _screenheight,
            ),
            _warning != null
                ? Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            _warning,
                            maxLines: 5,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                _warning = null;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 0.002 * _screenheight,
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (authFormType == AuthFormType.signUp)
                      TextFormField(
                        validator: UsernameValidator.validate,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        controller: userNameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Username",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onSaved: (value) => _username = value.trim(),
                      ),
                    if (authFormType != AuthFormType.reset)
                      SizedBox(height: 10),
                    TextFormField(
                      validator: EmailValidator.validate,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textInputAction: authFormType == AuthFormType.reset
                          ? TextInputAction.send
                          : TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Email",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        )),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onSaved: (value) => _email = value.trim(),
                    ),
                    SizedBox(height: 10),
                    if (authFormType != AuthFormType.reset)
                      TextFormField(
                        controller: passwordController,
                        validator: PasswordValidator.validate,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              !visible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  visible = !visible;
                                });
                              }
                            },
                          ),
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0)),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onSaved: (value) => _password = value.trim(),
                        obscureText: !visible,
                      ),
                    SizedBox(height: 10),
                    if (authFormType == AuthFormType.signUp)
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              !visible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  visible = !visible;
                                });
                              }
                            },
                          ),
                          hintText: "Confirm Password",
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0)),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        obscureText: !visible,
                      ),
                    if (authFormType != AuthFormType.reset)
                      Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          CustomDivider(),
                          ListTile(
                            title: Text(
                              "By signing in, you agree to the ${appName.capitalizeFirstOfEach} usage terms and conditions",
                            ),
                          ),
                          CustomDivider(),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () async {
                              const url = 'google.com';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                CommunicationServices().showToast(
                                  "Could not launch $url",
                                  primaryColor,
                                );
                                //throw '';
                              }
                            },
                            child: Text(
                              "Terms and conditions",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (processing) {
                            CommunicationServices().showSnackBar(
                                "Just a sec. Please wait.. (You can tap here to cancel and try again)",
                                context,
                                behavior: SnackBarBehavior.floating,
                                buttonText: "Cancel", whatToDo: () {
                              if (mounted) {
                                setState(() {
                                  processing = false;
                                });
                              }
                            });
                          } else {
                            if (authFormType == AuthFormType.signUp) {
                              if (passwordController.text.trim().isEmpty) {
                                final form = formKey.currentState;

                                form.save();
                                form.validate();
                              } else {
                                if (confirmPasswordController.text
                                    .trim()
                                    .isEmpty) {
                                  CommunicationServices().showSnackBar(
                                    "Please confirm your password",
                                    context,
                                    behavior: SnackBarBehavior.floating,
                                  );
                                } else {
                                  if (confirmPasswordController.text.trim() ==
                                      passwordController.text.trim()) {
                                    doIt();
                                  } else {
                                    CommunicationServices().showSnackBar(
                                      "Your password doesn't match. Please check on them.",
                                      context,
                                      behavior: SnackBarBehavior.floating,
                                    );
                                  }
                                }
                              }
                            } else {
                              doIt();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: processing
                              ? SpinKitWave(
                                  color: Colors.white,
                                  size: 25,
                                )
                              : Text(
                                  _submitButtonText,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                    if (_showForgotPassword)
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: primaryColor),
                          ),
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                authFormType = AuthFormType.reset;
                              });
                            }
                          },
                        ),
                      ),
                    TextButton(
                      child: Text(
                        _switchButton,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        if (authFormType == AuthFormType.reset) {
                          formKey.currentState.reset();
                          if (mounted) {
                            setState(() {
                              authFormType = AuthFormType.signIn;
                            });
                          }
                        } else {
                          if (authFormType == AuthFormType.signIn) {
                            formKey.currentState.reset();
                            if (mounted) {
                              setState(() {
                                authFormType = AuthFormType.signUp;
                              });
                            }
                          } else {
                            formKey.currentState.reset();
                            if (mounted) {
                              setState(() {
                                authFormType = AuthFormType.signIn;
                              });
                            }
                          }
                        }
                      },
                    ),
                  ], //buildInputs() + buildButtons(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  doIt() async {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      try {
        if (mounted) {
          setState(() {
            processing = true;
          });
        }
        final auth = AuthProvider.of(context).auth;

        if (authFormType == AuthFormType.signIn) {
          signIn();
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          _warning =
              "If there is an account linked to $_email, A password Reset link has been sent to $_email";
          if (mounted) {
            setState(
              () {
                authFormType = AuthFormType.signIn;
              },
            );
          }
        } else if (authFormType == AuthFormType.signUp) {
          signUp();
        }
      } catch (e) {
        processing = false;

        if (mounted) {
          setState(() {
            _warning = e.toString();
          });
        }
      }
    }
  }

  signUp() async {
    final auth = AuthProvider.of(context).auth;

    await auth
        .createUserWithEmailAndPassword(_email, _password, _username)
        .then((value) async {
      FirebaseMessaging.instance.getToken().then((token) {
        StorageServices().createNewUser(
          userName: _username.trim(),
          phoneNumber: null,
          images: [],
          token: token,
          uid: value,
          email: _email.trim(),
        );
      });

      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        CommunicationServices().showToast(
          "You need to give permissions to send notifications or else you'll miss out on a lot.",
          Colors.red,
        );
      }

      Navigator.of(context).pop();
      widget.doAfterWards();
    });
  }

  signIn() async {
    final auth = AuthProvider.of(context).auth;

    await auth.signInWithEmailAndPassword(_email, _password).then((value) {
      FirebaseMessaging.instance.getToken().then(
        (token) {
          StorageServices().updateFCMToken(
            value,
            token,
          );
        },
      );

      StorageServices().notifyAboutLogin(value);
    });

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      CommunicationServices().showToast(
        "You need to give permissions to send notifications or else you'll miss out on a lot.",
        Colors.red,
      );
    }

    Navigator.of(context).pop();
    widget.doAfterWards();
  }
}

class MySliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  MySliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(MySliverAppBarDelegate oldDelegate) {
    return false;
  }
}
