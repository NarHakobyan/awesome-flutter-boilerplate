//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Room {
  String key;
  String name;
  String owner;
  DateTime createdAt;

  Room({@required this.key, @required this.name, this.createdAt, this.owner});

  factory Room.fromMap(Map<String, dynamic> json, reference) {
    return Room(
        key: json['key'],
        name: json['name'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'name': name,
      'owner': owner,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Room{key: $key, name: $name, owner: $owner, createdAt: $createdAt}';
  }
}
