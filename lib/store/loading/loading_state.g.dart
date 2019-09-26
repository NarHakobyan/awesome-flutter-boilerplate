// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoadingState on _LoadingState, Store {
  final _$loadingAtom = Atom(name: '_LoadingState.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$_LoadingStateActionController =
      ActionController(name: '_LoadingState');

  @override
  void startLoading() {
    final _$actionInfo = _$_LoadingStateActionController.startAction();
    try {
      return super.startLoading();
    } finally {
      _$_LoadingStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopLoading() {
    final _$actionInfo = _$_LoadingStateActionController.startAction();
    try {
      return super.stopLoading();
    } finally {
      _$_LoadingStateActionController.endAction(_$actionInfo);
    }
  }
}
