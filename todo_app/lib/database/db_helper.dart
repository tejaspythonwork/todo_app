import 'dart:async';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modal/task.dart';

class DBHelper {
  Database? _db;
  int? version = 1;
  String tableName = 'task_todo';

  Future<Database?> get myDB async {
    _db = await init();

    if (_db == null) {
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database?> init() async {
    try {
      String path = '${await getDatabasesPath()}tasktodo.db';
      _db = await openDatabase(path,
          version: version, onCreate: onCreate, onUpgrade: onUpgrade);
      log('Database Created');
    } catch (e) {
      log('Error in initialize database ${e.toString()}');
    }

    return _db;
  }

  Future<void> onCreate(Database db, int version) async {
    try {
      String sql =
          '''create table $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,
        title Text,
        note Text,
        isCompleted INTEGER,
        date Text,
        startTime Text,
        endTime Text,
        color INTEGER, 
        remind INTEGER,
        repeat String)''';

      await db.execute(sql);
      log('onCreate called');
    } catch (e) {
      log('Error in onCreate method - ${e.toString()}');
    }
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    log('On Upgrade Called');
  }

  insert(Task? task) async {
    try {
      Database? db = await myDB;
      await db?.insert(tableName, task!.toMap());
    } catch (e) {
      log('Error in insert method - ${e.toString()}');
    }
  }

  deleteAll() async {
    try {
      Database? db = await myDB;
      await db?.delete(tableName);
    } catch (e) {
      log('Error in deleteAll method - ${e.toString()}');
    }
  }

  deleteSingleData(int id) async {
    try {
      Database? db = await myDB;
      await db?.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error in deleteSingleData method - ${e.toString()}');
    }
  }

  updateData(int id) async {
    try {
      Database? db = await myDB;
      await db?.rawUpdate(
        'update $tableName set isCompleted = ? where id = ? ',
        [1, id],
      );
    } catch (e) {
      log('Error in updateData method - ${e.toString()} ');
    }
  }

  Future<List<Map<String, Object?>>?> displayData() async {
    try {
      Database? db = await myDB;
      return await db?.query(tableName);
    } catch (e) {
      log('Error in display data - ${e.toString()}');
      return [];
    }
  }
}
