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
      final result = await HouseholdAccountModel.getAllTag();
      // タグ毎にリストを分ける必要がある
      _tagInfo = result;
    } catch (e) {
      print(e);
      _tagInfo = [];
    }
    notifyListeners();
  }
}
