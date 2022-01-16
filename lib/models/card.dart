import 'dart:ui';

import 'transaction.dart';

class CreditCard {
  List<Color> colors;
  String bank;
  String name;
  String ccNumber;
  String ccDate;

  List<Transaction> listTransactions;

  CreditCard(this.colors, this.bank, this.name, this.ccNumber, this.ccDate) {
    listTransactions = [];
  }

  void addTransaction(Transaction transaction) {
    listTransactions.add(transaction);
  }

  List<Transaction> getTransactions() {
    return listTransactions;
  }
}
