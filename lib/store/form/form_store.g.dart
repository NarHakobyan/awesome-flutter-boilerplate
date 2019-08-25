// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  final _$autoValidateAtom = Atom(name: '_FormStore.autoValidate');

  @override
  bool get autoValidate {
    _$autoValidateAtom.context.enforceReadPolicy(_$autoValidateAtom);
    _$autoValidateAtom.reportObserved();
    return super.autoValidate;
  }

  @override
  set autoValidate(bool value) {
    _$autoValidateAtom.context.conditionallyRunInAction(() {
      super.autoValidate = value;
      _$autoValidateAtom.reportChanged();
    }, _$autoValidateAtom, name: '${_$autoValidateAtom.name}_set');
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  dynamic setAutoValidate({bool autoValidate}) {
    final _$actionInfo = _$_FormStoreActionController.startAction();
    try {
      return super.setAutoValidate(autoValidate: autoValidate);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }
}
