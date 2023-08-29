import 'package:flutter/material.dart';

class SnackBarMessage {
  static showSnackBarWithMessage(
      {required BuildContext context,
      required String message,
      required Color boxColor}) {
    SnackBar snackDemo = SnackBar(
      content: Text(message),
      backgroundColor: boxColor,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackDemo);
  }
}
