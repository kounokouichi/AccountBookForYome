import 'package:sqflite/sqflite.dart';
import 'package:yumechanaccountbook/data/household_account.dart';

class HouseholdAccountModel {
  static const String dbName = 'household_account';

  static Future<void> createTables(Database database) async {}

  static Future<Database> _db() async {
    return openDatabase(
      '$dbName.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(
    String date,
    int money,
    MoneyType moneyType,
    String tagId,
    String memo,
  ) async {
    final db = await _db();

    final data = {
      'date': date,
      'money': money,
      'income_or_expend_flag': moneyType.value,
      'tag_id': tagId,
      'memo': memo,
    };
    final id = await db.insert(dbName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // 家計簿テーブル取得（日付検索）
  static Future<List<HouseholdAccount>> getByDateOf(String date) async {
    final db = await _db();
    final queryResult = await db.query(
      dbName,
      where: "date = ?",
      whereArgs: [date],
      orderBy: "id",
    );
    return HouseholdAccount.fromList(queryResult);
  }

  // 家計簿テーブル全取得
  static Future<List<HouseholdAccount>> getNotes() async {
    final db = await _db();
    final queryResult = await db.query(dbName, orderBy: "id");
    return HouseholdAccount.fromList(queryResult);
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await _db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // static Future<int> updateItem(
  //     int id, String title, String? descrption) async {
  //   final db = await _db();

  //   final data = {
  //     'title': title,
  //     'description': descrption,
  //     'createdAt': DateTime.now().toString()
  //   };

  //   final result =
  //       await db.update('items', data, where: "id = ?", whereArgs: [id]);
  //   return result;
  // }

  // static Future<void> deleteItem(int id) async {
  //   final db = await _db();
  //   try {
  //     await db.delete("items", where: "id = ?", whereArgs: [id]);
  //   } catch (err) {}
  // }
}

enum MoneyType {
  income('0'),
  expend('1');

  const MoneyType(this.value);

  final String value;
}
