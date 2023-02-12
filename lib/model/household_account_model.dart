import 'package:sqflite/sqflite.dart';
import 'package:yumechanaccountbook/data/household_account.dart';

class HouseholdAccountModel {
  static const String dbName = 'household_account';

  static Future<void> createTables(Database database) async {
    await database.execute("""
        CREATE TABLE $dbName(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          date TEXT NOT NULL,
          money INTEGER NOT NULL DEFAULT '0',
          income_or_expend_flag TEXT NOT NULL DEFAULT '0',
          tag_id TEXT NOT NULL,
          memo TEXT DEFAULT '',
          stamp_id TEXT DEFAULT '0'
        )
      """);
    await database.execute("""
        CREATE TABLE tag(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT NOT NULL,
          color TEXT,
          sort INTEGER NOT NULL
        )
      """);
    await database
        .rawInsert('INSERT INTO tag(name, color, sort) VALUES("食費", null, 10)');
    await database
        .rawInsert('INSERT INTO tag(name, color, sort) VALUES("雑費", null, 10)');
    await database.rawInsert(
        'INSERT INTO tag(name, color, sort) VALUES("外食費", null, 30)');
    // TODO:タグテーブルのレコードも作成
  }

  static Future<Database> _db() async {
    // TODO:ここらへんにいい感じにtagテーブルを追加
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
    final queryResult = await db.rawQuery('''
        select * 
        from
           $dbName h
           inner join tag t
           on h.tag_id = t.id
        where
          h.date like '$date%'
        order by h.id
      ''');
    print(queryResult);

    return HouseholdAccount.fromList(queryResult);
  }

  // 家計簿テーブル取得（日付検索）
  static Future<List<HouseholdAccount>> getTagByDateOf(String date) async {
    final db = await _db();
    final queryResult = await db.rawQuery('''
        select distinct tag_id ,name
        from
           $dbName h
           inner join tag t
           on h.tag_id = t.id
        where
          h.date like '$date%'
        order by h.id
      ''');
    print(queryResult);

    return HouseholdAccount.fromList(queryResult);
  }

  // テーブル取得（日付検索）
  static void getBytag() async {
    final db = await _db();
    final queryResult = await db.rawQuery('''
        select * 
        from $dbName
      ''');
    print(queryResult);
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
