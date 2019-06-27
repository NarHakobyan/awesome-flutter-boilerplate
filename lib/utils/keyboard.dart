import 'package:flutter/services.dart';

class KeyboardUtil {
  static hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }
}
