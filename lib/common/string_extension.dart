import 'package:intl/intl.dart';

extension StringExtension on String {
  /// DB登録用のString型をDatetime型に変換
  DateTime toDateTimeUpToSeconds() {
    // DateTime(this.substring(0,4));
    final _dateFormatter = DateFormat("yyyyMMddhhmmss");
    return _dateFormatter.parseStrict(this);
  }
}
