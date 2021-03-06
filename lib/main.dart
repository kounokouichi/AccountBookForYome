import 'package:flutter/material.dart';
import 'package:yumechanaccountbook/view/household_account_input.dart';
import 'router.dart' as rt;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeArea Sample',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      routes: {
        '/': (context) => const HouseholdAccountInput(),
        rt.Router.householdAccountInput: (context) =>
            const HouseholdAccountInput(),
      },
    );
  }
}
