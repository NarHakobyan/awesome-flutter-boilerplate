library postslist;

import 'package:json_annotation/json_annotation.dart';

import 'package:secure_chat/models/post/post.dart';

part 'post_list.g.dart';

@JsonSerializable()
class PostsList {
  factory PostsList.fromJson(Map<String, dynamic> json) =>
      _$PostsListFromJson(json);

  Map<String, dynamic> toJson() => _$PostsListToJson(this);

  final List<Post> posts;

  PostsList({
    this.posts,
  });
}
