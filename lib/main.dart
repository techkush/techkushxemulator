import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:techkushxemulator/screens/firebase_database/realtime_screen.dart';

import 'firebase_options.dart';

/*
Install FlutterFire

1. Open Terminal and run:
dart pub global activate flutterfire_cli
export PATH="$PATH":"$HOME/.pub-cache/bin"

2. Run: flutterfire --version

3. If you get a version number, flutterfire has been installed successfully
4. flutterfire configure --project=techkushxdb

Commands:
firebase projects:list
firebase init
firebase emulators:start

Automatically Create the iOS and Android Google-Service-Info files and App settings in Firebase Console.'

 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize for Emulator
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Emulator',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              centerTitle: true)),
      home: const MyHomePage(title: 'Firebase Emulator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // addUser(){
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //
  //   return users
  //       .add({
  //     'full_name': 'Namesh Kushantha', // John Doe
  //     'company': 'LogicContext', // Stokes and Sons
  //     'age': 27 // 42
  //   })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.supervised_user_circle_sharp,
              color: Colors.pink,
            ),
            title: const Text('Authentications'),
            trailing: const Icon(Icons.arrow_forward_ios),
            subtitle: const Text('firebase_auth: ^4.8.0'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.restart_alt,
              color: Colors.orange,
            ),
            title: const Text('Realtime Database'),
            trailing: const Icon(Icons.arrow_forward_ios),
            subtitle: const Text('firebase_database: ^10.2.5'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RealtimeDatabaseScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.cloud_upload,
              color: Colors.blue,
            ),
            title: const Text('Cloud Firestore'),
            trailing: const Icon(Icons.arrow_forward_ios),
            subtitle: const Text('cloud_firestore: ^4.9.0'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.storage,
              color: Colors.deepPurple,
            ),
            title: const Text('Cloud Storage'),
            trailing: const Icon(Icons.arrow_forward_ios),
            subtitle: const Text('firebase_storage: ^11.2.6'),
            onTap: () {},
          ),

        ],
      ),
    );
  }
}
