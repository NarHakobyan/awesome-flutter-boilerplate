import 'package:flutter/material.dart';

mixin LoadingMixin<T extends StatefulWidget> implements State<T> {
  bool isLoading = false;

  _setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  startLoading() {
    this._setLoading(true);
  }

  stopLoading() {
    this._setLoading(false);
  }
}
