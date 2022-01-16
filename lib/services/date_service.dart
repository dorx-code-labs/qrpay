import 'package:intl/intl.dart';

class DateService {
  String dateFromMilliseconds(milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    String day = DateFormat.E().format(dt);
    String rest = DateFormat.yMMMd().format(dt);

    String concat = "$day $rest";
    return concat;
  }

  int convertMillisecondsToNightCount(int milliseconds) {
    double dd = milliseconds / (24 * 60 * 60 * 1000);

    return dd.toInt();
  }

  String dateInNumbers(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime = DateFormat('EEEE d LLLL, y').format(dt);

    return formattedTime;
  }

  String timeIn24Hours(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime = DateFormat('HH:mm').format(dt);

    return formattedTime;
  }

  String monthInText(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime = DateFormat('LLLL').format(dt);

    return formattedTime;
  }

  String dayNumberInText(int milliseconds) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime = DateFormat('d').format(dt);

    return formattedTime;
  }
}
