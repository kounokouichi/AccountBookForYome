import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumechanaccountbook/common/date_time_extension.dart';
import 'package:yumechanaccountbook/data/household_account.dart';
import 'package:yumechanaccountbook/model/household_account_model.dart';

final byMonthTableCalenderProvider = ChangeNotifierProvider.autoDispose
    .family<ByMonthTableCalenderViewModel, String>(
        ((ref, _) => ByMonthTableCalenderViewModel()));

class ByMonthTableCalenderViewModel extends ChangeNotifier {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  // 画面に表示する家計簿一覧
  List<HouseholdAccount> _houseHoldAccountInfo = [];
  List<HouseholdAccount> get houseHoldAccountInfo => _houseHoldAccountInfo;
  int infoLength(int tagId) {
    return houseHoldAccountInfo.where((e) => e.tagId == tagId).length;
  }

  // houseHoldAccountInfoで使用されているタグのリスト
  List<HouseholdAccount> _houseHoldAccountTag = [];
  List<HouseholdAccount> get houseHoldAccountTag => _houseHoldAccountTag;

  void searchHouseHoldAccountBy() async {}

  void setDayInfo(DateTime day) {
    focusedDay = day;
    notifyListeners();
  }

  /// 家計簿の登録
  void registHouseHoldAccount() async {
    try {
      await HouseholdAccountModel.createItem(
        DateTime.now().toRegistrationString(),
        1105,
        MoneyType.expend,
        '1',
        'お肉お弁当「${DateTime.now().toRegistrationString()}」',
      );
      print(' create end');
    } catch (e) {
      print('登録失敗');
    }
  }

  /// 確認
  void getBytag() async {
    try {
      HouseholdAccountModel.getBytag();
      // print(aaa);
    } catch (e) {
      print('登録失敗');
    }
  }

  // 家計簿の検索
  void getHouseHoldAccount() async {
    try {
      final result = await HouseholdAccountModel.getNotes();

      for (var element in result) {
        print(element);
      }
    } catch (e) {
      print(e);
    }
  }

  // 日付毎に家計簿を検索し結果をタグ毎にまとめる
  void getByDateOf(DateTime dateTime) async {
    try {
      final result = await HouseholdAccountModel.getByDateOf(
        dateTime.toSearchString(),
      );
      final useingTag = await HouseholdAccountModel.getTagByDateOf(
        dateTime.toSearchString(),
      );
      // タグ毎にリストを分ける必要がある
      _houseHoldAccountInfo = result;
      _houseHoldAccountTag = useingTag;
    } catch (e) {
      print(e);
      _houseHoldAccountInfo = [];
    }
    notifyListeners();
  }
}
