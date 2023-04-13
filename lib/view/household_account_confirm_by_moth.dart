import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:yumechanaccountbook/view/by_month/by_month_table_calender.dart';
import 'package:yumechanaccountbook/view/by_month/by_month_tagging_money.dart';
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
      ref.watch(byMonthTableCalenderProvider('id'));

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
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.black,
                onPressed: () => {},
              ),
            ],
          ),
          body: ProviderScope(
            child: Column(
              children: const [
                ByMonthTableCalender(),
                ByMonthTaggingMoney(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
