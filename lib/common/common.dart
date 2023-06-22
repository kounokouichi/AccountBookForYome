import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider = StateProvider<String>((ref) => '');

class Common {
  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      action: SnackBarAction(
        label: '閉じる',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
