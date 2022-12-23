import 'dart:async';
import 'package:horno/database/index.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbApp {
  static const _databaseName = 'bake';
  static const _dbVersion = 1;

  DbApp._privateConstructor();

  static final DbApp instance = DbApp._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(DBOrders.createTable());
    await db.execute(DBDetails.createTable());
  }

  Future deleteDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);

    databaseFactory.deleteDatabase(path);
  }
}
