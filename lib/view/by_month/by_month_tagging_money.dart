import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumechanaccountbook/common/colors.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _vm.searchHouseHoldAccountBy();
    });
  }

  ByMonthTableCalenderViewModel get _vm =>
      ref.watch(byMonthTableCalenderProvider('id'));

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _vm.houseHoldAccountTag.length,
        itemBuilder: (BuildContext context, int i) {
          return ExpansionTile(
            textColor: CommonColors.black,
            title: Text(_vm.houseHoldAccountTag[i].tagName),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: _vm.infoLength(_vm.houseHoldAccountTag[i].tagId),
                itemBuilder: (BuildContext context, int j) {
                  return Container(
                    decoration: BoxDecoration(
                        // color: Colors.blue,
                        // border: Border.all(color: Colors.red),
                        // borderRadius: BorderRadius.circular(10),
                        ),
                    padding: const EdgeInsets.only(left: 20),
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(_vm.houseHoldAccountInfo[j].memo),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('${_vm.houseHoldAccountInfo[j].money}円'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget nakami() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(left: 20),
          color: Colors.blue,
          width: 200,
          height: 30,
          child: Text('メモ内容$index: 〇〇〇〇円'),
        );
      },
    );
  }
}
