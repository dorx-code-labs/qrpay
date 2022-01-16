import 'package:cloud_firestore/cloud_firestore.dart';

class CardServices {
  String collection = "cards";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createCard(
      {String holderName,
      String id,
      String userId,
      // ignore: non_constant_identifier_names
      int exp_month,
      // ignore: non_constant_identifier_names
      int exp_year,
      int last4}) {
    _firestore
        .collection(collection)
        .doc(userId)
        .collection(userId)
        .doc(id)
        .set({
      "id": id,
      "userId": userId,
      "exp_month": exp_month,
      "timeAdded": DateTime.now().millisecondsSinceEpoch,
      "exp_year": exp_year,
      "last4": last4,
      "holderName": holderName
    });
  }

  void updateDetails(
      Map<String, dynamic> values, String userId, String cardID) {
    _firestore
        .collection(collection)
        .doc(userId)
        .collection(userId)
        .doc(cardID)
        .update(values);
  }

  void deleteCard(Map<String, dynamic> values, String userId, String cardID) {
    _firestore
        .collection(collection)
        .doc(userId)
        .collection(userId)
        .doc(cardID)
        .delete();
  }
}
