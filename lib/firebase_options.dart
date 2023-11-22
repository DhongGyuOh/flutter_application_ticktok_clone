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
    apiKey: 'AIzaSyCosCA-aBzisRul33VDOnZMYboUo6oRHHY',
    appId: '1:1041867751887:web:b9fb65515e1021c03452ba',
    messagingSenderId: '1041867751887',
    projectId: 'tiktokclone-f68f0',
    authDomain: 'tiktokclone-f68f0.firebaseapp.com',
    storageBucket: 'tiktokclone-f68f0.appspot.com',
    measurementId: 'G-5EF1XWRWSM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBk3pf9QVdc5lzgu-ULmdSOGtL-aWBf7j0',
    appId: '1:1041867751887:android:82206b845fb9e6a43452ba',
    messagingSenderId: '1041867751887',
    projectId: 'tiktokclone-f68f0',
    storageBucket: 'tiktokclone-f68f0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBzwcVGGZrN12_ss8nrPUVRhcp4OO7kGs',
    appId: '1:1041867751887:ios:a0019d6a56040f433452ba',
    messagingSenderId: '1041867751887',
    projectId: 'tiktokclone-f68f0',
    storageBucket: 'tiktokclone-f68f0.appspot.com',
    iosBundleId: 'com.example.flutterApplicationTicktokClone',
  );
}
