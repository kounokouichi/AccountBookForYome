import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yumechanaccountbook/common/colors.dart';

class ByMonthTableCalender extends ConsumerStatefulWidget {
  const ByMonthTableCalender({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ByMonthTableCellState();
  }
}

class _ByMonthTableCellState extends ConsumerState<ByMonthTableCalender> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ja_JP',
      daysOfWeekHeight: 20,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: CommonColors.primaryColor,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: TextStyle(color: Colors.red),
        selectedTextStyle: TextStyle(color: CommonColors.primaryColor),
      ),
      onDaySelected: ((selectedDay, focusedDay) {
        print(selectedDay);
        print(focusedDay);
      }),
    );
  }
}
