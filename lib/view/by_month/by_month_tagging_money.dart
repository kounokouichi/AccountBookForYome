import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumechanaccountbook/common/colors.dart';
import 'package:yumechanaccountbook/common/common.dart';
import 'package:yumechanaccountbook/data/household_account.dart';
import 'package:yumechanaccountbook/view/household_account_input.dart';
import 'package:yumechanaccountbook/view_model/by_month_table_calender_view_model.dart';

/// 選択されている日付のタグ毎の家計簿を表示する画面
class ByMonthTaggingMoney extends ConsumerStatefulWidget {
  const ByMonthTaggingMoney({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ByMonthTaggingMoneyState();
  }
}

class _ByMonthTaggingMoneyState extends ConsumerState<ByMonthTaggingMoney> {
  ByMonthTableCalenderViewModel get _vm =>
      ref.watch(byMonthTableCalenderProvider);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: _vm.houseHoldAccountTag.length,
              (BuildContext context, int tagIndex) {
                return ExpansionTile(
                  textColor: CommonColors.black,
                  // タグ名
                  title: Text(_vm.houseHoldAccountTag[tagIndex].tagName),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _vm
                          .infoLength(_vm.houseHoldAccountTag[tagIndex].tagId),
                      itemBuilder: (BuildContext context, int accountIndex) {
                        return _contentByTag(accountIndex);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentByTag(int accountIndex) {
    return Dismissible(
      key: Key(_vm.houseHoldAccountInfo[accountIndex].id.toString()),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      onDismissed: (_) {
        _vm.deleteItemHouseHoldAccount(
            _vm.houseHoldAccountInfo[accountIndex].id);
      },
      child: GestureDetector(
        onTap: () {
          if (_vm.houseHoldAccountInfo.isEmpty) return;
          _showModalPicker(_vm.houseHoldAccountInfo[accountIndex]);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          height: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // メモ
              Expanded(
                flex: 4,
                child: Text(_vm.houseHoldAccountInfo[accountIndex].memo),
              ),
              // 金額
              Expanded(
                flex: 1,
                child: Text('${_vm.houseHoldAccountInfo[accountIndex].money}円'),
              ),
            ],
          ),
        ),
      ),
    );
  }

// 更新できるようにしないと
  void _showModalPicker(HouseholdAccount account) {
    // 家計簿登録確認フラグを初期化
    ref.read(isUpdatedProvider.notifier).state = false;
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: HouseholdAccountInput(
            initDate: _vm.selectedDay,
            selectingAccountInfo: account,
          ),
        );
      },
    ).then((_) {
      if (ref.read(isUpdatedProvider)) {
        _vm.getByDateOf();
      }
    });
  }
}
