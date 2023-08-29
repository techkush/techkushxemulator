// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA4JZunmO8d2OtbIpQbhDeFA542vl0dAow',
    appId: '1:655757573044:web:4bd6fe12b384858458d0e1',
    messagingSenderId: '655757573044',
    projectId: 'techkushxdb',
    authDomain: 'techkushxdb.firebaseapp.com',
    databaseURL: 'https://techkushxdb-default-rtdb.firebaseio.com',
    storageBucket: 'techkushxdb.appspot.com',
    measurementId: 'G-9ZRC7CK1LQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCf5_0pyVchUQMuIL0n6zdx5ADWiXrxcrw',
    appId: '1:655757573044:android:f85724f803ca1a1258d0e1',
    messagingSenderId: '655757573044',
    projectId: 'techkushxdb',
    databaseURL: 'https://techkushxdb-default-rtdb.firebaseio.com',
    storageBucket: 'techkushxdb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA20VCw0ShnxazR88QwAq_k77ojeYwq_CU',
    appId: '1:655757573044:ios:93fa75b72c8adfaf58d0e1',
    messagingSenderId: '655757573044',
    projectId: 'techkushxdb',
    databaseURL: 'https://techkushxdb-default-rtdb.firebaseio.com',
    storageBucket: 'techkushxdb.appspot.com',
    androidClientId: '655757573044-vlrfbhogf15c4d04nmg5kpt3gbm1er2g.apps.googleusercontent.com',
    iosClientId: '655757573044-i9u38h1q2ft5v3aonnplpsbsddftvj56.apps.googleusercontent.com',
    iosBundleId: 'com.techkushx.techkushxemulator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA20VCw0ShnxazR88QwAq_k77ojeYwq_CU',
    appId: '1:655757573044:ios:b32df9df3b8b09be58d0e1',
    messagingSenderId: '655757573044',
    projectId: 'techkushxdb',
    databaseURL: 'https://techkushxdb-default-rtdb.firebaseio.com',
    storageBucket: 'techkushxdb.appspot.com',
    androidClientId: '655757573044-vlrfbhogf15c4d04nmg5kpt3gbm1er2g.apps.googleusercontent.com',
    iosClientId: '655757573044-767qvdrtnb4kn7nrag92ilm0kh7sehu2.apps.googleusercontent.com',
    iosBundleId: 'com.techkushx.techkushxemulator.RunnerTests',
  );
}
