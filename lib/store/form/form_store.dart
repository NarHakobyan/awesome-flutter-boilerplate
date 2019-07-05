import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:secure_chat/store/error/error_store.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // store variables:-----------------------------------------------------------
  @observable
  bool autoValidate = false;

  @observable
  bool loading = false;

  // actions:-------------------------------------------------------------------
  @action
  Future setLoading({@required bool loading}) async {
    this.loading = loading;
  }

  @action
  setAutoValidate({@required bool autoValidate}) {
    this.autoValidate = autoValidate;
  }
}
