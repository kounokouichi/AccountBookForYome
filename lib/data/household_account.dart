import 'package:freezed_annotation/freezed_annotation.dart';

part 'household_account.freezed.dart';

@freezed
class HouseholdAccount with _$HouseholdAccount {
  const factory HouseholdAccount(
    int id,
    String date,
    int money,
    String incomeOrExpendFlag,
    int tagId,
    String tagName,
    String memo,
  ) = _HouseholdAccount;

  static List<HouseholdAccount> fromList(List<Map<String, dynamic>> data) {
    List<HouseholdAccount> result = [];
    for (var item in data) {
      result.add(
        HouseholdAccount(
          item['id'] ?? 0,
          item['date'] ?? '',
          item['money'] ?? 0,
          item['income_or_expend_flag'] ?? '',
          item['tag_id'] ?? 0,
          item['name'] ?? '',
          item['memo'] ?? '',
        ),
      );
    }
    return result;
  }
}
