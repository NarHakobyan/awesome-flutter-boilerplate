import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
    final String id;
    final String name;
    final DocumentReference reference;

    Room.fromMap(Map<String, dynamic> map, {this.reference})
        : assert(map['id'] != null),
            assert(map['name'] != null),
            id = map['id'],
            name = map['name'];

    Room.fromSnapshot(DocumentSnapshot snapshot)
        : this.fromMap(snapshot.data, reference: snapshot.reference);

    @override
    String toString() => "Record<$id:$name>";
}
