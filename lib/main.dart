import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumechanaccountbook/view/edit_tag.dart';
import 'package:yumechanaccountbook/view/household_account_input.dart';
import 'package:yumechanaccountbook/components/menu_bar.dart';
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
      routes: {
        '/': (context) => const Menu(),
        rt.Router.householdAccountInput: (context) => HouseholdAccountInput(
              initDate: DateTime.now(),
            ),
        rt.Router.editTag: (context) => const EditTag(),
      },
    );
  }
}
