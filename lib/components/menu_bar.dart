import 'package:flutter/material.dart';
import 'package:yumechanaccountbook/view/household_account_confirm_by_moth.dart';

import 'package:yumechanaccountbook/view/household_account_input.dart';
import 'package:yumechanaccountbook/main2.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffffccf0),
        primarySwatch: Colors.blue,
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const _screens = [
    HouseholdAccountInput(),
    HouseholdAccountConfirmByMonth(),
    HouseholdAccountInput(),
    HouseholdAccountInput(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: _screens,
          controller: _pageViewController,
          onPageChanged: _onItemTapped,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageViewController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.easeOut);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
