import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yumechanaccountbook/common/colors.dart';

class ByMonthTaggingMoney extends ConsumerStatefulWidget {
  const ByMonthTaggingMoney({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ByMonthTaggingMoneyState();
  }
}

class _ByMonthTaggingMoneyState extends ConsumerState<ByMonthTaggingMoney> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: CommonColors.primaryColor,
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text('タグ名$index: 〇〇〇〇円'),
              children: [
                ListView.builder(
                  shrinkWrap: true,
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
                ),
              ],
            ),
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
