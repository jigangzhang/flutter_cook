import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cook/entity/cook_bean.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  // ignore: non_constant_identifier_names
  static final int TYPE_HISTORY = 1;

  // ignore: non_constant_identifier_names
  static final int TYPE_COLLECT = 2;

  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  Database _db;
  String _dbName = 'cookbook.db';
  String _tableName = 'cookbook';
  String _columnMenuId = 'menuId';
  String _columnName = 'name';
  String _columnImage = 'thumbnail';
  String _columnCtg = 'ctgTitles';
  String _columnType = 'type'; //1 - 历史记录； 2 - 收藏；

  Future<Database> get db async {
    if (_db == null) _db = await _initDB();
    return _db;
  }

  Future<Database> _initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, $_columnMenuId TEXT, '
        '$_columnName TEXT, $_columnImage TEXT, $_columnCtg TEXT, $_columnType INTEGER)');
  }

  Future<int> collectCookbook(Cookbook cookbook) async {
    int result;
    var database = await db;
    var list = await database.query(_tableName,
        where: '$_columnMenuId = ? and $_columnType = $TYPE_COLLECT',
        whereArgs: [cookbook.menuId]);
    if (list != null && list.length == 0) {
      var map = cookbook.toMap();
      map[_columnType] = TYPE_COLLECT;
      result = await database.insert(_tableName, map);
    } else
      result = 200;
    close(database);
    return result;
  }

  Future<int> saveCookbook(Cookbook cookbook) async {
    //事务
    int result;
    var database = await db;
    var list = await database.query(_tableName,
        where: '$_columnMenuId = ? and $_columnType = $TYPE_HISTORY',
        whereArgs: [cookbook.menuId]);
    if (list != null && list.length > 0) {
      result = 200;
    } else {
      var map = cookbook.toMap();
      map[_columnType] = TYPE_HISTORY;
      result = await database.insert(_tableName, map);
    }
    close(database);
    return result;
  }

  Future<int> deleteCookbook(String menuId, int type) async {
    var database = await db;
    int result = await database.delete(_tableName,
        where: '$_columnMenuId = ? and $_columnType = ?',
        whereArgs: [menuId, type]);
    close(database);
    return result;
  }

  deleteAll(int type) async {
    var database = await db;
    int result = await database
        .delete(_tableName, where: '$_columnType = ?', whereArgs: [type]);
    close(database);
    return result;
  }

  updateCookbook(String menuId, Cookbook cookbook) async {
    var database = await db;
    int result = await database.update(_tableName, cookbook.toMap(),
        where: '$_columnMenuId = ?', whereArgs: [menuId]);
    close(database);
  }

  Future<List<Map<String, dynamic>>> queryCookbook(
      String menuId, int type) async {
    var database = await db;
    var list = await database.query(_tableName,
        where: '$_columnMenuId = ? and $_columnType = ?',
        whereArgs: [menuId, type]);
    close(database);
    return list;
  }

  Future<List<Map<String, dynamic>>> queryAll(int type) async {
    var database = await db;
    var list = await database
        .query(_tableName, where: '$_columnType = ?', whereArgs: [type]);
    close(database);
    return list;
  }

  close(var database) async {
    _db = null;
    return database.close();
  }
}
