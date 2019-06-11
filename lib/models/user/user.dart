import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String firstName;
  String lastName;
  String username;
  String role;
  String email;
  String avatar;
  DateTime createdAt;
  DateTime updatedAt;

  User(
      {this.firstName,
      this.lastName,
      this.username,
      this.role,
      this.email,
      this.avatar,
      this.createdAt,
      this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  factory User.fromJsonString(String jsonString) =>
      _$UserFromJson(jsonDecode(jsonString));
  Map<String, dynamic> toJson() => _$UserToJson(this);
  User clone() => User.fromJson(this.toJson());
}
