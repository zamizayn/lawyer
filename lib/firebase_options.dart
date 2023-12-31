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
    apiKey: 'AIzaSyASB9UBbMLap-EmTawi3VQiNcmhN0-KCXk',
    appId: '1:135935935706:web:dbb83995b11418748d51e3',
    messagingSenderId: '135935935706',
    projectId: 'find-your-lawyer-392a2',
    authDomain: 'find-your-lawyer-392a2.firebaseapp.com',
    storageBucket: 'find-your-lawyer-392a2.appspot.com',
    measurementId: 'G-W29YM0PQJS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCC9JKUj6Z3FXpFDQJcS-WO-h2L3gc-Gn8',
    appId: '1:135935935706:android:7a1696b0f9d0d4708d51e3',
    messagingSenderId: '135935935706',
    projectId: 'find-your-lawyer-392a2',
    storageBucket: 'find-your-lawyer-392a2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBV5WhCmuqJ7U788biNTdHan19j7K60FEQ',
    appId: '1:135935935706:ios:e1c0f38e64cfc1fc8d51e3',
    messagingSenderId: '135935935706',
    projectId: 'find-your-lawyer-392a2',
    storageBucket: 'find-your-lawyer-392a2.appspot.com',
    iosClientId: '135935935706-1p68ffrsljkfhjkcm8knlagfj4khjd7c.apps.googleusercontent.com',
    iosBundleId: 'com.example.findYourLawyer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBV5WhCmuqJ7U788biNTdHan19j7K60FEQ',
    appId: '1:135935935706:ios:9da13bca824abb978d51e3',
    messagingSenderId: '135935935706',
    projectId: 'find-your-lawyer-392a2',
    storageBucket: 'find-your-lawyer-392a2.appspot.com',
    iosClientId: '135935935706-75c4qd219n55dboqke503hd980fstj14.apps.googleusercontent.com',
    iosBundleId: 'com.example.findYourLawyer.RunnerTests',
  );
}
