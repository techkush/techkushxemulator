import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:techkushxemulator/dialogs/add_data.dart';
import 'package:techkushxemulator/dialogs/snackbar.dart';
import 'package:techkushxemulator/dialogs/update_date.dart';
import 'package:techkushxemulator/models/todo_items.dart';

class RealtimeDatabaseScreen extends StatefulWidget {
  const RealtimeDatabaseScreen({Key? key}) : super(key: key);

  @override
  State<RealtimeDatabaseScreen> createState() => _RealtimeDatabaseScreenState();
}

class _RealtimeDatabaseScreenState extends State<RealtimeDatabaseScreen> {

  // References
  // https://firebase.flutter.dev/docs/database/read-and-write

  // READ DATA ONCE
  Future<List> readDataOnce() async {
    List<ToDoItem> toDoItemList = [];
    FirebaseDatabase.instance.ref().child("todoList").get().then((snapShot) {
      if (snapShot.exists) {
        for (final snap in snapShot.children) {
          ToDoItem toDoItem = ToDoItem.fromSnapshot(snap);
          toDoItemList.add(toDoItem);
        }
        return toDoItemList;
      } else {
        debugPrint('No data available.');
      }
    }).catchError((error){
      SnackBarMessage.showSnackBarWithMessage(
          context: context, message: 'Error!', boxColor: Colors.red);
    });
    return [];
  }

  // WRITE DATA
  Future<void> addDataToDatabase(String title, String description) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("todoList").push();
    await ref.set({
      "title": title,
      "description": description,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    }).then((value) {
      SnackBarMessage.showSnackBarWithMessage(
          context: context,
          message: 'Added your data!',
          boxColor: Colors.green);
    }).catchError((error) {
      SnackBarMessage.showSnackBarWithMessage(
          context: context, message: 'Error!', boxColor: Colors.red);
    });
  }

  // UPDATE DATA
  Future<void> updateDataToDatabase(
      String id, String title, String description) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("todoList/$id");
    await ref.update({
      "title": title,
      "description": description,
      "updatedTime": DateTime.now().millisecondsSinceEpoch
    }).then((value) {
      SnackBarMessage.showSnackBarWithMessage(
          context: context,
          message: 'Update your data!',
          boxColor: Colors.green);
    }).catchError((error) {
      SnackBarMessage.showSnackBarWithMessage(
          context: context, message: 'Error!', boxColor: Colors.red);
    });
  }

  // REMOVE DATA
  void removeItemById(String id){
    FirebaseDatabase.instance.ref("todoList/$id").remove().then((value) {
      SnackBarMessage.showSnackBarWithMessage(
          context: context,
          message: 'Item deleted!',
          boxColor: Colors.green);
    }).catchError((error) {
      SnackBarMessage.showSnackBarWithMessage(
          context: context, message: 'Error!', boxColor: Colors.red);
    });
  }


  void toggleStar(String uid) async {
    DatabaseReference postRef =
    FirebaseDatabase.instance.ref("posts/foo-bar-123");

    TransactionResult result = await postRef.runTransaction((Object? post) {
      // Ensure a post at the ref exists.
      if (post == null) {
        return Transaction.abort();
      }

      Map<String, dynamic> _post = Map<String, dynamic>.from(post as Map);
      if (_post["stars"] is Map && _post["stars"][uid] != null) {
        _post["starCount"] = (_post["starCount"] ?? 1) - 1;
        _post["stars"][uid] = null;
      } else {
        _post["starCount"] = (_post["starCount"] ?? 0) + 1;
        if (!_post.containsKey("stars")) {
          _post["stars"] = {};
        }
        _post["stars"][uid] = true;
      }

      // Return the new data.
      return Transaction.success(_post);
    });


  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('todoList');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Database'),
        actions: [
          IconButton(
              onPressed: () {
                toggleStar('wef2345');
              },
              icon: const Icon(Icons.transfer_within_a_station)),
          IconButton(
              onPressed: () {
                AddDataDialogBox(handleFunction: (title, description) {
                  addDataToDatabase(title, description);
                }).showAddDialogBox(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      // REALTIME DATA READ
      body: StreamBuilder<DatabaseEvent>(
          stream: starCountRef.onValue,
          builder: (context, snapShot) {
            List<ToDoItem> toDoItemList = [];
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapShot.hasData &&
                  snapShot.data != null &&
                  snapShot.data!.snapshot.value != null) {

                // Convert DatabaseEvent to Map
                // final toDoItems = Map<dynamic, dynamic>.from(
                //     snapShot.data!.snapshot.value
                //     as Map<dynamic, dynamic>);

                for (final snap in snapShot.data!.snapshot.children) {
                  ToDoItem toDoItem = ToDoItem.fromSnapshot(snap);
                  toDoItemList.add(toDoItem);
                }
                return RefreshIndicator(
                  onRefresh: () => readDataOnce(),
                  child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      return ListTile(
                        title: Text(toDoItemList[i].title),
                        subtitle: Text(toDoItemList[i].description),
                        enabled: toDoItemList[i].updatedTime == null ? true : false ,
                        trailing: IconButton(
                          onPressed: () {
                            removeItem(toDoItemList[i].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          UpdateDataDialogBox(
                                  handleFunction: (title, description) {
                                    updateDataToDatabase(toDoItemList[i].id, title, description);
                                  },
                                  title: toDoItemList[i].title,
                                  description: toDoItemList[i].description)
                              .showAddDialogBox(context);
                        },
                      );
                    },
                    itemCount: toDoItemList.length,
                  ),
                );
              }
              return const Center(child: Text('No Data'));
            }
          }),
    );
  }

  Future<void> removeItem(String id){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: const Text('Delete'),
            content: const Text('Are you sure to delete this item?'),
            actions: [
              TextButton(
                onPressed: () {
                  removeItemById(id);
                  Navigator.pop(context);
                },
                child: const Text('DELETE'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCEL'),
              ),
            ],
          ),
        );
      },
    );
  }
}
