import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final byMonthTableCalenderProvider = ChangeNotifierProvider.autoDispose
    .family<ByMonthTableCalenderViewModel, String>(
        ((ref, _) => ByMonthTableCalenderViewModel()));

class ByMonthTableCalenderViewModel extends ChangeNotifier {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  void setDayInfo(DateTime day) {
    focusedDay = day;
    notifyListeners();
  }
}
