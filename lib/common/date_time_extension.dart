import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toRegistrationString() {
    final formatter = DateFormat('yyyyMMddhhmmss', "ja_JP");
    final stringDateTime = formatter.format(this);
    return '';
  }
}
