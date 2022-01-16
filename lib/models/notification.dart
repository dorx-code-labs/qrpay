import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationModel {
  static const WELCOMETOMUSAWO = "welcomeToMusawo";

  static const ORDERSET = "orderSet";


  static const INBOXDOTLOCATION = "inboxDotLocation";
  static const CHATSDOTLOCATION = "chatsDotLocation";
  static const HOMENOTIFICATIONDOT = "homeDotLocation";
  static const FEEDNOTIFICATIONDOT = "feedDotLocation";
  static const DISCOUNTNOTIFICATIONDOT = "discountDotLocation";
  static const HOTNOTIFICATIONDOT = "hotDotLocation";
  static const NOTIFICATIONDOTLOCATION = "notificationDotLocation";
  static const NOTIFICATIONDOTPATH = "notificationDotPath";

  static const DIRECTORY = "notifications";
  static const NOTIFICATIONCOUNT = "notificationCount";

  static const DATE = "date";
  static const ID = "id";
  static const AMOUNT = "amount";
  static const REASON = "reason";
  static const TYPE = "type";
  static const GUEST = "guest";
  static const HOST = "host";
  //TODO: Specify these notification types
  static const HOSTORGUEST = "hostOrGuest";
  static const RECEPIENT = "recepient";
  static const SERVICEPROVIDER = "serviceProvider";
  static const PARTNER = "partner";
  static const CUSTOMER = "customer";
  static const SECONDARYID = "secondaryID";
  static const RESCHEDULER = "rescheduler";
  static const DELETER = "deleter";

  static const ORDERINDISPUTE = "orderInDispute";
  static const DISPUTERESOLVED = "disputeResolved";
  static const ORDERCOMPLETED = "orderCompleted";

  static const NEWFOOD = "newFood";
  static const NEWRECIPE = "newRecipe";
  static const NEWQUIZ = "newQuiz";
  static const NEWPOST = "newPost";
  static const NEWPACKAGE = "newPackage";
  static const DELETEDPACKAGE = "deletedPackage";
  static const POSTAPPROVED = "postApproved";
  static const NOTIFICATIONSDIRECTORY = "notifications";
  static const NEWDISCOUNTONFOOD = "newDiscountOnFood";
  static const CANCELLEDORDER = "canceledOrder";
  static const CANCELLEDBOOKING = "cancelledBooking";
  static const CANCELLEDBOOKINGREQUEST = "cancelledBookingRequest";
  static const NEWLOGIN = "newLogin";
  static const NEWRECIPEONYOURFOOD = "newRecipeOnYourFood";
  static const NEWCHAT = "newChat";
  static const POSTREJECTED = "postRejected";
  static const NEWFOODORDER = "newOrder";
  static const NEWRIDERREQUEST = "newRiderRequest";

  static const PENDINGTODELIVERING = "pendingToDelivering";
  static const RIDERACCEPTED = "riderAccepted";
  static const RIDERREJECTED = "riderRejected";
  static const DELIVERINGTOCOMPLETED = "deliveringToCompleted";
  static const PTOINDISPUTE = "deliveringToIndispute";
  static const INDISPUTETOPENDING = "indisputeToPending";

  int _time;
  String _recepient;
  String _notificationId;
  String _primaryId;
  String _secondaryId;
  String _reason;
  String _partnerId;
  String _customerId;
  String _serviceProviderId;
  String _rescheduler;
  String _deleter;
  String _notificationType;

  int get time => _time;
  // dynamic get amount => _amount;
  String get notificationId => _notificationId;
  String get partnerID => _partnerId;
  String get primaryId => _primaryId;
  String get reason => _reason;
  String get rescheduler => _rescheduler;
  String get serviceProviderId => _serviceProviderId;
  String get secondaryId => _secondaryId;
  String get customerID => _customerId;
  String get recepient => _recepient;
  String get deleter => _deleter;
  String get notificationType => _notificationType;

  NotificationModel.fromSnapshot(
    DocumentSnapshot snapshot,
    BuildContext context,
  ) {
    Map pp = snapshot.data() as Map;

    _notificationType = pp[TYPE];
    _time = pp[DATE];
    _primaryId = pp[ID];
    _reason = pp[REASON];
    _notificationId = snapshot.id;
    _recepient = pp[RECEPIENT];
    _partnerId = pp[PARTNER];
    _secondaryId = pp[SECONDARYID];
    _rescheduler = pp[RESCHEDULER];
    _customerId = pp[CUSTOMER];
    _serviceProviderId = pp[SERVICEPROVIDER];
    _deleter = pp[DELETER];
  }

  NotificationModel.fromData(
    String receiver,
    String type,
    DateTime time,
  ) {
    _recepient = receiver;
    _notificationType = type;
    _time = time.millisecondsSinceEpoch;
  }
}
