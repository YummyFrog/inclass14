// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyDChxsRSSjdH3nm3NahagLxgEqVZlqdbUs',
    appId: '1:335354769484:web:74124816baa3559e6884e9',
    messagingSenderId: '335354769484',
    projectId: 'inclass14-mad1142',
    authDomain: 'inclass14-mad1142.firebaseapp.com',
    storageBucket: 'inclass14-mad1142.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnahhDo7wDAQ_jrnqitOOEq_XwEO28_Yo',
    appId: '1:335354769484:android:101efa019b83dddd6884e9',
    messagingSenderId: '335354769484',
    projectId: 'inclass14-mad1142',
    storageBucket: 'inclass14-mad1142.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxxyPiDyvYbHnVkfmHIGctlT4QmdemP3U',
    appId: '1:335354769484:ios:8345924fcdc4860b6884e9',
    messagingSenderId: '335354769484',
    projectId: 'inclass14-mad1142',
    storageBucket: 'inclass14-mad1142.firebasestorage.app',
    iosBundleId: 'com.example.inclass14',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxxyPiDyvYbHnVkfmHIGctlT4QmdemP3U',
    appId: '1:335354769484:ios:8345924fcdc4860b6884e9',
    messagingSenderId: '335354769484',
    projectId: 'inclass14-mad1142',
    storageBucket: 'inclass14-mad1142.firebasestorage.app',
    iosBundleId: 'com.example.inclass14',
  );
}
