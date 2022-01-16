import 'package:qrpay/constants/basic.dart';
import 'package:qrpay/constants/images.dart';
import 'package:qrpay/core_widgets/custom_divider.dart';
import 'package:qrpay/core_widgets/top_back_bar.dart';
import 'package:qrpay/services/text_service.dart';
import 'package:flutter/material.dart';

import 'package:qrpay/theming/theme_controller.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
class AboutUs extends StatefulWidget {
  AboutUs({
    Key key,
  }) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              BackBar(
                icon: null,
                onPressed: null,
                text: "About Us",
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  height: 100,
                                  image: AssetImage(logo),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        appName.capitalizeFirstOfEach,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.purple,
                                          fontSize: 25,
                                        ),
                                      ),
                                      Text(
                                        ".",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Version $versionNumber",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  height: 100,
                                  image: AssetImage(
                                    ThemeBuilder.of(context)
                                                .getCurrentTheme() ==
                                            Brightness.dark
                                        ? niranLogoLight
                                        : niranLogo,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "NIRAN",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.purple,
                                          fontSize: 25,
                                        ),
                                      ),
                                      Text(
                                        ".",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Code Lab",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        appCatchPhrase,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(Icons.info_outline),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        title: Text("About ${appName.capitalizeFirstOfEach}"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              width: 80,
                                              height: 80,
                                              image: AssetImage(logo),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              appName.capitalizeFirstOfEach,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              niranMessage,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "-Niran",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Credit to Huy Hoang Nyugen on Rive for the animated theme switch.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "https://rive.app/a/hoangnguyen/files/recent/all",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        niranCredits,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "- designed by Niran Code Lab",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDivider(),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                        ),
                        title: Text(
                          "Contact the Developer",
                        ),
                        onTap: () async {
                          final Email email = Email(
                            body: 'Hello',
                            subject: 'Hello, Niran',
                            recipients: ['nirancodelab@gmail.com'],
                            isHTML: false,
                          );

                          await FlutterEmailSender.send(email);
                        },
                      ),
                      CustomDivider()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
