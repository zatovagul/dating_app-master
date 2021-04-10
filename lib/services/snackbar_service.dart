import 'package:flutter/material.dart';

class SnackBarService {
  static void showMessage(
    BuildContext context,
    String message,
    GlobalKey<ScaffoldState> scaffoldKey, [
    Color backgroundColor,
  ]) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ));
  }
}
