import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:yumechanaccountbook/data/household_account.dart';
import 'package:yumechanaccountbook/data/tag/tag.dart';
import 'package:yumechanaccountbook/enum/bool_type.dart';

class CommonModel {
  static const String tableNameHouseHoldAccount = 'HOUSEHOLD_ACCOUNT';
  static const String tableNameTag = 'TAG';

  static Future<void> _createTables(Database database) async {
    await database.execute("""
        CREATE TABLE $tableNameHouseHoldAccount(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          date TEXT NOT NULL,
          money INTEGER NOT NULL DEFAULT 0,
          income_or_expend_flag TEXT NOT NULL DEFAULT '0',
          tag_id INTEGER NOT NULL,
          memo TEXT DEFAULT '',
          stamp_id TEXT DEFAULT 0
        )
      """);
    await database.execute("""
        CREATE TABLE $tableNameTag(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT NOT NULL,
          color TEXT,
          sort INTEGER NOT NULL,
          invisible INTEGER DEFAULT 0
        )
      """);
    if (!kIsWeb) {
      // webやと通ってくれない
      await database.rawInsert(
          'INSERT INTO tag(name, color, sort) VALUES("食費", null, 10)');
      await database.rawInsert(
          'INSERT INTO tag(name, color, sort) VALUES("雑費", null, 20)');
      await database.rawInsert(
          'INSERT INTO tag(name, color, sort) VALUES("外食費", null, 30)');
    }
  }

  static Future<Database> db() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    return openDatabase(
      'household_account.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await _createTables(database);
      },
    );
  }
}
