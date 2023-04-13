import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yumechanaccountbook/common/colors.dart';
import 'package:yumechanaccountbook/view_model/by_month_table_calender_view_model.dart';

/// カレンダー画面
class ByMonthTableCalender extends ConsumerStatefulWidget {
  const ByMonthTableCalender({super.key});

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

  ByMonthTableCalenderViewModel get _vm =>
      ref.watch(byMonthTableCalenderProvider('id'));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
          locale: 'ja_JP',
          daysOfWeekHeight: 20,
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime.utc(2040, 12, 31),
          selectedDayPredicate: (day) {
            return isSameDay(_vm.selectedDay, day);
          },
          focusedDay: _vm.focusedDay,
          rowHeight: 40,
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: CommonColors.primaryColor,
              shape: BoxShape.circle,
            ),
            weekendTextStyle: TextStyle(color: Colors.red),
            selectedTextStyle: TextStyle(color: CommonColors.primaryColor),
          ),
          onDaySelected: ((selectedDay, focusedDay) {
            _vm.selectedDay = selectedDay;
            _vm.focusedDay = focusedDay;
            _vm.getByDateOf();
          }),
        ),
      ],
    );
  }
}
