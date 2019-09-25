import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:secure_chat/store/error/error_state.dart';

part 'form_group_state.g.dart';

class FormGroupState = _FormGroupState with _$FormGroupState;

abstract class _FormGroupState with Store {
  // store for handling error messages
  final ErrorState errorState = ErrorState();

  // store variables:-----------------------------------------------------------
  @observable
  bool autoValidate = false;

  @action
  void setAutoValidate({@required bool autoValidate}) {
    this.autoValidate = autoValidate;
  }
}
