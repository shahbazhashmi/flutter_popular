import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class Db {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  String getDatabaseName();

  int getDatabaseVersion();

  void onCreateDatabase(Database db, int version);

  void onUpgradeDatabase(Database db, int oldVersion, int newVersion);

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, getDatabaseName());
    return await openDatabase(path,
        version: getDatabaseVersion(),
        onOpen: (db) {},
        onUpgrade: onUpgradeDatabase,
        onCreate: onCreateDatabase);
  }
}