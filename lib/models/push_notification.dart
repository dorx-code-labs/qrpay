import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification.dart';

class PushNotification {
  String _title;
  String _body;
  String _thingID;
  String _image;
  String _thingType;
  // String _notificationType;
  String _secondaryId;

  PushNotification.fromRemoteMessage(RemoteMessage initialMessage) {
    _title = initialMessage.notification?.title;
    _body = initialMessage.notification?.body;
    _image = initialMessage.notification.android.imageUrl;
    _thingType = initialMessage.data["thingType"];
    _thingID = initialMessage.data["thingID"];
    _secondaryId = initialMessage.data[NotificationModel.SECONDARYID];
  }

  String get title => _title;
  String get image => _image;
  String get body => _body;
  String get secondaryId => _secondaryId;
//  String get notificationType => _notificationType;
  String get thingType => _thingType;
  String get thingID => _thingID;
}
