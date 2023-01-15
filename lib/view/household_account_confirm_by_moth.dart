import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yumechanaccountbook/common/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:yumechanaccountbook/view/by_month/by_month_table_calender.dart';
import 'package:yumechanaccountbook/view/by_month/by_month_tagging_money.dart';

class HouseholdAccountConfirmByMonth extends StatefulWidget {
  const HouseholdAccountConfirmByMonth({Key? key}) : super(key: key);

  @override
  State<HouseholdAccountConfirmByMonth> createState() =>
      _HouseholdAccountConfirmByMonthState();
}

class _HouseholdAccountConfirmByMonthState
    extends State<HouseholdAccountConfirmByMonth> {
  TextEditingController moneyController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  DateTime today = DateTime.now();
  String selecedTagId = '';

  String tagText = '1 タグ 1';
  final List<bool> _selectedFruits = <bool>[true, false];
  @override
  void initState() {
    super.initState();
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
            ),
            body: ProviderScope(
              child: Column(
                children: [
                  ByMonthTableCalender(),
                  ByMonthTaggingMoney(),
                ],
              ),
            )),
      );
    });
  }
}
