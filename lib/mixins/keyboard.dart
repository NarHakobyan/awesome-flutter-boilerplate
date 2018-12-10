import 'package:flutter/services.dart';

mixin Keyboard {
    hideKeyboard() {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    showKeyboard() {
        SystemChannels.textInput.invokeMethod('TextInput.show');
    }
}