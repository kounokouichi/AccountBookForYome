import 'package:sqflite/sqflite.dart';
import 'package:yumechanaccountbook/data/household_account.dart';
import 'package:yumechanaccountbook/data/tag/tag.dart';

class HouseholdAccountModel {
  static const String dbName = 'household_account';

  static Future<void> createTables(Database database) async {
    await database.execute("""
        CREATE TABLE $dbName(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          date TEXT NOT NULL,
          money INTEGER NOT NULL DEFAULT '0',
          income_or_expend_flag TEXT NOT NULL DEFAULT '0',
          tag_id INTEGER NOT NULL,
          memo TEXT DEFAULT '',
          stamp_id TEXT DEFAULT '0'
        )
      """);
    await database.execute("""
        CREATE TABLE tag(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT NOT NULL,
          color TEXT,
          sort INTEGER NOT NULL,
          invisible INTEGER 0
        )
      """);
    await database
        .rawInsert('INSERT INTO tag(name, color, sort) VALUES("食費", null, 10)');
    await database
        .rawInsert('INSERT INTO tag(name, color, sort) VALUES("雑費", null, 20)');
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
    int tagId,
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
    print('getByDateOf');
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
    print('getTagByDateOf');
    print(queryResult);

    return HouseholdAccount.fromList(queryResult);
  }

  // 家計簿テーブル取得（日付検索）
  static Future<List<Tag>> getAlalTag() async {
    final db = await _db();
    final queryResult = await db.rawQuery('''
        select * from tag t order by t.id
      ''');
    print('getAllTag');

    return Tag.fromList(queryResult);
  }

  // 家計簿テーブル取得（日付検索）
  static Future<List<Tag>> getVisibleTag() async {
    final db = await _db();
    final queryResult = await db.rawQuery('''
        select * from tag t where t.inVisible = 0 order by t.id
      ''');
    print('getAllTag');

    return Tag.fromList(queryResult);
  }

  static Future<List<Tag>> checkTagName(String name) async {
    final db = await _db();
    final queryResult = await db.rawQuery('''
        select distinct t.inVisible from tag t where t.name = $name
      ''');
    return Tag.fromList(queryResult);
  }

  static void insertTag(String name) async {
    final db = await _db();

    final queryResult = await db.rawQuery('''
        select distinct max(t.sort) from tag t 
      ''');
    final result = Tag.fromList(queryResult);
    var values = <String, dynamic>{
      "name": name,
      "color": null,
      "sort": result.first.sort + 10,
    };
    await db.insert("tag", values);
    print('insertTag');
  }

  static Future<void> updateTag(int id) async {
    final db = await _db();
    final data = {'inVisible': 0};
    await db.update('tag', data, where: "id = ?", whereArgs: [id]);
    print('updateTag');
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
