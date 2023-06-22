import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumechanaccountbook/common/common.dart';
import 'package:yumechanaccountbook/view/by_month/household_account_confirm_by_moth.dart';
import 'package:yumechanaccountbook/view/tag/edit_tag.dart';
import 'router.dart' as rt;
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ja')
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Stack(
        children: [
          MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              primaryColor: const Color(0xffffccf0),
            ),
            routes: {
              '/': (context) => const HouseholdAccountConfirmByMonth(),
              rt.Router.householdAccountConfirmByMoth: (context) =>
                  const HouseholdAccountConfirmByMonth(),
              rt.Router.editTag: (context) => const EditTag(),
            },
          ),
          IgnorePointer(
            ignoring: true,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.yellow.withOpacity(0),
                body: const ShowSnackBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowSnackBar extends ConsumerWidget {
  const ShowSnackBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(messageProvider, (_, String message) {
      if (message.isEmpty) return;
      Common.showSnackBar(context, message);
      // リセット
      ref.read(messageProvider.notifier).state = '';
    });
    return Container();
  }
}
