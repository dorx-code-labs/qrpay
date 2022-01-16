
import 'package:qrpay/services/sq_lite_services.dart';

class SearchHistory {
  String _text;
  int _time;

  String get text => _text;
  int get time => _time;

  SearchHistory.fromMap(Map mp) {
    _text = mp[SearchHistorySQFLiteServices.SEARCHHISTORYTEXT];
    _time = mp[SearchHistorySQFLiteServices.TIMESEARCHED];
  }

  toMap() {
    return {
      SearchHistorySQFLiteServices.SEARCHHISTORYTEXT: _text,
      SearchHistorySQFLiteServices.TIMESEARCHED: _time,
    };
  }
}
