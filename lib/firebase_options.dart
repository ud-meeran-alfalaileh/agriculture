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
        return windows;
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
    apiKey: 'AIzaSyArby3kY3d9761T8NvIJVC0zeZxM2til2I',
    appId: '1:1012598513127:web:320915295789bbf92d3142',
    messagingSenderId: '1012598513127',
    projectId: 'agriculture-84ca0',
    authDomain: 'agriculture-84ca0.firebaseapp.com',
    storageBucket: 'agriculture-84ca0.appspot.com',
    measurementId: 'G-T8YJD69L5X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyLIz22NtwX_dw5zUdBbnnF-850eRUKb8',
    appId: '1:1012598513127:android:5bfe358c734b9d8b2d3142',
    messagingSenderId: '1012598513127',
    projectId: 'agriculture-84ca0',
    storageBucket: 'agriculture-84ca0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrgEK7r32Fhq_y41PhMNTAQxhx_7C2Rfc',
    appId: '1:1012598513127:ios:dfdfe8095f7b91852d3142',
    messagingSenderId: '1012598513127',
    projectId: 'agriculture-84ca0',
    storageBucket: 'agriculture-84ca0.appspot.com',
    iosBundleId: 'com.example.agriculture',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrgEK7r32Fhq_y41PhMNTAQxhx_7C2Rfc',
    appId: '1:1012598513127:ios:dfdfe8095f7b91852d3142',
    messagingSenderId: '1012598513127',
    projectId: 'agriculture-84ca0',
    storageBucket: 'agriculture-84ca0.appspot.com',
    iosBundleId: 'com.example.agriculture',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyArby3kY3d9761T8NvIJVC0zeZxM2til2I',
    appId: '1:1012598513127:web:93292a1e3149c72c2d3142',
    messagingSenderId: '1012598513127',
    projectId: 'agriculture-84ca0',
    authDomain: 'agriculture-84ca0.firebaseapp.com',
    storageBucket: 'agriculture-84ca0.appspot.com',
    measurementId: 'G-GQ8QWMBDPL',
  );
}
