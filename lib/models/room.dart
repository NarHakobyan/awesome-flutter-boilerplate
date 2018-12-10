import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Room {
  String id;
  String name;
  DateTime createdAt;
  DocumentReference reference;

  Room({@required this.id, @required this.name, this.createdAt, this.reference});

  factory Room.fromMap(Map<String, dynamic> json, reference) {
    return Room(
        id: json['id'],
        name: json['name'],
        reference: reference,
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null);
  }

  factory Room.fromSnapshot(DocumentSnapshot snapshot) => Room.fromMap(snapshot.data, snapshot.reference);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Room{id: $id, name: $name, createdAt: $createdAt, reference: $reference}';
  }
}
