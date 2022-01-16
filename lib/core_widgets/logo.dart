import 'package:flutter/material.dart';
import 'package:qrpay/constants/basic.dart';
import 'package:qrpay/constants/images.dart';

  

class Logo extends StatelessWidget {
  final bool withString;
  final double wordSize;
  final double picSize;
  final bool withImage;
  Logo({
    Key key,
    @required this.withImage,
    this.picSize,
    this.wordSize,
    @required this.withString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: withImage != null && withImage,
          child: Image(
            fit: BoxFit.cover,
            height: picSize ?? MediaQuery.of(context).size.height * 0.22,
            image: AssetImage(
              logo,
            ),
          ),
        ),
        Visibility(
          visible: withString != null && withString,
          child: Text(
            appName,
            style: TextStyle(
              fontSize: wordSize ?? 30,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
