library room;

import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);

  String key;
  String name;
  String owner;
  DateTime createdAt;

  Room({this.key, this.name, this.owner, this.createdAt});
}
