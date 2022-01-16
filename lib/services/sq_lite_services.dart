import 'package:qrpay/constants/basic.dart';
import 'package:qrpay/models/search_history.dart';
import 'package:qrpay/services/map_generation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String searchHistoryTable = 'searchHistory';

class SearchHistorySQFLiteServices {
  static const SEARCHHISTORYTEXT = "text";
  static const TIMESEARCHED = "time";

  //doing this so that the phone doesn't have to create a new instance of sqflite service each time
  static final SearchHistorySQFLiteServices _sqLiteServices =  SearchHistorySQFLiteServices.internal();
  factory SearchHistorySQFLiteServices() => _sqLiteServices;
  SearchHistorySQFLiteServices.internal();

  static Database _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), '${appName}_database.db'),
      version: 1,
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute('''
          create table $searchHistoryTable (
          $TIMESEARCHED int primary key,
          $SEARCHHISTORYTEXT text)
        ''');
      },
    );
  }

  Future<dynamic> getPreviousStuff() async {
    var db = await database;
    var result = await db.query(searchHistoryTable, orderBy: TIMESEARCHED);
    return result;
  }

  Future<bool> saveSearchHistory(String history) async {
    var db = await database;

    await db.insert(
      searchHistoryTable,
      MapGeneration().generateSearchHistoryMap(history),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  }

  Future<List<SearchHistory>> getPreviousHistory() async {
    List<SearchHistory> _history = [];

    var db = await database;
    var result = await db.query(searchHistoryTable, orderBy: TIMESEARCHED);

    for (var item in result) {
      SearchHistory history = SearchHistory.fromMap(item);
      _history.add(history);
    }

    return _history;
  }

  Future<int> deleteSpecificHistory(int id) async {
    var db = await database;
    return await db.delete(searchHistoryTable,
        where: '$TIMESEARCHED = ?', whereArgs: [id]);
  }

  Future<bool> clearTable() async {
    List<SearchHistory> _history = await getPreviousHistory();

    for (var element in _history) {
      deleteSpecificHistory(element.time);
    }

    return true;
  }

  Future<void> updateSpecificHistory(SearchHistory history) async {
    final db = await database;

    await db.update(
      searchHistoryTable,
      history.toMap(),
      where: "id = ?",
      whereArgs: [history.time],
    );
  }
}