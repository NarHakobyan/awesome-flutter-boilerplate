// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostStore on _PostStore, Store {
  final _$postsListAtom = Atom(name: '_PostStore.postsList');

  @override
  PostsList get postsList {
    _$postsListAtom.context.enforceReadPolicy(_$postsListAtom);
    _$postsListAtom.reportObserved();
    return super.postsList;
  }

  @override
  set postsList(PostsList value) {
    _$postsListAtom.context.conditionallyRunInAction(() {
      super.postsList = value;
      _$postsListAtom.reportChanged();
    }, _$postsListAtom, name: '${_$postsListAtom.name}_set');
  }

  final _$getPostsAsyncAction = AsyncAction('getPosts');

  @override
  Future getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }
}
