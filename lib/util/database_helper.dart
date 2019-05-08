import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

//sqlite数据库管理
class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  final _lock = new Lock(); //同步

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    await _lock.synchronized(() async{
      if (_db != null) {
        return _db;
      }
      _db = await initDb();
    });
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'db.sqlite');

    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "db.sqlite"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);

    } else {
      print("Opening existing database");
    }

    var ourDb = await openDatabase(path);
    return ourDb;
  }




}