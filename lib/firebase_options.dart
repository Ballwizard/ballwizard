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
    apiKey: 'AIzaSyCT79Q-cVa3QzvUh7jSPVOdxdhhUDhb2sw',
    appId: '1:471266321533:web:51aa457d3cebe4b87a7d14',
    messagingSenderId: '471266321533',
    projectId: 'ballwizard-app',
    authDomain: 'ballwizard-app.firebaseapp.com',
    storageBucket: 'ballwizard-app.appspot.com',
    measurementId: 'G-HWQ17LPQ3Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuN2mfLXDsl_ehHGnxk7cfTb_EnzxRsUg',
    appId: '1:471266321533:android:1fcf5220ff9bc6727a7d14',
    messagingSenderId: '471266321533',
    projectId: 'ballwizard-app',
    storageBucket: 'ballwizard-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtYYKQT3ckwId9CSt89BjQyaw_KvgISXg',
    appId: '1:471266321533:ios:d6ffbe68ec09b5dc7a7d14',
    messagingSenderId: '471266321533',
    projectId: 'ballwizard-app',
    storageBucket: 'ballwizard-app.appspot.com',
    iosBundleId: 'com.example.ballwizard',
  );
}
