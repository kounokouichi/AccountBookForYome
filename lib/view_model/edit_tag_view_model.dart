import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumechanaccountbook/data/tag/tag.dart';
import 'package:yumechanaccountbook/model/household_account_model.dart';

final editTagProvider = ChangeNotifierProvider.autoDispose
    .family<EditTagViewModel, String>((ref, _) => EditTagViewModel());

class EditTagViewModel extends ChangeNotifier {
  // 画面に表示する家計簿一覧
  List<Tag> _tagInfo = [];
  List<Tag> get tagInfo => _tagInfo;
  // 日付毎に家計簿を検索し結果をタグ毎にまとめる
  void getAllTag() async {
    try {
      final result = await HouseholdAccountModel.getVisibleTag();
      _tagInfo = result;
    } catch (e) {
      print(e);
      _tagInfo = [];
    }
    notifyListeners();
  }

  void insertTag() async {
    try {
      // 重複チェック
      final checkTag = await HouseholdAccountModel.checkTagName('');
      if (checkTag.isEmpty) {
        // タグの挿入
        HouseholdAccountModel.insertTag('');
      } else if (checkTag.first.invisible) {
        // タグの更新
        HouseholdAccountModel.insertTag('');
      } else {
        // エラー
      }

      // 再読み込み
      getAllTag();
    } catch (e) {
      print(e);
    }
  }
}
