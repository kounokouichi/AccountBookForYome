import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:yumechanaccountbook/view/by_month/by_month_table_calender.dart';
import 'package:yumechanaccountbook/view/by_month/by_month_tagging_money.dart';
import 'package:yumechanaccountbook/view/household_account_input.dart';
import 'package:yumechanaccountbook/view_model/by_month_table_calender_view_model.dart';

// カレンダーからタグごとの金額が見える画面
class HouseholdAccountConfirmByMonth extends ConsumerStatefulWidget {
  const HouseholdAccountConfirmByMonth({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HouseholdAccountConfirmByMonthState();
}

class _HouseholdAccountConfirmByMonthState
    extends ConsumerState<HouseholdAccountConfirmByMonth> {
  ByMonthTableCalenderViewModel get _vm =>
      ref.watch(byMonthTableCalenderProvider);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getByDateOf();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Scaffold(
          body: SafeArea(
            child: ProviderScope(
              child: Column(
                children: const [
                  ByMonthTableCalender(),
                  ByMonthTaggingMoney(),
                ],
              ),
            ),
          ),
          // 登録ボタン
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              _showModalPicker();
            },
            child: const Icon(Icons.add),
          ),
        ),
      );
    });
  }

  void _showModalPicker() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: HouseholdAccountInput(
            initDate: _vm.selectedDay,
          ),
        );
      },
    );
  }
}
