import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

@Deprecated('change toast helper with flushbar')
class ToastHelper {
  static Future<bool> showToast(String msg,
      {int timeInSecForIos,
      Toast toastLength = Toast.LENGTH_SHORT,
      bool toUpperCase = true}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        timeInSecForIos: timeInSecForIos,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[200].withOpacity(0.8),
        textColor: Colors.grey[800]);
  }

  static Future<bool> showErrorToast(String msg,
      {int timeInSecForIos,
      Toast toastLength = Toast.LENGTH_SHORT,
      bool toUpperCase = true}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        timeInSecForIos: timeInSecForIos,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        textColor: Colors.white);
  }
}
