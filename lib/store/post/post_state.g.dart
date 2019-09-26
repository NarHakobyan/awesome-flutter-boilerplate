// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostState on _PostState, Store {
  Computed<bool> _$hasResultsComputed;

  @override
  bool get hasResults =>
      (_$hasResultsComputed ??= Computed<bool>(() => super.hasResults)).value;

  final _$fetchPostsFutureAtom = Atom(name: '_PostState.fetchPostsFuture');

  @override
  ObservableFuture<List<Post>> get fetchPostsFuture {
    _$fetchPostsFutureAtom.context.enforceReadPolicy(_$fetchPostsFutureAtom);
    _$fetchPostsFutureAtom.reportObserved();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<List<Post>> value) {
    _$fetchPostsFutureAtom.context.conditionallyRunInAction(() {
      super.fetchPostsFuture = value;
      _$fetchPostsFutureAtom.reportChanged();
    }, _$fetchPostsFutureAtom, name: '${_$fetchPostsFutureAtom.name}_set');
  }

  final _$getPostsAsyncAction = AsyncAction('getPosts');

  @override
  Future<void> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }
}
