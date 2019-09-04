import 'package:flutter/services.dart';

class KeyboardHelper {
  static Future<dynamic> hideKeyboard() {
    return SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static Future<dynamic> showKeyboard() {
    return SystemChannels.textInput.invokeMethod('TextInput.show');
  }
}
