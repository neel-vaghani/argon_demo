import 'dart:core';
import 'package:argon_demo/module/home/dependencies/home_dependencies.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_string_const.dart';

class DB {
  Database? _db;
  int version = 2;
  // Get the dataBase
  Future<Database> get _getDb async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    var dd = await _db?.batch();
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, DbStringConst.DATABASE_NAME);
    // Open the database
    var db = await openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
    );
    return db;
  }

  // creating the database
  _onCreate(Database db, int version) async {
    // CREATE TRANSACTION TABLE
    await db.execute("""CREATE TABLE ${DbStringConst.REPO_TABLE_NAME} (
          ${DbStringConst.REPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          ${DbStringConst.REPO_NAME} TEXT,
          ${DbStringConst.REPO_DESCRIPTION} TEXT,
          ${DbStringConst.REPO_WATCHERS_COUNT} INTEGER,
          ${DbStringConst.REPO_LANGUAGE} TEXT,
          ${DbStringConst.REPO_OPEN_ISSUE} INTEGER     
          )""");
  }

  Future<List<Map<String, Object?>>> query(String table,
      {List<String>? columns}) async {
    Database dbClient = await _getDb;
    return await dbClient.query(table, columns: columns);
  }

  Future<int> insert(String table, Map<String, dynamic> item) async {
    Database dbClient = await _getDb;
    return await dbClient.insert(table, item);
  }

  Future<void> deleteEverything() async {
    Batch batch = await getBatch;
    batch.rawDelete("""DELETE FROM ${DbStringConst.REPO_TABLE_NAME}""");

    await batch.commit();
  }

  /// get batch object for this database
  Future<Batch> get getBatch async {
    Database dbClient = await _getDb;
    return dbClient.batch();
  }
}
