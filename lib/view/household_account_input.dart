// import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:yumechanaccountbook/common/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:yumechanaccountbook/common/common.dart';
import 'package:yumechanaccountbook/view/common/common.dart';
import 'package:yumechanaccountbook/view_model/by_month_table_calender_view_model.dart';
import 'package:yumechanaccountbook/view_model/household_account_input/household_account_input_view_model.dart';

class HouseholdAccountInput extends ConsumerStatefulWidget {
  const HouseholdAccountInput({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HouseholdAccountInputState();
}

class TagInfo {
  TagInfo(
    this.name,
    this.id,
  );
  String name;
  String id;
}

class _HouseholdAccountInputState extends ConsumerState<HouseholdAccountInput> {
  HousehouldAccountInputViewModel get _vm =>
      ref.watch(househouldAccountInputProvider('id'));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _vm.searchTag();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 20,
            backgroundColor: CommonColors.primaryColor,
            // title: const Text('title'),
          ),
          body: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                // 収入・支出の選択
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ToggleButtons(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      // selectedBorderColor: CommonColors.primaryColor,
                      selectedColor: Colors.white,
                      fillColor: CommonColors.primaryColor,
                      color: CommonColors.primaryColor,
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
                    Expanded(
                      child: TextField(
                        controller: _vm.moneyController,
                        focusNode: _vm.moneyFocusNode,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                          selected:
                              _vm.tagInfoList[index].id == _vm.selecedTagId,
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
                    child: const Text(
                      'タグ編集',
                      style: TextStyle(
                        color: CommonColors.primaryColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                // メモ入力欄
                TextField(
                  cursorColor: CommonColors.primaryColor,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CommonColors.primaryColor,
                      ),
                    ),
                    labelText: 'メモ',
                    floatingLabelStyle: TextStyle(
                      color: CommonColors.primaryColor,
                    ),
                  ),
                  controller: _vm.memoController,
                  maxLength: 100,
                ),
              ],
            ),
          ),
          // 登録ボタン
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              _vm.registHouseHoldAccount();
              if (_vm.message.isNotEmpty) {
                _showSnackBar();
              }
            },
            child: const Icon(Icons.done),
          ),
        ),
      );
    });
  }

  void _showSnackBar() {
    Common.showSnackBar(context, _vm.message);
    _vm.message = '';
  }
}

class BottomOfTheScreenDropdown extends StatelessWidget {
  final List<TagInfo> tagInfos;
  final String selectedTagName;
  final ValueChanged<String?> onChanged;

  const BottomOfTheScreenDropdown({
    super.key,
    required this.tagInfos,
    required this.selectedTagName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _buildCupertinoPicker(context);
  }

  Widget _buildCupertinoPicker(BuildContext context) {
    return Center(
      child: CupertinoButton(
        child: Text(
          selectedTagName,
          textAlign: TextAlign.center,
          // style: TextStyle(color: Colors.blue),
        ),
        onPressed: () => _showModalPicker(context),
      ),
    );
  }

  void _showModalPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 40,
              children: tagInfos.map(_pickerItem).toList(),
              onSelectedItemChanged: (value) {
                onChanged(tagInfos[value].name);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _pickerItem(TagInfo tag) {
    return Center(
      child: Text(
        tag.name,
      ),
    );
  }
}
