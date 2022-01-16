import 'package:flutter/material.dart';

import 'custom_dialog_box.dart';

class NotLoggedInDialogBox extends StatelessWidget {
  const NotLoggedInDialogBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(
      showSignInButton: true,
      bodyText: null,
      buttonText: null,
      onButtonTap: null,
      showOtherButton: false,
    );
  }
}
