import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yumechanaccountbook/common/date_time_extension.dart';
import 'package:yumechanaccountbook/common/message.dart';
import 'package:yumechanaccountbook/data/tag/tag.dart';
import 'package:yumechanaccountbook/model/household_account_model.dart';

final househouldAccountInputProvider = ChangeNotifierProvider.autoDispose
    .family<HousehouldAccountInputViewModel, String>(
        ((ref, _) => HousehouldAccountInputViewModel()));

class HousehouldAccountInputViewModel extends ChangeNotifier {
  TextEditingController moneyController = TextEditingController();
  FocusNode moneyFocusNode = FocusNode();
  TextEditingController memoController = TextEditingController();
  FocusNode memoFocusNode = FocusNode();

  int selecedTagId = 0;
  late List<Tag> _tagInfoList = [];
  List<Tag> get tagInfoList => _tagInfoList;
  DateTime selectedDay = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
  String get formattedDay => outputFormat.format(selectedDay);
  // [収入、支出]の状態
  final List<bool> selectedMoneyType = [true, false];
  String message = '';

  void selectDay(DateTime date) {
    selectedDay = date;
    notifyListeners();
  }

  /// 収入と支出を選択する
  void selectMoneyType(String type) {
    selectedMoneyType[0] = type == MoneyType.income.value;
    selectedMoneyType[1] = type == MoneyType.expend.value;

    notifyListeners();
  }

  void searchTag() async {
    _tagInfoList = await HouseholdAccountModel.getVisibleTag();
    notifyListeners();
  }

  /// 家計簿の登録
  void registHouseHoldAccount() async {
    if (moneyController.text.isEmpty) {
      message = Message.E0001;
      return;
    }

    try {
      MoneyType moneyType =
          selectedMoneyType[0].toString() == MoneyType.income.value
              ? MoneyType.income
              : MoneyType.expend;

      await HouseholdAccountModel.createItem(
        selectedDay.toRegistrationString(),
        int.parse(moneyController.text),
        moneyType,
        selecedTagId,
        memoController.text,
      );
      moneyController.clear();
      memoController.clear();
      if (!moneyFocusNode.hasFocus) {
        moneyFocusNode.requestFocus();
      }
      message = Message.S0001;
    } catch (e) {
      message = Message.E0002;
    }
    return;
  }

  /// 家計簿の更新
  void updateHouseHoldAccount(int accountId) async {
    if (moneyController.text.isEmpty) {
      message = Message.E0001;
      return;
    }

    try {
      MoneyType moneyType =
          selectedMoneyType[0].toString() == MoneyType.income.value
              ? MoneyType.income
              : MoneyType.expend;

      await HouseholdAccountModel.updateItem(
        accountId.toString(),
        selectedDay.toRegistrationString(),
        int.parse(moneyController.text),
        moneyType,
        selecedTagId,
        memoController.text,
      );
      message = Message.S0001;
    } catch (e) {
      message = Message.E0002;
    }
  }
}
