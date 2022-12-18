// import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:yumechanaccountbook/common/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class HouseholdAccountInput extends StatefulWidget {
  const HouseholdAccountInput({Key? key}) : super(key: key);

  @override
  State<HouseholdAccountInput> createState() => _HouseholdAccountInputState();
}

class TagInfo {
  TagInfo(
    this.name,
    this.id,
  );
  String name;
  String id;
}

class _HouseholdAccountInputState extends State<HouseholdAccountInput> {
  TextEditingController moneyController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  List<TagInfo> tagInfoList = [];
  DateTime today = DateTime.now();
  String selecedTagId = '';

  String tagText = '1 タグ 1';
  final List<bool> _selectedFruits = <bool>[true, false];
  @override
  void initState() {
    super.initState();
    List<String> tempTagList = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    for (var item in tempTagList) {
      tagInfoList.add(TagInfo('$item タグ $item', item));
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat outputFormat = DateFormat('yyyy年MM月dd日');
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
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      outputFormat.format(today),
                      style: const TextStyle(
                        color: CommonColors.black,
                      ),
                    ),
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1900, 1, 1),
                        maxTime: DateTime(2049, 12, 31),
                        onConfirm: (date) {
                          setState(() {
                            today = date;
                          });
                          // initData();
                        },
                        currentTime: today,
                        locale: LocaleType.jp,
                      );
                    },
                  ),
                ),
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
                      isSelected: _selectedFruits,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedFruits.length; i++) {
                            _selectedFruits[i] = i == index;
                          }
                        });
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: moneyController,
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
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    itemCount: tagInfoList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(right: 5.0, left: 5.0),
                        child: ChoiceChip(
                          label: Text(tagInfoList[index].name),
                          selected: tagInfoList[index].id == selecedTagId,
                          onSelected: (selectedNum) {
                            setState(() {
                              selecedTagId = tagInfoList[index].id;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
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
                  controller: memoController,
                  maxLength: 100,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {},
            child: const Icon(
              Icons.done,
            ),
          ),
        ),
      );
    });
  }
}

class BottomOfTheScreenDropdown extends StatelessWidget {
  final List<TagInfo> tagInfos;
  final String selectedTagName;
  final ValueChanged<String?> onChanged;

  const BottomOfTheScreenDropdown(
      {Key? key,
      required this.tagInfos,
      required this.selectedTagName,
      required this.onChanged})
      : super(key: key);

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
