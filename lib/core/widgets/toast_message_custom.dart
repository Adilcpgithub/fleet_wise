import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToastMessage(String message, Color textColor, Color backgroundColor) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: textColor,
    textColor: backgroundColor,
    fontSize: 16.0,
  );
}
