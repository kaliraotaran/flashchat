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
    apiKey: 'AIzaSyDuhltsDMS8oMBxNxLvG4drxo5Cw_YZhPY',
    appId: '1:108513627843:web:88e0dd1d8da7f788159c76',
    messagingSenderId: '108513627843',
    projectId: 'flash-chat-d94c4',
    authDomain: 'flash-chat-d94c4.firebaseapp.com',
    storageBucket: 'flash-chat-d94c4.appspot.com',
    measurementId: 'G-BE6465EQHX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGkXcjECxbL_pAQ6FYReEvSi-y2jVZSAE',
    appId: '1:108513627843:android:ea4c67546dc7ac2f159c76',
    messagingSenderId: '108513627843',
    projectId: 'flash-chat-d94c4',
    storageBucket: 'flash-chat-d94c4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXonRGwKh1QuhfN-mS7iJFxQEsBqqd_sY',
    appId: '1:108513627843:ios:d7cdcb7dfe54e60f159c76',
    messagingSenderId: '108513627843',
    projectId: 'flash-chat-d94c4',
    storageBucket: 'flash-chat-d94c4.appspot.com',
    iosClientId: '108513627843-bs45hlg2enbh1elbm1v0rh05ggn00ihj.apps.googleusercontent.com',
    iosBundleId: 'co.appbrewery.flashChat',
  );
}