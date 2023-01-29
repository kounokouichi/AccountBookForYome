import 'package:freezed_annotation/freezed_annotation.dart';

part 'household_account.freezed.dart';

@freezed
class HouseholdAccount with _$HouseholdAccount {
  const factory HouseholdAccount(
    int id,
    String date,
    int money,
    String incomeOrExpendFlag,
    String tagId,
    String memo,
  ) = _HouseholdAccount;

  static List<HouseholdAccount> fromList(List<Map<String, dynamic>> data) {
    List<HouseholdAccount> result = [];
    for (var item in data) {
      result.add(
        HouseholdAccount(
          item['id'],
          item['date'],
          item['money'],
          item['income_or_expend_flag'],
          item['tag_id'],
          item['memo'],
        ),
      );
    }
    return result;
  }
}
