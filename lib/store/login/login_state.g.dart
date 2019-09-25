// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginState on _LoginState, Store {
  final _$rememberMeAtom = Atom(name: '_LoginState.rememberMe');

  @override
  bool get rememberMe {
    _$rememberMeAtom.context.enforceReadPolicy(_$rememberMeAtom);
    _$rememberMeAtom.reportObserved();
    return super.rememberMe;
  }

  @override
  set rememberMe(bool value) {
    _$rememberMeAtom.context.conditionallyRunInAction(() {
      super.rememberMe = value;
      _$rememberMeAtom.reportChanged();
    }, _$rememberMeAtom, name: '${_$rememberMeAtom.name}_set');
  }

  final _$_LoginStateActionController = ActionController(name: '_LoginState');

  @override
  void setRememberMe({@required bool rememberMe}) {
    final _$actionInfo = _$_LoginStateActionController.startAction();
    try {
      return super.setRememberMe(rememberMe: rememberMe);
    } finally {
      _$_LoginStateActionController.endAction(_$actionInfo);
    }
  }
}
