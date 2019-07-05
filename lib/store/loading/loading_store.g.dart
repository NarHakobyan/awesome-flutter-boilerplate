// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$LoadingStore on _LoadingStore, Store {
  final _$loadingAtom = Atom(name: '_LoadingStore.loading');

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

  final _$_LoadingStoreActionController =
      ActionController(name: '_LoadingStore');

  @override
  void startLoading() {
    final _$actionInfo = _$_LoadingStoreActionController.startAction();
    try {
      return super.startLoading();
    } finally {
      _$_LoadingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopLoading() {
    final _$actionInfo = _$_LoadingStoreActionController.startAction();
    try {
      return super.stopLoading();
    } finally {
      _$_LoadingStoreActionController.endAction(_$actionInfo);
    }
  }
}
