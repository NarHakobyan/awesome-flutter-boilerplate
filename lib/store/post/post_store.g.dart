// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$PostStore on _PostStore, Store {
  final _$postsListAtom = Atom(name: '_PostStore.postsList');

  @override
  PostsList get postsList {
    _$postsListAtom.reportObserved();
    return super.postsList;
  }

  @override
  set postsList(PostsList value) {
    _$postsListAtom.context
        .checkIfStateModificationsAreAllowed(_$postsListAtom);
    super.postsList = value;
    _$postsListAtom.reportChanged();
  }

  final _$getPostsAsyncAction = AsyncAction('getPosts');

  @override
  Future<dynamic> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }
}