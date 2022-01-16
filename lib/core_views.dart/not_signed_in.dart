import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrpay/constants/images.dart';
import 'package:qrpay/services/ui_services.dart';

  

class NotSignedInView extends StatefulWidget {
  NotSignedInView({
    Key key,
  }) : super(key: key);

  @override
  _NotSignedInViewState createState() => _NotSignedInViewState();
}

class _NotSignedInViewState extends State<NotSignedInView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                loginSvg,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "This page is only accessible when logged in. Please log in.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  UIServices().showLoginSheet(AuthFormType.signIn, (){}, context,);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1)),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
