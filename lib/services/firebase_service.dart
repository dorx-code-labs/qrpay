import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrpay/constants/ui.dart';
import 'package:qrpay/models/notification.dart';
import 'package:qrpay/models/push_notification.dart';
import 'package:qrpay/models/statistic.dart';
import 'package:qrpay/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'map_generation.dart';

class StorageServices {
 
 
  createNewUser({
    @required String token,
    @required String phoneNumber,
    @required String email,
    @required String uid,
    @required String userName,
    @required List images,
  }) {
    UserModel user = UserModel.fromData(
      phoneNumber: phoneNumber,
      username: userName,
      profilePic: images.isEmpty ? null : images[0],
      email: email,
      images: images,
    );

    FirebaseFirestore.instance
        .collection(UserModel.DIRECTORY)
        .doc(uid)
        .set(
          MapGeneration().generateUserMap(user),
        )
        .then(
      (value) {
        updateFCMToken(
          uid,
          token,
        );

        updateLastLogin(uid);

        NotificationModel not = NotificationModel.fromData(
          uid,
          NotificationModel.WELCOMETOMUSAWO,
          DateTime.now(),
        );

        FirebaseFirestore.instance
            .collection(NotificationModel.DIRECTORY)
            .doc(uid)
            .collection(uid)
            .add(
              MapGeneration().generateNotificationMap(
                not,
              ),
            );
      },
    );
  }

  increaseStatistic(String top, String user) {
    FirebaseDatabase.instance
        .reference()
        .child(Statistic.DIRECTORY)
        .child(top)
        .child(user)
        .once()
        .then(
      (vav) {
        FirebaseDatabase.instance
            .reference()
            .child(Statistic.DIRECTORY)
            .child(top)
            .update(
          {
            user: vav.value == null ? 1 : vav.value + 1,
          },
        );
      },
    );
  }

  void increaseNotification(String loc) {
    FirebaseDatabase.instance
        .reference()
        .child("notificationCount")
        .child(loc)
        .once()
        .then(
      (vav) {
        FirebaseDatabase.instance.reference().child("notificationCount").update(
          {
            loc: vav.value == null ? 1 : vav.value + 1,
          },
        );
      },
    );
  }

  increaseCount(String top, String user) {
    FirebaseDatabase.instance.reference().child(top).child(user).once().then(
      (vav) {
        FirebaseDatabase.instance.reference().child(top).update(
          {
            user: vav.value == null ? 1 : vav.value + 1,
          },
        );
      },
    );
  }

  int getPrice(String priceText, {double deMoney}) {
    int price = deMoney == null
        ? double.parse(priceText.trim()).toInt()
        : deMoney.toInt();

    int pricetoShow = price;

    return pricetoShow;
  }

 Future<bool> checkIfOnboardingWasDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool finishedOnBoarding = prefs.getBool(
          sharedPrefDoneWithOnBoarding,
        ) ??
        false;
    return finishedOnBoarding;
  }

  decreaseCount(String top, String user) {
    FirebaseDatabase.instance.reference().child(top).child(user).once().then(
      (vav) {
        FirebaseDatabase.instance.reference().child(top).update(
          {
            user: vav.value == null || vav.value == 0 ? 0 : vav.value - 1,
          },
        );
      },
    );
  }


  removeFCMToken(String userID) {
    FirebaseDatabase.instance.reference().child(UserModel.FCMTOKENS).update({
      userID: null,
    });

    updateLastLogout(userID);
  }

  updateFCMToken(String userID, String token) {
    FirebaseDatabase.instance.reference().child(UserModel.FCMTOKENS).update({
      userID: token,
    });

    updateLastLogin(userID);
  }

  handlePushNotificationClick(
    PushNotification notification,
    BuildContext context,
  ) {
    if (notification.thingType != null) {
    } else {}
  }

  updateLastLogin(String uid) {
    FirebaseDatabase.instance
        .reference()
        .child(UserModel.LASTLOGINTIME)
        .child(uid)
        .update({
      DateTime.now().millisecondsSinceEpoch.toString(): true,
    });
  }

  updateLastLogout(String uid) {
    FirebaseDatabase.instance
        .reference()
        .child(UserModel.LASTLOGOUTTIME)
        .child(uid)
        .update({
      DateTime.now().millisecondsSinceEpoch.toString(): true,
    });
  }

  notifyAboutLogin(
    String uid,
  ) {
    NotificationModel not = NotificationModel.fromData(
      uid,
      NotificationModel.NEWLOGIN,
      DateTime.now(),
    );

    sendInAppNotification(not);
  }

  sendInAppNotification(NotificationModel notificationModel) {
    FirebaseFirestore.instance
        .collection(NotificationModel.DIRECTORY)
        .doc(notificationModel.recepient)
        .collection(notificationModel.recepient)
        .add(
          MapGeneration().generateNotificationMap(
            notificationModel,
          ),
        );
  }
}
