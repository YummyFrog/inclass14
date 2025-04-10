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
    apiKey: 'AIzaSyDjtOY0m6RRy16UMfUBgLOTShO4wG-1c_I',
    appId: '1:1006320216750:web:6600c5ba2d746302f49b3f',
    messagingSenderId: '1006320216750',
    projectId: 'inclass14new-mad1414',
    authDomain: 'inclass14new-mad1414.firebaseapp.com',
    storageBucket: 'inclass14new-mad1414.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQ1f19fwChGwnIZd-nYBu3iGgAgS4O6Z4',
    appId: '1:1006320216750:android:b0eb618f1c78912ef49b3f',
    messagingSenderId: '1006320216750',
    projectId: 'inclass14new-mad1414',
    storageBucket: 'inclass14new-mad1414.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBO5YzCfWnZ0-eDy1tVRw_0oDKTLKU1PeI',
    appId: '1:1006320216750:ios:a9219d408e4914a7f49b3f',
    messagingSenderId: '1006320216750',
    projectId: 'inclass14new-mad1414',
    storageBucket: 'inclass14new-mad1414.firebasestorage.app',
    iosBundleId: 'com.example.inclass14new',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBO5YzCfWnZ0-eDy1tVRw_0oDKTLKU1PeI',
    appId: '1:1006320216750:ios:a9219d408e4914a7f49b3f',
    messagingSenderId: '1006320216750',
    projectId: 'inclass14new-mad1414',
    storageBucket: 'inclass14new-mad1414.firebasestorage.app',
    iosBundleId: 'com.example.inclass14new',
  );
}
