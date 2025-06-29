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
    apiKey: 'AIzaSyBeg5mrIxorOKFGRSeuKFrcA8ZiF6x34Z8',
    appId: '1:416740177928:web:f081d4e08cde9969df39bd',
    messagingSenderId: '416740177928',
    projectId: 'cape-and-kingdom-exports',
    authDomain: 'cape-and-kingdom-exports.firebaseapp.com',
    storageBucket: 'cape-and-kingdom-exports.firebasestorage.app',
    measurementId: 'G-CMWEP3MF7C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3m22iVyev90LBLnEka9wGxxIBfks0Ol0',
    appId: '1:416740177928:android:2a4007281b544d4fdf39bd',
    messagingSenderId: '416740177928',
    projectId: 'cape-and-kingdom-exports',
    storageBucket: 'cape-and-kingdom-exports.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAPahI8j32eviRC0YYTuJnCUdX_KXMBS4',
    appId: '1:416740177928:ios:a03cc7e9db02f7eedf39bd',
    messagingSenderId: '416740177928',
    projectId: 'cape-and-kingdom-exports',
    storageBucket: 'cape-and-kingdom-exports.firebasestorage.app',
    iosBundleId: 'com.example.capeAndKingdomExports',
  );
}
