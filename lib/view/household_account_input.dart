// import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yumechanaccountbook/common/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:yumechanaccountbook/common/common.dart';
import 'package:yumechanaccountbook/common/string_extension.dart';
import 'package:yumechanaccountbook/data/household_account.dart';
import 'package:yumechanaccountbook/router.dart' as rt;
import 'package:yumechanaccountbook/view_model/household_account_input/household_account_input_view_model.dart';

class HouseholdAccountInput extends ConsumerStatefulWidget {
  // カレンダー内の選択してる日付
  final DateTime initDate;
  final HouseholdAccount? selectingAccountInfo;
  const HouseholdAccountInput({
    super.key,
    required this.initDate,
    this.selectingAccountInfo,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HouseholdAccountInputState();
}

class _HouseholdAccountInputState extends ConsumerState<HouseholdAccountInput> {
  HousehouldAccountInputViewModel get _vm =>
      ref.watch(househouldAccountInputProvider('id'));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.selectingAccountInfo == null) {
        // 登録時
        _vm.selectedDay = widget.initDate;
      } else {
        // 更新時
        _vm.selectedDay =
            widget.selectingAccountInfo!.date.toDateTimeUpToSeconds();
        _vm.moneyController.text =
            widget.selectingAccountInfo!.money.toString();
        _vm.memoController.text = widget.selectingAccountInfo!.memo;
        _vm.selectMoneyType(widget.selectingAccountInfo!.incomeOrExpendFlag);
      }
      _vm.searchTag();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: () {
                  if (widget.selectingAccountInfo == null) {
                    _vm.registHouseHoldAccount();
                    _showSnackBar();
                  } else {
                    _vm.updateHouseHoldAccount(widget.selectingAccountInfo!.id);
                    _showSnackBar();
                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.selectingAccountInfo == null ? '登録' : '更新'),
              ),
            ],
          ),
          // 時間選択
          Align(
            alignment: Alignment.center,
            child: TextButton(
              child: Text(
                _vm.formattedDay,
                style: const TextStyle(
                  color: CommonColors.black,
                ),
              ),
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(2000, 1, 1),
                  maxTime: DateTime(2123, 12, 31),
                  onConfirm: (date) {
                    _vm.selectDay(date);
                  },
                  currentTime: _vm.selectedDay,
                  locale: LocaleType.jp,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 収入・支出の選択
              ToggleButtons(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                constraints: const BoxConstraints(
                  minHeight: 30.0,
                  minWidth: 60.0,
                ),
                children: const [Text('収入'), Text('支出')],
                isSelected: _vm.selectedMoneyType,
                onPressed: (int type) {
                  _vm.selectMoneyType(type.toString());
                },
              ),
              // 金額
              Expanded(
                child: TextField(
                  controller: _vm.moneyController,
                  focusNode: _vm.moneyFocusNode,
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text('円'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // タグの選択
          SizedBox(
            height: 30,
            child: ListView.builder(
              itemCount: _vm.tagInfoList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(right: 5.0, left: 5.0),
                  child: ChoiceChip(
                    label: Text(_vm.tagInfoList[index].name),
                    selected: _vm.tagInfoList[index].id == _vm.selecedTagId,
                    onSelected: (selectedNum) {
                      setState(() {
                        _vm.selecedTagId = _vm.tagInfoList[index].id;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // タグ編集ボタン
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: const Text('タグ編集'),
              onPressed: () {
                Navigator.of(context).pushNamed(rt.Router.editTag);
              },
            ),
          ),
          // メモ入力欄
          TextField(
            decoration: const InputDecoration(labelText: 'メモ'),
            controller: _vm.memoController,
            focusNode: _vm.memoFocusNode,
            maxLength: 100,
          ),
        ],
      ),
    );
  }

  void _showSnackBar() {
    Common.showSnackBar(context, _vm.message);
    _vm.message = '';
  }
}
