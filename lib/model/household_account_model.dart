import 'package:sqflite/sqflite.dart';
import 'package:yumechanaccountbook/data/household_account.dart';
import 'package:yumechanaccountbook/model/common_model.dart';

class HouseholdAccountModel {
  /// 家計簿を作成する
  static Future<int> createItem(
    String date,
    int money,
    MoneyType moneyType,
    int tagId,
    String memo,
  ) async {
    final db = await CommonModel.db();

    final data = {
      'date': date,
      'money': money,
      'income_or_expend_flag': moneyType.value,
      'tag_id': tagId,
      'memo': memo,
    };
    final id = await db.insert(
      CommonModel.tableNameHouseHoldAccount,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  /// 家計簿を更新する
  static Future<int> updateItem(
    String accountId,
    String date,
    int money,
    MoneyType moneyType,
    int tagId,
    String memo,
  ) async {
    final db = await CommonModel.db();

    final data = {
      'date': date,
      'money': money,
      'income_or_expend_flag': moneyType.value,
      'tag_id': tagId,
      'memo': memo,
    };
    final id = await db.update(
      CommonModel.tableNameHouseHoldAccount,
      data,
      where: 'id = ?',
      whereArgs: [accountId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  /// 家計簿を削除する
  static Future<int> deleteItem(String accountId) async {
    final db = await CommonModel.db();

    final id = await db.delete(
      CommonModel.tableNameHouseHoldAccount,
      where: 'id = ?',
      whereArgs: [accountId.toString()],
    );
    return id;
  }

  /// 家計簿テーブル取得（日付検索）
  static Future<List<HouseholdAccount>> getByDateOf(String date) async {
    final db = await CommonModel.db();
    final queryResult = await db.rawQuery('''
        select * 
        from
           ${CommonModel.tableNameHouseHoldAccount} h
           inner join ${CommonModel.tableNameTag} t
           on h.tag_id = t.id
        where
          h.date like '$date%'
        order by h.id
      ''');
    print('getByDateOf ¥n$queryResult');

    return HouseholdAccount.fromList(queryResult);
  }

  /// 家計簿テーブル取得（日付検索）
  static Future<List<HouseholdAccount>> getTagByDateOf(String date) async {
    final db = await CommonModel.db();
    final queryResult = await db.rawQuery('''
        select distinct tag_id ,name
        from
           ${CommonModel.tableNameHouseHoldAccount} h
           inner join ${CommonModel.tableNameTag} t
           on h.tag_id = t.id
        where
          h.date like '$date%'
        order by h.id
      ''');
    print('getTagByDateOf ¥n$queryResult');

    return HouseholdAccount.fromList(queryResult);
  }
}

enum MoneyType {
  income('0'),
  expend('1');

  const MoneyType(this.value);

  final String value;
}
