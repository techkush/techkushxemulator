import 'package:firebase_database/firebase_database.dart';

class ToDoItem {
  late String title, description, id;
  late int timestamp;
  int? updatedTime;

  ToDoItem(
      {required this.title,
      required this.description,
      required this.timestamp,
      required this.id,
      this.updatedTime});

  ToDoItem.fromSnapshot(DataSnapshot? dataSnapshot) {
    id = dataSnapshot!.key!;
    title = dataSnapshot!.child('title').value.toString();
    description = dataSnapshot!.child('description').value.toString();
    timestamp = int.parse(dataSnapshot!.child('timestamp').value.toString());
    updatedTime = dataSnapshot!.child('updatedTime').value == null
        ? null
        : int.parse(dataSnapshot!.child('updatedTime').value.toString());
  }
}
