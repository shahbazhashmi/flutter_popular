import 'dart:convert';

import 'package:core/utils/core_utils.dart';
import 'package:datasource/database/db.dart';
import 'package:flutter_popular/db/db_contract.dart';
import 'package:sqflite/sqflite.dart';

import '../config/config.dart';

class DBProvider extends Db {
  DBProvider._();

  static DBProvider getInstance() {
    return DBProvider._();
  }

  @override
  String getDatabaseName() => 'app.db';

  @override
  int getDatabaseVersion() => 1;

  @override
  void onCreateDatabase(Database db, int version) {
    initOfflineTable(db);
  }

  @override
  void onUpgradeDatabase(Database db, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {
      alterOfflineTable(db);
    }
    onCreateDatabase(db, newVersion);
  }


  alterOfflineTable(Database db) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${OfflineDataEntry.tableName} ("
            "${OfflineDataEntry.columnNameId} TEXT PRIMARY KEY,"
            "${OfflineDataEntry.columnNameData} Uint8List,"
            "${OfflineDataEntry.columnNameLastUpdated} INTEGER"
            ")");
  }

  initOfflineTable(Database db) async {
    await db.execute("CREATE TABLE ${OfflineDataEntry.tableName} ("
        "${OfflineDataEntry.columnNameId} TEXT PRIMARY KEY,"
        "${OfflineDataEntry.columnNameData} Uint8List,"
        "${OfflineDataEntry.columnNameLastUpdated} INTEGER"
        ")");
  }
}

enum OfflineDataType {
  movies
}

class OfflineDataHelper {
  OfflineDataHelper._(this.offlineDataType);

  final OfflineDataType offlineDataType;

  static OfflineDataHelper getInstance(OfflineDataType offlineDataType) {
    return OfflineDataHelper._(offlineDataType);
  }

  insertData(String data) async {
    final db = await DBProvider.getInstance().database;
    final timestamp = CoreUtils.getCurrentTimeStamp();

    var res = await db.rawInsert(
        "INSERT OR REPLACE Into ${OfflineDataEntry.tableName} (${OfflineDataEntry.columnNameId}, ${OfflineDataEntry.columnNameData}, ${OfflineDataEntry.columnNameLastUpdated})"
            " VALUES ('${offlineDataType.name}', '$data', '$timestamp')");
    return res;
  }

  Future<dynamic> getData() async {
    final db = await DBProvider.getInstance().database;

    /// check if record is not older than x hours
    var expiryTimestamp = CoreUtils.getCurrentTimeStamp() -
        Config.moviesDataExpiryThreshold;
    var res = await db.query(OfflineDataEntry.tableName,
        where:
        "${OfflineDataEntry.columnNameId} >= ? AND ${OfflineDataEntry.columnNameLastUpdated} >= ?",
        whereArgs: [offlineDataType.name, expiryTimestamp]);
    return res.isNotEmpty
        ? jsonDecode(
        res.first[OfflineDataEntry.columnNameData] as String)
        : null;
  }
}