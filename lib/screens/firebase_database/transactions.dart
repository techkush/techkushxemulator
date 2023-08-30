import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TransactionExampleScreen extends StatefulWidget {
  const TransactionExampleScreen({Key? key}) : super(key: key);

  @override
  State<TransactionExampleScreen> createState() =>
      _TransactionExampleScreenState();
}

class _TransactionExampleScreenState extends State<TransactionExampleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  incrementPostLikes(bool increment) async {
    TransactionResult result = await FirebaseDatabase.instance
        .ref("myPosts/123456")
        .runTransaction((Object? post) {
      if (post != null) {
        Map<String, dynamic> postMap = Map<String, dynamic>.from(post as Map);
        postMap['likes'] = postMap['likes'] + 1;
        return Transaction.success(postMap);
      } else {
        // Safely cancel the transaction.
        return Transaction.abort();
      }
      return Transaction.success(post);
    });
    print('Committed? ${result.committed}');
    // New Snapshot
    print('Snapshot? ${result.snapshot.value}');
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference postCount =
        FirebaseDatabase.instance.ref('myPosts/123456');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
          actions: [
            IconButton(
                onPressed: () async {
                  DatabaseReference ref =
                      FirebaseDatabase.instance.ref("myPosts/123456");
                  await ref.set({"likes": 10, "title": "New Games 2023"});
                },
                icon: const Icon(Icons.add))
          ],
        ),
        // REALTIME DATA READ
        body: Column(
          children: [
            StreamBuilder(
                stream: postCount.onValue,
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapShot.hasData &&
                        snapShot.data != null &&
                        snapShot.data!.snapshot.value != null) {
                      // Convert DatabaseEvent to Map
                      final postItem = Map<dynamic, dynamic>.from(snapShot
                          .data!.snapshot.value as Map<dynamic, dynamic>);

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          child: ListTile(
                            title: Text(postItem['title']),
                            leading: Text(
                              '${postItem['likes']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                incrementPostLikes(true);
                              },
                              icon: const Icon(Icons.upload_outlined),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return Container();
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: const Text('Atomic Server Side Increment'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      addStar('234123', '123123');
                    },
                  ),
                ),
              ),
            )
          ],
        ));
  }

  //Atomic server-side increments
  void addStar(uid, key) async {
    Map<String, Object?> updates = {};
    updates["posts/$key/stars/$uid"] = true;
    updates["posts/$key/starCount"] = ServerValue.increment(1);
    updates["user-posts/$key/stars/$uid"] = true;
    updates["user-posts/$key/starCount"] = ServerValue.increment(1);
    return FirebaseDatabase.instance.ref().update(updates);
  }
}
