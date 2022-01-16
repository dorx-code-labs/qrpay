import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrpay/core_views.dart/not_signed_in.dart';
import 'package:qrpay/services/auth_provider_widget.dart';

import 'loading_widget.dart';

// ignore: must_be_immutable
class OnlyWhenLoggedIn extends StatelessWidget {
  final Widget signedInView;
  final Function doOnceSignedIn;
  final dynamic notSignedIn;
  final dynamic loadingView;
  OnlyWhenLoggedIn({
    Key key,
    @required this.signedInView,
    this.doOnceSignedIn,
    this.loadingView,
    this.notSignedIn,
  }) : super(key: key);

  User user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthProvider.of(context).auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;

          if (signedIn) {
            if (doOnceSignedIn != null) {
              doOnceSignedIn();
            }

            return signedInView;
          } else {
            return notSignedIn ?? NotSignedInView();
          }
        } else {
          return loadingView ?? LoadingWidget();
        }
      },
    );
  }
}
