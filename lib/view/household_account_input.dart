// import 'dart:io';
// import 'package:table_calendar/table_calendar.dart';
// TableCalendar(
//   firstDay: DateTime.utc(2020, 1, 1),
//   lastDay: DateTime.utc(2032, 12, 31),
//   focusedDay: DateTime.now(),
// ),
// import 'package:yumechanaccountbook/router.dart' as rt;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
  String today = '';
  String selecedTagId = '';

  String tagText = '1 タグ 1';
  final List<bool> _selectedFruits = <bool>[true, false];
  @override
  void initState() {
    super.initState();
    today = '2022/10/01';
    List<String> tempTagList = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    for (var item in tempTagList) {
      tagInfoList.add(TagInfo('$item タグ $item', item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            // title: const Text('title'),
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(today),
                Row(
                  children: [
                    ToggleButtons(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Colors.red[700],
                      selectedColor: Colors.white,
                      fillColor: Colors.red[200],
                      color: Colors.red[400],
                      constraints: const BoxConstraints(
                        minHeight: 30.0,
                        minWidth: 60.0,
                      ),
                      children: const [Text('収入'), Text('支出')],
                      isSelected: _selectedFruits,
                      onPressed: (int index) {
                        print(Theme.of(context).primaryColor);
                        setState(() {
                          for (int i = 0; i < _selectedFruits.length; i++) {
                            _selectedFruits[i] = i == index;
                          }
                        });
                      },
                    ),
                    SizedBox(
                      width: 100,
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
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    itemCount: tagInfoList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ChoiceChip(
                        label: Text(tagInfoList[index].name),
                        selected: tagInfoList[index].id == selecedTagId,
                        onSelected: (selectedNum) {
                          setState(() {
                            selecedTagId = tagInfoList[index].id;
                          });
                        },
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text('タグ編集'),
                    onPressed: () {},
                  ),
                ),
                const Text('メモ'),
                TextField(
                  controller: memoController,
                  maxLength: 100,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
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
