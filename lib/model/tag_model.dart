import 'package:yumechanaccountbook/data/tag/tag.dart';
import 'package:yumechanaccountbook/enum/bool_type.dart';
import 'package:yumechanaccountbook/model/common_model.dart';

class TagModel {
  /// 全てのタグを取得する
  static Future<List<Tag>> getAllTag() async {
    final db = await CommonModel.db();
    final queryResult = await db.rawQuery('''
        select * from ${CommonModel.tableNameTag} t order by t.id
      ''');
    print('getAllTag ¥n$queryResult');

    return Tag.fromList(queryResult);
  }

  /// 表示可能なタグを取得する
  static Future<List<Tag>> getVisibleTag() async {
    final db = await CommonModel.db();
    final queryResult = await db.rawQuery('''
        select * from ${CommonModel.tableNameTag} t where t.inVisible = 0 order by t.id
      ''');
    print('getAllTag ¥n$queryResult');

    return Tag.fromList(queryResult);
  }

  /// [name]に一致するタグを取得する
  static Future<List<Tag>> checkTagName(String name) async {
    final db = await CommonModel.db();
    final queryResult = await db.rawQuery('''
        select t.inVisible from ${CommonModel.tableNameTag} t where t.name = '$name'
      ''');
    return Tag.fromList(queryResult);
  }

  /// タグを作成する
  static Future<void> insertTag(String name) async {
    final db = await CommonModel.db();

// TODO:呼び出し元でチェックすべき
    final queryResult = await db.rawQuery('''
        select distinct max(t.sort) from ${CommonModel.tableNameTag} t 
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

  /// タグを更新する
  static Future<void> updateTag(int id, IntBool bool) async {
    final db = await CommonModel.db();
    final data = {'inVisible': bool.value};
    await db.update(
      CommonModel.tableNameTag,
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    print('updateTag');
  }
}
