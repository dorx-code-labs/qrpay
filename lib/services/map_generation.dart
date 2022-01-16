import 'package:qrpay/models/notification.dart';
import 'package:qrpay/models/user.dart';

import 'sq_lite_services.dart';

class MapGeneration {
 
  generateUserMap(
    UserModel user,
  ) {
    return {
      UserModel.PHONENUMBER: user.phoneNumber,
      UserModel.USERNAME: user.userName,
      UserModel.PROFILEPIC: user.profilePic,
      UserModel.EMAIL: user.email,
      UserModel.IMAGES: user.images,
    };
  }

  generateSearchHistoryMap(String text) {
    return {
      SearchHistorySQFLiteServices.SEARCHHISTORYTEXT: text,
      SearchHistorySQFLiteServices.TIMESEARCHED:
          DateTime.now().millisecondsSinceEpoch,
    };
  }

  generateNotificationMap(NotificationModel not) {
    return {
      NotificationModel.TYPE: not.notificationType,
      NotificationModel.DATE: not.time,
      NotificationModel.ID: not.primaryId,
      NotificationModel.REASON: not.reason,
      NotificationModel.RECEPIENT: not.recepient,
      NotificationModel.PARTNER: not.partnerID,
      NotificationModel.SECONDARYID: not.secondaryId,
      NotificationModel.RESCHEDULER: not.rescheduler,
      NotificationModel.CUSTOMER: not.customerID,
      NotificationModel.SERVICEPROVIDER: not.serviceProviderId,
      NotificationModel.DELETER: not.deleter,
    };
  }
}
