import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumechanaccountbook/common/message.dart';
import 'package:yumechanaccountbook/data/tag/tag.dart';
import 'package:yumechanaccountbook/enum/bool_type.dart';
import 'package:yumechanaccountbook/model/tag_model.dart';

final editTagProvider = ChangeNotifierProvider.autoDispose
    .family<EditTagViewModel, String>((ref, _) => EditTagViewModel());

class EditTagViewModel extends ChangeNotifier {
  // 画面に表示する家計簿一覧
  List<Tag> _tagInfo = [];
  List<Tag> get tagInfo => _tagInfo;
  // 日付毎に家計簿を検索し結果をタグ毎にまとめる
  Future<void> getAllTag() async {
    try {
      final result = await TagModel.getVisibleTag();
      _tagInfo = result;
    } catch (e) {
      print(e);
      _tagInfo = [];
    }
    notifyListeners();
  }

  String message = '';

  /// タグを登録する、同じ名前のタグが寝てたら起こす
  Future<void> insertTag() async {
    try {
      // 重複チェック
      final checkTag = await TagModel.checkTagName(tagController.text);
      if (checkTag.isEmpty) {
        // タグの挿入
        await TagModel.insertTag(tagController.text);
      } else if (checkTag.first.invisible) {
        // タグの更新
        await TagModel.updateTag(checkTag.first.id, IntBool.ifalse);
      } else {
        // 同じ名前のタグを登録しようとするとエラー
        message = Message.E0003;
      }
      message = Message.S0001;
    } catch (e) {
      print(e);
      message = Message.E0002;
    }
    notifyListeners();
  }

  // タグを削除する
  void deleteTag(int id) async {
    try {
      TagModel.updateTag(id, IntBool.itrue);
    } catch (e) {
      message = Message.S0002;
      print(e);
    }
  }

  TextEditingController tagController = TextEditingController();
}
