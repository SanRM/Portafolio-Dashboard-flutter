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
    apiKey: 'AIzaSyDSJx1gxerTbU_WvRn5CQi4k0uVneEJntk',
    appId: '1:209186165717:web:c41b2d9818b235b13be35c',
    messagingSenderId: '209186165717',
    projectId: 'portafolio-65df7',
    authDomain: 'portafolio-65df7.firebaseapp.com',
    storageBucket: 'portafolio-65df7.appspot.com',
    measurementId: 'G-V3FTRDKVT7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCN8V7_tXc5uaQQDuFhdxrD3FQZsmB4kG4',
    appId: '1:209186165717:android:82c0579736c506f03be35c',
    messagingSenderId: '209186165717',
    projectId: 'portafolio-65df7',
    storageBucket: 'portafolio-65df7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDb3vrl4SDbwx5LB9F4knDjHHP63_TOGBA',
    appId: '1:209186165717:ios:59690b3cba44b2913be35c',
    messagingSenderId: '209186165717',
    projectId: 'portafolio-65df7',
    storageBucket: 'portafolio-65df7.appspot.com',
    iosClientId:
        '209186165717-ims2264b8kv9hrhavbacqs73qtp2aa0n.apps.googleusercontent.com',
    iosBundleId: 'com.example.portafolio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDb3vrl4SDbwx5LB9F4knDjHHP63_TOGBA',
    appId: '1:209186165717:ios:b2c6fc6e71a3dd8b3be35c',
    messagingSenderId: '209186165717',
    projectId: 'portafolio-65df7',
    storageBucket: 'portafolio-65df7.appspot.com',
    iosClientId:
        '209186165717-estkgf0mj5jlcbfvdm4qlcjbr73e37fk.apps.googleusercontent.com',
    iosBundleId: 'com.example.portafolio.RunnerTests',
  );
}
