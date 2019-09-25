// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DataState on _DataState, Store {
  final _$loadingAtom = Atom(name: '_DataState.loading');

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

  final _$hasDataAtom = Atom(name: '_DataState.hasData');

  @override
  bool get hasData {
    _$hasDataAtom.context.enforceReadPolicy(_$hasDataAtom);
    _$hasDataAtom.reportObserved();
    return super.hasData;
  }

  @override
  set hasData(bool value) {
    _$hasDataAtom.context.conditionallyRunInAction(() {
      super.hasData = value;
      _$hasDataAtom.reportChanged();
    }, _$hasDataAtom, name: '${_$hasDataAtom.name}_set');
  }

  final _$_DataStateActionController = ActionController(name: '_DataState');

  @override
  void startLoading() {
    final _$actionInfo = _$_DataStateActionController.startAction();
    try {
      return super.startLoading();
    } finally {
      _$_DataStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopLoading() {
    final _$actionInfo = _$_DataStateActionController.startAction();
    try {
      return super.stopLoading();
    } finally {
      _$_DataStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dataFetched() {
    final _$actionInfo = _$_DataStateActionController.startAction();
    try {
      return super.dataFetched();
    } finally {
      _$_DataStateActionController.endAction(_$actionInfo);
    }
  }
}
