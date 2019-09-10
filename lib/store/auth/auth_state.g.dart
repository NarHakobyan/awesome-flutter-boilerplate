// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthState on _AuthState, Store {
  final _$currentUserAtom = Atom(name: '_AuthState.currentUser');

  @override
  User get currentUser {
    _$currentUserAtom.context.enforceReadPolicy(_$currentUserAtom);
    _$currentUserAtom.reportObserved();
    return super.currentUser;
  }

  @override
  set currentUser(User value) {
    _$currentUserAtom.context.conditionallyRunInAction(() {
      super.currentUser = value;
      _$currentUserAtom.reportChanged();
    }, _$currentUserAtom, name: '${_$currentUserAtom.name}_set');
  }

  final _$_AuthStateActionController = ActionController(name: '_AuthState');

  @override
  void setCurrentUser(User user) {
    final _$actionInfo = _$_AuthStateActionController.startAction();
    try {
      return super.setCurrentUser(user);
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeUserName() {
    final _$actionInfo = _$_AuthStateActionController.startAction();
    try {
      return super.changeUserName();
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }
}
