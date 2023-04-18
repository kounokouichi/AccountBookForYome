import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumechanaccountbook/view/by_month/household_account_confirm_by_moth.dart';
import 'package:yumechanaccountbook/view/edit_tag.dart';
import 'router.dart' as rt;
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ja')
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffffccf0),
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HouseholdAccountConfirmByMonth(),
        rt.Router.householdAccountConfirmByMoth: (context) =>
            const HouseholdAccountConfirmByMonth(),
        rt.Router.editTag: (context) => const EditTag(),
      },
    );
  }
}
