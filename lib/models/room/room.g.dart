// GENERATED CODE - DO NOT MODIFY BY HAND

part of room;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) {
  return Room(
      key: json['key'] as String,
      name: json['name'] as String,
      owner: json['owner'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String));
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'owner': instance.owner,
      'createdAt': instance.createdAt?.toIso8601String()
    };
