import 'package:flutter/material.dart';

mixin FormMixin<T extends StatefulWidget> implements State<T> {
  bool _autoValidate = false;

  set autoValidate(bool autoValidate) {
    setState(() {
      _autoValidate = autoValidate;
    });
  }

  bool get autoValidate {
    return _autoValidate;
  }
}
