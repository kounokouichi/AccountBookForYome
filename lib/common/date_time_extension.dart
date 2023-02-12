import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// DB登録用のString型に変換
  String toRegistrationString() {
    final formatter = DateFormat('yyyyMMddhhmmss', "ja_JP");
    final stringDateTime = formatter.format(this);
    return stringDateTime;
  }

  /// DB検索用のString型に変換
  String toSearchString() {
    final formatter = DateFormat('yyyyMMdd', "ja_JP");
    final stringDateTime = formatter.format(this);
    return stringDateTime;
  }
}
