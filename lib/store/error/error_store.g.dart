// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$ErrorStore on _ErrorStore, Store {
  final _$errorAtom = Atom(name: '_ErrorStore.error');

  @override
  String get error {
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.context.checkIfStateModificationsAreAllowed(_$errorAtom);
    super.error = value;
    _$errorAtom.reportChanged();
  }

  final _$hasErrorAtom = Atom(name: '_ErrorStore.hasError');

  @override
  bool get hasError {
    _$hasErrorAtom.reportObserved();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.context.checkIfStateModificationsAreAllowed(_$hasErrorAtom);
    super.hasError = value;
    _$hasErrorAtom.reportChanged();
  }
}
