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
    apiKey: 'AIzaSyBqEWvExxj0OIGOpKguLk88RJO-PMun34w',
    appId: '1:948920668496:web:c9961e862436d72a931c55',
    messagingSenderId: '948920668496',
    projectId: 'to-do-list-499c6',
    authDomain: 'to-do-list-499c6.firebaseapp.com',
    storageBucket: 'to-do-list-499c6.appspot.com',
    measurementId: 'G-D8Z1L1JCJ1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAv_ah5h99oB_RQ7HArYFq4twlm9gQBCmg',
    appId: '1:948920668496:android:038410fbed991ba2931c55',
    messagingSenderId: '948920668496',
    projectId: 'to-do-list-499c6',
    storageBucket: 'to-do-list-499c6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjaWI24r-W1z8MDRNOoSuMY25veiIT79c',
    appId: '1:948920668496:ios:2302fc43fb101ce4931c55',
    messagingSenderId: '948920668496',
    projectId: 'to-do-list-499c6',
    storageBucket: 'to-do-list-499c6.appspot.com',
    iosBundleId: 'com.example.baseTodolist',
  );
}
