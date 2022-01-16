import 'package:flutter/material.dart';

class Statistic {
  static const DIRECTORY = "host_statistics";

  static const TOTALEARNINGS = "totalEarnings";
  static const BOOKINGREQUESTS = "bookingRequests";
  static const REVIEWS = "reviews";
  static const PROPERTIES = "properties";
  static const PRODUCTS = "products";
  static const UNIVERSITIES = "universities";

  String _key;
  String _name;
  Function _onTap;
  IconData _icon;
  Color _color;

  String get name => _name;
  String get key => _key;
  Function get onTap => _onTap;
  IconData get icon => _icon;
  Color get color => _color;

  Statistic.fromData(
    String name,
    String key,
    Function onTap,
    IconData icon,
    Color color,
  ) {
    _name = name;
    _icon = icon;
    _color = color;
    _onTap = onTap;
    _key = key;
  }
}
