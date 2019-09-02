// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$rememberMeAtom = Atom(name: '_LoginStore.rememberMe');

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

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  dynamic setRememberMe({@required bool rememberMe}) {
    final _$actionInfo = _$_LoginStoreActionController.startAction();
    try {
      return super.setRememberMe(rememberMe: rememberMe);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }
}
