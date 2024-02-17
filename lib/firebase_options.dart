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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDn4_S-T36_f6vKjEsR-wGrMUfAKfbKjDo',
    appId: '1:472171244454:web:4b9dae2c274634b532fd67',
    messagingSenderId: '472171244454',
    projectId: 'expense-tracker-flutterflow',
    authDomain: 'expense-tracker-flutterflow.firebaseapp.com',
    databaseURL: 'https://expense-tracker-flutterflow-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'expense-tracker-flutterflow.appspot.com',
    measurementId: 'G-5VNEX1HS8Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBEzeftX9XUnzxxa7eZxGoD0aiP9JWcx8',
    appId: '1:472171244454:android:1b9ae5f4eedeab6132fd67',
    messagingSenderId: '472171244454',
    projectId: 'expense-tracker-flutterflow',
    databaseURL: 'https://expense-tracker-flutterflow-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'expense-tracker-flutterflow.appspot.com',
  );
}
