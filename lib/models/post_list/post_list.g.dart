// GENERATED CODE - DO NOT MODIFY BY HAND

part of postslist;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsList _$PostsListFromJson(Map<String, dynamic> json) {
  return PostsList(
    posts: (json['posts'] as List)
        ?.map(
            (e) => e == null ? null : Post.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PostsListToJson(PostsList instance) => <String, dynamic>{
      'posts': instance.posts,
    };
