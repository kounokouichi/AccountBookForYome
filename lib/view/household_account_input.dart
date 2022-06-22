import 'dart:io';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter/cupertino.dart';
import 'package:yumechanaccountbook/router.dart' as rt;

class HouseholdAccountInput extends StatefulWidget {
  const HouseholdAccountInput({Key? key}) : super(key: key);

  @override
  State<HouseholdAccountInput> createState() => _HouseholdAccountInputState();
}

class _HouseholdAccountInputState extends State<HouseholdAccountInput> {
  final moneyController = TextEditingController();
  int _selectedRange = 1;
  String _selectedString = "年";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('title'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('2022/6/20'),
            Row(
              children: [
                TextField(controller: moneyController),
                const Text('円'),
              ],
            ),
            Row(
              children: [
                Text('タグ'),
                CycleSelectButtons(
                  selectedSpan: SpanExt.initFrom(_selectedString),
                  range: _selectedRange,
                  onSpanChanged: (value) {},
                  onRangeChanged: (value) {
                    print(value);
                  },
                ),
              ],
            )
            // TableCalendar(
            //   firstDay: DateTime.utc(2020, 1, 1),
            //   lastDay: DateTime.utc(2032, 12, 31),
            //   focusedDay: DateTime.now(),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.done,
        ),
      ),
    );
  }
}

class CycleSelectButtons extends StatelessWidget {
  static final List<String> strings = [
    Span.Year.stringValue,
    Span.Month.stringValue,
    Span.Day.stringValue,
    Span.None.stringValue,
  ];

  static final List<String> yearStrings =
      List<int>.generate(10, (i) => i + 1).map((i) => '$i').toList();
  static final List<String> monthStrings =
      List<int>.generate(12, (i) => i + 1).map((i) => '$i').toList();
  static final List<String> dayStrings =
      List<int>.generate(365, (i) => i + 1).map((i) => '$i').toList();

  final Span selectedSpan;
  final int range;
  final ValueChanged<String> onSpanChanged;
  final ValueChanged<int> onRangeChanged;

  CycleSelectButtons(
      {required this.selectedSpan,
      required this.onSpanChanged,
      required this.onRangeChanged,
      required this.range});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _dropdowns,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<Widget> get _dropdowns {
    List<Widget> dropdowns = [
      AdaptiveDropdown(
        itemStrings: strings,
        selectedItemString: selectedSpan.stringValue,
        onChanged: (v) {},
      ),
    ];

    if (selectedSpan == Span.None) {
      return dropdowns;
    } else {
      switch (selectedSpan) {
        case Span.Year:
          dropdowns.add(
            AdaptiveDropdown(
              itemStrings: yearStrings,
              selectedItemString: '$range',
              onChanged: (value) => onRangeChanged(int.parse(value!)),
            ),
          );
          break;
        case Span.Month:
          dropdowns.add(
            AdaptiveDropdown(
              itemStrings: monthStrings,
              selectedItemString: '$range',
              onChanged: (value) => onRangeChanged(int.parse(value!)),
            ),
          );
          break;
        case Span.Day:
          dropdowns.add(
            AdaptiveDropdown(
              itemStrings: dayStrings,
              selectedItemString: '$range',
              onChanged: (value) => onRangeChanged(int.parse(value!)),
            ),
          );
          break;
        case Span.None:
          break;
      }
      return dropdowns;
    }
  }
}

enum Span {
  Year,
  Month,
  Day,
  None,
}

extension SpanExt on Span {
  static Span initFrom(String spanString) {
    switch (spanString) {
      case '年':
        return Span.Year;
        break;
      case '月':
        return Span.Month;
        break;
      case '日':
        return Span.Day;
        break;
    }
    return Span.None;
  }

  String get stringValue {
    switch (this) {
      case Span.Year:
        return '年';
        break;
      case Span.Month:
        return '月';
        break;
      case Span.Day:
        return '日';
        break;
      case Span.None:
        return '未設定';
        break;
    }
    return "未設定";
  }
}

class AdaptiveDropdown extends StatelessWidget {
  final List<String> itemStrings;
  final String selectedItemString;
  final ValueChanged<String?> onChanged;

  AdaptiveDropdown(
      {required this.itemStrings,
      required this.selectedItemString,
      required this.onChanged})
      : assert(itemStrings != null),
        assert(selectedItemString != null),
        assert(onChanged != null);

  @override
  Widget build(BuildContext context) {
    return _buildCupertinoPicker(context);
  }

  Widget _buildCupertinoPicker(BuildContext context) {
    return Container(
      child: Center(
        child: CupertinoButton(
          child: Text(
            selectedItemString,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () => _showModalPicker(context),
        ),
      ),
    );
  }

  void _showModalPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 40,
              children: itemStrings.map(_pickerItem).toList(),
              onSelectedItemChanged: (value) {
                onChanged(itemStrings[value]);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _pickerItem(String string) {
    return Text(
      string,
    );
  }
}
